<?php

use App\Http\Helpers\VendorPermissionHelper;
use App\Models\Advertisement;
use App\Models\BasicSettings\Basic;
use App\Models\Car;
use App\Models\Journal\BlogCategory;
use App\Models\Language;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingContent;
use App\Models\Listing\ListingProduct;
use App\Models\Listing\ListingReview;
use App\Models\ListingCategory;
use App\Models\PaymentGateway\OnlineGateway;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

if (!function_exists('createSlug')) {
    function createSlug($string)
    {
        $slug = preg_replace('/\s+/u', '-', trim($string));
        $slug = str_replace('/', '', $slug);
        $slug = str_replace('?', '', $slug);
        $slug = str_replace(',', '', $slug);

        return mb_strtolower($slug);
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
            $link_href = route('dynamic_page', ['slug' => $data->type]);
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

        $sessionLang = session('currentLocaleCode');
        if (!empty($sessionLang)) {
            return $sessionLang;
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

        return route('frontend.listing.details', ['lang' => $langCode, 'slug' => $slug]);
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
        } elseif (isset($cache[$cacheKey])) {
            $slug = $cache[$cacheKey];
        } else {
            $languageId = Language::query()->where('code', $langCode)->value('id');
            $categoryModel = ListingCategory::query()->find($categoryId);
            $slug = $categoryModel?->getSlug($languageId) ?? $categoryModel?->slug;
            $cache[$cacheKey] = $slug;
        }

        return url('/' . $langCode . '/listings/' . $slug);
    }
}

if (!function_exists('blog_post_url')) {
    function blog_post_url($blog, ?string $langCode = null): string
    {
        $langCode = $langCode ?: current_front_locale();
        $slug = is_object($blog) ? ($blog->slug ?? null) : $blog;

        return route('blog.details', ['lang' => $langCode, 'slug' => $slug]);
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

        return route('blog.category', ['lang' => $langCode, 'slug' => $slug]);
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
