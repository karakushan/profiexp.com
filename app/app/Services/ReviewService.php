<?php

namespace App\Services;

use App\Models\Language;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingReview;
use App\Models\ReviewTranslation;
use App\Models\Shop\Product;
use App\Models\Shop\ProductReview;
use Illuminate\Support\Facades\DB;

class ReviewService
{
    public const TYPE_LISTING = 'listing';
    public const TYPE_PRODUCT = 'product';

    public static function languageId(?string $locale = null): ?int
    {
        $locale ??= function_exists('current_front_locale') ? current_front_locale() : app()->getLocale();

        return Language::query()->where('code', $locale)->value('id')
            ?? Language::query()->where('is_default', 1)->value('id');
    }

    public static function sourceText($review): string
    {
        return (string) ($review instanceof ProductReview ? $review->comment : $review->review);
    }

    public static function translatedText($review, ?int $languageId = null): string
    {
        $source = self::sourceText($review);
        if (!$languageId || (int) $review->language_id === $languageId) {
            return $source;
        }

        $translation = $review->translations()->where('language_id', $languageId)->value('text');

        return $translation ?: $source;
    }

    public static function setDisplayText($review, ?int $languageId = null): void
    {
        if ($review instanceof ProductReview) {
            $review->comment = self::translatedText($review, $languageId);
        } else {
            $review->review = self::translatedText($review, $languageId);
        }
    }

    public static function recalculate(string $type, int $parentId): void
    {
        $query = $type === self::TYPE_PRODUCT ? ProductReview::query() : ListingReview::query();
        $foreignKey = $type === self::TYPE_PRODUCT ? 'product_id' : 'listing_id';
        $model = $type === self::TYPE_PRODUCT ? Product::class : Listing::class;

        $average = $query->where($foreignKey, $parentId)
            ->where('status', 'approved')
            ->avg('rating');

        $model::query()->whereKey($parentId)->update(['average_rating' => $average ?: 0]);
    }

    public static function updateStatus($review, string $status): void
    {
        DB::transaction(function () use ($review, $status) {
            $review->update(['status' => $status]);
            self::recalculate(
                $review instanceof ProductReview ? self::TYPE_PRODUCT : self::TYPE_LISTING,
                (int) ($review instanceof ProductReview ? $review->product_id : $review->listing_id)
            );
        });
    }

    public static function model(string $type, int $id)
    {
        return $type === self::TYPE_PRODUCT
            ? ProductReview::query()->findOrFail($id)
            : ListingReview::query()->findOrFail($id);
    }

    public static function type($review): string
    {
        return $review instanceof ProductReview ? self::TYPE_PRODUCT : self::TYPE_LISTING;
    }

    public static function translationLanguages($review)
    {
        return $review->translations()->with('language')->get();
    }
}
