<?php

namespace App\Console\Commands;

use App\Jobs\TranslateAminiteBatchJob;
use App\Models\Aminite;
use App\Models\AminiteContent;
use App\Models\Language;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class TranslateAminites extends Command
{
    protected $signature = 'aminites:translate {--batch=5 : Number of aminites per run}';
    protected $description = 'Translate aminites to all missing languages in one job';

    public function handle(): int
    {
        $autoTranslateEnabled = DB::table('basic_settings')->value('auto_translate_status');

        if (!$autoTranslateEnabled) {
            $this->info('Auto-translate is disabled in settings.');
            return self::SUCCESS;
        }

        $defaultLang = Language::where('is_default', 1)->first();
        if (!$defaultLang) {
            Log::channel('translate')->warning('TranslateAminites: no default language found');
            return self::FAILURE;
        }

        $totalLangs = Language::count();
        $batchSize = max(1, (int) $this->option('batch'));

        $pending = Aminite::whereHas('contents', function ($q) {
            $q->whereNotNull('title')->where('title', '!=', '');
        })
            ->withCount(['contents as filled_count' => function ($q) {
                $q->whereNotNull('title')->where('title', '!=', '');
            }])
            ->get()
            ->filter(fn($c) => $c->filled_count > 0 && $c->filled_count < $totalLangs)
            ->take($batchSize);

        $ids = [];
        foreach ($pending as $aminite) {
            $source = AminiteContent::where('aminite_id', $aminite->id)
                ->whereNotNull('title')->where('title', '!=', '')
                ->first();
            if (!$source) continue;

            TranslateAminiteBatchJob::dispatchSync(
                aminiteId: $aminite->id,
                sourceLangId: $source->language_id,
            );
            $ids[] = $aminite->id;
        }

        if ($ids) {
            Log::channel('translate')->info("Dispatched aminite batch jobs: [" . implode(', ', $ids) . "]");
            $this->info("Dispatched " . count($ids) . " aminite batch translation jobs: [" . implode(', ', $ids) . "]");
        }

        return self::SUCCESS;
    }
}
