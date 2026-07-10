<?php

use App\Http\Helpers\VendorPermissionHelper;
use App\Models\Advertisement;
use App\Models\BasicSettings\Basic;
use App\Models\Car;
use App\Models\CustomPage\PageContent;
use App\Models\Journal\BlogCategory;
use App\Models\Journal\BlogInformation;
use App\Models\Language;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingContent;
use App\Models\Listing\ListingProduct;
use App\Models\Listing\ListingReview;
use App\Models\ListingCategory;
use App\Models\Location\CityContent;
use App\Models\Location\ListingCityCategoryContent;
use App\Models\Location\StateContent;
use App\Models\Location\ListingCityCategory;
use App\Models\PaymentGateway\OnlineGateway;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Str;

if (!function_exists('createSlug')) {
    function createSlug($string)
    {
        return Str::slug((string) $string);
    }
}
if (!function_exists('make_input_name')) {
    function make_input_name($string)
    {
        return preg_replace('/\s+/u', '_', trim($string));
    }
}

if (!function_exists('replaceBaseUrl')) {
    function replaceBaseUrl($html, $type)
    {
        $startDelimiter = 'src=""';
        if ($type == 'summernote') {
            $endDelimiter = '/assets/img/summernote';
        } elseif ($type == 'pagebuilder') {
            $endDelimiter = '/assets/img';
        }

        $startDelimiterLength = strlen($startDelimiter);
        $endDelimiterLength = strlen($endDelimiter);
        $startFrom = $contentStart = $contentEnd = 0;

        while (false !== ($contentStart = strpos($html, $startDelimiter, $startFrom))) {
            $contentStart += $startDelimiterLength;
            $contentEnd = strpos($html, $endDelimiter, $contentStart);

            if (false === $contentEnd) {
                break;
            }

            $html = substr_replace($html, url('/'), $contentStart, $contentEnd - $contentStart);
            $startFrom = $contentEnd + $endDelimiterLength;
        }

        return $html;
    }
}

if (!function_exists('setEnvironmentValue')) {
    function setEnvironmentValue(array $values)
    {
        $envPath = app()->environmentFilePath();
        $content = file_get_contents($envPath);

        foreach ($values as $key => $value) {
            $key = strtoupper($key);
            $value = trim($value);
            $pattern = "/^{$key}=.*/m";
            $newLine = "{$key}={$value}";

            if (preg_match($pattern, $content)) {
                $content = preg_replace($pattern, $newLine, $content);
            } else {
                $content .= "\n{$newLine}\n";
            }
        }
        return file_put_contents($envPath, $content) !== false;
    }
}

if (!function_exists('showAd')) {
    function showAd($resolutionType)
    {
        $ad = Advertisement::where('resolution_type', $resolutionType)->inRandomOrder()->first();
        $adsenseInfo = Basic::query()->select('google_adsense_publisher_id')->first();

        if (!is_null($ad)) {
            if ($resolutionType == 1) {
                $maxWidth = '300px';
                $maxHeight = '250px';
            } else if ($resolutionType == 2) {
                $maxWidth = '300px';
                $maxHeight = '600px';
            } else {
                $maxWidth = '728px';
                $maxHeight = '90px';
            }

            if ($ad->ad_type == 'banner') {
                $markUp = '<a href="' . url($ad->url) . '" target="_blank" onclick="adView(' . $ad->id . ')" class="ad-banner">
          <img data-src="' . asset('assets/img/advertisements/' . $ad->image) . '" alt="advertisement" style="width: ' . $maxWidth . '; height: ' . $maxHeight . ';" class="lazyload blur-up">
        </a>';
                return $markUp;
            } else {
                $markUp = '<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=' . $adsenseInfo->google_adsense_publisher_id . '" crossorigin="anonymous"></script>
        <ins class="adsbygoogle" style="display: block;" data-ad-client="' . $adsenseInfo->google_adsense_publisher_id . '" data-ad-slot="' . $ad->slot . '" data-ad-format="auto" data-full-width-responsive="true"></ins>
        <script>
          (adsbygoogle = window.adsbygoogle || []).push({});
        </script>';

                return $markUp;
            }
        } else {
            return;
        }
    }
}

