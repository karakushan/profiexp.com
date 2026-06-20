<?php

namespace App\Models\Listing;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ListingFeatureContent extends Model
{
    use HasFactory;

    protected $fillable = [
        'language_id',
        'listing_feature_id',
        'feature_heading',
        'feature_value',
    ];
}
