<?php

namespace App\Jobs;

use App\Models\Language;
use App\Models\Location\ListingCityCategory;
use App\Models\Location\ListingCityCategoryContent;
use App\Services\Ai\CityCategoryTranslationService;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;

class TranslateCityCategoryBatchJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public int $tries = 3;

    public function __construct(public int $itemId, public int $sourceLangId)
    {
    }

    public function handle(CityCategoryTranslationService $translator): void
    {
        $item = ListingCityCategory::with(['city', 'category'])->find($this->itemId);
        if (!$item) return;

        $defaultLanguageId = Language::where('is_default', 1)->value('id');
        $hasSeo = function ($query) {
            $query->where(function ($seoQuery) {
                $seoQuery->whereNotNull('meta_title')->where('meta_title', '!=', '')
                    ->orWhereNotNull('meta_description')->where('meta_description', '!=', '')
                    ->orWhereNotNull('seo_text')->where('seo_text', '!=', '');
            });
        };

        $defaultContent = $item->contents()
            ->where('language_id', $defaultLanguageId)
            ->whereNotNull('name')
            ->where('name', '!=', '')
            ->first();

        $source = $item->contents()
            ->whereNotNull('name')
            ->where('name', '!=', '')
            ->where($hasSeo)
            ->orderBy('language_id')
            ->first();

        $source ??= $defaultContent;
        $source ??= $item->contents()
            ->whereNotNull('name')
            ->where('name', '!=', '')
            ->orderBy('language_id')
            ->first();
        if (!$source) return;

        foreach (Language::where('id', '!=', $source->language_id)->get() as $language) {
            $existing = $item->contents()->where('language_id', $language->id)->first();
            if ($existing
                && filled($existing->meta_title)
                && filled($existing->meta_description)
                && filled($existing->seo_text)) {
                continue;
            }

            $cityName = $item->city->getName($language->id);
            $categoryName = $item->category->getName($language->id);
            if (!$cityName || !$categoryName) continue;

            try {
                $translated = $translator->translate($source, $language->name);
                $name = trim($cityName . ' — ' . $categoryName);
                $baseSlug = createSlug($name) ?: 'city-category-' . $item->id;
                $slug = $baseSlug;
                $suffix = 2;
                while (ListingCityCategoryContent::where('language_id', $language->id)
                    ->where('slug', $slug)
                    ->when($existing, fn($query) => $query->where('id', '!=', $existing->id))
                    ->exists()) {
                    $slug = $baseSlug . '-' . $suffix++;
                }

                $item->contents()->updateOrCreate(
                    ['language_id' => $language->id],
                    [
                        'name' => $name,
                        'slug' => $slug,
                        'meta_title' => $translated['meta_title'] ?? '',
                        'meta_description' => $translated['meta_description'] ?? '',
                        'seo_text' => $translated['seo_text'] ?? '',
                    ]
                );
            } catch (\Throwable $e) {
                Log::channel('translate')->error("TranslateCityCategoryBatchJob [item_id={$this->itemId}] error: " . $e->getMessage());
            }
        }
    }
}
