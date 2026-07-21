<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('basic_settings', function (Blueprint $table) {
            $table->longText('google_analytics_code')->nullable()->after('google_map_api_key');
        });
    }

    public function down(): void
    {
        Schema::table('basic_settings', function (Blueprint $table) {
            $table->dropColumn('google_analytics_code');
        });
    }
};
