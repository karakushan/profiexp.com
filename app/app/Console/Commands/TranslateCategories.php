<?php

namespace App\Console\Commands;

use App\Jobs\TranslateCategoryJob;
use App\Models\Language;
use App\Models\ListingCategory;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class TranslateCategories extends Command
{
    protected $signature = 'categories:translate {--batch=5 : Number of categories per language per run}';
    protected $description = 'Dispatch translation jobs for categories without translations';

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

        $targetLanguages = Language::where('id', '!=', $defaultLang->id)->get();
        if ($targetLanguages->isEmpty()) {
            return self::SUCCESS;
        }

        $batchSize = max(1, (int) $this->option('batch'));

        $this->dispatchDefaultBatch($defaultLang, $batchSize);

        foreach ($targetLanguages as $targetLang) {
            $this->dispatchBatch($defaultLang->id, $targetLang, $batchSize);
        }

        return self::SUCCESS;
    }

    private function dispatchDefaultBatch(Language $defaultLang, int $batchSize): void
    {
        $pendingCategories = ListingCategory::whereDoesntHave('contents', function ($q) use ($defaultLang) {
            $q->where('language_id', $defaultLang->id)
                ->whereNotNull('name')
                ->where('name', '!=', '');
        })
            ->whereHas('contents', function ($q) {
                $q->whereNotNull('name')->where('name', '!=', '');
            })
            ->with(['contents' => function ($q) {
                $q->whereNotNull('name')->where('name', '!=', '');
            }])
            ->limit($batchSize)
            ->get();

        $ids = [];
        foreach ($pendingCategories as $category) {
            $sourceContent = $category->contents->first();
            if (!$sourceContent) continue;

            TranslateCategoryJob::dispatchSync(
                categoryId: $category->id,
                sourceLangId: $defaultLang->id,
                targetLangId: $defaultLang->id,
                targetLangCode: $defaultLang->code,
                targetLangName: $defaultLang->name,
            );
            $ids[] = $category->id;
        }

        if ($ids) {
            Log::channel('translate')->info("Dispatched default lang category jobs: [" . implode(', ', $ids) . "]");
            $this->info("Dispatched " . count($ids) . " category translation jobs for default language: [" . implode(', ', $ids) . "]");
        }
    }

    private function dispatchBatch(int $defaultLangId, Language $targetLang, int $batchSize): void
    {
        $pendingCategories = ListingCategory::whereDoesntHave('contents', function ($q) use ($targetLang) {
            $q->where('language_id', $targetLang->id);
        })
            ->whereHas('contents', function ($q) use ($defaultLangId) {
                $q->where('language_id', $defaultLangId)
                    ->whereNotNull('name')
                    ->where('name', '!=', '');
            })
            ->limit($batchSize)
            ->get();

        $ids = [];
        foreach ($pendingCategories as $category) {
            TranslateCategoryJob::dispatch(
                categoryId: $category->id,
                sourceLangId: $defaultLangId,
                targetLangId: $targetLang->id,
                targetLangCode: $targetLang->code,
                targetLangName: $targetLang->name,
            );
            $ids[] = $category->id;
        }

        if ($ids) {
            Log::channel('translate')->info("Dispatched category jobs for {$targetLang->code}: [" . implode(', ', $ids) . "]");
            $this->info("Dispatched " . count($ids) . " category translation jobs for {$targetLang->code}: [" . implode(', ', $ids) . "]");
        }
    }
}