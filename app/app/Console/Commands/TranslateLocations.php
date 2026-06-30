<?php

namespace App\Console\Commands;

use App\Jobs\TranslateLocationBatchJob;
use App\Models\Language;
use App\Models\Location\City;
use App\Models\Location\Country;
use App\Models\Location\State;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class TranslateLocations extends Command
{
    protected $signature = 'locations:translate {--batch=5 : Number of entities per run}';
    protected $description = 'Translate locations to all missing languages in one job';

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

        $totalLangs = Language::count();
        $batchSize = max(1, (int) $this->option('batch'));

        foreach (['country', 'state', 'city'] as $entityType) {
            $table = match ($entityType) {
                'country' => 'countries',
                'state' => 'states',
                'city' => 'cities',
            };
            $contentTable = $entityType . '_contents';
            $fk = $entityType . '_id';

            $pending = DB::select("
                SELECT e.id FROM {$table} e
                WHERE (
                    SELECT COUNT(*) FROM {$contentTable}
                    WHERE {$fk} = e.id AND name IS NOT NULL AND name != ''
                ) > 0
                AND (
                    SELECT COUNT(*) FROM {$contentTable}
                    WHERE {$fk} = e.id AND name IS NOT NULL AND name != ''
                ) < ?
                LIMIT ?
            ", [$totalLangs, $batchSize]);

            $ids = [];
            foreach ($pending as $row) {
                $source = DB::table($contentTable)
                    ->where($fk, $row->id)
                    ->whereNotNull('name')->where('name', '!=', '')
                    ->first();
                if (!$source) continue;

                TranslateLocationBatchJob::dispatchSync(
                    entityType: $entityType,
                    entityId: $row->id,
                    sourceLangId: $source->language_id,
                );
                $ids[] = $row->id;
            }

            if ($ids) {
                Log::channel('translate')->info("Dispatched {$entityType} batch jobs: [" . implode(', ', $ids) . "]");
                $this->info("Dispatched " . count($ids) . " {$entityType} batch translation jobs: [" . implode(', ', $ids) . "]");
            }
        }

        return self::SUCCESS;
    }
}
