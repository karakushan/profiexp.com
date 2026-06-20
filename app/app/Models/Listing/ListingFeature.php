<?php

namespace App\Models\Listing;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ListingFeature extends Model
{
    use HasFactory;

    protected $fillable = [
        'language_id',
        'listing_id',
        'feature_heading',
        'feature_value',
        'indx'
    ];

}
