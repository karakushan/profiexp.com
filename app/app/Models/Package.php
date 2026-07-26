<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Package extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'title_translations',
        'price',
        'term',
        'is_trial',
        'trial_days',
        'status',
        'number_of_car_featured',
        'number_of_listing',
        'number_of_images_per_listing',
        'number_of_products',
        'number_of_images_per_products',
        'slug',
        'number_of_amenities_per_listing',
        'custom_features',
        'custom_features_translations',
        'pricing_features_title',
        'pricing_features_title_translations',
        'pricing_features_description',
        'pricing_features_description_translations',
        'features',
        'number_of_faq',
        'number_of_social_links',
        'number_of_additional_specification',
        'icon',
        'recommended',
        'ai_engine',
        'ai_token_limit',
        'ai_image_limit',
    ];

    public function memberships()
    {
        return $this->hasMany(Membership::class);
    }

    public function translatedValue(string $field, ?string $languageCode = null): ?string
    {
        $translations = json_decode($this->{$field . '_translations'} ?? '', true) ?: [];
        $languageCode = $languageCode ?: app()->getLocale();

        return $translations[$languageCode] ?? $this->{$field};
    }
}
