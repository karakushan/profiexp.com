<?php

namespace App\Models\HomePage;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ListingSection extends Model
{
    use HasFactory;

    protected $table = 'listing_sections';
    protected $fillable = [
        'language_id',
        'title',
        'subtitle',
        'button_text'
    ];
}
