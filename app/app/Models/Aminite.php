<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Aminite extends Model
{
    use HasFactory;

    protected $fillable = [
        'id',
        'icon',
    ];

    public function contents(): HasMany
    {
        return $this->hasMany(AminiteContent::class);
    }

    public function getTitle(int $languageId): ?string
    {
        $content = $this->contents->firstWhere('language_id', $languageId);
        return $content?->title;
    }
}
