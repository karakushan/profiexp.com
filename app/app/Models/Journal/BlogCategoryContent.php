<?php

namespace App\Models\Journal;

use App\Models\Language;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class BlogCategoryContent extends Model
{
    use HasFactory;

    protected $fillable = [
        'blog_category_id',
        'language_id',
        'name',
        'slug',
        'meta_title',
        'meta_description',
        'seo_text',
    ];

    public function category(): BelongsTo
    {
        return $this->belongsTo(BlogCategory::class, 'blog_category_id');
    }

    public function language(): BelongsTo
    {
        return $this->belongsTo(Language::class);
    }
}
