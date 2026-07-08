<?php

namespace App\Http\Controllers\FrontEnd;

use App\Http\Controllers\Controller;
use App\Models\CustomPage\PageContent;
use App\Models\Journal\BlogCategory;
use App\Models\Journal\BlogInformation;
use App\Models\Language;
use App\Models\Listing\ListingContent;
use App\Models\ListingCategory;
use Spatie\Sitemap\Sitemap;
use Spatie\Sitemap\SitemapIndex;
use Spatie\Sitemap\Tags\Url;

class SitemapController extends Controller
{
    public function index()
    {
        $index = SitemapIndex::create()
            ->add(url('/sitemap/listings.xml'))
            ->add(url('/sitemap/categories.xml'))
            ->add(url('/sitemap/blog-posts.xml'))
            ->add(url('/sitemap/blog-categories.xml'))
            ->add(url('/sitemap/pages.xml'))
            ->add(url('/sitemap/static-pages.xml'));

        return $this->xmlResponse($index->render());
    }

    public function listings()
    {
        $languages = Language::query()->get()->keyBy('id');
        $groups = ListingContent::query()
            ->whereHas('listing', function ($query) {
                $query->where('status', 1)->where('visibility', 1);
            })
            ->select('listing_id')
            ->distinct()
            ->get();

        $sitemap = Sitemap::create();

        foreach ($groups as $group) {
            $translations = ListingContent::query()
                ->where('listing_id', $group->listing_id)
                ->get()
                ->filter(fn($item) => !empty($item->slug) && isset($languages[$item->language_id]));

            $primary = $translations->first();
            if (!$primary) {
                continue;
            }

            $sitemap->add(
                $this->withAlternates(
                    Url::create(route('frontend.listing.details', [
                        'lang' => $languages[$primary->language_id]->code,
                        'slug' => $primary->slug,
                    ]))
                        ->setLastModificationDate($primary->updated_at)
                        ->setChangeFrequency(Url::CHANGE_FREQUENCY_WEEKLY)
                        ->setPriority(0.8),
                    $translations,
                    fn($translation, $language) => route('frontend.listing.details', [
                        'lang' => $language->code,
                        'slug' => $translation->slug,
                    ])
                )
            );
        }

        return $this->xmlResponse($sitemap->render());
    }

    public function categories()
    {
        $languages = Language::query()->get()->keyBy('id');
        $categories = ListingCategory::query()->active()->get();
        $sitemap = Sitemap::create();

        foreach ($categories as $category) {
            $translations = $category->contents()
                ->get()
                ->filter(fn($item) => !empty($item->slug) && isset($languages[$item->language_id]));

            $primary = $translations->first();
            if (!$primary) {
                continue;
            }

            $sitemap->add(
                $this->withAlternates(
                    Url::create(url('/' . $languages[$primary->language_id]->code . '/listings/' . $primary->slug))
                        ->setLastModificationDate($primary->updated_at ?? $category->updated_at)
                        ->setChangeFrequency(Url::CHANGE_FREQUENCY_WEEKLY)
                        ->setPriority(0.6),
                    $translations,
                    fn($translation, $language) => url('/' . $language->code . '/listings/' . $translation->slug)
                )
            );
        }

        return $this->xmlResponse($sitemap->render());
    }

    public function blogPosts()
    {
        $languages = Language::query()->get()->keyBy('id');
        $groups = BlogInformation::query()
            ->select('blog_id')
            ->distinct()
            ->get();

        $sitemap = Sitemap::create();

        foreach ($groups as $group) {
            $translations = BlogInformation::query()
                ->where('blog_id', $group->blog_id)
                ->get()
                ->filter(fn($item) => !empty($item->slug) && isset($languages[$item->language_id]));

            $primary = $translations->first();
            if (!$primary) {
                continue;
            }

            $sitemap->add(
                $this->withAlternates(
                    Url::create(route('blog.details', [
                        'lang' => $languages[$primary->language_id]->code,
                        'slug' => $primary->slug,
                    ]))
                        ->setLastModificationDate($primary->updated_at)
                        ->setChangeFrequency(Url::CHANGE_FREQUENCY_MONTHLY)
                        ->setPriority(0.7),
                    $translations,
                    fn($translation, $language) => route('blog.details', [
                        'lang' => $language->code,
                        'slug' => $translation->slug,
                    ])
                )
            );
        }

        return $this->xmlResponse($sitemap->render());
    }

