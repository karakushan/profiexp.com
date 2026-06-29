<?php

namespace App\Jobs;

use App\Models\Journal\BlogCategory;
use App\Models\Journal\BlogCategoryContent;
use App\Models\Language;
use App\Services\Ai\BlogCategoryTranslationService;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;

class TranslateBlogCategoryJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public int $tries = 2;

    public function __construct(
        public int $categoryId,
        public int $sourceLangId,
        public int $targetLangId,
        public string $targetLangCode,
        public string $targetLangName,
    ) {
    }

    public function handle(BlogCategoryTranslationService $translator): void
    {
        $sourceContent = BlogCategoryContent::where('blog_category_id', $this->categoryId)
            ->where('language_id', $this->sourceLangId)
            ->first();

        if (!$sourceContent || empty($sourceContent->name)) {
            return;
        }

        $exists = BlogCategoryContent::where('blog_category_id', $this->categoryId)
            ->where('language_id', $this->targetLangId)
            ->exists();

        if ($exists) {
            return;
        }

        $translated = $translator->translate(
            $sourceContent,
            $this->targetLangCode,
            $this->targetLangName
        );

        $slug = $translated['slug'] ?? '';
        if (empty($slug)) {
            $slug = Str::slug($translated['name'] ?? $sourceContent->name);
        }

        if ($this->targetLangCode !== 'en' && !empty($translated['name'])) {
            $transliteratedSlug = $this->transliterateSlug($translated['name']);
            if (!empty($transliteratedSlug)) {
                $slug = $transliteratedSlug;
            }
        }

        BlogCategoryContent::create([
            'blog_category_id' => $this->categoryId,
            'language_id' => $this->targetLangId,
            'name' => $translated['name'] ?? '',
            'slug' => $slug,
            'meta_title' => $translated['meta_title'] ?? '',
            'meta_description' => $translated['meta_description'] ?? '',
            'seo_text' => $translated['seo_text'] ?? '',
        ]);
    }

    private function transliterateSlug(string $text): string
    {
        $slug = Str::slug($text);
        if (!empty($slug)) {
            return $slug;
        }

        $enLanguage = Language::where('code', 'en')->first();
        if ($enLanguage) {
            $enContent = BlogCategoryContent::where('blog_category_id', $this->categoryId)
                ->where('language_id', $enLanguage->id)
                ->first();
            if ($enContent && !empty($enContent->slug)) {
                return $enContent->slug;
            }
        }

        return '';
    }

    public function failed(\Throwable $e): void
    {
        Log::error("Translation job failed for blog category #{$this->categoryId} to {$this->targetLangCode}: " . $e->getMessage());
    }
}
