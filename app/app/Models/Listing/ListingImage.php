<?php

namespace App\Models\Listing;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ListingImage extends Model
{
    use HasFactory;

    protected $fillable = [
        'listing_id',
        'image'
    ];
    public function listing()
    {
        return $this->belongsTo(Listing::class, 'id', 'listing_id');
    }
}
