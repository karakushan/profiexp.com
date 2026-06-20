<?php

namespace App\Models\HomePage;

use App\Models\Language;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class HeroSection extends Model
{
    use HasFactory;
    protected $fillable = ['language_id', 'title', 'text'];

    public function language()
    {
        return $this->belongsTo(Language::class, 'language_id', 'id');
    }
}
