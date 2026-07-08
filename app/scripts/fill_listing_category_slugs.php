<?php

declare(strict_types=1);

use App\Models\ListingCategory;
use App\Models\ListingCategoryContent;
use Illuminate\Contracts\Console\Kernel;

require __DIR__ . '/../vendor/autoload.php';

$app = require __DIR__ . '/../bootstrap/app.php';
$app->make(Kernel::class)->bootstrap();

$dryRun = in_array('--dry-run', $argv, true);
$fillBase = true;
$fillContents = !in_array('--base-only', $argv, true);

$createdBase = 0;
$createdContents = 0;
$skipped = 0;

function build_category_slug(?string $name, string $fallback): string
{
    $slug = createSlug((string) $name);

    return $slug !== '' ? $slug : $fallback;
}

function unique_base_category_slug(string $baseSlug, int $categoryId): string
{
    $slug = $baseSlug;
    $suffix = 2;

    while (
        ListingCategory::query()
            ->where('slug', $slug)
            ->where('id', '!=', $categoryId)
            ->exists()
    ) {
        $slug = $baseSlug . '-' . $suffix;
        $suffix++;
    }

    return $slug;
}

function unique_category_content_slug(string $baseSlug, int $languageId, int $contentId): string
{
    $slug = $baseSlug;
    $suffix = 2;

    while (
        ListingCategoryContent::query()
            ->where('language_id', $languageId)
            ->where('slug', $slug)
            ->where('id', '!=', $contentId)
            ->exists()
    ) {
        $slug = $baseSlug . '-' . $suffix;
        $suffix++;
    }

    return $slug;
}

if ($fillBase) {
    $categories = ListingCategory::query()
        ->with(['contents' => fn ($query) => $query->orderBy('language_id')])
        ->where(function ($query) {
            $query->whereNull('slug')->orWhere('slug', '');
        })
        ->orderBy('id')
        ->get();

    foreach ($categories as $category) {
        $name = $category->name ?: $category->contents->first(fn ($content) => filled($content->name))?->name;

        if (blank($name)) {
            $skipped++;
            echo "SKIP base category #{$category->id}: no name available\n";
            continue;
        }

        $baseSlug = build_category_slug($name, 'category-' . $category->id);
        $slug = unique_base_category_slug($baseSlug, $category->id);

        if ($dryRun) {
            echo "DRY-RUN base category #{$category->id}: {$slug}\n";
        } else {
            $category->slug = $slug;
            $category->save();
            echo "UPDATED base category #{$category->id}: {$slug}\n";
        }

        $createdBase++;
    }
}

if ($fillContents) {
    $contents = ListingCategoryContent::query()
        ->where(function ($query) {
            $query->whereNull('slug')->orWhere('slug', '');
        })
        ->orderBy('id')
        ->get();

    foreach ($contents as $content) {
        if (blank($content->name)) {
            $skipped++;
            echo "SKIP content #{$content->id}: no name available\n";
            continue;
        }

        $baseSlug = build_category_slug($content->name, 'category-content-' . $content->id);
        $slug = unique_category_content_slug($baseSlug, (int) $content->language_id, $content->id);

        if ($dryRun) {
            echo "DRY-RUN content #{$content->id} (lang {$content->language_id}): {$slug}\n";
        } else {
            $content->slug = $slug;
            $content->save();
            echo "UPDATED content #{$content->id} (lang {$content->language_id}): {$slug}\n";
        }

        $createdContents++;
    }
}

echo "\nSummary:\n";
echo 'Base category slugs ' . ($dryRun ? 'to fill' : 'filled') . ": {$createdBase}\n";
echo 'Translated category slugs ' . ($dryRun ? 'to fill' : 'filled') . ": {$createdContents}\n";
echo "Skipped: {$skipped}\n";
