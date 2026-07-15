<?php

namespace App\Console\Commands;

use App\Jobs\TranslateCategoryBatchJob;
use App\Models\Language;
use App\Models\ListingCategory;
use App\Models\ListingCategoryContent;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class TranslateCategories extends Command
{
    protected $signature = 'categories:translate {--batch=5 : Number of categories per run}';
    protected $description = 'Translate categories to all missing languages in one job';

    public function handle(): int
    {
        $autoTranslateEnabled = DB::table('basic_settings')->value('auto_translate_status');

        if (!$autoTranslateEnabled) {
            $this->info('Auto-translate is disabled in settings.');
            return self::SUCCESS;
        }

        $defaultLang = Language::where('is_default', 1)->first();
        if (!$defaultLang) {
            Log::channel('translate')->warning('TranslateCategories: no default language found');
            return self::FAILURE;
        }

        $totalLangs = Language::count();
        $batchSize = max(1, (int) $this->option('batch'));

        $pending = ListingCategory::whereHas('contents', function ($q) {
            $q->whereNotNull('name')->where('name', '!=', '');
        })
            ->with(['parent.contents'])
            ->withCount(['contents as filled_count' => function ($q) {
                $q->whereNotNull('name')->where('name', '!=', '');
            }])
            ->get()
            ->filter(function ($category) use ($totalLangs) {
                if ($category->filled_count <= 0 || $category->filled_count >= $totalLangs) {
                    return false;
                }

                if (!$category->parent_id) {
                    return true;
                }

                $parentLanguageCount = $category->parent?->contents
                    ->filter(fn($content) => filled($content->name))
                    ->pluck('language_id')
                    ->unique()
                    ->count() ?? 0;

                return $parentLanguageCount >= $totalLangs;
            })
            ->sortBy(fn($category) => [
                $category->parent_id ? 1 : 0,
                $category->serial_number ?? PHP_INT_MAX,
                $category->id,
            ])
            ->take($batchSize);

        $ids = [];
        foreach ($pending as $category) {
            $source = ListingCategoryContent::where('listing_category_id', $category->id)
                ->whereNotNull('name')->where('name', '!=', '')
                ->first();
            if (!$source) continue;

            TranslateCategoryBatchJob::dispatchSync(
                categoryId: $category->id,
                sourceLangId: $source->language_id,
            );
            $ids[] = $category->id;
        }

        if ($ids) {
            Log::channel('translate')->info("Dispatched category batch jobs: [" . implode(', ', $ids) . "]");
            $this->info("Dispatched " . count($ids) . " category batch translation jobs: [" . implode(', ', $ids) . "]");
        }

        return self::SUCCESS;
    }
}
