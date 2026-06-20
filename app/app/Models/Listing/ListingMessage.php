<?php

namespace App\Models\Listing;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Vendor;

class ListingMessage extends Model
{
    use HasFactory;
    protected $fillable = [
        'listing_id',
        'vendor_id',
        'name',
        'email',
        'phone',
        'message'
    ];
    public function vendor()
    {
        return $this->belongsTo(Vendor::class);
    }
}
