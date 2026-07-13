<?php

namespace App\Services;

use App\Models\Language;
use App\Models\Location\ListingCityCategory;
use App\Models\Location\ListingCityCategoryContent;
use Illuminate\Http\Request;
use Illuminate\Support\Collection;

class ListingCityCategoryContentService
{
    public function ensureMissing(ListingCityCategory $item, Collection $languages): array
    {
        $item->loadMissing(['city.contents', 'category.contents']);
        $created = 0;
        $updated = 0;

        foreach ($languages as $language) {
            $cityName = $item->city->getName($language->id);
            $categoryName = $item->category->getName($language->id);

            if (blank($cityName) || blank($categoryName)) {
                continue;
            }

            $name = trim($cityName . ' — ' . $categoryName);
            $content = $item->contents()->where('language_id', $language->id)->first();

            if (!$content) {
                $item->contents()->create([
                    'language_id' => $language->id,
                    'name' => $name,
                    'slug' => $this->uniqueSlug(createSlug($name), $language->id),
                ]);
                $created++;
                continue;
            }

            $updates = [];
            if (blank($content->name)) {
                $updates['name'] = $name;
            }
            if (blank($content->slug)) {
                $updates['slug'] = $this->uniqueSlug(
                    createSlug($content->name ?: $name),
                    $language->id,
                    $content->id
                );
            }

            if ($updates) {
                $content->update($updates);
                $updated++;
            }
        }

        return compact('created', 'updated');
    }

    public function saveFromRequest(ListingCityCategory $item, Request $request, Collection $languages): void
    {
        $item->loadMissing(['city.contents', 'category.contents']);
        $defaultLanguage = $languages->firstWhere('is_default', 1) ?? $languages->first();
        $defaultLanguageId = $defaultLanguage?->id;

        foreach ($languages as $language) {
            $cityName = $item->city->getName($language->id);
            $categoryName = $item->category->getName($language->id);
            $requestedName = trim((string) $request->input($language->code . '_name'));
            $generatedName = blank($cityName) || blank($categoryName)
                ? ''
                : trim($cityName . ' — ' . $categoryName);
            $name = $requestedName ?: $generatedName;
            $metaTitle = $request->input($language->code . '_meta_title');
            $metaDescription = $request->input($language->code . '_meta_description');
            $seoText = $request->input($language->code . '_seo_text');

            if (blank($name) && blank($metaTitle) && blank($metaDescription) && blank($seoText)) {
                continue;
            }

            $name = $name ?: trim(
                ($item->city->getName($defaultLanguageId) ?: '') . ' — ' .
                ($item->category->getName($defaultLanguageId) ?: '')
            );
            $requestedSlug = $request->input($language->code . '_slug');
            $content = $item->contents()->where('language_id', $language->id)->first();
            $slug = $this->uniqueSlug(
                createSlug($requestedSlug ?: $name ?: 'city-category-' . $item->id . '-' . $language->code),
                $language->id,
                $content?->id
            );

            $item->contents()->updateOrCreate(
                ['language_id' => $language->id],
                [
                    'name' => $name,
                    'slug' => $slug,
                    'meta_title' => $metaTitle,
                    'meta_description' => $metaDescription,
                    'seo_text' => $seoText,
                ]
            );
        }
    }

    private function uniqueSlug(string $base, int $languageId, ?int $ignoreId = null): string
    {
        $base = $base !== '' ? $base : 'city-category';
        $slug = $base;
        $suffix = 2;

        while (ListingCityCategoryContent::where('language_id', $languageId)
            ->where('slug', $slug)
            ->when($ignoreId !== null, fn ($query) => $query->where('id', '!=', $ignoreId))
            ->exists()) {
            $slug = $base . '-' . $suffix++;
        }

        return $slug;
    }
}
