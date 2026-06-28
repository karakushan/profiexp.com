<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('listing_category_contents', function (Blueprint $table) {
            $table->id();
            $table->foreignId('listing_category_id')->constrained('listing_categories')->cascadeOnDelete();
            $table->foreignId('language_id')->constrained('languages')->cascadeOnDelete();
            $table->string('name', 255)->nullable();
            $table->string('slug', 255)->nullable();
            $table->string('meta_title', 255)->nullable();
            $table->text('meta_description')->nullable();
            $table->timestamps();

            $table->unique(['listing_category_id', 'language_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('listing_category_contents');
    }
};