<?php

namespace Tests\Feature;

use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class LocalizedRoutingTest extends TestCase
{
    public function test_root_redirects_to_default_language(): void
    {
        $response = $this->get('/');

        $response->assertRedirect(route('index', ['lang' => default_front_locale()]));
    }

    public function test_listing_routes_use_slug_and_legacy_redirects(): void
    {
        [$ruId, $enId] = $this->languageIds();
        $categoryId = $this->createListingCategory($ruId, $enId);
        $listingId = $this->createListing($categoryId, $ruId, $enId);

        $this->get("/listings/test-listing-ru/{$listingId}")
            ->assertRedirect('/ru/listings/test-listing-ru');

        $this->get('/change-language?lang_code=en&current_url=/ru/listings/test-listing-ru')
            ->assertRedirect('http://localhost:8080/en/listings/test-listing-en');
    }

    public function test_category_query_redirects_to_slug_url(): void
    {
        [$ruId, $enId] = $this->languageIds();
        $categoryId = $this->createListingCategory($ruId, $enId);

        $this->get("/ru/listings?category_id={$categoryId}")
            ->assertRedirect('/ru/listings/test-category-ru');
    }

    public function test_language_switcher_preserves_blog_and_page_translations(): void
    {
        [$ruId, $enId] = $this->languageIds();
        $blogCategoryId = $this->createBlogCategory($ruId, $enId);
        $this->createBlog($blogCategoryId, $ruId, $enId);
        $this->createCustomPage($ruId, $enId);

        $this->get('/change-language?lang_code=en&current_url=/ru/blog/test-post-ru')
            ->assertRedirect('http://localhost:8080/en/blog/test-post-en');

        $this->get('/change-language?lang_code=en&current_url=/ru/blog/category/test-blog-category-ru')
            ->assertRedirect('http://localhost:8080/en/blog/category/test-blog-category-en');

        $this->get('/change-language?lang_code=en&current_url=/ru/test-page-ru')
            ->assertRedirect('http://localhost:8080/en/test-page-en');
    }

    public function test_sitemap_contains_localized_urls_and_hreflang(): void
    {
        [$ruId, $enId] = $this->languageIds();
        $categoryId = $this->createListingCategory($ruId, $enId);
        $this->createListing($categoryId, $ruId, $enId);
        $blogCategoryId = $this->createBlogCategory($ruId, $enId);
        $this->createBlog($blogCategoryId, $ruId, $enId);
        $this->createCustomPage($ruId, $enId);

        $this->get('/sitemap.xml')
            ->assertOk()
            ->assertSee('/sitemap/pages.xml', false)
            ->assertSee('/sitemap/static-pages.xml', false);

        $this->get('/sitemap/listings.xml')
            ->assertOk()
            ->assertSee('/ru/listings/test-listing-ru', false)
            ->assertSee('hreflang="en"', false);

        $this->get('/sitemap/pages.xml')
            ->assertOk()
            ->assertSee('/ru/test-page-ru', false)
            ->assertSee('hreflang="en"', false);
    }

    private function languageIds(): array
    {
        return [
            DB::table('languages')->where('code', 'ru')->value('id'),
            DB::table('languages')->where('code', 'en')->value('id'),
        ];
    }

    private function createListingCategory(int $ruId, int $enId): int
    {
        $now = Carbon::now();
        $categoryId = DB::table('listing_categories')->insertGetId([
            'name' => 'Test Category',
            'slug' => 'test-category-ru',
            'serial_number' => 999999,
            'status' => 1,
            'created_at' => $now,
            'updated_at' => $now,
        ]);

        DB::table('listing_category_contents')->insert([
            [
                'listing_category_id' => $categoryId,
                'language_id' => $ruId,
                'name' => 'Тестовая категория',
                'slug' => 'test-category-ru',
                'created_at' => $now,
                'updated_at' => $now,
            ],
            [
                'listing_category_id' => $categoryId,
                'language_id' => $enId,
                'name' => 'Test Category',
                'slug' => 'test-category-en',
                'created_at' => $now,
                'updated_at' => $now,
            ],
        ]);

        return $categoryId;
    }

    private function createListing(int $categoryId, int $ruId, int $enId): int
    {
        $now = Carbon::now();
        $listingId = DB::table('listings')->insertGetId([
            'vendor_id' => 0,
            'status' => 1,
            'visibility' => 1,
            'created_at' => $now,
            'updated_at' => $now,
        ]);

        DB::table('listing_contents')->insert([
            [
                'language_id' => $ruId,
                'listing_id' => $listingId,
                'category_id' => $categoryId,
                'title' => 'Тестовое объявление',
                'slug' => 'test-listing-ru',
                'description' => 'Описание',
                'address' => 'Адрес',
                'summary' => 'Summary',
                'created_at' => $now,
                'updated_at' => $now,
            ],
            [
                'language_id' => $enId,
                'listing_id' => $listingId,
                'category_id' => $categoryId,
                'title' => 'Test listing',
                'slug' => 'test-listing-en',
                'description' => 'Description',
                'address' => 'Address',
                'summary' => 'Summary',
                'created_at' => $now,
                'updated_at' => $now,
            ],
        ]);

        return $listingId;
    }

    private function createBlogCategory(int $ruId, int $enId): int
    {
        $now = Carbon::now();
        $categoryId = DB::table('blog_categories')->insertGetId([
            'status' => 1,
            'serial_number' => 999999,
            'created_at' => $now,
            'updated_at' => $now,
        ]);

        DB::table('blog_category_contents')->insert([
            [
                'blog_category_id' => $categoryId,
                'language_id' => $ruId,
                'name' => 'Тестовая категория блога',
                'slug' => 'test-blog-category-ru',
                'created_at' => $now,
                'updated_at' => $now,
            ],
            [
                'blog_category_id' => $categoryId,
                'language_id' => $enId,
                'name' => 'Test Blog Category',
                'slug' => 'test-blog-category-en',
                'created_at' => $now,
                'updated_at' => $now,
            ],
        ]);

        return $categoryId;
    }

    private function createBlog(int $blogCategoryId, int $ruId, int $enId): void
    {
        $now = Carbon::now();
        $blogId = DB::table('blogs')->insertGetId([
            'image' => 'test.jpg',
            'serial_number' => 999999,
            'created_at' => $now,
            'updated_at' => $now,
        ]);

        DB::table('blog_informations')->insert([
            [
                'language_id' => $ruId,
                'blog_category_id' => $blogCategoryId,
                'blog_id' => $blogId,
                'title' => 'Тестовый пост',
                'slug' => 'test-post-ru',
                'author' => 'Tester',
                'content' => 'Content',
                'created_at' => $now,
                'updated_at' => $now,
            ],
            [
                'language_id' => $enId,
                'blog_category_id' => $blogCategoryId,
                'blog_id' => $blogId,
                'title' => 'Test post',
                'slug' => 'test-post-en',
                'author' => 'Tester',
                'content' => 'Content',
                'created_at' => $now,
                'updated_at' => $now,
            ],
        ]);
    }

    private function createCustomPage(int $ruId, int $enId): void
    {
        $now = Carbon::now();
        $pageId = DB::table('pages')->insertGetId([
            'status' => 1,
            'created_at' => $now,
            'updated_at' => $now,
        ]);

        DB::table('page_contents')->insert([
            [
                'language_id' => $ruId,
                'page_id' => $pageId,
                'title' => 'Тестовая страница',
                'slug' => 'test-page-ru',
                'content' => 'Content',
                'created_at' => $now,
                'updated_at' => $now,
            ],
            [
                'language_id' => $enId,
                'page_id' => $pageId,
                'title' => 'Test page',
                'slug' => 'test-page-en',
                'content' => 'Content',
                'created_at' => $now,
                'updated_at' => $now,
            ],
        ]);
    }
}
