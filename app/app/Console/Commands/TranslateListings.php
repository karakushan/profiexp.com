<?php

namespace App\Console\Commands;

use App\Jobs\TranslateListingJob;
use App\Models\Language;
use App\Models\Listing\Listing;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class TranslateListings extends Command
{
    protected $signature = 'listings:translate {--batch=3 : Number of listings per language per run}';
    protected $description = 'Dispatch translation jobs for pending listings';

    public function handle(): int
    {
        $autoTranslateEnabled = DB::table('basic_settings')->value('auto_translate_status');

        if (!$autoTranslateEnabled) {
            $this->info('Auto-translate is disabled in settings.');
            return self::SUCCESS;
        }

        $defaultLang = Language::where('is_default', 1)->first();
        if (!$defaultLang) {
            Log::warning('TranslateListings: no default language found');
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
        $pendingListings = Listing::query()
            ->where(function ($query) use ($targetLang) {
                $query->whereNull('translated_languages')
                    ->orWhereRaw('JSON_CONTAINS_PATH(translated_languages, \'one\', ?) = 0', [
                        '$."' . $targetLang->code . '"',
                    ]);
            })
            ->whereHas('listing_content', function ($query) use ($defaultLangId) {
                $query->where('language_id', $defaultLangId)
                    ->whereNotNull('title')
                    ->where('title', '!=', '');
            })
            ->whereHas('listing_content', function ($query) use ($targetLang) {
                $query->where('language_id', $targetLang->id)
                    ->where(function ($q) {
                        $q->whereNull('title')->orWhere('title', '');
                    });
            })
            ->limit($batchSize)
            ->get();

        $count = 0;
        foreach ($pendingListings as $listing) {
            TranslateListingJob::dispatch(
                listingId: $listing->id,
                sourceLangId: $defaultLangId,
                targetLangId: $targetLang->id,
                targetLangCode: $targetLang->code,
                targetLangName: $targetLang->name,
            );
            $count++;
        }

        if ($count > 0) {
            Log::info("Dispatched {$count} translation jobs for {$targetLang->code}");
            $this->info("Dispatched {$count} translation jobs for {$targetLang->code}");
        }
    }
}
