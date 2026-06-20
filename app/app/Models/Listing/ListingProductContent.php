<?php

namespace App\Models\Listing;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ListingProductContent extends Model
{
    use HasFactory;
    protected $fillable = [
        'listing_id',
        'language_id',
        'listing_product_id',
        'title',
        'content',
        'meta_keyword',
        'meta_description',
        'slug'
    ];
    public function car()
    {
        return $this->belongsTo(ListingProduct::class);
    }
}
