<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('basic_settings', function (Blueprint $table) {
            $table->renameColumn('google_analytics_code', 'google_analytics_id');
        });
    }

    public function down(): void
    {
        Schema::table('basic_settings', function (Blueprint $table) {
            $table->renameColumn('google_analytics_id', 'google_analytics_code');
        });
    }
};
