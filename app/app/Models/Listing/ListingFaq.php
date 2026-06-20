<?php

namespace App\Models\Listing;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ListingFaq extends Model
{
    use HasFactory;
    protected $fillable = [
        'language_id',
        'listing_id',
        'question',
        'answer',
        'serial_number'
    ];
}
