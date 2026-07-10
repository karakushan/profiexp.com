<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ListingCategoryContent extends Model
{
    use HasFactory;

    protected $fillable = [
        'listing_category_id',
        'language_id',
        'name',
        'slug',
        'meta_title',
        'meta_description',
        'seo_text',
        'other_cities_title',
    ];

    public function category(): BelongsTo
    {
        return $this->belongsTo(ListingCategory::class, 'listing_category_id');
    }

    public function language(): BelongsTo
    {
        return $this->belongsTo(Language::class);
    }
}