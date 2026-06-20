<?php

namespace App\Models\Listing;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ListingSocialMedia extends Model
{
    use HasFactory;
    protected $table = 'listing_socail_medias';
    protected $fillable = [
        'listing_id',
        'link',
        'icon',
    ];
}
