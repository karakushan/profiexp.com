<?php

namespace App\Models\Listing;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ListingProductImage extends Model
{
    use HasFactory;
    protected $fillable = [
        'listing_id',
        'listing_product_id',
        'image'
    ];
}
