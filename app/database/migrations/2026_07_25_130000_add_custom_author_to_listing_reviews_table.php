<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (!Schema::hasTable('listing_reviews')) return;

        Schema::table('listing_reviews', function (Blueprint $table) {
            if (!Schema::hasColumn('listing_reviews', 'author_name')) $table->string('author_name')->nullable()->after('user_id');
            if (!Schema::hasColumn('listing_reviews', 'author_image')) $table->string('author_image')->nullable()->after('author_name');
        });
    }

    public function down(): void
    {
        if (!Schema::hasTable('listing_reviews')) return;

        Schema::table('listing_reviews', function (Blueprint $table) {
            foreach (['author_name', 'author_image'] as $column) {
                if (Schema::hasColumn('listing_reviews', $column)) $table->dropColumn($column);
            }
        });
    }
};
