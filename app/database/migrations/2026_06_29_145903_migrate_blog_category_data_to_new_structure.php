<?php

use App\Models\Language;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        $categories = DB::table('blog_categories')->orderBy('id')->get();
        if ($categories->isEmpty()) {
            return;
        }

        $defaultLang = Language::where('is_default', 1)->first();
        if (!$defaultLang) {
            return;
        }

        $hasData = false;
        foreach ($categories as $cat) {
            if ($cat->language_id !== null && !empty($cat->name)) {
                $hasData = true;
                break;
            }
        }

        if (!$hasData) {
            return;
        }

        $grouped = [];
        foreach ($categories as $cat) {
            if ($cat->language_id === null || empty($cat->name)) {
                continue;
            }
            $key = $cat->serial_number;
            if (!isset($grouped[$key])) {
                $grouped[$key] = [
                    'id' => $cat->id,
                    'serial_number' => $cat->serial_number,
                    'status' => $cat->status,
                    'created_at' => $cat->created_at,
                    'updated_at' => $cat->updated_at,
                    'translations' => [],
                ];
            }
            $grouped[$key]['translations'][] = $cat;
        }

        foreach ($grouped as $key => $group) {
            if (empty($group['translations'])) {
                continue;
            }

            $keepId = $group['id'];

            $hasDefault = false;
            foreach ($group['translations'] as $cat) {
                if ((int) $cat->language_id === (int) $defaultLang->id) {
                    $keepId = $cat->id;
                    $hasDefault = true;
                    break;
                }
            }

            $defaultTranslation = null;
            foreach ($group['translations'] as $cat) {
                if ((int) $cat->id === $keepId) {
                    $defaultTranslation = $cat;
                    break;
                }
            }

            $defaultTranslation ??= $group['translations'][0];

            DB::table('blog_categories')
                ->where('id', $keepId)
                ->update([
                    'serial_number' => $group['serial_number'],
                    'status' => $group['status'],
                    'updated_at' => $group['updated_at'],
                ]);

            foreach ($group['translations'] as $cat) {
                DB::table('blog_category_contents')->insert([
                    'blog_category_id' => $keepId,
                    'language_id' => $cat->language_id,
                    'name' => $cat->name,
                    'slug' => $cat->slug,
                    'created_at' => $cat->created_at,
                    'updated_at' => $cat->updated_at,
                ]);

                DB::table('blog_informations')
                    ->where('blog_category_id', $cat->id)
                    ->update(['blog_category_id' => $keepId]);
            }

            foreach ($group['translations'] as $cat) {
                if ((int) $cat->id !== $keepId) {
                    DB::table('blog_categories')->where('id', $cat->id)->delete();
                }
            }
        }

        $orphans = DB::table('blog_categories')
            ->whereNotIn('id', function ($q) {
                $q->select('blog_category_id')->from('blog_category_contents');
            })
            ->get();

        foreach ($orphans as $orphan) {
            DB::table('blog_categories')->where('id', $orphan->id)->delete();
        }
    }

    public function down(): void
    {

    }
};
