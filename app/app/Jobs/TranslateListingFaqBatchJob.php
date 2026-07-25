<?php

namespace App\Jobs;

use App\Models\Language;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingFaq;
use App\Services\Ai\ListingFaqTranslationService;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;

class TranslateListingFaqBatchJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public int $tries = 3;

    public function __construct(
        public int $listingId,
        public int $sourceLangId,
    ) {
    }

    public function handle(ListingFaqTranslationService $translator): void
    {
        $listing = Listing::find($this->listingId);
        if (!$listing) {
            Log::channel('translate')->warning("TranslateListingFaqBatchJob [listing_id={$this->listingId}]: listing not found");
            return;
        }

        ListingFaq::query()
            ->where('listing_id', $this->listingId)
            ->whereNotNull('question')->where('question', '!=', '')
            ->whereNotNull('answer')->where('answer', '!=', '')
            ->whereNull('serial_number')
            ->get(['id'])
            ->each(fn (ListingFaq $faq) => Log::channel('translate')->warning(
                "TranslateListingFaqBatchJob [listing_id={$this->listingId}, faq_id={$faq->id}]: filled FAQ has no valid serial_number and was skipped"
            ));

        $sourceFaqs = ListingFaq::query()
            ->where('listing_id', $this->listingId)
            ->where('language_id', $this->sourceLangId)
            ->whereNotNull('serial_number')
            ->whereNotNull('question')
            ->where('question', '!=', '')
            ->whereNotNull('answer')
            ->where('answer', '!=', '')
            ->orderBy('serial_number')
            ->orderBy('id')
            ->get();

        if ($sourceFaqs->isEmpty()) {
            $sourceFaqs = ListingFaq::query()
                ->where('listing_id', $this->listingId)
                ->whereNotNull('serial_number')
                ->whereNotNull('question')
                ->where('question', '!=', '')
                ->whereNotNull('answer')
                ->where('answer', '!=', '')
                ->orderBy('language_id')
                ->orderBy('serial_number')
                ->orderBy('id')
                ->get();
        }

        if ($sourceFaqs->isEmpty()) {
            Log::channel('translate')->warning("TranslateListingFaqBatchJob [listing_id={$this->listingId}]: no valid source FAQs found");
            return;
        }

        $sourceFaqs = $sourceFaqs->groupBy('serial_number')->map(function ($faqs, $serialNumber) {
            if ($faqs->count() > 1) {
                Log::channel('translate')->warning("TranslateListingFaqBatchJob: duplicate source serial_number={$serialNumber}; using the first FAQ");
            }

            return $faqs->first();
        });

        $languages = Language::query()->where('id', '!=', $this->sourceLangId)->get();

        foreach ($languages as $targetLanguage) {
            foreach ($sourceFaqs as $serialNumber => $sourceFaq) {
                $targetFaqs = ListingFaq::query()
                    ->where('listing_id', $this->listingId)
                    ->where('language_id', $targetLanguage->id)
                    ->where('serial_number', $serialNumber)
                    ->orderBy('id')
                    ->get();

                if ($targetFaqs->count() > 1) {
                    Log::channel('translate')->warning("TranslateListingFaqBatchJob [listing_id={$this->listingId}]: duplicate target serial_number={$serialNumber} for {$targetLanguage->code}; using the first FAQ");
                }

                $targetFaq = $targetFaqs->first();
                if ($targetFaq && filled($targetFaq->question) && filled($targetFaq->answer)) {
                    continue;
                }

                try {
                    $translated = $translator->translate(
                        $sourceFaq,
                        $targetLanguage->code,
                        $targetLanguage->name,
                    );

                    $question = trim((string) ($translated['question'] ?? ''));
                    $answer = (string) ($translated['answer'] ?? '');

                    if (!$targetFaq && ($question === '' || trim($answer) === '')) {
                        Log::channel('translate')->warning("TranslateListingFaqBatchJob [listing_id={$this->listingId}, serial_number={$serialNumber}]: incomplete AI response for {$targetLanguage->code}; FAQ was not created");
                        continue;
                    }

                    if (!$targetFaq) {
                        $targetFaq = new ListingFaq();
                        $targetFaq->listing_id = $this->listingId;
                        $targetFaq->language_id = $targetLanguage->id;
                        $targetFaq->serial_number = $serialNumber;
                    }

                    if (blank($targetFaq->question) && $question !== '') {
                        $targetFaq->question = $question;
                    }
                    if (blank($targetFaq->answer) && trim($answer) !== '') {
                        $targetFaq->answer = $answer;
                    }

                    $targetFaq->save();

                    Log::channel('translate')->info("TranslateListingFaqBatchJob [listing_id={$this->listingId}, serial_number={$serialNumber}]: translated to {$targetLanguage->code}");
                } catch (\Throwable $e) {
                    Log::channel('translate')->error("TranslateListingFaqBatchJob [listing_id={$this->listingId}, serial_number={$serialNumber}] error to {$targetLanguage->code}: " . $e->getMessage());
                }
            }
        }
    }

    public function failed(\Throwable $e): void
    {
        Log::channel('translate')->error("TranslateListingFaqBatchJob [listing_id={$this->listingId}] FAILED: " . $e->getMessage());
    }
}
