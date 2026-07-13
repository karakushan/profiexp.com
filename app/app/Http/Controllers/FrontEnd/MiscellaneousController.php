<?php

namespace App\Http\Controllers\FrontEnd;

use App\Http\Controllers\Controller;
use App\Models\Advertisement;
use App\Models\BasicSettings\Basic;
use App\Models\CustomPage\PageContent;
use App\Models\Journal\BlogCategory;
use App\Models\Journal\BlogInformation;
use App\Models\Language;
use App\Models\Listing\ListingContent;
use App\Models\ListingCategory;
use App\Models\Location\ListingCityCategoryContent;
use App\Models\Subscriber;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class MiscellaneousController extends Controller
{
  public function getLanguage()
  {
    $locale = request()->route('lang');

    if (empty($locale)) {
      $locale = default_front_locale();
    }

    if (empty($locale)) {
      $language = Language::where('is_default', 1)->first();
    } else {
      $language = Language::where('code', $locale)->first();
      if (empty($language)) {
        $language = Language::where('is_default', 1)->first();
      }
    }


    return $language;
  }


  public function storeSubscriber(Request $request)
  {
    $rules = [
      'email_id' => [
        'required',
        'email:rfc,dns',
        Rule::unique('subscribers', 'email_id')
      ]
    ];
    $messsage = [];
    $messsage['email_id.required'] = 'Email address feild is required';
    $messsage['email_id.unique'] = 'The email address already been taken';
    $validator = Validator::make($request->all(), $rules, $messsage);
    if ($validator->fails()) {
      return Response::json([
        'error' => $validator->getMessageBag()
      ], 400);
    }


    Subscriber::create([
      'email_id' => $request->email_id
    ]);

    return response()->json(['message' => 'You have successfully subscribed to our newsletter.', 'alert_type' => 'success']);
  }


  public function changeLanguage(Request $request)
  {
    $langCode = $request->string('lang_code')->toString();
    $targetLanguage = Language::query()->where('code', $langCode)->firstOrFail();
    $request->session()->put('currentLocaleCode', $targetLanguage->code);

    $currentUrl = $request->string('current_url')->toString();
    if (empty($currentUrl)) {
      $currentUrl = url()->previous();
    }

    return redirect()->to($this->resolveLocalizedUrl($currentUrl, $targetLanguage->code));
  }

  public function getPageHeading($language)
  {
    if (Route::is('frontend.listings') || Route::is('frontend.listings.category') || Route::is('frontend.listing.details')) {
      $pageHeading = $language->pageName()->select('listing_page_title')->first();
    } elseif (Route::is('frontend.vendors')) {
      $pageHeading = $language->pageName()->select('vendor_page_title')->first();
    } elseif (Route::is('shop.products')) {
      $pageHeading = $language->pageName()->select('products_page_title')->first();
    } elseif (Route::is('shop.product_details')) {
      $pageHeading = $language->pageName()->select('products_page_title')->first();
    }elseif (Route::is('shop.cart')) {
      $pageHeading = $language->pageName()->select('cart_page_title')->first();
    } elseif (Route::is('shop.checkout')) {
      $pageHeading = $language->pageName()->select('checkout_page_title')->first();
    } elseif (Route::is('user.login')) {
      $pageHeading = $language->pageName()->select('login_page_title')->first();
    } elseif (Route::is('user.signup')) {
      $pageHeading = $language->pageName()->select('signup_page_title')->first();
    } elseif (Route::is('about_us')) {
      $pageHeading = $language->pageName()->select('about_us_title')->first();
    } elseif (Route::is('blog') || Route::is('blog.details') || Route::is('blog.category')) {
      $pageHeading = $language->pageName()->select('blog_page_title')->first();
    } elseif (Route::is('frontend.pricing')) {
      $pageHeading = $language->pageName()->select('pricing_page_title')->first();
    } elseif (Route::is('faq')) {
      $pageHeading = $language->pageName()->select('faq_page_title')->first();
    } elseif (Route::is('contact')) {
      $pageHeading = $language->pageName()->select('contact_page_title')->first();
    } elseif (Route::is('vendor.login')) {
      $pageHeading = $language->pageName()->select('vendor_login_page_title')->first();
    } elseif (Route::is('vendor.signup')) {
      $pageHeading = $language->pageName()->select('vendor_signup_page_title')->first();
    } elseif (Route::is('user.forget_password')) {
      $pageHeading = $language->pageName()->select('forget_password_page_title')->first();
    } elseif (Route::is('vendor.forget.password')) {
      $pageHeading = $language->pageName()->select('vendor_forget_password_page_title')->first();
    } elseif (Route::is('user.wishlist')) {
      $pageHeading = $language->pageName()->select('wishlist_page_title')->first();
    } elseif (Route::is('user.dashboard')) {
      $pageHeading = $language->pageName()->select('dashboard_page_title')->first();
    } elseif (Route::is('user.order.index')) {
      $pageHeading = $language->pageName()->select('orders_page_title')->first();
    } elseif (Route::is('user.support_ticket')) {
      $pageHeading = $language->pageName()->select('support_ticket_page_title')->first();
    } elseif (Route::is('user.support_ticket.create')) {
      $pageHeading = $language->pageName()->select('support_ticket_create_page_title')->first();
    } elseif (Route::is('user.change_password')) {
      $pageHeading = $language->pageName()->select('change_password_page_title')->first();
    } elseif (Route::is('user.edit_profile')) {
      $pageHeading = $language->pageName()->select('edit_profile_page_title')->first();
    } else {
      $pageHeading = null;
    }

    return $pageHeading;
  }


  public static function getBreadcrumb()
  {
    $breadcrumb = Basic::select('breadcrumb')->first();

    return $breadcrumb;
  }


  public function countAdView($id)
  {
    try {
      $ad = Advertisement::findOrFail($id);

      $ad->update([
        'views' => $ad->views + 1
      ]);

      return response()->json(['success' => 'Advertisement view counted successfully.']);
    } catch (ModelNotFoundException $e) {
      return response()->json(['error' => 'Sorry, something went wrong!']);
    }
  }

  public function serviceUnavailable()
  {
    $info = Basic::select('maintenance_img', 'maintenance_msg')->first();

    return view('errors.503', compact('info'));
  }

  public function redirectToDefaultLanguage()
  {
    return redirect()->to(route('index'), 301);
  }

  public function redirectToLocalizedPath(Request $request, string $path = '')
  {
    $supportedCodes = Language::query()->pluck('code')->all();
    $segments = array_values(array_filter(explode('/', trim($path, '/'))));

    if (!empty($segments[0]) && in_array($segments[0], $supportedCodes, true)) {
      abort(404);
    }

    $targetPath = trim($path, '/');
    $redirectUrl = route('index');

    if (!empty($targetPath)) {
      $redirectUrl = url('/' . $targetPath);
    }

    if ($request->getQueryString()) {
      $redirectUrl .= '?' . $request->getQueryString();
    }

    return redirect()->to($redirectUrl, 301);
  }

  private function resolveLocalizedUrl(?string $currentUrl, string $targetLang): string
  {
    $fallbackUrl = localized_route('index', [], $targetLang);

    if (empty($currentUrl)) {
      return $fallbackUrl;
    }

    $normalizedUrl = $this->normalizeUrl($currentUrl);
    $path = parse_url($normalizedUrl, PHP_URL_PATH) ?: '/';
    $queryString = parse_url($normalizedUrl, PHP_URL_QUERY) ?: '';

    parse_str($queryString, $queryParams);

    try {
      $route = app('router')->getRoutes()->match(Request::create($path, 'GET', $queryParams));
    } catch (\Throwable $exception) {
      return $fallbackUrl;
    }

    $routeName = $route->getName();
    $routeParams = $route->parameters();
    $currentLang = $routeParams['lang'] ?? current_front_locale();

    if (in_array($routeName, ['frontend.listings.category', 'frontend.listing.details'], true)) {
      return $this->resolveLocalizedListingPath($routeParams['slug'], $currentLang, $targetLang, $queryParams);
    }

    if ($routeName === 'blog.details') {
      return $this->resolveLocalizedBlogPostUrl($routeParams['slug'], $currentLang, $targetLang) ?? $fallbackUrl;
    }

    if ($routeName === 'blog.category') {
      return $this->resolveLocalizedBlogCategoryUrl($routeParams['slug'], $currentLang, $targetLang) ?? $fallbackUrl;
    }

    if ($routeName === 'frontend.listing.city_category') {
      return $this->resolveLocalizedCityCategoryUrl(
        $routeParams['slug'],
        $currentLang,
        $targetLang,
        $queryParams
      ) ?? $fallbackUrl;
    }

    if ($routeName === 'dynamic_page') {
      return $this->resolveLocalizedPageUrl($routeParams['slug'], $currentLang, $targetLang) ?? $fallbackUrl;
    }

    if ($routeName === 'frontend.listings' && !empty($queryParams['category_id']) && $this->isPureCategoryRequest($queryParams)) {
      return $this->resolveLocalizedCategoryIdUrl((int) $queryParams['category_id'], $targetLang, $queryParams) ?? $fallbackUrl;
    }

    if (empty($routeName)) {
      return $fallbackUrl;
    }

    unset($routeParams['lang']);

    return localized_route($routeName, array_merge($routeParams, $queryParams), $targetLang);
  }

  private function normalizeUrl(string $url): string
  {
    if (str_starts_with($url, 'http://') || str_starts_with($url, 'https://')) {
      return $url;
    }

    return url('/' . ltrim($url, '/'));
  }

  private function resolveLocalizedListingPath(string $slug, string $currentLang, string $targetLang, array $queryParams = []): string
  {
    $currentLanguageId = Language::query()->where('code', $currentLang)->value('id');
    $targetLanguageId = Language::query()->where('code', $targetLang)->value('id');

    $listingContent = ListingContent::query()
      ->where('language_id', $currentLanguageId)
      ->where('slug', $slug)
      ->first();

    if ($listingContent) {
      $targetListingContent = ListingContent::query()
        ->where('language_id', $targetLanguageId)
        ->where('listing_id', $listingContent->listing_id)
        ->first();

      return $targetListingContent
        ? listing_url($targetListingContent->slug, $targetLang)
        : localized_route('index', [], $targetLang);
    }

    $category = ListingCategory::query()->bySlug($currentLanguageId, $slug)->active()->first();

    if (!$category) {
      return localized_route('index', [], $targetLang);
    }

    $targetSlug = $category->getSlug($targetLanguageId);

    return $targetSlug
      ? $this->appendQueryString(listing_category_url($category->id, $targetLang), $queryParams)
      : localized_route('index', [], $targetLang);
  }

  private function resolveLocalizedBlogPostUrl(string $slug, string $currentLang, string $targetLang): ?string
  {
    $currentLanguageId = Language::query()->where('code', $currentLang)->value('id');
    $targetLanguageId = Language::query()->where('code', $targetLang)->value('id');

    $blogInfo = BlogInformation::query()
      ->where('language_id', $currentLanguageId)
      ->where('slug', $slug)
      ->first();

    if (!$blogInfo) {
      return null;
    }

    $targetBlogInfo = BlogInformation::query()
      ->where('language_id', $targetLanguageId)
      ->where('blog_id', $blogInfo->blog_id)
      ->first();

    return $targetBlogInfo ? blog_post_url($targetBlogInfo->slug, $targetLang) : null;
  }

  private function resolveLocalizedBlogCategoryUrl(string $slug, string $currentLang, string $targetLang): ?string
  {
    $currentLanguageId = Language::query()->where('code', $currentLang)->value('id');
    $targetLanguageId = Language::query()->where('code', $targetLang)->value('id');

    $category = BlogCategory::query()->active()->bySlug($currentLanguageId, $slug)->first();

    if (!$category) {
      return null;
    }

    $targetSlug = $category->getSlug($targetLanguageId);

    return $targetSlug ? blog_category_url($category->id, $targetLang) : null;
  }

  private function resolveLocalizedCityCategoryUrl(
    string $slug,
    string $currentLang,
    string $targetLang,
    array $queryParams = []
  ): ?string {
    $currentLanguageId = Language::query()->where('code', $currentLang)->value('id');
    $targetLanguageId = Language::query()->where('code', $targetLang)->value('id');

    $content = ListingCityCategoryContent::query()
      ->where('language_id', $currentLanguageId)
      ->where('slug', $slug)
      ->first();

    if (!$content) {
      return null;
    }

    $targetContent = ListingCityCategoryContent::query()
      ->where('listing_city_category_id', $content->listing_city_category_id)
      ->where('language_id', $targetLanguageId)
      ->whereNotNull('slug')
      ->where('slug', '!=', '')
      ->first();

    if (!$targetContent) {
      return null;
    }

    return $this->appendQueryString(
      localized_route('frontend.listing.city_category', ['slug' => $targetContent->slug], $targetLang),
      $queryParams
    );
  }

  private function resolveLocalizedPageUrl(string $slug, string $currentLang, string $targetLang): ?string
  {
    $currentLanguageId = Language::query()->where('code', $currentLang)->value('id');
    $targetLanguageId = Language::query()->where('code', $targetLang)->value('id');

    $pageContent = PageContent::query()
      ->where('language_id', $currentLanguageId)
      ->where('slug', $slug)
      ->first();

    if (!$pageContent) {
      return null;
    }

    $targetPageContent = PageContent::query()
      ->where('language_id', $targetLanguageId)
      ->where('page_id', $pageContent->page_id)
      ->first();

    return $targetPageContent ? page_url($targetPageContent->slug, $targetLang) : null;
  }

  private function resolveLocalizedCategoryIdUrl(int $categoryId, string $targetLang, array $queryParams): ?string
  {
    $targetLanguageId = Language::query()->where('code', $targetLang)->value('id');
    $category = ListingCategory::query()->active()->find($categoryId);

    if (!$category) {
      return null;
    }

    $targetSlug = $category->getSlug($targetLanguageId);

    if (empty($targetSlug)) {
      return null;
    }

    unset($queryParams['category_id']);

    return $this->appendQueryString(listing_category_url($category->id, $targetLang), $queryParams);
  }

  private function isPureCategoryRequest(array $queryParams): bool
  {
    $allowedKeys = ['category_id', 'page', 'view'];

    return collect(array_keys($queryParams))
      ->diff($allowedKeys)
      ->isEmpty();
  }

  private function appendQueryString(string $url, array $queryParams = []): string
  {
    return empty($queryParams) ? $url : ($url . '?' . http_build_query($queryParams));
  }

}
