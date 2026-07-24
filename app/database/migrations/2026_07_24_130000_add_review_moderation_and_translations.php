<?php

use App\Models\Language;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        $defaultLanguageId = Language::query()->where('is_default', 1)->value('id');

        foreach (['listing_reviews', 'product_reviews'] as $table) {
            if (!Schema::hasTable($table)) {
                continue;
            }

            $statusAdded = false;
            Schema::table($table, function (Blueprint $table) use (&$statusAdded) {
                if (!Schema::hasColumn($table->getTable(), 'status')) {
                    $table->string('status', 20)->default('pending')->index();
                    $statusAdded = true;
                }

                if (!Schema::hasColumn($table->getTable(), 'language_id')) {
                    $table->unsignedBigInteger('language_id')->nullable()->index();
                }
            });

            if ($statusAdded) {
                DB::table($table)->update(['status' => 'approved']);
            } else {
                DB::table($table)->whereNull('status')->update(['status' => 'approved']);
            }
            if ($defaultLanguageId) {
                DB::table($table)->whereNull('language_id')->update(['language_id' => $defaultLanguageId]);
            }
        }

        if (!Schema::hasTable('review_translations')) {
            Schema::create('review_translations', function (Blueprint $table) {
                $table->id();
                $table->string('review_type', 20);
                $table->unsignedBigInteger('review_id');
                $table->unsignedBigInteger('language_id');
                $table->text('text');
                $table->timestamps();

                $table->unique(['review_type', 'review_id', 'language_id'], 'review_translation_unique');
                $table->index(['review_type', 'review_id']);
                $table->foreign('language_id')->references('id')->on('languages')->cascadeOnDelete();
            });
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('review_translations');

        foreach (['listing_reviews', 'product_reviews'] as $table) {
            if (!Schema::hasTable($table)) {
                continue;
            }

            Schema::table($table, function (Blueprint $table) {
                foreach (['status', 'language_id'] as $column) {
                    if (Schema::hasColumn($table->getTable(), $column)) {
                        $table->dropColumn($column);
                    }
                }
            });
        }
    }
};
