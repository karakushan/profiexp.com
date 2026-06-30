<?php

namespace App\Jobs;

use App\Models\Language;
use App\Models\Location\City;
use App\Models\Location\CityContent;
use App\Models\Location\Country;
use App\Models\Location\CountryContent;
use App\Models\Location\State;
use App\Models\Location\StateContent;
use App\Services\Ai\LocationTranslationService;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;

class TranslateLocationJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public int $tries = 2;

    public function __construct(
        public string $entityType,
        public int $entityId,
        public int $sourceLangId,
        public int $targetLangId,
        public string $targetLangCode,
        public string $targetLangName,
    ) {
    }

    public function handle(LocationTranslationService $translator): void
    {
        try {
            $sourceContent = match ($this->entityType) {
                'country' => CountryContent::where('country_id', $this->entityId)
                    ->where('language_id', $this->sourceLangId)
                    ->first(),
                'state' => StateContent::where('state_id', $this->entityId)
                    ->where('language_id', $this->sourceLangId)
                    ->first(),
                'city' => CityContent::where('city_id', $this->entityId)
                    ->where('language_id', $this->sourceLangId)
                    ->first(),
                default => null,
            };

            if (!$sourceContent || empty($sourceContent->name)) {
                Log::channel('translate')->warning("TranslateLocationJob [{$this->entityType}#{$this->entityId}]: source content not found for lang #{$this->sourceLangId}");
                return;
            }

            $exists = match ($this->entityType) {
                'country' => CountryContent::where('country_id', $this->entityId)
                    ->where('language_id', $this->targetLangId)
                    ->exists(),
                'state' => StateContent::where('state_id', $this->entityId)
                    ->where('language_id', $this->targetLangId)
                    ->exists(),
                'city' => CityContent::where('city_id', $this->entityId)
                    ->where('language_id', $this->targetLangId)
                    ->exists(),
                default => true,
            };

            if ($exists) {
                Log::channel('translate')->info("TranslateLocationJob [{$this->entityType}#{$this->entityId}]: already translated to {$this->targetLangCode}");
                return;
            }

            Log::channel('translate')->info("TranslateLocationJob [{$this->entityType}#{$this->entityId}]: calling translate to {$this->targetLangCode}");

            $translated = match ($this->entityType) {
                'country' => $translator->translateCountry($sourceContent, $this->targetLangName),
                'state' => $translator->translateState($sourceContent, $this->targetLangName),
                'city' => $translator->translateCity($sourceContent, $this->targetLangName),
                default => [],
            };

            Log::channel('translate')->info("TranslateLocationJob [{$this->entityType}#{$this->entityId}]: translate response to {$this->targetLangCode}: " . json_encode($translated));

            if (empty($translated['name'])) {
                Log::channel('translate')->warning("TranslateLocationJob [{$this->entityType}#{$this->entityId}]: empty translation result to {$this->targetLangCode}");
                return;
            }

            $data = ['name' => $translated['name']];

            if ($this->entityType === 'city') {
                $slug = $translated['slug'] ?? '';
                if (empty($slug)) {
                    $slug = Str::slug($translated['name']);
                }
                if ($this->targetLangCode !== 'en') {
                    $transliterated = $this->transliterateSlug($translated['name']);
                    if (!empty($transliterated)) {
                        $slug = $transliterated;
                    }
                }
                $data['slug'] = $slug;
            }

            match ($this->entityType) {
                'country' => CountryContent::create(array_merge(
                    ['country_id' => $this->entityId, 'language_id' => $this->targetLangId],
                    $data
                )),
                'state' => StateContent::create(array_merge(
                    ['state_id' => $this->entityId, 'language_id' => $this->targetLangId],
                    $data
                )),
                'city' => CityContent::create(array_merge(
                    ['city_id' => $this->entityId, 'language_id' => $this->targetLangId],
                    $data
                )),
                default => null,
            };

            Log::channel('translate')->info("TranslateLocationJob [{$this->entityType}#{$this->entityId}]: successfully translated to {$this->targetLangCode}");
        } catch (\Throwable $e) {
            Log::channel('translate')->error("TranslateLocationJob [{$this->entityType}#{$this->entityId}] error to {$this->targetLangCode}: " . $e->getMessage() . "\n" . $e->getTraceAsString());
            throw $e;
        }
    }

    private function transliterateSlug(string $text): string
    {
        $slug = Str::slug($text);
        if (!empty($slug)) {
            return $slug;
        }

        $enLanguage = Language::where('code', 'en')->first();
        if ($enLanguage) {
            $enContent = CityContent::where('city_id', $this->entityId)
                ->where('language_id', $enLanguage->id)
                ->first();
            if ($enContent && !empty($enContent->slug)) {
                return $enContent->slug;
            }
        }

        return '';
    }

    public function failed(\Throwable $e): void
    {
        Log::channel('translate')->error("TranslateLocationJob [{$this->entityType}#{$this->entityId}] FAILED to {$this->targetLangCode}: " . $e->getMessage());
    }
}
