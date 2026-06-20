<?php

namespace App\Models\Listing;

use App\Models\Language;
use App\Models\ListingCategory;
use App\Models\Location\City;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ListingContent extends Model
{
    use HasFactory;

    protected $fillable = [
        'id',
        'language_id',
        'listing_id',
        'category_id',
        'country_id',
        'state_id',
        'city_id',
        'title',
        'slug',
        'description',
        'address',
        'meta_keyword',
        'meta_description',
        'summary',
        'features'
    ];

    public function category()
    {
        return $this->belongsTo(ListingCategory::class);
    }
    public function city()
    {
        return $this->belongsTo(City::class);
    }
    public function listing()
    {
        return $this->belongsTo(Listing::class);
    }
    public function language()
    {
        return $this->belongsTo(Language::class, 'language_id', 'id');
    }
}
