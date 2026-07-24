<?php

namespace App\Console\Commands;

use App\Jobs\TranslateReviewJob;
use App\Models\Language;
use App\Models\Listing\ListingReview;
use App\Models\Shop\ProductReview;
use App\Services\ReviewService;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class TranslateReviews extends Command
{
    protected $signature = 'reviews:translate {--batch=10 : Number of reviews per run}';
    protected $description = 'Translate approved reviews to all missing languages';

    public function handle(): int
    {
        if (!DB::table('basic_settings')->value('auto_translate_status')) {
            $this->info('Auto-translate is disabled in settings.');
            return self::SUCCESS;
        }

        $languages = Language::query()->orderBy('id')->get();
        $batch = max(1, (int) $this->option('batch'));
        $processed = 0;

        foreach ([
            ReviewService::TYPE_LISTING => ListingReview::class,
            ReviewService::TYPE_PRODUCT => ProductReview::class,
        ] as $type => $model) {
            $reviews = $model::query()
                ->where('status', 'approved')
                ->whereNotNull('language_id')
                ->orderBy('id')
                ->cursor();

            foreach ($reviews as $review) {
                foreach ($languages as $language) {
                    if ((int) $language->id === (int) $review->language_id || $review->translations()
                        ->where('language_id', $language->id)
                        ->exists()) {
                        continue;
                    }

                    try {
                        TranslateReviewJob::dispatchSync(
                            reviewType: $type,
                            reviewId: $review->id,
                            sourceLanguageId: (int) $review->language_id,
                            targetLanguageId: (int) $language->id,
                            targetLanguageName: $language->name,
                        );
                        $processed++;
                    } catch (\Throwable $exception) {
                        Log::channel('translate')->warning(sprintf(
                            'TranslateReviews skipped %s#%d to %s: %s',
                            $type,
                            $review->id,
                            $language->code,
                            $exception->getMessage()
                        ));
                    }

                    if ($processed >= $batch) {
                        break 2;
                    }
                }
            }
        }

        $this->info("Processed {$processed} review translations.");
        return self::SUCCESS;
    }
}
