<?php

namespace App\Console\Commands;

use App\Models\Listing\ListingContent;
use App\Models\ListingCategory;
use App\Models\ListingCategoryContent;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class NormalizeListingSlugs extends Command
{
    protected $signature = 'slugs:normalize-listings';

    protected $description = 'Transliterate listing and listing category slugs and keep them unique per language';

    public function handle(): int
    {
        DB::transaction(function (): void {
            $this->normalizeCategories();
            $this->normalizeListings();
        });

        $this->info('Listing and category slugs normalized.');

        return self::SUCCESS;
    }

    private function normalizeCategories(): void
    {
        $used = [];

        ListingCategoryContent::query()
            ->orderBy('id')
            ->each(function (ListingCategoryContent $content) use (&$used): void {
                $base = Str::slug($content->name ?: $content->slug);
                $base = $base !== '' ? $base : 'category-' . $content->listing_category_id;
                $content->slug = $this->uniqueSlug($base, $used[(int) $content->language_id] ?? []);
                $used[(int) $content->language_id][] = $content->slug;
                $content->save();
            });

        $usedBase = [];
        ListingCategory::query()->orderBy('id')->each(function (ListingCategory $category) use (&$usedBase): void {
            $base = Str::slug($category->name ?: $category->slug);
            $base = $base !== '' ? $base : 'category-' . $category->id;
            $category->slug = $this->uniqueSlug($base, $usedBase);
            $usedBase[] = $category->slug;
            $category->save();
        });
    }

    private function normalizeListings(): void
    {
        $used = [];

        ListingContent::query()
            ->orderBy('id')
            ->each(function (ListingContent $content) use (&$used): void {
                $base = Str::slug($content->title ?: $content->slug);
                $base = $base !== '' ? $base : 'listing-' . $content->listing_id;
                $content->slug = $this->uniqueSlug($base, $used[(int) $content->language_id] ?? []);
                $used[(int) $content->language_id][] = $content->slug;
                $content->save();
            });
    }

    private function uniqueSlug(string $base, array $used): string
    {
        $slug = $base;
        $suffix = 2;

        while (in_array($slug, $used, true)) {
            $slug = $base . '-' . $suffix++;
        }

        return $slug;
    }
}
