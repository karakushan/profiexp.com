<?php

namespace App\Jobs;

use App\Models\Language;
use App\Models\ListingCategory;
use App\Models\ListingCategoryContent;
use App\Services\Ai\CategoryTranslationService;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;

class TranslateCategoryBatchJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public int $tries = 3;

    public function __construct(
        public int $categoryId,
        public int $sourceLangId,
    ) {
    }

    public function handle(CategoryTranslationService $translator): void
    {
        $category = ListingCategory::find($this->categoryId);
        if (!$category) {
            Log::channel('translate')->warning("TranslateCategoryBatchJob [cat_id={$this->categoryId}]: category not found");
            return;
        }

        $sourceContent = ListingCategoryContent::where('listing_category_id', $this->categoryId)
            ->where('language_id', $this->sourceLangId)
            ->first();

        if (!$sourceContent || empty($sourceContent->name)) {
            $sourceContent = ListingCategoryContent::where('listing_category_id', $this->categoryId)
                ->whereNotNull('name')->where('name', '!=', '')
                ->first();
            if (!$sourceContent) {
                Log::channel('translate')->warning("TranslateCategoryBatchJob [cat_id={$this->categoryId}]: no filled content found");
                return;
            }
            Log::channel('translate')->info("TranslateCategoryBatchJob [cat_id={$this->categoryId}]: using lang #{$sourceContent->language_id} as source");
        }

        $targetLanguages = Language::where('id', '!=', $sourceContent->language_id)->get();

        foreach ($targetLanguages as $targetLang) {
            $exists = ListingCategoryContent::where('listing_category_id', $this->categoryId)
                ->where('language_id', $targetLang->id)
                ->whereNotNull('name')->where('name', '!=', '')
                ->exists();
            if ($exists) continue;

            try {
                $translated = $translator->translate(
                    $sourceContent,
                    $targetLang->code,
                    $targetLang->name
                );

                $slug = $translated['slug'] ?? '';
                if (empty($slug)) {
                    $slug = Str::slug($translated['name'] ?? $sourceContent->name);
                }

                if ($targetLang->code !== 'en' && !empty($translated['name'])) {
                    $transliterated = Str::slug($translated['name']);
                    if (!empty($transliterated)) $slug = $transliterated;
                }

                ListingCategoryContent::create([
                    'listing_category_id' => $this->categoryId,
                    'language_id' => $targetLang->id,
                    'name' => $translated['name'] ?? '',
                    'slug' => $slug,
                    'meta_title' => $translated['meta_title'] ?? '',
                    'meta_description' => $translated['meta_description'] ?? '',
                    'seo_text' => $translated['seo_text'] ?? '',
                ]);

                Log::channel('translate')->info("TranslateCategoryBatchJob [cat_id={$this->categoryId}]: translated to {$targetLang->code}");
            } catch (\Throwable $e) {
                Log::channel('translate')->error("TranslateCategoryBatchJob [cat_id={$this->categoryId}] error to {$targetLang->code}: " . $e->getMessage());
            }
        }
    }

    public function failed(\Throwable $e): void
    {
        Log::channel('translate')->error("TranslateCategoryBatchJob [cat_id={$this->categoryId}] FAILED: " . $e->getMessage());
    }
}
