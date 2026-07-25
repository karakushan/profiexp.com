<?php

namespace App\Console\Commands;

use App\Jobs\TranslateListingFaqBatchJob;
use App\Models\Language;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingFaq;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class TranslateListingFaqs extends Command
{
    protected $signature = 'faq:translate {--batch=5 : Number of listings per run}';
    protected $description = 'Translate listing FAQs to all missing languages in one job';

    public function handle(): int
    {
        if (!DB::table('basic_settings')->value('auto_translate_status')) {
            $this->info('Auto-translate is disabled in settings.');
            return self::SUCCESS;
        }

        $languages = Language::query()->orderBy('id')->get();
        $defaultLanguage = $languages->firstWhere('is_default', 1);
        if (!$defaultLanguage) {
            Log::channel('translate')->warning('TranslateListingFaqs: no default language found');
            return self::FAILURE;
        }

        $batchSize = max(1, (int) $this->option('batch'));
        $candidateListings = Listing::query()
            ->whereHas('listingFaqs', fn ($query) => $query
                ->whereNotNull('question')->where('question', '!=', '')
                ->whereNotNull('answer')->where('answer', '!=', ''))
            ->orderByDesc('id')
            ->with('listingFaqs')
            ->get();

        $dispatched = [];

        foreach ($candidateListings as $listing) {
            if (count($dispatched) >= $batchSize) {
                break;
            }

            foreach ($listing->listingFaqs->filter(fn (ListingFaq $faq) =>
                $this->isFilledFaq($faq) && $faq->serial_number === null) as $invalidFaq) {
                Log::channel('translate')->warning("TranslateListingFaqs [listing_id={$listing->id}, faq_id={$invalidFaq->id}]: filled FAQ has no valid serial_number and was skipped");
            }

            $sourceLangId = $this->sourceLanguageId($listing, $defaultLanguage->id);
            if (!$sourceLangId) {
                continue;
            }

            $sourceSerials = $listing->listingFaqs
                ->filter(fn (ListingFaq $faq) => $this->isFilledFaq($faq) && $faq->serial_number !== null)
                ->where('language_id', $sourceLangId)
                ->pluck('serial_number')
                ->unique()
                ->values();

            if ($sourceSerials->isEmpty()) {
                Log::channel('translate')->warning("TranslateListingFaqs [listing_id={$listing->id}]: no valid source serials found");
                continue;
            }

            $hasPending = $languages
                ->where('id', '!=', $sourceLangId)
                ->contains(function (Language $targetLanguage) use ($listing, $sourceSerials) {
                    return $sourceSerials->contains(function ($serialNumber) use ($listing, $targetLanguage) {
                        $targetFaq = $listing->listingFaqs
                            ->first(fn (ListingFaq $faq) =>
                                (int) $faq->language_id === (int) $targetLanguage->id
                                && (string) $faq->serial_number === (string) $serialNumber);

                        return !$targetFaq || blank($targetFaq->question) || blank($targetFaq->answer);
                    });
                });

            if (!$hasPending) {
                continue;
            }

            TranslateListingFaqBatchJob::dispatchSync(
                listingId: $listing->id,
                sourceLangId: $sourceLangId,
            );
            $dispatched[] = $listing->id;
        }

        if ($dispatched) {
            $ids = implode(', ', $dispatched);
            Log::channel('translate')->info("Dispatched listing FAQ batch jobs: [{$ids}]");
            $this->info("Dispatched " . count($dispatched) . " listing FAQ translation jobs: [{$ids}]");
        }

        return self::SUCCESS;
    }

    private function sourceLanguageId(Listing $listing, int $defaultLanguageId): ?int
    {
        $filledFaqs = $listing->listingFaqs
            ->filter(fn (ListingFaq $faq) => $this->isFilledFaq($faq) && $faq->serial_number !== null);

        if ($filledFaqs->contains(fn (ListingFaq $faq) => (int) $faq->language_id === $defaultLanguageId)) {
            return $defaultLanguageId;
        }

        return $filledFaqs->pluck('language_id')->filter()->sort()->first();
    }

    private function isFilledFaq(ListingFaq $faq): bool
    {
        return filled($faq->question) && filled($faq->answer);
    }
}
