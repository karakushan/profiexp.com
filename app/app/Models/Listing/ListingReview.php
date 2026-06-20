<?php

namespace App\Models\Listing;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;
use App\Models\Listing\Listing;

class ListingReview extends Model
{
    use HasFactory;
    protected $fillable = [
        'user_id',
        'listing_id',
        'rating',
        'review',
    ];
    public function userInfo()
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }
    public function listingInfo()
    {
        return $this->belongsTo(Listing::class);
    }
}