if (!function_exists('onlyDigitalItemsInCart')) {
    function onlyDigitalItemsInCart()
    {
        $cart = session()->get('productCart');
        if (!empty($cart)) {
            foreach ($cart as $key => $cartItem) {
                if ($cartItem['type'] != 'digital') {
                    return false;
                }
            }
        }
        return true;
    }
}

if (!function_exists('onlyDigitalItems')) {
    function onlyDigitalItems($order)
    {

        $oitems = $order->orderitems;
        foreach ($oitems as $key => $oitem) {

            if ($oitem->item->type != 'digital') {
                return false;
            }
        }

        return true;
    }
}

if (!function_exists('get_href')) {
    function get_href($data)
    {
        $link_href = '';

        if ($data->type == 'home') {
            $link_href = route('index');
        } else if ($data->type == 'listings') {
            $link_href = route('frontend.listings');
        } else if ($data->type == 'pricing') {
            $link_href = route('frontend.pricing');
        } else if ($data->type == 'vendors') {
            $link_href = route('frontend.vendors');
        } else if ($data->type == 'shop') {
            $link_href = route('shop.products');
        } else if ($data->type == 'cart') {
            $link_href = route('shop.cart');
        } else if ($data->type == 'checkout') {
            $link_href = route('shop.checkout');
        } else if ($data->type == 'blog') {
            $link_href = route('blog');
        } else if ($data->type == 'faq') {
            $link_href = route('faq');
        } else if ($data->type == 'contact') {
            $link_href = route('contact');
        } else if ($data->type == 'about-us') {
            $link_href = route('about_us');
        } else if ($data->type == 'custom') {
            /**
             * this menu has created using menu-builder from the admin panel.
             * this menu will be used as drop-down or to link any outside url to this system.
             */
            if ($data->href == '') {
                $link_href = '#';
            } else {
                $link_href = $data->href;
            }
        } else {
            // this menu is for the custom page which has been created from the admin panel.
            $link_href = page_url($data->type);
        }

        return $link_href;
    }
}

if (!function_exists('current_front_locale')) {
    function current_front_locale(): string
    {
        $routeLang = request()?->route('lang');

        if (!empty($routeLang)) {
            return $routeLang;
        }

        return Language::query()->where('is_default', 1)->value('code') ?? config('app.locale');
    }
}

if (!function_exists('default_front_locale')) {
    function default_front_locale(): string
    {
        return Language::query()->where('is_default', 1)->value('code') ?? config('app.locale');
    }
}

if (!function_exists('listing_url')) {
    function listing_url($listing, ?string $langCode = null): string
    {
        $langCode = $langCode ?: current_front_locale();
        $slug = is_object($listing) ? ($listing->slug ?? null) : $listing;

        if (blank($slug) && is_object($listing)) {
            $listingId = $listing->listing_id ?? $listing->id ?? null;

            if (!empty($listingId)) {
                $languageId = Language::query()->where('code', $langCode)->value('id');

                $slug = ListingContent::query()
                    ->when($languageId, fn($query) => $query->where('language_id', $languageId))
                    ->where('listing_id', $listingId)
                    ->value('slug');

                if (blank($slug)) {
                    $slug = ListingContent::query()
                        ->where('listing_id', $listingId)
                        ->whereNotNull('slug')
                        ->where('slug', '!=', '')
                        ->value('slug');
                }
            }
        }

        return localized_route('frontend.listing.details', ['slug' => $slug], $langCode);
    }
}

