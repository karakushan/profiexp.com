<?php

namespace App\Jobs;

use App\Models\Language;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingContent;
use App\Services\Ai\ListingTranslationService;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;

class TranslateListingBatchJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public int $tries = 3;

    public function __construct(
        public int $listingId,
        public int $sourceLangId,
    ) {
    }

    public function handle(ListingTranslationService $translator): void
    {
        $listing = Listing::find($this->listingId);
        if (!$listing) {
            Log::channel('translate')->warning("TranslateListingBatchJob [listing_id={$this->listingId}]: listing not found");
            return;
        }

        $sourceContent = ListingContent::where('listing_id', $this->listingId)
            ->where('language_id', $this->sourceLangId)
            ->first();

        if (!$sourceContent || empty($sourceContent->title)) {
            $sourceContent = ListingContent::where('listing_id', $this->listingId)
                ->whereNotNull('title')->where('title', '!=', '')
                ->first();
            if (!$sourceContent) {
                Log::channel('translate')->warning("TranslateListingBatchJob [listing_id={$this->listingId}]: no filled content found");
                return;
            }
            Log::channel('translate')->info("TranslateListingBatchJob [listing_id={$this->listingId}]: using lang #{$sourceContent->language_id} as source instead");
        }

        $sourceLang = Language::find($sourceContent->language_id);
        $targetLanguages = Language::where('id', '!=', $sourceContent->language_id)->get();

        $translatedLangs = $listing->translated_languages ? json_decode($listing->translated_languages, true) : [];
        if (!is_array($translatedLangs)) $translatedLangs = [];

        foreach ($targetLanguages as $targetLang) {
            $targetContent = ListingContent::where('listing_id', $this->listingId)
                ->where('language_id', $targetLang->id)
                ->first();

            $addressIsFilled = $targetContent && !empty($targetContent->address);
            if (!empty($translatedLangs[$targetLang->code])) {
                if (!$targetContent || empty($targetContent->title) || $addressIsFilled) continue;
            }
            if ($targetContent && !empty($targetContent->title) && $addressIsFilled) continue;

            try {
                $translated = $translator->translate(
                    $sourceContent,
                    $targetLang->code,
                    $targetLang->name
                );

                if ($targetContent && !empty($targetContent->title)) {
                    if (empty($targetContent->address) && !empty($translated['address'])) {
                        $targetContent->address = $translated['address'];
                        $targetContent->save();
                    }

                    $translatedLangs[$targetLang->code] = true;
                    continue;
                }

                if (!$targetContent) {
                    $targetContent = new ListingContent();
                    $targetContent->listing_id = $this->listingId;
                    $targetContent->language_id = $targetLang->id;
                    $targetContent->category_id = $sourceContent->category_id;
                    $targetContent->country_id = $sourceContent->country_id;
                    $targetContent->state_id = $sourceContent->state_id;
                    $targetContent->city_id = $sourceContent->city_id;
                }

                $targetContent->title = $translated['title'] ?? '';
                $slugTitle = $translated['title'] ?? '';
                if ($targetLang->code !== 'en') {
                    $enLang = Language::where('code', 'en')->first();
                    if ($enLang) {
                        $enContent = ListingContent::where('listing_id', $this->listingId)
                            ->where('language_id', $enLang->id)
                            ->first();
                        if ($enContent && !empty($enContent->title)) {
                            $slugTitle = $enContent->title;
                        }
                    }
                }
                $targetContent->slug = Str::slug($slugTitle);
                $targetContent->description = $translated['description'] ?? ($sourceContent->description ?? '');
                $targetContent->summary = $translated['summary'] ?? '';
                if (empty($targetContent->address)) {
                    $targetContent->address = $translated['address'] ?? '';
                }
                $targetContent->meta_keyword = $translated['meta_keyword'] ?? '';
                $targetContent->meta_description = $translated['meta_description'] ?? '';
                $targetContent->save();

                $translatedLangs[$targetLang->code] = true;

                Log::channel('translate')->info("TranslateListingBatchJob [listing_id={$this->listingId}]: translated to {$targetLang->code}");
            } catch (\Throwable $e) {
                Log::channel('translate')->error("TranslateListingBatchJob [listing_id={$this->listingId}] error to {$targetLang->code}: " . $e->getMessage());
            }
        }

        DB::table('listings')
            ->where('id', $this->listingId)
            ->update(['translated_languages' => json_encode($translatedLangs)]);
    }

    public function failed(\Throwable $e): void
    {
        Log::channel('translate')->error("TranslateListingBatchJob [listing_id={$this->listingId}] FAILED: " . $e->getMessage());
    }
}
