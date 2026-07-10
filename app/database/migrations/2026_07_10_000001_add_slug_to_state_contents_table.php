<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('state_contents', function (Blueprint $table) {
            $table->string('slug', 255)->nullable()->after('name');
        });

        DB::table('state_contents')
            ->whereNotNull('name')
            ->where('name', '!=', '')
            ->orderBy('id')
            ->eachById(function ($content): void {
                DB::table('state_contents')->where('id', $content->id)->update([
                    'slug' => Str::slug($content->name),
                ]);
            });

        DB::table('city_contents')
            ->whereNull('slug')
            ->whereNotNull('name')
            ->where('name', '!=', '')
            ->orderBy('id')
            ->eachById(function ($content): void {
                DB::table('city_contents')->where('id', $content->id)->update([
                    'slug' => Str::slug($content->name),
                ]);
            });
    }

    public function down(): void
    {
        Schema::table('state_contents', function (Blueprint $table) {
            $table->dropColumn('slug');
        });
    }
};
