<?php

namespace Tests\Feature\Commands;

use App\Models\Language;
use App\Models\ListingCategory;
use App\Models\ListingCategoryContent;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class TranslateCategoriesCommandTest extends TestCase
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

    private function createCategoryWithContent(): ListingCategory
    {
        $category = ListingCategory::create([
            'icon' => 'fas fa-spa',
            'status' => 1,
            'serial_number' => 1,
        ]);

        ListingCategoryContent::create([
            'listing_category_id' => $category->id,
            'language_id' => $this->defaultLang->id,
            'name' => 'Beauty Salons',
            'slug' => 'beauty-salons',
            'meta_title' => 'Best Beauty Salons',
            'meta_description' => 'Find beauty salons',
        ]);

        return $category;
    }

    public function test_command_exits_successfully_when_no_target_languages(): void
    {
        Language::where('id', '!=', $this->defaultLang->id)->delete();

        $this->artisan('categories:translate')
            ->assertSuccessful();
    }

    public function test_command_exits_with_error_when_no_default_language(): void
    {
        Language::query()->update(['is_default' => 0]);

        $this->artisan('categories:translate')
            ->assertFailed();
    }

    public function test_command_skips_categories_with_empty_source_name(): void
    {
        $category = ListingCategory::create([
            'icon' => 'fas fa-test',
            'status' => 1,
            'serial_number' => 1,
        ]);

        ListingCategoryContent::create([
            'listing_category_id' => $category->id,
            'language_id' => $this->defaultLang->id,
            'name' => '',
            'slug' => '',
        ]);

        $this->artisan('categories:translate')
            ->assertSuccessful();

        $targetExists = ListingCategoryContent::where('listing_category_id', $category->id)
            ->where('language_id', $this->targetLang->id)
            ->exists();

        $this->assertFalse($targetExists, 'Target content should not be created because source name is empty');
    }

    public function test_command_skips_categories_with_existing_translation(): void
    {
        $category = $this->createCategoryWithContent();

        ListingCategoryContent::create([
            'listing_category_id' => $category->id,
            'language_id' => $this->targetLang->id,
            'name' => 'Already translated',
            'slug' => 'already-translated',
        ]);

        $this->artisan('categories:translate')
            ->assertSuccessful();

        $targetContent = ListingCategoryContent::where('listing_category_id', $category->id)
            ->where('language_id', $this->targetLang->id)
            ->first();

        $this->assertEquals('Already translated', $targetContent->name);
    }

    public function test_command_skips_categories_without_default_language_content(): void
    {
        ListingCategory::create([
            'icon' => 'fas fa-test',
            'status' => 1,
            'serial_number' => 1,
        ]);

        $this->artisan('categories:translate')
            ->assertSuccessful();
    }
}