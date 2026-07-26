<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('packages', function (Blueprint $table) {
            $table->text('title_translations')->nullable()->after('title');
            $table->text('pricing_features_title_translations')->nullable()->after('pricing_features_title');
            $table->text('pricing_features_description_translations')->nullable()->after('pricing_features_description');
        });
    }

    public function down(): void
    {
        Schema::table('packages', function (Blueprint $table) {
            $table->dropColumn([
                'title_translations',
                'pricing_features_title_translations',
                'pricing_features_description_translations',
            ]);
        });
    }
};
