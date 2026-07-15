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
        'other_cities_title',
    ];

    public function listingCityCategory(): BelongsTo
    {
        return $this->belongsTo(ListingCityCategory::class);
    }

    public function language(): BelongsTo
    {
        return $this->belongsTo(Language::class);
    }

    public function isComplete(): bool
    {
        return filled($this->name)
            && filled($this->slug)
            && filled($this->meta_title)
            && filled($this->meta_description)
            && filled($this->seo_text);
    }

    public function isPartiallyTranslated(): bool
    {
        return !$this->isComplete()
            && (filled($this->name)
                || filled($this->meta_title)
                || filled($this->meta_description)
                || filled($this->seo_text));
    }
}
