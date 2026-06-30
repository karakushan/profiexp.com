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
            Log::channel('translate')->warning('TranslateListings: no default language found');
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
        $pendingListings = Listing::query()
            ->whereHas('listing_content', function ($q) {
                $q->whereNotNull('title')->where('title', '!=', '');
            })
            ->whereDoesntHave('listing_content', function ($q) use ($defaultLang) {
                $q->where('language_id', $defaultLang->id)
                    ->whereNotNull('title')->where('title', '!=', '');
            })
            ->limit($batchSize)
            ->get();

        $ids = [];
        foreach ($pendingListings as $listing) {
            TranslateListingJob::dispatch(
                listingId: $listing->id,
                sourceLangId: $defaultLang->id,
                targetLangId: $defaultLang->id,
                targetLangCode: $defaultLang->code,
                targetLangName: $defaultLang->name,
            );
            $ids[] = $listing->id;
        }

        if ($ids) {
            Log::channel('translate')->info("Dispatched default lang listing jobs: [" . implode(', ', $ids) . "]");
            $this->info("Dispatched " . count($ids) . " listing translation jobs for default language: [" . implode(', ', $ids) . "]");
        }
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
            ->where(function ($query) use ($targetLang) {
                $query->whereDoesntHave('listing_content', function ($q) use ($targetLang) {
                    $q->where('language_id', $targetLang->id);
                })->orWhereHas('listing_content', function ($q) use ($targetLang) {
                    $q->where('language_id', $targetLang->id)
                        ->where(function ($sq) {
                            $sq->whereNull('title')->orWhere('title', '');
                        });
                });
            })
            ->limit($batchSize)
            ->get();

        $ids = [];
        foreach ($pendingListings as $listing) {
            TranslateListingJob::dispatch(
                listingId: $listing->id,
                sourceLangId: $defaultLangId,
                targetLangId: $targetLang->id,
                targetLangCode: $targetLang->code,
                targetLangName: $targetLang->name,
            );
            $ids[] = $listing->id;
        }

        if ($ids) {
            Log::channel('translate')->info("Dispatched listing jobs for {$targetLang->code}: [" . implode(', ', $ids) . "]");
            $this->info("Dispatched " . count($ids) . " listing translation jobs for {$targetLang->code}: [" . implode(', ', $ids) . "]");
        }
    }
}
