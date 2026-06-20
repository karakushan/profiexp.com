<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BusinessHour extends Model
{
    use HasFactory;
    protected $fillable = [
        'listing_id',
        'day',
        'start_time',
        'end_time',
        'holiday'
    ];
}
