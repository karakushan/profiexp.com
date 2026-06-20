<?php

namespace App\Models\Listing;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Listing\ListingContent;
use App\Models\Vendor;

class Listing extends Model
{
    use HasFactory;
    protected $fillable = [
        'feature_image',
        'vendor_id',
        'mail',
        'phone',
        'average_rating',
        'latitude',
        'longitude',
        'video_url',
        'video_background_image',
        'status',
        'max_price',
        'min_price',
        'visibility'
    ];

    public function listing_content()
    {
        return $this->hasMany(ListingContent::class, 'listing_id', 'id');
    }

    public function galleries()
    {
        return $this->hasMany(ListingImage::class, 'listing_id', 'id');
    }

    public function vendor()
    {
        return $this->belongsTo(Vendor::class);
    }
    public function listingProducts()
    {
        return $this->hasMany(ListingProduct::class, 'listing_id', 'id');
    }
    public function listingFaqs()
    {
        return $this->hasMany(ListingFaq::class);
    }
    public function specifications()
    {
        return $this->hasMany(ListingFeature::class, 'listing_id', 'id');
    }
    public function sociallinks()
    {
        return $this->hasMany(ListingSocialMedia::class, 'listing_id', 'id');
    }
}
