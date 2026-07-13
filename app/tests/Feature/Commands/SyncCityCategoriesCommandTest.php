<?php

namespace Tests\Feature\Commands;

use App\Models\Language;
use App\Models\ListingCategory;
use App\Models\ListingCategoryContent;
use App\Models\Location\City;
use App\Models\Location\CityContent;
use App\Models\Location\ListingCityCategory;
use App\Models\Location\ListingCityCategoryContent;
use Tests\TestCase;

class SyncCityCategoriesCommandTest extends TestCase
{
    private Language $defaultLanguage;
    private Language $targetLanguage;
    private City $city;
    private ListingCategory $category;
    private ListingCategory $otherCategory;

    protected function setUp(): void
    {
        parent::setUp();

        Language::query()->update(['is_default' => 0]);
        $this->defaultLanguage = Language::create([
            'name' => 'Sync Default',
            'code' => 'sync-default-' . uniqid(),
            'direction' => 0,
            'is_default' => 1,
        ]);
        $this->targetLanguage = Language::create([
            'name' => 'Sync Target',
            'code' => 'sync-target-' . uniqid(),
            'direction' => 0,
            'is_default' => 0,
        ]);

        $this->city = City::query()->firstOrFail();
        $this->category = ListingCategory::create([
            'status' => 1,
            'serial_number' => 999998,
        ]);
        $this->otherCategory = ListingCategory::create([
            'status' => 1,
            'serial_number' => 999997,
        ]);

        CityContent::create([
            'city_id' => $this->city->id,
            'language_id' => $this->defaultLanguage->id,
            'name' => 'Sync City',
            'slug' => 'sync-city-' . $this->defaultLanguage->id,
        ]);
        CityContent::create([
            'city_id' => $this->city->id,
            'language_id' => $this->targetLanguage->id,
            'name' => 'Sync City Target',
            'slug' => 'sync-city-target-' . $this->targetLanguage->id,
        ]);

        foreach ([$this->category, $this->otherCategory] as $category) {
            ListingCategoryContent::create([
                'listing_category_id' => $category->id,
                'language_id' => $this->defaultLanguage->id,
                'name' => 'Sync Category ' . $category->id,
                'slug' => 'sync-category-' . $category->id . '-' . $this->defaultLanguage->id,
            ]);
            ListingCategoryContent::create([
                'listing_category_id' => $category->id,
                'language_id' => $this->targetLanguage->id,
                'name' => 'Sync Category Target ' . $category->id,
                'slug' => 'sync-category-target-' . $category->id . '-' . $this->targetLanguage->id,
            ]);
        }
    }

    public function test_command_creates_all_active_category_bindings_and_content(): void
    {
        $this->artisan('city-categories:sync')->assertSuccessful();

        $activeCategoryIds = ListingCategory::active()->pluck('id');
        $this->assertSame(
            $activeCategoryIds->count(),
            ListingCityCategory::where('city_id', $this->city->id)
                ->whereIn('listing_category_id', $activeCategoryIds)
                ->count()
        );

        $item = ListingCityCategory::where('city_id', $this->city->id)
            ->where('listing_category_id', $this->category->id)
            ->firstOrFail();
        $content = $item->contents()->where('language_id', $this->targetLanguage->id)->first();

        $this->assertSame('Sync City Target — ' . $this->category->getName($this->targetLanguage->id), $content->name);
        $this->assertNotEmpty($content->slug);
    }

    public function test_command_is_idempotent_and_does_not_touch_existing_values(): void
    {
        $item = ListingCityCategory::create([
            'city_id' => $this->city->id,
            'listing_category_id' => $this->category->id,
        ]);
        $defaultContent = ListingCityCategoryContent::create([
            'listing_city_category_id' => $item->id,
            'language_id' => $this->defaultLanguage->id,
            'name' => 'Manual Name',
            'slug' => 'manual-slug',
            'meta_title' => 'Manual SEO title',
        ]);
        ListingCityCategoryContent::create([
            'listing_city_category_id' => $item->id,
            'language_id' => $this->targetLanguage->id,
            'meta_title' => 'Keep this SEO title',
        ]);

        $this->artisan('city-categories:sync')->assertSuccessful();
        $bindingsAfterFirstRun = ListingCityCategory::where('city_id', $this->city->id)->count();
        $this->artisan('city-categories:sync')->assertSuccessful();

        $this->assertSame($bindingsAfterFirstRun, ListingCityCategory::where('city_id', $this->city->id)->count());
        $defaultContent->refresh();
        $this->assertSame('Manual Name', $defaultContent->name);
        $this->assertSame('manual-slug', $defaultContent->slug);
        $this->assertSame('Manual SEO title', $defaultContent->meta_title);

        $targetContent = $item->contents()->where('language_id', $this->targetLanguage->id)->firstOrFail();
        $this->assertSame('Keep this SEO title', $targetContent->meta_title);
        $this->assertNotEmpty($targetContent->name);
        $this->assertNotEmpty($targetContent->slug);
    }

    public function test_command_uses_unique_slug_and_skips_inactive_categories(): void
    {
        $inactiveCategory = ListingCategory::create(['status' => 0, 'serial_number' => 999]);
        $collision = ListingCityCategory::create([
            'city_id' => $this->city->id,
            'listing_category_id' => $this->otherCategory->id,
        ]);
        ListingCityCategoryContent::create([
            'listing_city_category_id' => $collision->id,
            'language_id' => $this->targetLanguage->id,
            'name' => 'Collision',
            'slug' => createSlug('Sync City Target — Sync Category Target ' . $this->category->id),
        ]);

        $this->artisan('city-categories:sync')->assertSuccessful();

        $this->assertFalse(ListingCityCategory::where('city_id', $this->city->id)
            ->where('listing_category_id', $inactiveCategory->id)
            ->exists());
        $this->assertDatabaseHas('listing_city_category_contents', [
            'language_id' => $this->targetLanguage->id,
            'slug' => createSlug('Sync City Target — Sync Category Target ' . $this->category->id) . '-2',
        ]);
    }
}
