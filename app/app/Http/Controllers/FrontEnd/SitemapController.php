<?php

namespace App\Http\Controllers\FrontEnd;

use App\Http\Controllers\Controller;
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
            ->add(url('/sitemap/blog-categories.xml'));

        return response($index->render(), 200, [
            'Content-Type' => 'application/xml',
        ]);
    }

    public function listings()
    {
        $defaultLang = Language::where('is_default', 1)->firstOrFail();

        $listings = ListingContent::query()
            ->where('language_id', $defaultLang->id)
            ->whereHas('listing', function ($q) {
                $q->where('status', 1)
                    ->where('visibility', 1);
            })
            ->select('slug', 'listing_id', 'updated_at')
            ->get();

        $sitemap = Sitemap::create();

        foreach ($listings as $listing) {
            $sitemap->add(
                Url::create(route('frontend.listing.details', [
                    'slug' => $listing->slug,
                    'id' => $listing->listing_id,
                ]))
                    ->setLastModificationDate($listing->updated_at)
                    ->setChangeFrequency(Url::CHANGE_FREQUENCY_WEEKLY)
                    ->setPriority(0.8)
            );
        }

        return response($sitemap->render(), 200, [
            'Content-Type' => 'application/xml',
        ]);
    }

    public function categories()
    {
        $defaultLang = Language::where('is_default', 1)->firstOrFail();

        $categories = ListingCategory::forLanguage($defaultLang->id)->active()
            ->get();

        $sitemap = Sitemap::create();

        foreach ($categories as $category) {
            $sitemap->add(
                Url::create(route('frontend.listings', [
                    'category_id' => $category->id,
                ]))
                    ->setLastModificationDate($category->updated_at)
                    ->setChangeFrequency(Url::CHANGE_FREQUENCY_WEEKLY)
                    ->setPriority(0.6)
            );
        }

        return response($sitemap->render(), 200, [
            'Content-Type' => 'application/xml',
        ]);
    }

    public function blogPosts()
    {
        $defaultLang = Language::where('is_default', 1)->firstOrFail();

        $blogInfos = BlogInformation::query()
            ->where('language_id', $defaultLang->id)
            ->select('slug', 'updated_at')
            ->get();

        $sitemap = Sitemap::create();

        foreach ($blogInfos as $blogInfo) {
            $sitemap->add(
                Url::create(route('blog.details', ['slug' => $blogInfo->slug]))
                    ->setLastModificationDate($blogInfo->updated_at)
                    ->setChangeFrequency(Url::CHANGE_FREQUENCY_MONTHLY)
                    ->setPriority(0.7)
            );
        }

        return response($sitemap->render(), 200, [
            'Content-Type' => 'application/xml',
        ]);
    }

    public function blogCategories()
    {
        $defaultLang = Language::where('is_default', 1)->firstOrFail();

        $categories = BlogCategory::active()
            ->whereHas('contents', function ($q) use ($defaultLang) {
                $q->where('language_id', $defaultLang->id);
            })
            ->get();

        $sitemap = Sitemap::create();

        foreach ($categories as $category) {
            $slug = $category->getSlug($defaultLang->id);
            if (empty($slug)) continue;

            $sitemap->add(
                Url::create(route('blog', ['category' => $slug]))
                    ->setLastModificationDate($category->updated_at)
                    ->setChangeFrequency(Url::CHANGE_FREQUENCY_WEEKLY)
                    ->setPriority(0.5)
            );
        }

        return response($sitemap->render(), 200, [
            'Content-Type' => 'application/xml',
        ]);
    }
}
