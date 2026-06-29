<?php

namespace Tests\Feature\Commands;

use App\Jobs\TranslateBlogCategoryJob;
use App\Models\Journal\BlogCategory;
use App\Models\Journal\BlogCategoryContent;
use App\Models\Language;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Illuminate\Support\Facades\Bus;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class TranslateBlogCategoriesCommandTest extends TestCase
{
    use DatabaseTransactions;
    private Language $defaultLang;
    private Language $targetLang;

    protected function setUp(): void
    {
        parent::setUp();

        DB::table('basic_settings')->updateOrInsert(
            ['uniqid' => 12345],
            ['auto_translate_status' => 1]
        );

        Language::where('is_default', 1)->update(['is_default' => 0]);
        Language::where('is_default', 0)->delete();

        $this->defaultLang = Language::create([
            'name' => 'English',
            'code' => 'en',
            'direction' => 0,
            'is_default' => 1,
        ]);

        $this->targetLang = Language::create([
            'name' => 'Arabic',
            'code' => 'ar',
            'direction' => 1,
            'is_default' => 0,
        ]);
    }

    public function test_command_exits_successfully_when_no_target_languages(): void
    {
        Language::where('id', '!=', $this->defaultLang->id)->delete();

        $this->artisan('blog-categories:translate')
            ->assertSuccessful();
    }

    public function test_command_exits_with_error_when_no_default_language(): void
    {
        Language::query()->update(['is_default' => 0]);

        $this->artisan('blog-categories:translate')
            ->assertFailed();
    }

    public function test_command_dispatches_jobs_for_pending_categories(): void
    {
        Bus::fake();

        $category = BlogCategory::create([
            'status' => 1,
            'serial_number' => 1,
        ]);

        BlogCategoryContent::create([
            'blog_category_id' => $category->id,
            'language_id' => $this->defaultLang->id,
            'name' => 'Test Category',
            'slug' => 'test-category',
        ]);

        $this->artisan('blog-categories:translate')
            ->assertSuccessful();

        Bus::assertDispatched(TranslateBlogCategoryJob::class);
    }

    public function test_command_skips_already_translated_categories(): void
    {
        Bus::fake();

        $category = BlogCategory::create([
            'status' => 1,
            'serial_number' => 2,
        ]);

        BlogCategoryContent::create([
            'blog_category_id' => $category->id,
            'language_id' => $this->defaultLang->id,
            'name' => 'Test Category',
            'slug' => 'test-category',
        ]);

        BlogCategoryContent::create([
            'blog_category_id' => $category->id,
            'language_id' => $this->targetLang->id,
            'name' => 'فئة اختبار',
            'slug' => 'فئة-اختبار',
        ]);

        $this->artisan('blog-categories:translate')
            ->assertSuccessful();

        Bus::assertNotDispatched(TranslateBlogCategoryJob::class);
    }
}