if (!function_exists('listing_category_url')) {
    function listing_category_url($category, ?string $langCode = null): string
    {
        static $cache = [];

        $langCode = $langCode ?: current_front_locale();
        $categoryId = is_object($category) ? ($category->id ?? null) : $category;
        $cacheKey = $langCode . ':' . $categoryId;

        if (is_object($category) && method_exists($category, 'getSlug')) {
            $languageId = Language::query()->where('code', $langCode)->value('id');
            $slug = $category->getSlug($languageId) ?? $category->slug;
            $categoryModel = $category;
        } elseif (isset($cache[$cacheKey])) {
            $slug = $cache[$cacheKey];
            $categoryModel = null;
        } else {
            $languageId = Language::query()->where('code', $langCode)->value('id');
            $categoryModel = ListingCategory::query()->find($categoryId);
            $slug = $categoryModel?->getSlug($languageId) ?? $categoryModel?->slug;
        }

        if (blank($slug) && !empty($categoryId)) {
            $categoryModel = $categoryModel ?? ListingCategory::query()->find($categoryId);

            $slug = $categoryModel?->contents()
                ->whereNotNull('slug')
                ->where('slug', '!=', '')
                ->value('slug') ?? $categoryModel?->slug;
        }

        if (blank($slug)) {
            return localized_route('frontend.listings', [], $langCode);
        }

        $cache[$cacheKey] = $slug;

        return localized_route('frontend.listing.details', ['slug' => $slug], $langCode);
    }
}

if (!function_exists('listing_city_url')) {
    function listing_city_url($city, ?string $langCode = null): string
    {
        $langCode = $langCode ?: current_front_locale();
        $cityId = is_object($city) ? ($city->id ?? null) : $city;

        return localized_route('frontend.listings', ['city' => $cityId], $langCode);
    }
}

if (!function_exists('listing_state_url')) {
    function listing_state_url($state, ?string $langCode = null): string
    {
        $langCode = $langCode ?: current_front_locale();
        $stateId = is_object($state) ? ($state->id ?? null) : $state;

        return localized_route('frontend.listings', ['state' => $stateId], $langCode);
    }
}

if (!function_exists('listing_city_category_url')) {
    function listing_city_category_url($item, ?string $langCode = null): string
    {
        $langCode = $langCode ?: current_front_locale();
        $content = is_object($item) && method_exists($item, 'getTranslation')
            ? $item->getTranslation((int) Language::query()->where('code', $langCode)->value('id'))
            : ListingCityCategory::query()->find($item)?->getTranslation((int) Language::query()->where('code', $langCode)->value('id'));

        return $content?->slug
            ? localized_route('frontend.listing.city_category', ['slug' => $content->slug], $langCode)
            : localized_route('frontend.listings', [], $langCode);
    }
}

if (!function_exists('blog_post_url')) {
    function blog_post_url($blog, ?string $langCode = null): string
    {
        $langCode = $langCode ?: current_front_locale();
        $slug = is_object($blog) ? ($blog->slug ?? null) : $blog;

        return localized_route('blog.details', ['slug' => $slug], $langCode);
    }
}

if (!function_exists('page_url')) {
    function page_url($page, ?string $langCode = null): string
    {
        $langCode = $langCode ?: current_front_locale();
        $slug = is_object($page) ? ($page->slug ?? null) : $page;
        $slug = ltrim((string) $slug, '/');

        if ($slug === '') {
            return localized_route('index', [], $langCode);
        }

        $defaultLang = default_front_locale();

        return $langCode === $defaultLang
            ? url('/' . $slug)
            : url('/' . $langCode . '/' . $slug);
    }
}

if (!function_exists('blog_category_url')) {
    function blog_category_url($category, ?string $langCode = null): string
    {
        static $cache = [];

        $langCode = $langCode ?: current_front_locale();
        $categoryId = is_object($category) ? ($category->id ?? null) : $category;
        $cacheKey = $langCode . ':' . $categoryId;

        if (is_object($category) && method_exists($category, 'getSlug')) {
            $languageId = Language::query()->where('code', $langCode)->value('id');
            $slug = $category->getSlug($languageId);
        } elseif (isset($cache[$cacheKey])) {
            $slug = $cache[$cacheKey];
        } else {
            $languageId = Language::query()->where('code', $langCode)->value('id');
            $categoryModel = BlogCategory::query()->find($categoryId);
            $slug = $categoryModel?->getSlug($languageId);
            $cache[$cacheKey] = $slug;
        }

        return localized_route('blog.category', ['slug' => $slug], $langCode);
    }
}

