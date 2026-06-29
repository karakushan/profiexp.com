<?php

namespace Database\Seeders;

use App\Models\Journal\Blog;
use App\Models\Journal\BlogCategory;
use App\Models\Journal\BlogCategoryContent;
use App\Models\Journal\BlogInformation;
use App\Models\Language;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class BlogSeeder extends Seeder
{
    public function run(): void
    {
        $lang = Language::where('code', 'ru')->firstOrFail();
        $categories = BlogCategory::with('contents')->get();

        if ($categories->isEmpty()) {
            $this->command->warn('No blog categories found. Run BlogCategorySeeder first.');
            return;
        }

        $categoryMap = [];
        foreach ($categories as $cat) {
            $content = $cat->contents->firstWhere('language_id', $lang->id);
            if ($content) {
                $categoryMap[$content->name] = $cat->id;
            }
        }

        $posts = [
            [
                'title' => '10 советов по оптимизации бизнес-профиля',
                'category' => 'Бизнес-оптимизация',
                'content' => '<p>В современном цифровом мире наличие сильного онлайн-присутствия имеет решающее значение для успеха любого бизнеса. Вот 10 советов, которые помогут вам оптимизировать свой бизнес-профиль.</p><ol><li><p><strong>Заполните профиль полностью</strong> — убедитесь, что вся информация о вашем бизнесе актуальна.</p></li><li><p><strong>Выберите правильные категории</strong> — это поможет клиентам легче вас найти.</p></li><li><p><strong>Оптимизируйте описание</strong> — используйте релевантные ключевые слова.</p></li><li><p><strong>Добавьте качественные фото</strong> — визуальный контент привлекает клиентов.</p></li><li><p><strong>Собирайте отзывы</strong> — положительные отзывы повышают доверие.</p></li></ol>',
            ],
            [
                'title' => 'Как улучшить видимость вашего бизнеса в поисковых системах',
                'category' => 'Бизнес-оптимизация',
                'content' => '<p>SEO-оптимизация — это ключ к привлечению большего количества клиентов. В этой статье мы расскажем о основных стратегиях продвижения.</p><p>Начните с исследования ключевых слов, оптимизируйте мета-теги и создавайте качественный контент. Не забывайте про локальное SEO — это особенно важно для малого бизнеса.</p>',
            ],
            [
                'title' => '5 эффективных стратегий для привлечения местных клиентов',
                'category' => 'Советы для местного бизнеса',
                'content' => '<p>Привлечение местных клиентов требует особого подхода. Вот 5 проверенных стратегий:</p><ul><li>Участвуйте в местных мероприятиях</li><li>Сотрудничайте с другими местными бизнесами</li><li>Используйте геотаргетированную рекламу</li><li>Оптимизируйте профиль в Google My Business</li><li>Создайте программу лояльности</li></ul>',
            ],
            [
                'title' => 'Почему малому бизнесу нужен свой сайт',
                'category' => 'Рост малого бизнеса',
                'content' => '<p>В эпоху цифровых технологий наличие веб-сайта — это не роскошь, а необходимость. Сайт работает как ваша витрина 24/7, привлекая клиентов даже в нерабочее время.</p><p>Инвестиции в качественный сайт окупаются за счет увеличения продаж и узнаваемости бренда. Современные конструкторы сайтов делают создание сайта доступным для любого бюджета.</p>',
            ],
            [
                'title' => 'Как использовать социальные сети для продвижения бизнеса',
                'category' => 'Онлайн-присутствие',
                'content' => '<p>Социальные сети — мощный инструмент для продвижения бизнеса. Вот основные шаги:</p><ol><li>Выберите подходящие платформы</li><li>Создайте контент-план</li><li>Взаимодействуйте с аудиторией</li><li>Используйте платную рекламу</li><li>Анализируйте результаты</li></ol><p>Помните: регулярность и качество контента важнее количества.</p>',
            ],
            [
                'title' => 'Тренды цифрового маркетинга 2026 года',
                'category' => 'Маркетинг и продвижение',
                'content' => '<p>Цифровой маркетинг продолжает развиваться. Главные тренды этого года:</p><ul><li><strong>Искусственный интеллект</strong> — персонализация и автоматизация</li><li><strong>Видеоконтент</strong> — короткие видео набирают популярность</li><li><strong>Голосовой поиск</strong> — оптимизация под голосовые запросы</li><li><strong>Устойчивое развитие</strong> — экологичность становится важным фактором</li></ul>',
            ],
        ];

        foreach ($posts as $i => $post) {
            $categoryId = $categoryMap[$post['category']] ?? null;
            if (!$categoryId) {
                $this->command->warn("Category '{$post['category']}' not found, skipping post '{$post['title']}'");
                continue;
            }

            $images = [
                '663b3fa55cb46.png',
                '663b3fb1052e5.png',
                '663b3fc9a3c11.png',
                '663b3fdcf2d29.png',
                '663b4016d8f69.png',
                '663b40207f13d.png',
            ];

            $blog = Blog::create([
                'image' => $images[$i] ?? 'default-blog.jpg',
                'serial_number' => $i + 1,
                'translated_languages' => '{}',
            ]);

            BlogInformation::create([
                'language_id' => $lang->id,
                'blog_category_id' => $categoryId,
                'blog_id' => $blog->id,
                'title' => $post['title'],
                'slug' => Str::slug($post['title']),
                'author' => 'Администратор',
                'content' => $post['content'],
                'meta_keywords' => $post['category'] . ', бизнес, советы',
                'meta_description' => mb_substr(strip_tags($post['content']), 0, 160),
            ]);
        }

        $this->command->info('Blog posts seeded successfully.');
    }
}
