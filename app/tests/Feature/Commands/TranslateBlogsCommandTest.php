<?php

namespace Tests\Feature\Commands;

use App\Jobs\TranslateBlogJob;
use App\Models\Journal\Blog;
use App\Models\Journal\BlogCategory;
use App\Models\Journal\BlogCategoryContent;
use App\Models\Journal\BlogInformation;
use App\Models\Language;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Illuminate\Support\Facades\Bus;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class TranslateBlogsCommandTest extends TestCase
{
    use DatabaseTransactions;
    private Language $defaultLang;
    private Language $targetLang;
    private BlogCategory $category;

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

        $this->category = BlogCategory::create([
            'status' => 1,
            'serial_number' => 1,
        ]);

        BlogCategoryContent::create([
            'blog_category_id' => $this->category->id,
            'language_id' => $this->defaultLang->id,
            'name' => 'Test Category',
            'slug' => 'test-category',
        ]);
    }

    public function test_command_exits_successfully_when_no_target_languages(): void
    {
        Language::where('id', '!=', $this->defaultLang->id)->delete();

        $this->artisan('blogs:translate')
            ->assertSuccessful();
    }

    public function test_command_exits_with_error_when_no_default_language(): void
    {
        Language::query()->update(['is_default' => 0]);

        $this->artisan('blogs:translate')
            ->assertFailed();
    }

    public function test_command_dispatches_jobs_for_pending_blogs(): void
    {
        Bus::fake();

        $blog = Blog::create([
            'image' => 'test.jpg',
            'serial_number' => 1,
            'translated_languages' => '{}',
        ]);

        BlogInformation::create([
            'blog_id' => $blog->id,
            'language_id' => $this->defaultLang->id,
            'blog_category_id' => $this->category->id,
            'title' => 'Test Blog Post',
            'slug' => 'test-blog-post',
            'author' => 'Admin',
            'content' => '<p>Test content</p>',
        ]);

        $this->artisan('blogs:translate')
            ->assertSuccessful();

        Bus::assertDispatched(TranslateBlogJob::class);
    }

    public function test_command_skips_already_translated_blogs(): void
    {
        Bus::fake();

        $blog = Blog::create([
            'image' => 'test.jpg',
            'serial_number' => 2,
            'translated_languages' => json_encode(['ar' => true]),
        ]);

        BlogInformation::create([
            'blog_id' => $blog->id,
            'language_id' => $this->defaultLang->id,
            'blog_category_id' => $this->category->id,
            'title' => 'Test Blog Post',
            'slug' => 'test-blog-post',
            'author' => 'Admin',
            'content' => '<p>Test content</p>',
        ]);

        $this->artisan('blogs:translate')
            ->assertSuccessful();

        Bus::assertNotDispatched(TranslateBlogJob::class);
    }
}