if (!function_exists('localized_route')) {
    function localized_route(string $name, array $parameters = [], ?string $langCode = null): string
    {
        $langCode = $langCode ?: current_front_locale();
        $defaultLang = default_front_locale();

        if (!empty($langCode) && $langCode !== $defaultLang) {
            $parameters['lang'] = $langCode;
        } else {
            unset($parameters['lang']);
        }

        return route($name, $parameters);
    }
}

if (!function_exists('hreflang_links')) {
    /**
     * Return the localized equivalents of the current content page.
     */
    function hreflang_links(): array
    {
        $route = request()->route();
        $routeName = $route?->getName();
        $slug = $route?->parameter('slug');

        $staticPaths = [
            'index' => '/',
            'frontend.listings' => '/listings',
            'blog' => '/blog',
            'frontend.pricing' => '/pricing',
            'faq' => '/faq',
            'about_us' => '/about-us',
            'contact' => '/contact',
            'frontend.vendors' => '/vendors',
            'shop.products' => '/products',
        ];

        if (array_key_exists($routeName, $staticPaths)) {
            return Language::query()
                ->get()
                ->mapWithKeys(fn ($language) => [$language->code => hreflang_localized_url($staticPaths[$routeName], $language->code)])
                ->all();
        }

        if (blank($slug)) {
            return [];
        }

        $languageId = Language::query()->where('code', current_front_locale())->value('id');
        $translations = collect();
        $urlResolver = null;

        if (in_array($routeName, ['frontend.listing.details', 'frontend.listings.category'], true)) {
            $listingContent = ListingContent::query()->where('language_id', $languageId)->where('slug', $slug)->first()
                ?? ListingContent::query()->where('slug', $slug)->first();

            if ($listingContent) {
                $translations = ListingContent::query()->where('listing_id', $listingContent->listing_id)->whereNotNull('slug')->where('slug', '!=', '')->get();
                $urlResolver = fn ($translation, $language) => hreflang_localized_url('/listings/' . $translation->slug, $language->code);
            } else {
                $category = ListingCategory::query()->active()->whereHas('contents', fn ($query) => $query->where('slug', $slug))->first();

                if ($category) {
                    $translations = $category->contents()->whereNotNull('slug')->where('slug', '!=', '')->get();
                    $urlResolver = fn ($translation, $language) => hreflang_localized_url('/listings/' . $translation->slug, $language->code);
                }
            }
        } elseif ($routeName === 'frontend.listing.city_category') {
            $content = ListingCityCategoryContent::query()->where('language_id', $languageId)->where('slug', $slug)->first()
                ?? ListingCityCategoryContent::query()->where('slug', $slug)->first();

            if ($content) {
                $translations = ListingCityCategoryContent::query()
                    ->where('listing_city_category_id', $content->listing_city_category_id)
                    ->whereNotNull('slug')->where('slug', '!=', '')->get();
                $urlResolver = fn ($translation, $language) => hreflang_localized_url('/listing-city-category/' . $translation->slug, $language->code);
            }
        } elseif ($routeName === 'frontend.listing.city') {
            $content = CityContent::query()->where('language_id', $languageId)->where('slug', $slug)->first()
                ?? CityContent::query()->where('slug', $slug)->first();

            if ($content) {
                $translations = CityContent::query()->where('city_id', $content->city_id)->whereNotNull('slug')->where('slug', '!=', '')->get();
                $urlResolver = fn ($translation, $language) => hreflang_localized_url('/listing-city/' . $translation->slug, $language->code);
            }
        } elseif ($routeName === 'frontend.listing.state') {
            $content = StateContent::query()->where('language_id', $languageId)->where('slug', $slug)->first()
                ?? StateContent::query()->where('slug', $slug)->first();

            if ($content) {
                $translations = StateContent::query()->where('state_id', $content->state_id)->whereNotNull('slug')->where('slug', '!=', '')->get();
                $urlResolver = fn ($translation, $language) => hreflang_localized_url('/listing-state/' . $translation->slug, $language->code);
            }
        } elseif ($routeName === 'blog.details') {
            $blogInformation = BlogInformation::query()->where('language_id', $languageId)->where('slug', $slug)->first()
                ?? BlogInformation::query()->where('slug', $slug)->first();

            if ($blogInformation) {
                $translations = BlogInformation::query()->where('blog_id', $blogInformation->blog_id)->whereNotNull('slug')->where('slug', '!=', '')->get();
                $urlResolver = fn ($translation, $language) => hreflang_localized_url('/blog/' . $translation->slug, $language->code);
            }
        } elseif ($routeName === 'blog.category') {
            $category = BlogCategory::query()->active()->whereHas('contents', fn ($query) => $query->where('slug', $slug))->first();

            if ($category) {
                $translations = $category->contents()->whereNotNull('slug')->where('slug', '!=', '')->get();
                $urlResolver = fn ($translation, $language) => hreflang_localized_url('/blog/category/' . $translation->slug, $language->code);
            }
        } elseif ($routeName === 'dynamic_page') {
            $pageContent = PageContent::query()->where('language_id', $languageId)->where('slug', $slug)->first()
                ?? PageContent::query()->where('slug', $slug)->first();

            if ($pageContent) {
                $translations = PageContent::query()->where('page_id', $pageContent->page_id)->whereNotNull('slug')->where('slug', '!=', '')->get();
                $urlResolver = fn ($translation, $language) => hreflang_localized_url('/' . $translation->slug, $language->code);
            }
        }

        if ($translations->isEmpty() || !$urlResolver) {
            return [];
        }

        $languages = Language::query()->get()->keyBy('id');

        return $translations->mapWithKeys(function ($translation) use ($languages, $urlResolver) {
            $language = $languages->get($translation->language_id);

            return $language ? [$language->code => $urlResolver($translation, $language)] : [];
        })->all();
    }
}

