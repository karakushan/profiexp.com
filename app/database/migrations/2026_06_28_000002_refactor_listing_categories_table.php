<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('listing_categories', function (Blueprint $table) {
            $table->dropColumn(['language_id', 'name', 'slug', 'meta_title', 'meta_description']);

            if (Schema::hasColumn('listing_categories', 'parent_id')) {
                return;
            }

            $table->foreignId('parent_id')->nullable()->after('id')->constrained('listing_categories')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::table('listing_categories', function (Blueprint $table) {
            $table->bigInteger('language_id')->nullable();
            $table->string('name', 255)->nullable();
            $table->string('slug', 255)->nullable();
            $table->string('meta_title', 255)->nullable();
            $table->text('meta_description')->nullable();

            if ($this->hasParentIdForeign()) {
                $table->dropForeign(['parent_id']);
            }
            $table->dropColumn('parent_id');
        });
    }

    private function hasParentIdForeign(): bool
    {
        $foreignKeys = Schema::getForeignKeys('listing_categories');
        foreach ($foreignKeys as $fk) {
            if (in_array('parent_id', $fk['columns'])) {
                return true;
            }
        }
        return false;
    }
};