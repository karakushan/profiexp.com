<?php

namespace App\Models\Location;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class State extends Model
{
    use HasFactory;

    protected $fillable = [
        'country_id',
    ];

    public function country(): BelongsTo
    {
        return $this->belongsTo(Country::class, 'country_id');
    }

    public function cities(): HasMany
    {
        return $this->hasMany(City::class, 'state_id');
    }

    public function contents(): HasMany
    {
        return $this->hasMany(StateContent::class, 'state_id');
    }

    public function scopeForLanguage(Builder $query, int $languageId): Builder
    {
        return $query->whereHas('contents', function ($q) use ($languageId) {
            $q->where('language_id', $languageId);
        });
    }

    public function getTranslation(int $languageId): ?StateContent
    {
        return $this->contents()->where('language_id', $languageId)->first();
    }

    public function getName(int $languageId): ?string
    {
        return $this->getTranslation($languageId)?->name;
    }
}
