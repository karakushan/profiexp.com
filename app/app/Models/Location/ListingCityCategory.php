<?php

namespace App\Models\Location;

use App\Models\ListingCategory;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ListingCityCategory extends Model
{
    use HasFactory;

    protected $fillable = ['city_id', 'listing_category_id'];

    public function city(): BelongsTo
    {
        return $this->belongsTo(City::class);
    }

    public function category(): BelongsTo
    {
        return $this->belongsTo(ListingCategory::class, 'listing_category_id');
    }

    public function contents(): HasMany
    {
        return $this->hasMany(ListingCityCategoryContent::class);
    }

    public function getTranslation(int $languageId): ?ListingCityCategoryContent
    {
        return $this->contents()->where('language_id', $languageId)->first();
    }
}
