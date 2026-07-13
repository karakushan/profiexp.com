<?php

namespace App\Console\Commands;

use App\Models\Language;
use App\Models\ListingCategory;
use App\Models\Location\City;
use App\Models\Location\ListingCityCategory;
use App\Services\ListingCityCategoryContentService;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class SyncCityCategories extends Command
{
    protected $signature = 'city-categories:sync {--dry-run : Show changes without writing them}';
    protected $description = 'Create missing city-category bindings and localized content';

    public function handle(ListingCityCategoryContentService $contentService): int
    {
        $defaultLanguage = Language::where('is_default', 1)->first();
        if (!$defaultLanguage) {
            $this->error('No default language found.');
            return self::FAILURE;
        }

        $languages = Language::all();
        $cities = City::with('contents')->get();
        $categories = ListingCategory::active()->with('contents')->get();
        $validCities = $cities->filter(fn (City $city) => filled($city->getName($defaultLanguage->id)));
        $skippedCities = $cities->count() - $validCities->count();

        $existingKeys = ListingCityCategory::query()
            ->whereIn('city_id', $validCities->pluck('id'))
            ->whereIn('listing_category_id', $categories->pluck('id'))
            ->get(['city_id', 'listing_category_id'])
            ->mapWithKeys(fn ($item) => [$this->key($item->city_id, $item->listing_category_id) => true]);

        $rows = [];
        foreach ($validCities as $city) {
            foreach ($categories as $category) {
                if (!$existingKeys->has($this->key($city->id, $category->id))) {
                    $rows[] = [
                        'city_id' => $city->id,
                        'listing_category_id' => $category->id,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ];
                }
            }
        }

        $this->info('Cities: ' . $cities->count() . ', active categories: ' . $categories->count());
        $this->info('Missing bindings: ' . count($rows) . ', skipped cities: ' . $skippedCities);

        if ($skippedCities > 0) {
            Log::channel('translate')->warning("SyncCityCategories: skipped {$skippedCities} cities without a default-language name");
        }

        if ($this->option('dry-run')) {
            $this->info('Dry run: no bindings or content were written.');
            return self::SUCCESS;
        }

        [$createdBindings, $createdContent, $updatedContent] = DB::transaction(function () use (
            $rows,
            $validCities,
            $categories,
            $languages,
            $contentService
        ) {
            $createdBindings = $rows ? DB::table('listing_city_categories')->insertOrIgnore($rows) : 0;
            $items = ListingCityCategory::with(['city.contents', 'category.contents'])
                ->whereIn('city_id', $validCities->pluck('id'))
                ->whereIn('listing_category_id', $categories->pluck('id'))
                ->get();

            $createdContent = 0;
            $updatedContent = 0;
            foreach ($items as $item) {
                $result = $contentService->ensureMissing($item, $languages);
                $createdContent += $result['created'];
                $updatedContent += $result['updated'];
            }

            return [$createdBindings, $createdContent, $updatedContent];
        });

        $this->info('Created bindings: ' . $createdBindings);
        $this->info('Created content records: ' . $createdContent);
        $this->info('Completed content records: ' . $updatedContent);

        return self::SUCCESS;
    }

    private function key(int $cityId, int $categoryId): string
    {
        return $cityId . ':' . $categoryId;
    }
}
