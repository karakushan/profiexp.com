<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class AminiteContent extends Model
{
    use HasFactory;

    protected $fillable = [
        'aminite_id',
        'language_id',
        'title',
    ];

    public function aminite(): BelongsTo
    {
        return $this->belongsTo(Aminite::class);
    }

    public function language(): BelongsTo
    {
        return $this->belongsTo(Language::class);
    }
}
