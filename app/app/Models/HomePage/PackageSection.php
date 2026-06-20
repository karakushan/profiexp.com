<?php

namespace App\Models\HomePage;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PackageSection extends Model
{
    use HasFactory;

    protected $table = 'package_sections';
    protected $fillable = [
        'language_id',
        'title',
        'subtitle',
        'button_text'
    ];

}
