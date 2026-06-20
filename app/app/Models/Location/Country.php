<?php

namespace App\Models\Location;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Country extends Model
{
    use HasFactory;

    protected $fillable = [
        'language_id',
        'name'
    ];

    public function states()
    {
        return $this->hasMany(State::class, 'country_id');
    }

}
