<?php

namespace App\Models;

use App\Models\Listing\Listing;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ClaimListing extends Model
{
    use HasFactory;
    protected $fillable = [
        'listing_id',
        'user_id',
        'vendor_id',
        'status',
        'customer_name',
        'language_id',
        'customer_email',
        'customer_phone	',
        'information',
        'redemption_token',
        'raw_redemption_token',
        'redemption_expires_at',
        'approved_at',
    ];

    // The listing this claim is about
    public function listing()
    {
        return $this->belongsTo(Listing::class, 'listing_id', 'id');
    }

    // The user who submitted the claim
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }

    public function vendor()
    {
        return $this->belongsTo(Vendor::class, 'vendor_id', 'id');
    }

}
