<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('basic_settings', function (Blueprint $table) {
            $table->string('google_recaptcha_project_id')->nullable()->after('google_recaptcha_status');
            $table->string('google_recaptcha_api_key')->nullable()->after('google_recaptcha_secret_key');
        });
    }

    public function down(): void
    {
        Schema::table('basic_settings', function (Blueprint $table) {
            $table->dropColumn(['google_recaptcha_project_id', 'google_recaptcha_api_key']);
        });
    }
};
