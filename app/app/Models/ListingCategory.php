<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Listing\ListingContent;

class ListingCategory extends Model
{
    use HasFactory;

    protected $fillable = [
        'id',
        'language_id',
        'name',
        'slug',
        'serial_number',
        'status',
        'icon',
        'mobile_image'
    ];
    public function listing_contents()
    {
        return $this->hasMany(ListingContent::class, 'category_id');
    }
}
