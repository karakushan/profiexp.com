<?php

namespace App\Models\Journal;

use App\Models\Language;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class BlogCategory extends Model
{
    use HasFactory;

    protected $fillable = ['status', 'serial_number'];

    public function contents(): HasMany
    {
        return $this->hasMany(BlogCategoryContent::class, 'blog_category_id');
    }

    public function blogInfo(): HasMany
    {
        return $this->hasMany(BlogInformation::class);
    }

    public function scopeBySlug(Builder $query, int $languageId, string $slug): Builder
    {
        return $query->whereHas('contents', function ($q) use ($languageId, $slug) {
            $q->where('language_id', $languageId)->where('slug', $slug);
        });
    }

    public function scopeActive(Builder $query): Builder
    {
        return $query->where('status', 1);
    }

    public function getTranslation(int $languageId): ?BlogCategoryContent
    {
        return $this->contents()->where('language_id', $languageId)->first();
    }

    public function getName(int $languageId): ?string
    {
        return $this->getTranslation($languageId)?->name;
    }

    public function getSlug(int $languageId): ?string
    {
        return $this->getTranslation($languageId)?->slug;
    }
}
