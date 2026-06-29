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
            return;
        }

        $translated = match ($this->entityType) {
            'country' => $translator->translateCountry($sourceContent, $this->targetLangName),
            'state' => $translator->translateState($sourceContent, $this->targetLangName),
            'city' => $translator->translateCity($sourceContent, $this->targetLangName),
            default => [],
        };

        if (empty($translated['name'])) {
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
        Log::error("Translation job failed for {$this->entityType} #{$this->entityId} to {$this->targetLangCode}: " . $e->getMessage());
    }
}
