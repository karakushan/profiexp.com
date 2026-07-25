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

        $pending = Listing::query()
            ->whereHas('listing_content', function ($query): void {
                $query->whereNotNull('title')->where('title', '!=', '');
            })
            ->where(function ($query) use ($totalLangs): void {
                $query
                    ->whereRaw(
                        '(SELECT COUNT(*) FROM listing_contents WHERE listing_id = listings.id AND title IS NOT NULL AND title != "") < ?',
                        [$totalLangs]
                    )
                    ->orWhereRaw(
                        '(SELECT COUNT(*) FROM listing_contents WHERE listing_id = listings.id AND address IS NOT NULL AND address != "") < ?',
                        [$totalLangs]
                    );
            })
            ->select('id')
            ->limit($batchSize)
            ->get();

        $ids = [];
        foreach ($pending as $listing) {
            $source = ListingContent::where('listing_id', $listing->id)
                ->whereNotNull('title')->where('title', '!=', '')
                ->first();
            if (!$source) continue;

            TranslateListingBatchJob::dispatchSync(
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
