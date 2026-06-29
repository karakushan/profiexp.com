<?php

namespace App\Models\Location;

use App\Models\Language;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class CityContent extends Model
{
    use HasFactory;

    protected $fillable = [
        'city_id',
        'language_id',
        'name',
        'slug',
    ];

    public function city(): BelongsTo
    {
        return $this->belongsTo(City::class);
    }

    public function language(): BelongsTo
    {
        return $this->belongsTo(Language::class);
    }
}
