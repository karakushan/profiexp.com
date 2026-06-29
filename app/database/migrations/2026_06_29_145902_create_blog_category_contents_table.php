<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('blog_category_contents', function (Blueprint $table) {
            $table->id();
            $table->foreignId('blog_category_id')->constrained('blog_categories')->cascadeOnDelete();
            $table->foreignId('language_id')->constrained('languages')->cascadeOnDelete();
            $table->string('name', 255);
            $table->string('slug', 255);
            $table->string('meta_title', 255)->nullable();
            $table->text('meta_description')->nullable();
            $table->text('seo_text')->nullable();
            $table->timestamps();

            $table->unique(['blog_category_id', 'language_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('blog_category_contents');
    }
};
