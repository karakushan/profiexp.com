<?php

namespace App\Console\Commands;

use App\Jobs\TranslateListingBatchJob;
use App\Models\Language;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingContent;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class TranslateListings extends Command
{
    protected $signature = 'listings:translate {--batch=3 : Number of listings per run}';
    protected $description = 'Translate listings to all missing languages in one job';

    public function handle(): int
    {
        $autoTranslateEnabled = DB::table('basic_settings')->value('auto_translate_status');

        if (!$autoTranslateEnabled) {
            $this->info('Auto-translate is disabled in settings.');
            return self::SUCCESS;
        }

        $defaultLang = Language::where('is_default', 1)->first();
        if (!$defaultLang) {
            Log::channel('translate')->warning('TranslateListings: no default language found');
            return self::FAILURE;
        }

        $totalLangs = Language::count();
        $batchSize = max(1, (int) $this->option('batch'));

        $pending = Listing::select('id')
            ->selectRaw('(SELECT COUNT(*) FROM listing_contents WHERE listing_id = listings.id AND title IS NOT NULL AND title != "") as filled')
            ->havingRaw('filled > 0 AND filled < ?', [$totalLangs])
            ->limit($batchSize)
            ->get();

        $ids = [];
        foreach ($pending as $listing) {
            $source = ListingContent::where('listing_id', $listing->id)
                ->whereNotNull('title')->where('title', '!=', '')
                ->first();
            if (!$source) continue;

            TranslateListingBatchJob::dispatch(
                listingId: $listing->id,
                sourceLangId: $source->language_id,
            );
            $ids[] = $listing->id;
        }

        if ($ids) {
            Log::channel('translate')->info("Dispatched listing batch jobs: [" . implode(', ', $ids) . "]");
            $this->info("Dispatched " . count($ids) . " listing batch translation jobs: [" . implode(', ', $ids) . "]");
        }

        return self::SUCCESS;
    }
}