if (!function_exists('hreflang_localized_url')) {
    function hreflang_localized_url(string $path, string $languageCode): string
    {
        $path = '/' . ltrim($path, '/');

        return $languageCode === default_front_locale()
            ? url($path)
            : url('/' . $languageCode . $path);
    }
}

if (!function_exists('unique_listing_slug')) {
    function unique_listing_slug(?string $title, int $languageId, ?int $ignoreListingContentId = null): string
    {
        $baseSlug = createSlug((string) $title);
        if ($baseSlug === '') {
            $baseSlug = 'listing';
        }

        $slug = $baseSlug;
        $suffix = 2;

        while (true) {
            $query = ListingContent::query()
                ->where('language_id', $languageId)
                ->where('slug', $slug);

            if (!empty($ignoreListingContentId)) {
                $query->where('id', '!=', $ignoreListingContentId);
            }

            if (!$query->exists()) {
                return $slug;
            }

            $slug = $baseSlug . '-' . $suffix;
            $suffix++;
        }
    }
}

if (!function_exists('format_price')) {
    function format_price($value): string
    {
        if (session()->has('lang')) {
            $currentLang = Language::where('code', session()
                ->get('lang'))
                ->first();
        } else {
            $currentLang = Language::where('is_default', 1)
                ->first();
        }
        $bs = Basic::first();
        if ($bs->base_currency_symbol_position == 'left') {
            return $bs->base_currency_symbol . $value;
        } else {
            return $value . $bs->base_currency_symbol;
        }
    }
}

