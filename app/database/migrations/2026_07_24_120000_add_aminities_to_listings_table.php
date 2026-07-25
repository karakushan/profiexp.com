<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('listings', function (Blueprint $table) {
            $table->text('aminities')->nullable()->after('visibility');
        });

        DB::table('listing_contents')
            ->select('listing_id', 'aminities')
            ->whereNotNull('aminities')
            ->where('aminities', '!=', '[]')
            ->orderBy('id')
            ->get()
            ->groupBy('listing_id')
            ->each(function ($contents, $listingId) {
                $source = $contents->first();

                if ($source) {
                    DB::table('listings')
                        ->where('id', $listingId)
                        ->update(['aminities' => $source->aminities]);
                }
            });
    }

    public function down(): void
    {
        Schema::table('listings', function (Blueprint $table) {
            $table->dropColumn('aminities');
        });
    }
};
