<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('blog_categories', function (Blueprint $table) {
            $table->dropColumn(['language_id', 'name', 'slug']);
        });
    }

    public function down(): void
    {
        Schema::table('blog_categories', function (Blueprint $table) {
            $table->unsignedBigInteger('language_id')->nullable()->after('id');
            $table->string('name', 255)->nullable()->after('language_id');
            $table->string('slug', 255)->nullable()->after('name');
        });
    }
};
