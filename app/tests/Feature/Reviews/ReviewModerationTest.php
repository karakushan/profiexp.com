<?php

namespace Tests\Feature\Reviews;

use App\Models\Language;
use App\Models\Listing\ListingReview;
use App\Models\ReviewTranslation;
use App\Models\User;
use App\Jobs\TranslateReviewJob;
use App\Services\Ai\ReviewTranslationService;
use App\Services\ReviewService;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
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

    public function test_localized_listing_review_route_passes_listing_id_to_controller(): void
    {
        Auth::guard('web')->login(User::query()->findOrFail(1));

        $this->post('/ru/listings/listing-review/' . $this->listingId . '/store-review', [
            'review' => 'Localized route review',
            'rating' => 5,
        ])->assertRedirect();

        $this->assertDatabaseHas('listing_reviews', [
            'user_id' => 1,
            'listing_id' => $this->listingId,
            'review' => 'Localized route review',
            'rating' => 5,
            'status' => 'pending',
        ]);
    }

    public function test_listing_review_requires_recaptcha_when_enabled(): void
    {
        DB::table('basic_settings')->updateOrInsert(
            ['uniqid' => 12345],
            [
                'google_recaptcha_status' => 1,
                'google_recaptcha_site_key' => 'test-site-key',
                'google_recaptcha_secret_key' => 'test-secret-key',
            ]
        );
        Auth::guard('web')->login(User::query()->findOrFail(1));

        $this->post('/ru/listings/listing-review/' . $this->listingId . '/store-review', [
            'review' => 'Blocked without captcha',
            'rating' => 5,
        ])->assertRedirect()->assertSessionHas('error');

        $this->assertDatabaseMissing('listing_reviews', [
            'user_id' => 1,
            'listing_id' => $this->listingId,
            'review' => 'Blocked without captcha',
        ]);
    }

    public function test_listing_review_accepts_valid_v3_recaptcha_action_and_score(): void
    {
        DB::table('basic_settings')->updateOrInsert(
            ['uniqid' => 12345],
            [
                'google_recaptcha_status' => 1,
                'google_recaptcha_site_key' => 'test-site-key',
                'google_recaptcha_secret_key' => 'test-secret-key',
            ]
        );
        Http::fake([
            'https://www.google.com/recaptcha/api/siteverify' => Http::response([
                'success' => true,
                'score' => 0.9,
                'action' => 'listing_review',
            ], 200),
        ]);
        Auth::guard('web')->login(User::query()->findOrFail(1));

        $this->post('/ru/listings/listing-review/' . $this->listingId . '/store-review', [
            'review' => 'Accepted with captcha',
            'rating' => 5,
            'g-recaptcha-response' => 'test-token',
        ])->assertRedirect();

        Http::assertSent(function ($request) {
            return $request->url() === 'https://www.google.com/recaptcha/api/siteverify'
                && $request['secret'] === 'test-secret-key'
                && $request['response'] === 'test-token';
        });
        $this->assertDatabaseHas('listing_reviews', [
            'user_id' => 1,
            'listing_id' => $this->listingId,
            'review' => 'Accepted with captcha',
            'status' => 'pending',
        ]);
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
