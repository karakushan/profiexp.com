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

        foreach ($targetLanguages as $targetLang) {
            $this->dispatchBatch($defaultLang->id, $targetLang, $batchSize);
        }

        return self::SUCCESS;
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

        $count = 0;
        foreach ($pendingCategories as $category) {
            TranslateCategoryJob::dispatch(
                categoryId: $category->id,
                sourceLangId: $defaultLangId,
                targetLangId: $targetLang->id,
                targetLangCode: $targetLang->code,
                targetLangName: $targetLang->name,
            );
            $count++;
        }

        if ($count > 0) {
            Log::channel('translate')->info("Dispatched {$count} category translation jobs for {$targetLang->code}");
            $this->info("Dispatched {$count} category translation jobs for {$targetLang->code}");
        }
    }
}