if (!function_exists('symbolPrice')) {
    function symbolPrice($price)
    {
        $basic = Basic::where('uniqid', 12345)->select('base_currency_symbol_position', 'base_currency_symbol')->first();
        if ($basic->base_currency_symbol_position == 'left') {
            $data = $basic->base_currency_symbol . round($price, 2);
            return str_replace(' ', '', $data);
        } elseif ($basic->base_currency_symbol_position == 'right') {
            $data = round($price, 2) . $basic->base_currency_symbol;
            return str_replace(' ', '', $data);
        }
    }
}
if (!function_exists('checkWishList')) {
    function checkWishList($listing_id, $user_id)
    {
        $check = App\Models\Car\Wishlist::where('listing_id', $listing_id)
            ->where('user_id', $user_id)
            ->first();
        if ($check) {
            return true;
        } else {
            return false;
        }
    }
}

if (!function_exists('vendorTotalAddedListing')) {
    function vendorTotalAddedListing($vendor_id)
    {
        $total = Listing::where('vendor_id', $vendor_id)->get()->count();
        return $total;
    }
}
if (!function_exists('TotalProductPerListing')) {
    function TotalProductPerListing($listing_id)
    {
        $total = ListingProduct::where('listing_id', $listing_id)->get()->count();
        return $total;
    }
}

if (!function_exists('packageTotalAdditionalSpecification')) {
    function packageTotalAdditionalSpecification($vendor_id)
    {
        $current_package = VendorPermissionHelper::packagePermission($vendor_id);
        $additionalFeatureLimit = $current_package->number_of_additional_specification;

        return $additionalFeatureLimit;
    }
}

if (!function_exists('packageTotalAminities')) {
    function packageTotalAminities($vendor_id)
    {
        $current_package = VendorPermissionHelper::packagePermission($vendor_id);
        $aminitiesLimit = $current_package->number_of_amenities_per_listing;

        return $aminitiesLimit;
    }
}

if (!function_exists('vendorTotalListing')) {
    function vendorTotalListing($vendorId)
    {
        $vendorTotalListing = Listing::where('vendor_id', $vendorId)->count();

        return $vendorTotalListing;
    }
}
if (!function_exists('packageTotalSocialLink')) {
    function packageTotalSocialLink($vendor_id)
    {
        $current_package = VendorPermissionHelper::packagePermission($vendor_id);
        $SocialLinkLimit = $current_package->number_of_social_links;

        return $SocialLinkLimit;
    }
}

if (!function_exists('packageTotalFaqs')) {
    function packageTotalFaqs($listing_id)
    {
        $vendor_id = Listing::where('id', $listing_id)->pluck('vendor_id')->first();
        if ($vendor_id != 0) {
            $current_package = VendorPermissionHelper::packagePermission($vendor_id);
            $faqLimit = $current_package->number_of_faq;
        } else {
            $faqLimit = 999999;
        }
        return $faqLimit;
    }
}
if (!function_exists('currentPackageFeatures')) {
    function currentPackageFeatures($vendor_id)
    {
        $current_package = VendorPermissionHelper::packagePermission($vendor_id);
        $Features = $current_package->features;
        return $Features;
    }
}

if (!function_exists('productPermission')) {
    function productPermission($listing_id)
    {
        $vendor_id = Listing::where('id', $listing_id)->pluck('vendor_id')->first();
        if ($vendor_id != 0) {
            $current_package = VendorPermissionHelper::packagePermission($vendor_id);

            if ($current_package != '[]') {
                $permissions = $current_package->features;
                $permissions = json_decode($permissions, true);
            } else {
                return false;
            }

            if (is_array($permissions) && in_array('Products', $permissions)) {
                return true;
            } else {
                return false;
            }
        } else {
            return true;
        }
    }
}

