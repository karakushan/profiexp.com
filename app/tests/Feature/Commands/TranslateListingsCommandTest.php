<?php

namespace Tests\Feature\Commands;

use App\Models\Language;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingContent;
use App\Models\Vendor;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class TranslateListingsCommandTest extends TestCase
{
    private Language $defaultLang;
    private Language $targetLang;

    protected function setUp(): void
    {
        parent::setUp();

        DB::table('basic_settings')->updateOrInsert(
            ['uniqid' => 12345],
            ['auto_translate_status' => 1]
        );

        $this->defaultLang = Language::create([
            'name' => 'English',
            'code' => 'en',
            'direction' => 0,
            'is_default' => 1,
        ]);

        $this->targetLang = Language::create([
            'name' => 'Arabic',
            'code' => 'ar',
            'direction' => 1,
            'is_default' => 0,
        ]);
    }

    private function createListingWithContent(array $listingAttrs = [], array $sourceAttrs = [], ?array $translations = null): Listing
    {
        $vendor = Vendor::create([
            'username' => 'test_vendor_' . uniqid(),
            'email' => uniqid() . '@test.com',
            'password' => bcrypt('password'),
            'status' => 1,
            'phone' => '123456789',
        ]);

        $listing = Listing::create(array_merge([
            'vendor_id' => $vendor->id,
            'status' => 1,
            'visibility' => 1,
            'translated_languages' => $translations ? json_encode($translations) : '{}',
        ], $listingAttrs));

        ListingContent::create([
            'listing_id' => $listing->id,
            'language_id' => $this->defaultLang->id,
            'title' => $sourceAttrs['title'] ?? 'Test Listing',
            'description' => $sourceAttrs['description'] ?? '<p>Test description</p>',
            'summary' => $sourceAttrs['summary'] ?? 'Test summary',
            'address' => $sourceAttrs['address'] ?? 'Test address',
            'meta_keyword' => $sourceAttrs['meta_keyword'] ?? 'test, listing',
            'meta_description' => $sourceAttrs['meta_description'] ?? 'Test meta description',
        ]);

        ListingContent::create([
            'listing_id' => $listing->id,
            'language_id' => $this->targetLang->id,
            'title' => '',
            'description' => '',
            'summary' => '',
            'address' => '',
            'meta_keyword' => '',
            'meta_description' => '',
        ]);

        return $listing;
    }

    public function test_command_exits_successfully_when_no_target_languages(): void
    {
        Language::where('id', '!=', $this->defaultLang->id)->delete();

        $this->artisan('listings:translate')
            ->assertSuccessful();
    }

    public function test_command_exits_with_error_when_no_default_language(): void
    {
        Language::query()->update(['is_default' => 0]);

        $this->artisan('listings:translate')
            ->assertFailed();
    }

    public function test_command_skips_listings_with_empty_source_title(): void
    {
        $vendor = Vendor::create([
            'username' => 'vendor_empty_title',
            'email' => 'empty_title@test.com',
            'password' => bcrypt('password'),
            'status' => 1,
            'phone' => '123456789',
        ]);

        $listing = Listing::create([
            'vendor_id' => $vendor->id,
            'status' => 1,
            'visibility' => 1,
            'translated_languages' => '{}',
        ]);

        ListingContent::create([
            'listing_id' => $listing->id,
            'language_id' => $this->defaultLang->id,
            'title' => '',
            'description' => '',
        ]);

        ListingContent::create([
            'listing_id' => $listing->id,
            'language_id' => $this->targetLang->id,
            'title' => '',
            'description' => '',
        ]);

        $this->artisan('listings:translate')
            ->assertSuccessful();

        $targetContent = ListingContent::where('listing_id', $listing->id)
            ->where('language_id', $this->targetLang->id)
            ->first();

        $this->assertEmpty($targetContent->title, 'Target content should remain empty because source title is empty');
    }

    public function test_command_skips_listings_with_non_empty_target_title(): void
    {
        $vendor = Vendor::create([
            'username' => 'vendor_non_empty',
            'email' => 'non_empty_target@test.com',
            'password' => bcrypt('password'),
            'status' => 1,
            'phone' => '123456789',
        ]);

        $listing = Listing::create([
            'vendor_id' => $vendor->id,
            'status' => 1,
            'visibility' => 1,
            'translated_languages' => '{}',
        ]);

        ListingContent::create([
            'listing_id' => $listing->id,
            'language_id' => $this->defaultLang->id,
            'title' => 'Source title',
            'description' => 'Source desc',
        ]);

        ListingContent::create([
            'listing_id' => $listing->id,
            'language_id' => $this->targetLang->id,
            'title' => 'Already translated title',
            'description' => 'Already translated desc',
        ]);

        $this->artisan('listings:translate')
            ->assertSuccessful();

        $targetContent = ListingContent::where('listing_id', $listing->id)
            ->where('language_id', $this->targetLang->id)
            ->first();

        $this->assertEquals(
            'Already translated title',
            $targetContent->title,
            'Target content should not be overwritten'
        );
    }

    public function test_command_skips_already_translated_listings(): void
    {
        $listing = $this->createListingWithContent(
            translations: ['ar' => true]
        );

        $this->artisan('listings:translate')
            ->assertSuccessful();

        $targetContent = ListingContent::where('listing_id', $listing->id)
            ->where('language_id', $this->targetLang->id)
            ->first();

        $this->assertEmpty($targetContent->title, 'Already translated listing should not be processed');
    }
}
