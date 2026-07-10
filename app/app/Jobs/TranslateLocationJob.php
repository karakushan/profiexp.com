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
                Log::channel('translate')->warning("TranslateLocationJob [{$this->entityType}#{$this->entityId}]: source content not found for lang #{$this->sourceLangId}, trying first available...");
                $sourceContent = match ($this->entityType) {
                    'country' => CountryContent::where('country_id', $this->entityId)
                        ->whereNotNull('name')
                        ->where('name', '!=', '')
                        ->first(),
                    'state' => StateContent::where('state_id', $this->entityId)
                        ->whereNotNull('name')
                        ->where('name', '!=', '')
                        ->first(),
                    'city' => CityContent::where('city_id', $this->entityId)
                        ->whereNotNull('name')
                        ->where('name', '!=', '')
                        ->first(),
                    default => null,
                };
                if (!$sourceContent) {
                    Log::channel('translate')->warning("TranslateLocationJob [{$this->entityType}#{$this->entityId}]: no filled content found in any language");
                    return;
                }
                Log::channel('translate')->info("TranslateLocationJob [{$this->entityType}#{$this->entityId}]: using lang #{$sourceContent->language_id} as source instead");
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

            if (in_array($this->entityType, ['city', 'state'], true)) {
                $data['slug'] = createSlug($translated['name']);
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

    public function failed(\Throwable $e): void
    {
        Log::channel('translate')->error("TranslateLocationJob [{$this->entityType}#{$this->entityId}] FAILED to {$this->targetLangCode}: " . $e->getMessage());
    }
}
