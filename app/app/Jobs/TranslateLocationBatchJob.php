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

class TranslateLocationBatchJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public int $tries = 3;

    public function __construct(
        public string $entityType,
        public int $entityId,
        public int $sourceLangId,
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
            $sourceContent = match ($this->entityType) {
                'country' => CountryContent::where('country_id', $this->entityId)
                    ->whereNotNull('name')->where('name', '!=', '')->first(),
                'state' => StateContent::where('state_id', $this->entityId)
                    ->whereNotNull('name')->where('name', '!=', '')->first(),
                'city' => CityContent::where('city_id', $this->entityId)
                    ->whereNotNull('name')->where('name', '!=', '')->first(),
                default => null,
            };
            if (!$sourceContent) {
                Log::channel('translate')->warning("TranslateLocationBatchJob [{$this->entityType}#{$this->entityId}]: no filled content");
                return;
            }
            Log::channel('translate')->info("TranslateLocationBatchJob [{$this->entityType}#{$this->entityId}]: using lang #{$sourceContent->language_id} as source");
        }

        $targetLanguages = Language::where('id', '!=', $sourceContent->language_id)->get();

        foreach ($targetLanguages as $targetLang) {
            $exists = match ($this->entityType) {
                'country' => CountryContent::where('country_id', $this->entityId)
                    ->where('language_id', $targetLang->id)->exists(),
                'state' => StateContent::where('state_id', $this->entityId)
                    ->where('language_id', $targetLang->id)->exists(),
                'city' => CityContent::where('city_id', $this->entityId)
                    ->where('language_id', $targetLang->id)->exists(),
                default => true,
            };
            if ($exists) continue;

            try {
                $translated = match ($this->entityType) {
                    'country' => $translator->translateCountry($sourceContent, $targetLang->name),
                    'state' => $translator->translateState($sourceContent, $targetLang->name),
                    'city' => $translator->translateCity($sourceContent, $targetLang->name),
                    default => [],
                };

                if (empty($translated['name'])) continue;

                $data = ['name' => $translated['name']];

                if (in_array($this->entityType, ['city', 'state'], true)) {
                    $data['slug'] = createSlug($translated['name']);
                }

                try {
                    match ($this->entityType) {
                        'country' => CountryContent::updateOrCreate(
                            ['country_id' => $this->entityId, 'language_id' => $targetLang->id], $data
                        ),
                        'state' => StateContent::updateOrCreate(
                            ['state_id' => $this->entityId, 'language_id' => $targetLang->id], $data
                        ),
                        'city' => CityContent::updateOrCreate(
                            ['city_id' => $this->entityId, 'language_id' => $targetLang->id], $data
                        ),
                        default => null,
                    };
                } catch (\Throwable $e2) {
                    Log::channel('translate')->warning("TranslateLocationBatchJob [{$this->entityType}#{$this->entityId}] create error to {$targetLang->code}: " . $e2->getMessage());
                    continue;
                }

                Log::channel('translate')->info("TranslateLocationBatchJob [{$this->entityType}#{$this->entityId}]: translated to {$targetLang->code}");
            } catch (\Throwable $e) {
                Log::channel('translate')->error("TranslateLocationBatchJob [{$this->entityType}#{$this->entityId}] error to {$targetLang->code}: " . $e->getMessage());
            }
        }
    }

    public function failed(\Throwable $e): void
    {
        Log::channel('translate')->error("TranslateLocationBatchJob [{$this->entityType}#{$this->entityId}] FAILED: " . $e->getMessage());
    }
}
