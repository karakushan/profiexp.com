<?php

namespace App\Models\Listing;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Listing\ListingProductContent;
use App\Models\Listing\ListingProductImage;

class ListingProduct extends Model
{
    use HasFactory;
    protected $fillable = [
        'listing_id',
        'status',
        'current_price',
        'previous_price',
        'feature_image',
        'vendor_id'
    ];
    public function listing_product_content()
    {
        return $this->hasOne(ListingProductContent::class, 'listing_product_id', 'id');
    }
    public function galleries()
    {
        return $this->hasMany(ListingProductImage::class);
    }
    public function listings()
    {
        return $this->belongsTo(Listing::class);
    }
}
