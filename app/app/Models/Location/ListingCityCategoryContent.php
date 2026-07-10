<?php

namespace App\Models\Location;

use App\Models\Language;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ListingCityCategoryContent extends Model
{
    use HasFactory;

    protected $fillable = [
        'listing_city_category_id',
        'language_id',
        'name',
        'slug',
        'meta_title',
        'meta_description',
        'seo_text',
    ];

    public function listingCityCategory(): BelongsTo
    {
        return $this->belongsTo(ListingCityCategory::class);
    }

    public function language(): BelongsTo
    {
        return $this->belongsTo(Language::class);
    }
}
