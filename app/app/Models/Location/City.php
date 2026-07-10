<?php

namespace App\Models\Location;

use App\Models\Listing\ListingContent;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class City extends Model
{
    use HasFactory;

    protected $fillable = [
        'country_id',
        'feature_image',
        'state_id',
    ];

    public function country(): BelongsTo
    {
        return $this->belongsTo(Country::class, 'country_id');
    }

    public function state(): BelongsTo
    {
        return $this->belongsTo(State::class, 'state_id');
    }

    public function contents(): HasMany
    {
        return $this->hasMany(CityContent::class, 'city_id');
    }

    public function listingCityCategories(): HasMany
    {
        return $this->hasMany(ListingCityCategory::class);
    }

    public function scopeForLanguage(Builder $query, int $languageId): Builder
    {
        return $query->whereHas('contents', function ($q) use ($languageId) {
            $q->where('language_id', $languageId);
        });
    }

    public function getTranslation(int $languageId): ?CityContent
    {
        return $this->contents()->where('language_id', $languageId)->first();
    }

    public function getName(int $languageId): ?string
    {
        return $this->getTranslation($languageId)?->name;
    }

    public function listing_city()
    {
        return $this->hasMany(ListingContent::class, 'city_id')
            ->whereHas('listing', function ($q) {
                $q->where('status', 1)
                    ->where('visibility', 1)
                    ->where(function ($q) {
                        $q->where('vendor_id', 0)
                            ->orWhereHas('vendor', function ($v) {
                                $v->where('status', 1)
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
