<?php

use App\Models\Aminite;
use App\Models\AminiteContent;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('aminite_contents', function (Blueprint $table) {
            $table->id();
            $table->foreignId('aminite_id')->constrained('aminites')->cascadeOnDelete();
            $table->foreignId('language_id')->constrained('languages')->cascadeOnDelete();
            $table->string('title', 255)->nullable();
            $table->timestamps();
            $table->unique(['aminite_id', 'language_id']);
        });

        $existingLanguageIds = \DB::table('languages')->pluck('id')->toArray();

        foreach (Aminite::all() as $aminite) {
            if (!in_array($aminite->language_id, $existingLanguageIds)) {
                $aminite->delete();
                continue;
            }

            AminiteContent::create([
                'aminite_id' => $aminite->id,
                'language_id' => $aminite->language_id,
                'title' => $aminite->title,
            ]);
        }

        Schema::table('aminites', function (Blueprint $table) {
            $table->dropColumn('language_id');
            $table->dropColumn('title');
        });
    }

    public function down(): void
    {
        Schema::table('aminites', function (Blueprint $table) {
            $table->unsignedBigInteger('language_id')->nullable()->after('id');
            $table->string('title', 255)->nullable()->after('language_id');
        });

        foreach (AminiteContent::all() as $content) {
            Aminite::where('id', $content->aminite_id)->update([
                'language_id' => $content->language_id,
                'title' => $content->title,
            ]);
        }

        Schema::dropIfExists('aminite_contents');
    }
};
