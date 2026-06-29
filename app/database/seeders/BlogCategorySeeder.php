<?php

namespace Database\Seeders;

use App\Models\Journal\BlogCategory;
use App\Models\Journal\BlogCategoryContent;
use App\Models\Language;
use Illuminate\Database\Seeder;

class BlogCategorySeeder extends Seeder
{
    public function run(): void
    {
        $lang = Language::where('code', 'ru')->firstOrFail();

        $categories = [
            ['name' => 'Бизнес-оптимизация', 'serial_number' => 1],
            ['name' => 'Советы для местного бизнеса', 'serial_number' => 2],
            ['name' => 'Рост малого бизнеса', 'serial_number' => 3],
            ['name' => 'Онлайн-присутствие', 'serial_number' => 4],
            ['name' => 'Маркетинг и продвижение', 'serial_number' => 5],
        ];

        foreach ($categories as $cat) {
            $category = BlogCategory::create([
                'status' => 1,
                'serial_number' => $cat['serial_number'],
            ]);

            BlogCategoryContent::create([
                'blog_category_id' => $category->id,
                'language_id' => $lang->id,
                'name' => $cat['name'],
                'slug' => createSlug($cat['name']),
            ]);
        }

        $this->command->info('Blog categories seeded successfully.');
    }
}
