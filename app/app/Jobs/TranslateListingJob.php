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
        try {
            $sourceContent = ListingContent::where('listing_id', $this->listingId)
                ->where('language_id', $this->sourceLangId)
                ->first();

            if (!$sourceContent || empty($sourceContent->title)) {
                Log::channel('translate')->warning("TranslateListingJob [listing_id={$this->listingId}]: source content not found for lang #{$this->sourceLangId}, trying first available...");
                $sourceContent = ListingContent::where('listing_id', $this->listingId)
                    ->whereNotNull('title')
                    ->where('title', '!=', '')
                    ->first();
                if (!$sourceContent) {
                    Log::channel('translate')->warning("TranslateListingJob [listing_id={$this->listingId}]: no filled content found in any language");
                    return;
                }
                Log::channel('translate')->info("TranslateListingJob [listing_id={$this->listingId}]: using lang #{$sourceContent->language_id} as source instead");
            }

            $targetContent = ListingContent::where('listing_id', $this->listingId)
                ->where('language_id', $this->targetLangId)
                ->first();

            if ($targetContent && !empty($targetContent->title)) {
                Log::channel('translate')->info("TranslateListingJob [listing_id={$this->listingId}]: already translated to {$this->targetLangCode}");
                return;
            }

            Log::channel('translate')->info("TranslateListingJob [listing_id={$this->listingId}]: calling translate from ru to {$this->targetLangCode}");

            $translated = $translator->translate(
                $sourceContent,
                $this->targetLangCode,
                $this->targetLangName
            );

            Log::channel('translate')->info("TranslateListingJob [listing_id={$this->listingId}]: translate response to {$this->targetLangCode}: " . json_encode($translated));

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
            $targetContent->slug = unique_listing_slug(
                $translated['title'] ?? $sourceContent->title ?? '',
                $this->targetLangId,
                $targetContent->id
            );
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

            Log::channel('translate')->info("TranslateListingJob [listing_id={$this->listingId}]: successfully translated to {$this->targetLangCode}");
        } catch (\Throwable $e) {
            Log::channel('translate')->error("TranslateListingJob [listing_id={$this->listingId}] error to {$this->targetLangCode}: " . $e->getMessage() . "\n" . $e->getTraceAsString());
            throw $e;
        }
    }

    public function failed(\Throwable $e): void
    {
        Log::channel('translate')->error("TranslateListingJob [listing_id={$this->listingId}] FAILED to {$this->targetLangCode}: " . $e->getMessage());
    }
}
