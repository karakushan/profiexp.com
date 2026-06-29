<?php

namespace App\Models\Location;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Country extends Model
{
    use HasFactory;

    protected $fillable = [];

    public function states(): HasMany
    {
        return $this->hasMany(State::class, 'country_id');
    }

    public function contents(): HasMany
    {
        return $this->hasMany(CountryContent::class, 'country_id');
    }

    public function scopeForLanguage(Builder $query, int $languageId): Builder
    {
        return $query->whereHas('contents', function ($q) use ($languageId) {
            $q->where('language_id', $languageId);
        });
    }

    public function getTranslation(int $languageId): ?CountryContent
    {
        return $this->contents()->where('language_id', $languageId)->first();
    }

    public function getName(int $languageId): ?string
    {
        return $this->getTranslation($languageId)?->name;
    }
}
