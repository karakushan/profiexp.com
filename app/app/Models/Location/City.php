<?php

namespace App\Models\Location;

use App\Models\Listing\ListingContent;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class City extends Model
{
    use HasFactory;
    protected $fillable = [
        'language_id',
        'country_id',
        'feature_image',
        'state_id',
        'name',
        'slug'
    ];

    public function country()
    {
        return $this->belongsTo(Country::class, 'country_id');
    }
    public function state()
    {
        return $this->belongsTo(State::class, 'state_id');
    }
    public function listing_city()
    {
        return $this->hasMany(ListingContent::class, 'city_id')
            ->whereHas('listing', function ($q) {
                $q->where('status', 1)
                    ->where('visibility', 1)
                    ->where(function ($q) {
                        $q->where('vendor_id', 0)

                            // CHANGE 3: vendor check moved inside orWhereHas('vendor')
                            ->orWhereHas('vendor', function ($v) {
                                $v->where('status', 1)

                                    // CHANGE 4: memberships check is now inside vendor
                                    ->whereHas('memberships', function ($m) {
                                        $m->where('status', 1)
                                            ->whereDate('start_date', '<=', now())
                                            ->whereDate('expire_date', '>=', now());
                                    });
                            });
                    });
            })
            ->whereHas('category', function ($q) {
                $q->where('status', 1);
            });
    }
}
