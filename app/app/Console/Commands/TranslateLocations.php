<?php

namespace App\Console\Commands;

use App\Jobs\TranslateLocationJob;
use App\Models\Language;
use App\Models\Location\City;
use App\Models\Location\Country;
use App\Models\Location\State;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;

class TranslateLocations extends Command
{
    protected $signature = 'locations:translate {--batch=5 : Number of entities per language per run}';
    protected $description = 'Dispatch translation jobs for location entities (countries, states, cities)';

    public function handle(): int
    {
        $autoTranslateEnabled = DB::table('basic_settings')->value('auto_translate_status');

        if (!$autoTranslateEnabled) {
            $this->info('Auto-translate is disabled in settings.');
            return self::SUCCESS;
        }

        $defaultLang = Language::where('is_default', 1)->first();
        if (!$defaultLang) {
            Log::channel('translate')->warning('TranslateLocations: no default language found');
            return self::FAILURE;
        }

        $targetLanguages = Language::where('id', '!=', $defaultLang->id)->get();
        if ($targetLanguages->isEmpty()) {
            return self::SUCCESS;
        }

        $batchSize = max(1, (int) $this->option('batch'));

        $this->dispatchDefaultBatch($defaultLang, $batchSize);

        foreach ($targetLanguages as $targetLang) {
            $this->dispatchForModel(
                'country',
                Country::class,
                'App\Models\Location\CountryContent',
                $defaultLang->id,
                $targetLang,
                $batchSize,
            );

            $this->dispatchForModel(
                'state',
                State::class,
                'App\Models\Location\StateContent',
                $defaultLang->id,
                $targetLang,
                $batchSize,
            );

            $this->dispatchForModel(
                'city',
                City::class,
                'App\Models\Location\CityContent',
                $defaultLang->id,
                $targetLang,
                $batchSize,
            );
        }

        return self::SUCCESS;
    }

    private function dispatchDefaultBatch(Language $defaultLang, int $batchSize): void
    {
        foreach (['country', 'state', 'city'] as $entityType) {
            $modelClass = match ($entityType) {
                'country' => Country::class,
                'state' => State::class,
                'city' => City::class,
            };
            $contentClass = match ($entityType) {
                'country' => 'App\Models\Location\CountryContent',
                'state' => 'App\Models\Location\StateContent',
                'city' => 'App\Models\Location\CityContent',
            };

            $pendingIds = $modelClass::whereHas('contents', function ($q) {
                $q->whereNotNull('name')->where('name', '!=', '');
            })
                ->whereDoesntHave('contents', function ($q) use ($defaultLang) {
                    $q->where('language_id', $defaultLang->id)
                        ->whereNotNull('name')->where('name', '!=', '');
                })
                ->limit($batchSize)
                ->pluck('id');

            $dispatched = [];
            foreach ($pendingIds as $id) {
                TranslateLocationJob::dispatch(
                    entityType: $entityType,
                    entityId: $id,
                    sourceLangId: $defaultLang->id,
                    targetLangId: $defaultLang->id,
                    targetLangCode: $defaultLang->code,
                    targetLangName: $defaultLang->name,
                );
                $dispatched[] = $id;
            }

            if ($dispatched) {
                Log::channel('translate')->info("Dispatched default lang {$entityType} jobs: [" . implode(', ', $dispatched) . "]");
                $this->info("Dispatched " . count($dispatched) . " {$entityType} translation jobs for default language: [" . implode(', ', $dispatched) . "]");
            }
        }
    }

    private function dispatchForModel(
        string $entityType,
        string $modelClass,
        string $contentClass,
        int $defaultLangId,
        Language $targetLang,
        int $batchSize,
    ): void {
        $pendingIds = $modelClass::whereDoesntHave('contents', function ($q) use ($targetLang, $contentClass) {
            $q->where('language_id', $targetLang->id);
        })
            ->whereHas('contents', function ($q) use ($defaultLangId) {
                $q->where('language_id', $defaultLangId)
                    ->whereNotNull('name')
                    ->where('name', '!=', '');
            })
            ->limit($batchSize)
            ->pluck('id');

        $dispatched = [];
        foreach ($pendingIds as $id) {
            TranslateLocationJob::dispatch(
                entityType: $entityType,
                entityId: $id,
                sourceLangId: $defaultLangId,
                targetLangId: $targetLang->id,
                targetLangCode: $targetLang->code,
                targetLangName: $targetLang->name,
            );
            $dispatched[] = $id;
        }

        if ($dispatched) {
            Log::channel('translate')->info("Dispatched {$entityType} jobs for {$targetLang->code}: [" . implode(', ', $dispatched) . "]");
            $this->info("Dispatched " . count($dispatched) . " {$entityType} translation jobs for {$targetLang->code}: [" . implode(', ', $dispatched) . "]");
        }
    }
}
