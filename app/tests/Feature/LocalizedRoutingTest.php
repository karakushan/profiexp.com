<?php

namespace Tests\Feature;

use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class LocalizedRoutingTest extends TestCase
{
    public function test_secondary_language_homepage_uses_localized_index_route(): void
    {
        [$defaultLanguage, $secondaryLanguage] = $this->languages();

        $this->get('/change-language?lang_code=' . $secondaryLanguage['code'] . '&current_url=/')
            ->assertRedirect('http://localhost:8080/' . $secondaryLanguage['code']);

        $this->get('/' . $secondaryLanguage['code'])
            ->assertOk()
            ->assertDontSee('404 not found');
    }

    public function test_default_language_uses_unprefixed_routes(): void
    {
        [$defaultLanguage, $secondaryLanguage] = $this->languages();
        $this->createCustomPage($defaultLanguage, $secondaryLanguage);

        $this->get('/test-page-' . $defaultLanguage['code'])
            ->assertOk();

        $this->get('/change-language?lang_code=' . $defaultLanguage['code'] . '&current_url=/' . $secondaryLanguage['code'] . '/test-page-' . $secondaryLanguage['code'])
            ->assertRedirect('http://localhost:8080/test-page-' . $defaultLanguage['code']);
    }

    public function test_listing_routes_use_slug_and_legacy_redirects(): void
    {
        [$defaultLanguage, $secondaryLanguage] = $this->languages();
        $categoryId = $this->createListingCategory($defaultLanguage, $secondaryLanguage);
        $listingId = $this->createListing($categoryId, $defaultLanguage, $secondaryLanguage);

        $this->get('/listings/test-listing-' . $defaultLanguage['code'] . '/' . $listingId)
            ->assertRedirect('/listings/test-listing-' . $defaultLanguage['code']);

        $this->get('/change-language?lang_code=' . $secondaryLanguage['code'] . '&current_url=/listings/test-listing-' . $defaultLanguage['code'])
            ->assertRedirect('http://localhost:8080/' . $secondaryLanguage['code'] . '/listings/test-listing-' . $secondaryLanguage['code']);
    }

    public function test_category_query_redirects_to_slug_url(): void
    {
        [$defaultLanguage, $secondaryLanguage] = $this->languages();
        $categoryId = $this->createListingCategory($defaultLanguage, $secondaryLanguage);

        $this->get("/listings?category_id={$categoryId}")
            ->assertRedirect('/listings/test-category-' . $defaultLanguage['code']);
    }

    public function test_language_switcher_preserves_blog_and_page_translations(): void
    {
        [$defaultLanguage, $secondaryLanguage] = $this->languages();
        $blogCategoryId = $this->createBlogCategory($defaultLanguage, $secondaryLanguage);
        $this->createBlog($blogCategoryId, $defaultLanguage, $secondaryLanguage);
        $this->createCustomPage($defaultLanguage, $secondaryLanguage);

        $this->get('/change-language?lang_code=' . $secondaryLanguage['code'] . '&current_url=/blog/test-post-' . $defaultLanguage['code'])
            ->assertRedirect('http://localhost:8080/' . $secondaryLanguage['code'] . '/blog/test-post-' . $secondaryLanguage['code']);

        $this->get('/change-language?lang_code=' . $secondaryLanguage['code'] . '&current_url=/blog/category/test-blog-category-' . $defaultLanguage['code'])
            ->assertRedirect('http://localhost:8080/' . $secondaryLanguage['code'] . '/blog/category/test-blog-category-' . $secondaryLanguage['code']);

        $this->get('/change-language?lang_code=' . $secondaryLanguage['code'] . '&current_url=/test-page-' . $defaultLanguage['code'])
            ->assertRedirect('http://localhost:8080/' . $secondaryLanguage['code'] . '/test-page-' . $secondaryLanguage['code']);
    }

    public function test_sitemap_contains_localized_urls_and_hreflang(): void
    {
        [$defaultLanguage, $secondaryLanguage] = $this->languages();
        $categoryId = $this->createListingCategory($defaultLanguage, $secondaryLanguage);
        $this->createListing($categoryId, $defaultLanguage, $secondaryLanguage);
        $blogCategoryId = $this->createBlogCategory($defaultLanguage, $secondaryLanguage);
        $this->createBlog($blogCategoryId, $defaultLanguage, $secondaryLanguage);
        $this->createCustomPage($defaultLanguage, $secondaryLanguage);

        $this->get('/sitemap.xml')
            ->assertOk()
            ->assertSee('/sitemap/pages.xml', false)
            ->assertSee('/sitemap/static-pages.xml', false);

        $this->get('/sitemap/listings.xml')
            ->assertOk()
            ->assertSee('/listings/test-listing-' . $defaultLanguage['code'], false)
            ->assertSee('hreflang="' . $secondaryLanguage['code'] . '"', false);

        $this->get('/sitemap/categories.xml')
            ->assertOk()
            ->assertSee('/listings/test-category-' . $defaultLanguage['code'], false)
            ->assertDontSee('/' . $defaultLanguage['code'] . '/listings/test-category-' . $defaultLanguage['code'], false);

        $this->get('/sitemap/blog-posts.xml')
            ->assertOk()
            ->assertSee('/blog/test-post-' . $defaultLanguage['code'], false)
            ->assertDontSee('/' . $defaultLanguage['code'] . '/blog/test-post-' . $defaultLanguage['code'], false);

        $this->get('/sitemap/blog-categories.xml')
            ->assertOk()
            ->assertSee('/blog/category/test-blog-category-' . $defaultLanguage['code'], false)
            ->assertDontSee('/' . $defaultLanguage['code'] . '/blog/category/test-blog-category-' . $defaultLanguage['code'], false);

        $this->get('/sitemap/pages.xml')
            ->assertOk()
            ->assertSee('/test-page-' . $defaultLanguage['code'], false)
            ->assertSee('hreflang="' . $secondaryLanguage['code'] . '"', false)
            ->assertDontSee('/' . $defaultLanguage['code'] . '/test-page-' . $defaultLanguage['code'], false);

        $this->get('/sitemap/static-pages.xml')
            ->assertOk()
            ->assertSee('http://localhost:8080/', false)
            ->assertDontSee('http://localhost:8080/' . $defaultLanguage['code'] . '/', false);
    }

    private function languages(): array
    {
        $defaultLanguage = DB::table('languages')
            ->select('id', 'code')
            ->where('is_default', 1)
            ->first();

        $secondaryLanguage = DB::table('languages')
            ->select('id', 'code')
            ->where('code', '!=', $defaultLanguage->code)
            ->orderByRaw("case when code = 'en' then 0 else 1 end")
            ->orderBy('id')
            ->first();

        return [
            ['id' => $defaultLanguage->id, 'code' => $defaultLanguage->code],
            ['id' => $secondaryLanguage->id, 'code' => $secondaryLanguage->code],
        ];
    }

    private function createListingCategory(array $defaultLanguage, array $secondaryLanguage): int
    {
        $now = Carbon::now();
        $categoryId = DB::table('listing_categories')->insertGetId([
            'name' => 'Test Category',
            'slug' => 'test-category-' . $defaultLanguage['code'],
            'serial_number' => 999999,
            'status' => 1,
            'created_at' => $now,
            'updated_at' => $now,
        ]);

        DB::table('listing_category_contents')->insert([
            [
                'listing_category_id' => $categoryId,
                'language_id' => $defaultLanguage['id'],
                'name' => 'Тестовая категория',
                'slug' => 'test-category-' . $defaultLanguage['code'],
                'created_at' => $now,
                'updated_at' => $now,
            ],
            [
                'listing_category_id' => $categoryId,
                'language_id' => $secondaryLanguage['id'],
                'name' => 'Test Category',
                'slug' => 'test-category-' . $secondaryLanguage['code'],
                'created_at' => $now,
                'updated_at' => $now,
            ],
        ]);

        return $categoryId;
    }

    private function createListing(int $categoryId, array $defaultLanguage, array $secondaryLanguage): int
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
                'language_id' => $defaultLanguage['id'],
                'listing_id' => $listingId,
                'category_id' => $categoryId,
                'title' => 'Тестовое объявление',
                'slug' => 'test-listing-' . $defaultLanguage['code'],
                'description' => 'Описание',
                'address' => 'Адрес',
                'summary' => 'Summary',
                'created_at' => $now,
                'updated_at' => $now,
            ],
            [
                'language_id' => $secondaryLanguage['id'],
                'listing_id' => $listingId,
                'category_id' => $categoryId,
                'title' => 'Test listing',
                'slug' => 'test-listing-' . $secondaryLanguage['code'],
                'description' => 'Description',
                'address' => 'Address',
                'summary' => 'Summary',
                'created_at' => $now,
                'updated_at' => $now,
            ],
        ]);

        return $listingId;
    }

    private function createBlogCategory(array $defaultLanguage, array $secondaryLanguage): int
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
                'language_id' => $defaultLanguage['id'],
                'name' => 'Тестовая категория блога',
                'slug' => 'test-blog-category-' . $defaultLanguage['code'],
                'created_at' => $now,
                'updated_at' => $now,
            ],
            [
                'blog_category_id' => $categoryId,
                'language_id' => $secondaryLanguage['id'],
                'name' => 'Test Blog Category',
                'slug' => 'test-blog-category-' . $secondaryLanguage['code'],
                'created_at' => $now,
                'updated_at' => $now,
            ],
        ]);

        return $categoryId;
    }

    private function createBlog(int $blogCategoryId, array $defaultLanguage, array $secondaryLanguage): void
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
                'language_id' => $defaultLanguage['id'],
                'blog_category_id' => $blogCategoryId,
                'blog_id' => $blogId,
                'title' => 'Тестовый пост',
                'slug' => 'test-post-' . $defaultLanguage['code'],
                'author' => 'Tester',
                'content' => 'Content',
                'created_at' => $now,
                'updated_at' => $now,
            ],
            [
                'language_id' => $secondaryLanguage['id'],
                'blog_category_id' => $blogCategoryId,
                'blog_id' => $blogId,
                'title' => 'Test post',
                'slug' => 'test-post-' . $secondaryLanguage['code'],
                'author' => 'Tester',
                'content' => 'Content',
                'created_at' => $now,
                'updated_at' => $now,
            ],
        ]);
    }

    private function createCustomPage(array $defaultLanguage, array $secondaryLanguage): void
    {
        $now = Carbon::now();
        $pageId = DB::table('pages')->insertGetId([
            'status' => 1,
            'created_at' => $now,
            'updated_at' => $now,
        ]);

        DB::table('page_contents')->insert([
            [
                'language_id' => $defaultLanguage['id'],
                'page_id' => $pageId,
                'title' => 'Тестовая страница',
                'slug' => 'test-page-' . $defaultLanguage['code'],
                'content' => 'Content',
                'created_at' => $now,
                'updated_at' => $now,
            ],
            [
                'language_id' => $secondaryLanguage['id'],
                'page_id' => $pageId,
                'title' => 'Test page',
                'slug' => 'test-page-' . $secondaryLanguage['code'],
                'content' => 'Content',
                'created_at' => $now,
                'updated_at' => $now,
            ],
        ]);
    }
}
