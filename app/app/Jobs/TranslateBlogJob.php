<?php

namespace App\Jobs;

use App\Models\Journal\Blog;
use App\Models\Journal\BlogInformation;
use App\Models\Language;
use App\Services\Ai\BlogTranslationService;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;

class TranslateBlogJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public int $tries = 2;

    public function __construct(
        public int $blogId,
        public int $sourceLangId,
        public int $targetLangId,
        public string $targetLangCode,
        public string $targetLangName,
    ) {
    }

    public function handle(BlogTranslationService $translator): void
    {
        $sourceContent = BlogInformation::where('blog_id', $this->blogId)
            ->where('language_id', $this->sourceLangId)
            ->first();

        if (!$sourceContent || empty($sourceContent->title)) {
            return;
        }

        $targetContent = BlogInformation::where('blog_id', $this->blogId)
            ->where('language_id', $this->targetLangId)
            ->first();

        if ($targetContent && !empty($targetContent->title)) {
            return;
        }

        $translated = $translator->translate(
            $sourceContent,
            $this->targetLangCode,
            $this->targetLangName
        );

        if (!$targetContent) {
            $targetContent = new BlogInformation();
            $targetContent->blog_id = $this->blogId;
            $targetContent->language_id = $this->targetLangId;
            $targetContent->blog_category_id = $sourceContent->blog_category_id;
        }

        $targetContent->title = $translated['title'] ?? '';

        $slugTitle = $translated['title'] ?? '';
        if ($this->targetLangCode !== 'en') {
            $enLanguage = Language::where('code', 'en')->first();
            if ($enLanguage) {
                $enContent = BlogInformation::where('blog_id', $this->blogId)
                    ->where('language_id', $enLanguage->id)
                    ->first();
                if ($enContent && !empty($enContent->title)) {
                    $slugTitle = $enContent->title;
                }
            }
        }
        $targetContent->slug = createSlug($slugTitle);
        $targetContent->author = $translated['author'] ?? ($sourceContent->author ?? '');
        $targetContent->content = $translated['content'] ?? ($sourceContent->content ?? '');
        $targetContent->meta_keywords = $translated['meta_keywords'] ?? '';
        $targetContent->meta_description = $translated['meta_description'] ?? '';

        $targetContent->save();

        $currentTranslations = DB::table('blogs')
            ->where('id', $this->blogId)
            ->value('translated_languages');

        $currentTranslations = $currentTranslations ? json_decode($currentTranslations, true) : [];
        if (!is_array($currentTranslations)) {
            $currentTranslations = [];
        }

        $currentTranslations[$this->targetLangCode] = true;

        DB::table('blogs')
            ->where('id', $this->blogId)
            ->update(['translated_languages' => json_encode($currentTranslations)]);
    }

    public function failed(\Throwable $e): void
    {
        Log::error("Translation job failed for blog #{$this->blogId} to {$this->targetLangCode}: " . $e->getMessage());
    }
}
