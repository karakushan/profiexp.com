<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('packages', function (Blueprint $table) {
            $table->string('pricing_features_title')->nullable()->after('custom_features');
            $table->text('pricing_features_description')->nullable()->after('pricing_features_title');
        });
    }

    public function down(): void
    {
        Schema::table('packages', function (Blueprint $table) {
            $table->dropColumn(['pricing_features_title', 'pricing_features_description']);
        });
    }
};
