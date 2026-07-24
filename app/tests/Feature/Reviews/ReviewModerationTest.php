<?php

namespace Tests\Feature\Reviews;

use App\Models\Language;
use App\Models\Listing\ListingReview;
use App\Models\ReviewTranslation;
use App\Jobs\TranslateReviewJob;
use App\Services\Ai\ReviewTranslationService;
use App\Services\ReviewService;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class ReviewModerationTest extends TestCase
{
    private Language $language;
    private int $listingId;

    protected function setUp(): void
    {
        parent::setUp();

        $this->language = Language::query()->firstOrCreate(
            ['code' => 'en'],
            ['name' => 'English', 'direction' => 0, 'is_default' => 1]
        );

        $this->listingId = DB::table('listings')->insertGetId([
            'vendor_id' => 0,
            'status' => 1,
            'visibility' => 1,
            'average_rating' => 0,
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }

    public function test_new_review_is_pending_and_only_approved_reviews_affect_rating(): void
    {
        $review = ListingReview::query()->create([
            'user_id' => 1,
            'listing_id' => $this->listingId,
            'rating' => 5,
            'review' => 'Great place',
            'language_id' => $this->language->id,
        ]);

        $this->assertSame('pending', $review->fresh()->status);

        ReviewService::recalculate(ReviewService::TYPE_LISTING, $this->listingId);
        $this->assertSame(0.0, (float) DB::table('listings')->where('id', $this->listingId)->value('average_rating'));

        ReviewService::updateStatus($review->fresh(), 'approved');
        $this->assertSame(5.0, (float) DB::table('listings')->where('id', $this->listingId)->value('average_rating'));

        ReviewService::updateStatus($review->fresh(), 'rejected');
        $this->assertSame(0.0, (float) DB::table('listings')->where('id', $this->listingId)->value('average_rating'));
    }

    public function test_review_translation_falls_back_to_source_text(): void
    {
        $review = ListingReview::query()->create([
            'user_id' => 1,
            'listing_id' => $this->listingId,
            'rating' => 4,
            'review' => 'Original text',
            'language_id' => $this->language->id,
            'status' => 'approved',
        ]);

        $targetLanguage = Language::query()->create([
            'name' => 'Ukrainian',
            'code' => 'uk-review-test',
            'direction' => 0,
            'is_default' => 0,
        ]);

        $this->assertSame('Original text', ReviewService::translatedText($review, $targetLanguage->id));

        ReviewTranslation::query()->create([
            'review_type' => ReviewService::TYPE_LISTING,
            'review_id' => $review->id,
            'language_id' => $targetLanguage->id,
            'text' => 'Translated text',
        ]);

        $this->assertSame('Translated text', ReviewService::translatedText($review->fresh(), $targetLanguage->id));
    }

    public function test_listing_review_uses_listing_id_for_its_listing_relation(): void
    {
        $review = ListingReview::query()->create([
            'user_id' => 1,
            'listing_id' => $this->listingId,
            'rating' => 4,
            'review' => 'Linked review',
            'language_id' => $this->language->id,
        ]);

        $this->assertSame($this->listingId, $review->listingInfo?->id);
    }

    public function test_reviews_management_routes_are_registered(): void
    {
        $names = collect(app('router')->getRoutes()->getRoutes())->pluck('action.as')->filter()->all();

        $this->assertContains('admin.reviews.index', $names);
        $this->assertContains('admin.reviews.create', $names);
        $this->assertContains('admin.reviews.store', $names);
        $this->assertContains('admin.reviews.update', $names);
        $this->assertContains('admin.reviews.update_status', $names);
        $this->assertContains('admin.reviews.bulk_status', $names);
    }

    public function test_translation_job_creates_missing_translation_for_approved_review(): void
    {
        $review = ListingReview::query()->create([
            'user_id' => 1,
            'listing_id' => $this->listingId,
            'rating' => 5,
            'review' => 'Original text',
            'language_id' => $this->language->id,
            'status' => 'approved',
        ]);

        $targetLanguage = Language::query()->create([
            'name' => 'Spanish',
            'code' => 'es-review-test',
            'direction' => 0,
            'is_default' => 0,
        ]);

        $this->mock(ReviewTranslationService::class, function ($mock) {
            $mock->shouldReceive('translate')->once()->andReturn('Texto traducido');
        });

        TranslateReviewJob::dispatchSync(
            reviewType: ReviewService::TYPE_LISTING,
            reviewId: $review->id,
            sourceLanguageId: $this->language->id,
            targetLanguageId: $targetLanguage->id,
            targetLanguageName: $targetLanguage->name,
        );

        $this->assertDatabaseHas('review_translations', [
            'review_type' => ReviewService::TYPE_LISTING,
            'review_id' => $review->id,
            'language_id' => $targetLanguage->id,
            'text' => 'Texto traducido',
        ]);
    }

    public function test_translation_command_skips_when_ai_is_disabled(): void
    {
        DB::table('basic_settings')->updateOrInsert(
            ['uniqid' => 12345],
            ['auto_translate_status' => 0]
        );

        $this->artisan('reviews:translate')->assertSuccessful();
    }
}
