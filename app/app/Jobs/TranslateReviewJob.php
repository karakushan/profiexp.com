<?php

namespace App\Jobs;

use App\Models\Language;
use App\Models\Listing\ListingReview;
use App\Models\ReviewTranslation;
use App\Models\Shop\ProductReview;
use App\Services\Ai\ReviewTranslationService;
use App\Services\ReviewService;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;

class TranslateReviewJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public int $tries = 2;

    public function __construct(
        public string $reviewType,
        public int $reviewId,
        public int $sourceLanguageId,
        public int $targetLanguageId,
        public string $targetLanguageName,
    ) {
    }

    public function handle(ReviewTranslationService $translator): void
    {
        $review = $this->reviewType === ReviewService::TYPE_PRODUCT
            ? ProductReview::query()->find($this->reviewId)
            : ListingReview::query()->find($this->reviewId);

        if (!$review || $review->status !== 'approved') {
            return;
        }

        if ($this->sourceLanguageId === $this->targetLanguageId) {
            return;
        }

        $sourceText = ReviewService::sourceText($review);
        if ($sourceText === '' || ReviewTranslation::query()
            ->where('review_type', $this->reviewType)
            ->where('review_id', $review->id)
            ->where('language_id', $this->targetLanguageId)
            ->exists()) {
            return;
        }

        $translated = $translator->translate($sourceText, $this->targetLanguageName);
        if ($translated === '') {
            return;
        }

        ReviewTranslation::query()->updateOrCreate(
            [
                'review_type' => $this->reviewType,
                'review_id' => $review->id,
                'language_id' => $this->targetLanguageId,
            ],
            ['text' => $translated]
        );
    }

    public function failed(\Throwable $exception): void
    {
        Log::channel('translate')->error(sprintf(
            'TranslateReviewJob [%s#%d] failed: %s',
            $this->reviewType,
            $this->reviewId,
            $exception->getMessage()
        ));
    }
}
