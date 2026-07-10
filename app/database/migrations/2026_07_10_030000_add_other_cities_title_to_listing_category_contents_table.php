<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('listing_category_contents', function (Blueprint $table) {
            $table->string('other_cities_title')->nullable()->after('seo_text');
        });
    }

    public function down(): void
    {
        Schema::table('listing_category_contents', function (Blueprint $table) {
            $table->dropColumn('other_cities_title');
        });
    }
};
