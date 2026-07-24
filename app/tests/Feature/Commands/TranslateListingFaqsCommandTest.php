<?php

namespace Tests\Feature\Commands;

use App\Models\Language;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingFaq;
use App\Models\Vendor;
use App\Services\Ai\Engines\GeminiTextEngine;
use Illuminate\Support\Facades\DB;
use Mockery;
use Tests\TestCase;

class TranslateListingFaqsCommandTest extends TestCase
{
    private Language $defaultLanguage;
    private Language $targetLanguage;

    protected function setUp(): void
    {
        parent::setUp();

        DB::table('basic_settings')->updateOrInsert(
            ['uniqid' => 12345],
            ['auto_translate_status' => 1]
        );

        $this->defaultLanguage = Language::create([
            'name' => 'English',
            'code' => 'en',
            'direction' => 0,
            'is_default' => 1,
        ]);

        $this->targetLanguage = Language::create([
            'name' => 'Arabic',
            'code' => 'ar',
            'direction' => 1,
            'is_default' => 0,
        ]);
    }

    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    private function mockGemini(array $response = ['question' => 'Translated question', 'answer' => '<p>Translated answer</p>']): void
    {
        $engine = Mockery::mock(GeminiTextEngine::class);
        $engine->shouldReceive('generate')
            ->andReturn(json_encode($response, JSON_UNESCAPED_UNICODE));

        $this->app->instance(GeminiTextEngine::class, $engine);
    }

    private function listing(): Listing
    {
        $vendor = Vendor::create([
            'username' => 'faq_vendor_' . uniqid(),
            'email' => uniqid() . '@test.com',
            'password' => bcrypt('password'),
            'status' => 1,
            'phone' => '123456789',
        ]);

        return Listing::create([
            'vendor_id' => $vendor->id,
            'status' => 1,
            'visibility' => 1,
            'translated_languages' => '{}',
        ]);
    }

    private function faq(Listing $listing, Language $language, array $attributes = []): ListingFaq
    {
        return ListingFaq::create(array_merge([
            'listing_id' => $listing->id,
            'language_id' => $language->id,
            'question' => 'Is parking available?',
            'answer' => '<p>Yes, parking is available.</p>',
            'serial_number' => 1,
        ], $attributes));
    }

    public function test_command_creates_missing_translation(): void
    {
        $listing = $this->listing();
        $this->faq($listing, $this->defaultLanguage);
        $this->mockGemini();

        $this->artisan('faq:translate')->assertSuccessful();

        $translated = ListingFaq::where('listing_id', $listing->id)
            ->where('language_id', $this->targetLanguage->id)
            ->where('serial_number', 1)
            ->first();

        $this->assertNotNull($translated);
        $this->assertSame('Translated question', $translated->question);
        $this->assertSame('<p>Translated answer</p>', $translated->answer);
    }

    public function test_command_does_not_overwrite_filled_translation(): void
    {
        $listing = $this->listing();
        $this->faq($listing, $this->defaultLanguage);
        $existing = $this->faq($listing, $this->targetLanguage, [
            'question' => 'Manual question',
            'answer' => 'Manual answer',
        ]);
        $this->mockGemini();

        $this->artisan('faq:translate')->assertSuccessful();

        $existing->refresh();
        $this->assertSame('Manual question', $existing->question);
        $this->assertSame('Manual answer', $existing->answer);
    }

    public function test_command_fills_only_empty_fields_in_existing_translation(): void
    {
        $listing = $this->listing();
        $this->faq($listing, $this->defaultLanguage);
        $existing = $this->faq($listing, $this->targetLanguage, [
            'question' => 'Manual question',
            'answer' => '',
        ]);
        $this->mockGemini();

        $this->artisan('faq:translate')->assertSuccessful();

        $existing->refresh();
        $this->assertSame('Manual question', $existing->question);
        $this->assertSame('<p>Translated answer</p>', $existing->answer);
    }

    public function test_command_uses_first_filled_language_when_default_has_no_faq(): void
    {
        $sourceLanguage = Language::create([
            'name' => 'Russian',
            'code' => 'ru',
            'direction' => 0,
            'is_default' => 0,
        ]);
        $listing = $this->listing();
        $this->faq($listing, $sourceLanguage, [
            'question' => 'Есть парковка?',
            'answer' => 'Да.',
        ]);
        $this->mockGemini();

        $this->artisan('faq:translate')->assertSuccessful();

        $targetFaq = ListingFaq::where('listing_id', $listing->id)
            ->where('language_id', $this->targetLanguage->id)
            ->first();

        $this->assertNotNull($targetFaq);
        $this->assertSame('Translated question', $targetFaq->question);
    }

    public function test_command_skips_when_auto_translation_is_disabled(): void
    {
        DB::table('basic_settings')->where('uniqid', 12345)->update(['auto_translate_status' => 0]);

        $listing = $this->listing();
        $this->faq($listing, $this->defaultLanguage);

        $this->artisan('faq:translate')->assertSuccessful();

        $this->assertDatabaseMissing('listing_faqs', [
            'listing_id' => $listing->id,
            'language_id' => $this->targetLanguage->id,
        ]);
    }

    public function test_command_fails_when_no_default_language_exists(): void
    {
        Language::query()->update(['is_default' => 0]);

        $this->artisan('faq:translate')->assertFailed();
    }

    public function test_command_skips_listing_without_a_valid_source_faq(): void
    {
        $listing = $this->listing();
        $this->faq($listing, $this->defaultLanguage, [
            'question' => '',
            'answer' => '',
        ]);
        $this->mockGemini();

        $this->artisan('faq:translate')->assertSuccessful();

        $this->assertDatabaseMissing('listing_faqs', [
            'listing_id' => $listing->id,
            'language_id' => $this->targetLanguage->id,
        ]);
    }
}
