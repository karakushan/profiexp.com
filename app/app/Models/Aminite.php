<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Aminite extends Model
{
    use HasFactory;

    protected $fillable = [
        'id',
        'language_id',
        'icon',
        'title',
    ];
}
