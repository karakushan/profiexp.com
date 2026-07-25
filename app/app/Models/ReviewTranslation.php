<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ReviewTranslation extends Model
{
    use HasFactory;

    protected $fillable = [
        'review_type',
        'review_id',
        'language_id',
        'text',
    ];

    public function language()
    {
        return $this->belongsTo(Language::class);
    }
}