    public function blogCategories()
    {
        $languages = Language::query()->get()->keyBy('id');
        $categories = BlogCategory::query()->active()->get();
        $sitemap = Sitemap::create();

        foreach ($categories as $category) {
            $translations = $category->contents()
                ->get()
                ->filter(fn($item) => !empty($item->slug) && isset($languages[$item->language_id]));

            $primary = $translations->first();
            if (!$primary) {
                continue;
            }

            $sitemap->add(
                $this->withAlternates(
                    Url::create(route('blog.category', [
                        'lang' => $languages[$primary->language_id]->code,
                        'slug' => $primary->slug,
                    ]))
                        ->setLastModificationDate($primary->updated_at ?? $category->updated_at)
                        ->setChangeFrequency(Url::CHANGE_FREQUENCY_WEEKLY)
                        ->setPriority(0.5),
                    $translations,
                    fn($translation, $language) => route('blog.category', [
                        'lang' => $language->code,
                        'slug' => $translation->slug,
                    ])
                )
            );
        }

        return $this->xmlResponse($sitemap->render());
    }

    public function pages()
    {
        $languages = Language::query()->get()->keyBy('id');
        $groups = PageContent::query()
            ->select('page_id')
            ->distinct()
            ->get();

        $sitemap = Sitemap::create();

        foreach ($groups as $group) {
            $translations = PageContent::query()
                ->where('page_id', $group->page_id)
                ->get()
                ->filter(fn($item) => !empty($item->slug) && isset($languages[$item->language_id]));

            $primary = $translations->first();
            if (!$primary) {
                continue;
            }

            $sitemap->add(
                $this->withAlternates(
                    Url::create(route('dynamic_page', [
                        'lang' => $languages[$primary->language_id]->code,
                        'slug' => $primary->slug,
                    ]))
                        ->setLastModificationDate($primary->updated_at)
                        ->setChangeFrequency(Url::CHANGE_FREQUENCY_MONTHLY)
                        ->setPriority(0.6),
                    $translations,
                    fn($translation, $language) => route('dynamic_page', [
                        'lang' => $language->code,
                        'slug' => $translation->slug,
                    ])
                )
            );
        }

        return $this->xmlResponse($sitemap->render());
    }

    public function staticPages()
    {
        $languages = Language::query()->get();
        $routes = [
            ['name' => 'index', 'priority' => 1.0, 'frequency' => Url::CHANGE_FREQUENCY_DAILY],
            ['name' => 'frontend.pricing', 'priority' => 0.7, 'frequency' => Url::CHANGE_FREQUENCY_WEEKLY],
            ['name' => 'faq', 'priority' => 0.5, 'frequency' => Url::CHANGE_FREQUENCY_WEEKLY],
            ['name' => 'about_us', 'priority' => 0.5, 'frequency' => Url::CHANGE_FREQUENCY_MONTHLY],
            ['name' => 'contact', 'priority' => 0.5, 'frequency' => Url::CHANGE_FREQUENCY_MONTHLY],
            ['name' => 'blog', 'priority' => 0.6, 'frequency' => Url::CHANGE_FREQUENCY_WEEKLY],
            ['name' => 'frontend.listings', 'priority' => 0.7, 'frequency' => Url::CHANGE_FREQUENCY_DAILY],
            ['name' => 'frontend.vendors', 'priority' => 0.5, 'frequency' => Url::CHANGE_FREQUENCY_WEEKLY],
        ];

        $sitemap = Sitemap::create();

        foreach ($routes as $route) {
            $primaryLanguage = $languages->first();
            if (!$primaryLanguage) {
                continue;
            }

            $tag = Url::create(route($route['name'], ['lang' => $primaryLanguage->code]))
                ->setLastModificationDate(now())
                ->setChangeFrequency($route['frequency'])
                ->setPriority($route['priority']);

            foreach ($languages as $language) {
                $tag->addAlternate(route($route['name'], ['lang' => $language->code]), $language->code);
            }

            $sitemap->add($tag);
        }

        return $this->xmlResponse($sitemap->render());
    }

    private function withAlternates(Url $tag, $translations, callable $urlResolver): Url
    {
        $languages = Language::query()->get()->keyBy('id');

        foreach ($translations as $translation) {
            $language = $languages[$translation->language_id] ?? null;
            if (!$language) {
                continue;
            }

            $tag->addAlternate($urlResolver($translation, $language), $language->code);
        }

        return $tag;
    }

    private function xmlResponse(string $content)
    {
        return response($content, 200, [
            'Content-Type' => 'application/xml',
        ]);
    }
}