if (!function_exists('listingMessagePermission')) {
    function listingMessagePermission($vendor_id)
    {
        $current_package = VendorPermissionHelper::packagePermission($vendor_id);

        if ($current_package != '[]') {
            $permissions = $current_package->features;
            $permissions = json_decode($permissions, true);
        } else {
            return false;
        }
        if (is_array($permissions) && in_array('Listing Enquiry Form', $permissions)) {
            return true;
        } else {
            return false;
        }
    }
}
if (!function_exists('productMessagePermission')) {
    function productMessagePermission($vendor_id)
    {
        $current_package = VendorPermissionHelper::packagePermission($vendor_id);

        if ($current_package != '[]') {
            $permissions = $current_package->features;
            $permissions = json_decode($permissions, true);
        } else {
            return false;
        }
        if (is_array($permissions) && in_array('Products', $permissions)) {
            if (is_array($permissions) && in_array('Product Enquiry Form', $permissions)) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }
}
if (!function_exists('additionalSpecificationsPermission')) {
    function additionalSpecificationsPermission($listing_id)
    {
        $vendor_id = Listing::where('id', $listing_id)->pluck('vendor_id')->first();
        if ($vendor_id != 0) {
            $current_package = VendorPermissionHelper::packagePermission($vendor_id);

            if ($current_package != '[]') {
                $permissions = $current_package->features;
                $permissions = json_decode($permissions, true);
            } else {
                return false;
            }

            if (is_array($permissions) && in_array('Feature', $permissions)) {
                return true;
            } else {
                return false;
            }
        } else {
            return true;
        }
    }
}
if (!function_exists('socialLinksPermission')) {
    function socialLinksPermission($listing_id)
    {
        $vendor_id = Listing::where('id', $listing_id)->pluck('vendor_id')->first();
        if ($vendor_id != 0) {
            $current_package = VendorPermissionHelper::packagePermission($vendor_id);

            if ($current_package != '[]') {
                $permissions = $current_package->features;
                $permissions = json_decode($permissions, true);
            } else {
                return false;
            }

            if (is_array($permissions) && in_array('Social Links', $permissions)) {
                return true;
            } else {
                return false;
            }
        } else {
            return true;
        }
    }
}




if (!function_exists('faqPermission')) {
    function faqPermission($listing_id)
    {
        $vendor_id = Listing::where('id', $listing_id)->pluck('vendor_id')->first();
        if ($vendor_id != 0) {
            $current_package = VendorPermissionHelper::packagePermission($vendor_id);

            if ($current_package != '[]') {
                $permissions = $current_package->features;
                $permissions = json_decode($permissions, true);
            } else {
                return false;
            }

            if (is_array($permissions) && in_array('FAQ', $permissions)) {
                return true;
            } else {
                return false;
            }
        } else {
            return true;
        }
    }
}

if (!function_exists('businessHoursPermission')) {
    function businessHoursPermission($listing_id)
    {
        $vendor_id = Listing::where('id', $listing_id)->pluck('vendor_id')->first();
        if ($vendor_id != 0) {

            $current_package = VendorPermissionHelper::packagePermission($vendor_id);

            if ($current_package != '[]') {
                $permissions = $current_package->features;
                $permissions = json_decode($permissions, true);
            } else {
                return false;
            }

            if (is_array($permissions) && in_array('Business Hours', $permissions)) {
                return true;
            } else {
                return false;
            }
        } else {
            return true;
        }
    }
}

if (!function_exists('packageTotalProducts')) {
    function packageTotalProducts($listing_id)
    {
        $vendor_id = Listing::where('id', $listing_id)->pluck('vendor_id')->first();
        $current_package = VendorPermissionHelper::packagePermission($vendor_id);
        $productCanAdd = $current_package->number_of_products;

        return $productCanAdd;
    }
}

if (!function_exists('packageTotalListing')) {
    function packageTotalListing($vendor_id)
    {
        try {
            $current_package = VendorPermissionHelper::packagePermission($vendor_id);

            // Handle if it's a Collection - get the first package or null
            if ($current_package instanceof \Illuminate\Support\Collection) {
                $current_package = $current_package->first();
            }

            if (empty($current_package) || is_null($current_package)) {
                return 0;
            }
            return $current_package->number_of_listing ?? 0;
        } catch (\Exception $e) {
            \Log::error('Error in packageTotalListing for vendor_id ' . $vendor_id . ': ' . $e->getMessage());
            return 0;
        }
    }
}


if (!function_exists('packageTotalProductImage')) {
    function packageTotalProductImage($listing_id)
    {
        $vendor_id = Listing::where('id', $listing_id)->pluck('vendor_id')->first();
        if ($vendor_id != 0) {
            $current_package = VendorPermissionHelper::packagePermission($vendor_id);
            $productImageLimit = $current_package->number_of_images_per_products;
        } else {
            $productImageLimit = 99999999;
        }

        return $productImageLimit;
    }
}
if (!function_exists('packageTotalListingImage')) {
    function packageTotalListingImage($vendor_id)
    {
        $current_package = VendorPermissionHelper::packagePermission($vendor_id);
        $listingImageLimit = $current_package->number_of_images_per_listing;

        return $listingImageLimit;
    }
}

if (!function_exists('StoreTransaction')) {
    function StoreTransaction($data)
    {
        App\Models\Transcation::create($data);
    }
}
if (!function_exists('convertUtf8')) {
    function convertUtf8($value)
    {
        return mb_detect_encoding($value, mb_detect_order(), true) === 'UTF-8' ? $value : mb_convert_encoding($value, 'UTF-8');
    }
}
if (!function_exists('totalListingReview')) {
    function totalListingReview($listing_id)
    {
        $totalReview = ListingReview::Where('listing_id', $listing_id)->count();

        return $totalReview;
    }
}
if (!function_exists('paytabInfo')) {
    function paytabInfo()
    {
        $paytabs = OnlineGateway::where('keyword', 'paytabs')->first();
        $paytabsInfo = json_decode($paytabs->information, true);
        if ($paytabsInfo['country'] == 'global') {
            $currency = 'USD';
        } elseif ($paytabsInfo['country'] == 'sa') {
            $currency = 'SAR';
        } elseif ($paytabsInfo['country'] == 'uae') {
            $currency = 'AED';
        } elseif ($paytabsInfo['country'] == 'egypt') {
            $currency = 'EGP';
        } elseif ($paytabsInfo['country'] == 'oman') {
            $currency = 'OMR';
        } elseif ($paytabsInfo['country'] == 'jordan') {
            $currency = 'JOD';
        } elseif ($paytabsInfo['country'] == 'iraq') {
            $currency = 'IQD';
        } else {
            $currency = 'USD';
        }
        return [
            'server_key' => $paytabsInfo['server_key'],
            'profile_id' => $paytabsInfo['profile_id'],
            'url'        => $paytabsInfo['api_endpoint'],
            'currency'   => $currency,
        ];
    }
}

if (!function_exists('options')) {
    function options()
    {
        $data = OnlineGateway::where('keyword', 'iyzico')->first();
        $information = json_decode($data->information, true);

        $options = new \Iyzipay\Options();
        $options->setApiKey($information['api_key']);
        $options->setSecretKey($information['secrect_key']);
        if ($information['iyzico_mode'] == 1) {
            $options->setBaseUrl("https://sandbox-api.iyzipay.com");
        } else {
            $options->setBaseUrl("https://api.iyzipay.com");
        }
        return $options;
    }
}
if (!function_exists('adminLanguage')) {
    function adminLanguage()
    {
        $code = Auth::guard('admin')->user()->code;

        $language = Language::where('code', $code)->first();

        return $language;
    }
}
if (!function_exists('vendorLanguage')) {
    function vendorLanguage()
    {
        $code = Auth::guard('vendor')->user()->code;

        $language = Language::where('code', $code)->first();

        return $language;
    }
}

if (!function_exists('createInputName')) {
    function createInputName($string)
    {
        $inputName = preg_replace('/\s+/u', '_', trim($string));

        return mb_strtolower($inputName);
    }
}
