<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MobileInterfaceSetting extends Model
{
  use HasFactory;

  protected $fillable = [
    'language_id',
    'category_listing_section_title',
    'featured_listing_section_title',
    'banner_background_image',
    'banner_image',
    'banner_title',
    'banner_button_text',
    'banner_button_url'
  ];
}
