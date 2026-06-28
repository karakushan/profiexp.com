<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use App\Models\Listing\ListingContent;

class ListingCategory extends Model
{
    use HasFactory;

    protected $fillable = [
        'id',
        'parent_id',
        'name',
        'slug',
        'language_id',
        'icon',
        'mobile_image',
        'serial_number',
        'status',
    ];

    public function parent(): BelongsTo
    {
        return $this->belongsTo(ListingCategory::class, 'parent_id');
    }

    public function children(): HasMany
    {
        return $this->hasMany(ListingCategory::class, 'parent_id')->orderBy('serial_number');
    }

    public function allChildren(): HasMany
    {
        return $this->children()->with('allChildren');
    }

    public function contents(): HasMany
    {
        return $this->hasMany(ListingCategoryContent::class, 'listing_category_id');
    }

    public function content(): HasMany
    {
        return $this->contents();
    }

    public function listing_contents(): HasMany
    {
        return $this->hasMany(ListingContent::class, 'category_id');
    }

    public function scopeForLanguage(Builder $query, int $languageId): Builder
    {
        return $query->whereHas('contents', function ($q) use ($languageId) {
            $q->where('language_id', $languageId);
        });
    }

    public function scopeBySlug(Builder $query, int $languageId, string $slug): Builder
    {
        return $query->whereHas('contents', function ($q) use ($languageId, $slug) {
            $q->where('language_id', $languageId)->where('slug', $slug);
        });
    }

    public function scopeActive(Builder $query): Builder
    {
        return $query->where('status', 1);
    }

    public function scopeRoot(Builder $query): Builder
    {
        return $query->whereNull('parent_id');
    }

    public function getTranslation(int $languageId): ?ListingCategoryContent
    {
        return $this->contents()->where('language_id', $languageId)->first();
    }

    public function getName(int $languageId): ?string
    {
        return $this->getTranslation($languageId)?->name ?? $this->name;
    }

    public function getSlug(int $languageId): ?string
    {
        return $this->getTranslation($languageId)?->slug ?? $this->slug;
    }
}