<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('listing_categories', function (Blueprint $table) {
            $table->string('name', 255)->nullable()->after('parent_id');
            $table->string('slug', 255)->nullable()->after('name');
            $table->bigInteger('language_id')->nullable()->after('slug');
        });
    }

    public function down(): void
    {
        Schema::table('listing_categories', function (Blueprint $table) {
            $table->dropColumn(['name', 'slug', 'language_id']);
        });
    }
};