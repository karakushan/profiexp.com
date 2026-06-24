<?php

namespace App\Jobs;

use App\Models\Listing\Listing;
use App\Models\Listing\ListingContent;
use App\Models\Language;
use App\Services\Ai\ListingTranslationService;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;

class TranslateListingJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public int $tries = 2;

    public function __construct(
        public int $listingId,
        public int $sourceLangId,
        public int $targetLangId,
        public string $targetLangCode,
        public string $targetLangName,
    ) {
    }

    public function handle(ListingTranslationService $translator): void
    {
        $sourceContent = ListingContent::where('listing_id', $this->listingId)
            ->where('language_id', $this->sourceLangId)
            ->first();

        if (!$sourceContent || empty($sourceContent->title)) {
            return;
        }

        $targetContent = ListingContent::where('listing_id', $this->listingId)
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
            $targetContent = new ListingContent();
            $targetContent->listing_id = $this->listingId;
            $targetContent->language_id = $this->targetLangId;
            $targetContent->category_id = $sourceContent->category_id;
            $targetContent->country_id = $sourceContent->country_id;
            $targetContent->state_id = $sourceContent->state_id;
            $targetContent->city_id = $sourceContent->city_id;
        }

        $targetContent->title = $translated['title'] ?? '';
        $slugTitle = $translated['title'] ?? '';
        if ($this->targetLangCode !== 'en') {
            $enLanguage = Language::where('code', 'en')->first();
            if ($enLanguage) {
                $enContent = ListingContent::where('listing_id', $this->listingId)
                    ->where('language_id', $enLanguage->id)
                    ->first();
                if ($enContent && !empty($enContent->title)) {
                    $slugTitle = $enContent->title;
                }
            }
        }
        $targetContent->slug = Str::slug($slugTitle);
        $targetContent->description = $translated['description'] ?? ($sourceContent->description ?? '');
        $targetContent->summary = $translated['summary'] ?? '';
        $targetContent->address = $translated['address'] ?? '';
        $targetContent->meta_keyword = $translated['meta_keyword'] ?? '';
        $targetContent->meta_description = $translated['meta_description'] ?? '';

        $targetContent->save();

        $listing = Listing::find($this->listingId);
        if ($listing) {
            $currentTranslations = $listing->translated_languages
                ? json_decode($listing->translated_languages, true)
                : [];

            if (!is_array($currentTranslations)) {
                $currentTranslations = [];
            }

            $currentTranslations[$this->targetLangCode] = true;

            DB::table('listings')
                ->where('id', $this->listingId)
                ->update(['translated_languages' => json_encode($currentTranslations)]);
        }
    }

    public function failed(\Throwable $e): void
    {
        Log::error("Translation job failed for listing #{$this->listingId} to {$this->targetLangCode}: " . $e->getMessage());
    }
}
