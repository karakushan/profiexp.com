<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('listing_city_categories', function (Blueprint $table) {
            $table->id();
            $table->foreignId('city_id')->constrained('cities')->cascadeOnDelete();
            $table->foreignId('listing_category_id')->constrained('listing_categories')->cascadeOnDelete();
            $table->timestamps();

            $table->unique(['city_id', 'listing_category_id'], 'lcc_city_category_unique');
        });

        Schema::create('listing_city_category_contents', function (Blueprint $table) {
            $table->id();
            $table->foreignId('listing_city_category_id')->constrained('listing_city_categories')->cascadeOnDelete();
            $table->foreignId('language_id')->constrained('languages')->cascadeOnDelete();
            $table->string('name', 255)->nullable();
            $table->string('slug', 255)->nullable();
            $table->string('meta_title', 255)->nullable();
            $table->text('meta_description')->nullable();
            $table->longText('seo_text')->nullable();
            $table->timestamps();

            $table->unique(['listing_city_category_id', 'language_id'], 'lccc_item_language_unique');
            $table->unique(['language_id', 'slug'], 'lccc_language_slug_unique');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('listing_city_category_contents');
        Schema::dropIfExists('listing_city_categories');
    }
};
