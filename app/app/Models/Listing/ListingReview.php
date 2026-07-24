<?php

namespace App\Models\Listing;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;
use App\Models\Listing\Listing;
use App\Models\Language;
use App\Models\ReviewTranslation;

class ListingReview extends Model
{
    public const TYPE = 'listing';

    use HasFactory;
    protected $fillable = [
        'user_id',
        'listing_id',
        'rating',
        'review',
        'status',
        'language_id',
    ];
    public function userInfo()
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }
    public function listingInfo()
    {
        return $this->belongsTo(Listing::class, 'listing_id', 'id');
    }

    public function language()
    {
        return $this->belongsTo(Language::class);
    }

    public function translations()
    {
        return $this->hasMany(ReviewTranslation::class, 'review_id')->where('review_type', self::TYPE);
    }
}
