<?php

namespace App\Http\Controllers\FrontEnd;

use App\Http\Controllers\Controller;
use App\Http\Controllers\FrontEnd\MiscellaneousController;
use App\Http\Controllers\Frontend\paymentgateway\MyfatoorahController;
use App\Http\Controllers\Payment\MyfatoorahController as PaymentMyfatoorahController;
use App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway\MyfatoorahController as FeaturePaymentGetwayMyfatoorahController;
use App\Models\BasicSettings\Basic;
use App\Models\CounterSection;
use App\Models\HomePage\CategorySection;
use App\Models\HomePage\HeroSection;
use App\Models\HomePage\Section;
use App\Models\Journal\Blog;
use App\Models\Prominence\FeatureSection;
use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Models\HomePage\ListingSection;
use App\Models\HomePage\PackageSection;
use App\Models\Listing\ListingContent;
use App\Models\ListingCategory;
use App\Models\Location\City;
use Illuminate\Support\Facades\DB;
use App\Models\Package;
use Illuminate\Support\Facades\Session;

class HomeController extends Controller
{
  public function index(Request $request)
  {
    $themeVersion = Basic::query()->pluck('theme_version')->first();

    $secInfo = Section::query()->first();

    $misc = new MiscellaneousController();

    $language = $misc->getLanguage();

    $information['language'] = $language;

    $information['seoInfo'] = $language->seoInfo()->select('meta_keyword_home', 'meta_description_home')->first();


    if ($secInfo->about_section_status == 1) {
      $information['aboutSectionImage'] = Basic::query()->pluck('about_section_image')->first();
      $information['aboutSecInfo'] = $language->aboutSection()->first();
    }
    if ($themeVersion == 2) {
      $information['categorySectionImage'] = Basic::query()->pluck('category_section_background')->first();
    }
    $information['catgorySecInfo'] = CategorySection::where('language_id', $language->id)->first();
    if ($themeVersion == 2) {
      $information['featuredSecInfo'] = FeatureSection::where('language_id', $language->id)->first();
    }
    $information['listingSecInfo'] = ListingSection::where('language_id', $language->id)->first();

    $information['packageSecInfo'] = PackageSection::where('language_id', $language->id)->first();


    if ($secInfo->work_process_section_status == 1 && ($themeVersion == 1 || $themeVersion == 4)) {
      $information['workProcessSecInfo'] = $language->workProcessSection()->first();
      $information['processes'] = $language->workProcess()->orderBy('serial_number', 'asc')->get();
    }


    if ($secInfo->counter_section_status == 1) {
      $information['counterSectionImage'] = Basic::query()->pluck('counter_section_image')->first();
      $information['counterSectionInfo'] = CounterSection::where('language_id', $language->id)->first();
      $information['counters'] = $language->counterInfo()->orderByDesc('id')->get();
    }

    $information['currencyInfo'] = $this->getCurrencyInfo();


    $information['testimonialSecInfo'] = $language->testimonialSection()->first();
    $information['testimonials'] = $language->testimonial()->orderByDesc('id')->get();
    $information['testimonialSecImage'] = Basic::query()->pluck('testimonial_section_image')->first();

    $information['heroSection'] = HeroSection::where('language_id', $language->id)->first();
    $information['heroSectionImage'] = Basic::query()->pluck('hero_section_background_img')->first();


    if (($themeVersion == 1 || $themeVersion == 4) && $secInfo->call_to_action_section_status == 1) {
      $information['callToActionSectionImage'] = Basic::query()->pluck('call_to_action_section_image')->first();
      $information['callToActionSectionHighlightImage'] = Basic::query()->pluck('call_to_action_section_highlight_image')->first();
      $information['callToActionSecInfo'] = $language->callToActionSection()->first();
    }
    if ($themeVersion == 2 || $themeVersion == 4) {
      $information['videoSectionImage'] = Basic::query()->pluck('video_section_image')->first();
      $information['videoSecInfo'] = $language->videoSection()->first();
    }

    if ($secInfo->blog_section_status == 1) {
      $information['blogSecInfo'] = $language->blogSection()->first();

      $information['blogs'] = Blog::query()->join('blog_informations', 'blogs.id', '=', 'blog_informations.blog_id')
        ->join('blog_categories', 'blog_categories.id', '=', 'blog_informations.blog_category_id')
        ->where('blog_informations.language_id', '=', $language->id)
        ->select('blogs.image', 'blogs.id', 'blog_categories.name AS categoryName', 'blog_categories.slug AS categorySlug', 'blog_informations.title', 'blog_informations.slug', 'blog_informations.author', 'blogs.created_at', 'blog_informations.content')
        ->orderBy('blogs.serial_number', 'desc')
        ->limit(3)
        ->get();
      $blog_count = Blog::query()->join('blog_informations', 'blogs.id', '=', 'blog_informations.blog_id')
        ->join('blog_categories', 'blog_categories.id', '=', 'blog_informations.blog_category_id')
        ->where('blog_informations.language_id', '=', $language->id)
        ->select('blogs.image', 'blogs.id', 'blog_categories.name AS categoryName', 'blog_categories.slug AS categorySlug', 'blog_informations.title', 'blog_informations.slug', 'blog_informations.author', 'blogs.created_at', 'blog_informations.content')
        ->get();
      $information['blog_count'] = $blog_count;
    }

    $information['locationSecInfo'] = $language->locationSection()->first();

    $categories = ListingCategory::withCount('listing_contents')->has('listing_contents')->where([['language_id', $language->id], ['status', 1]])
      ->orderBy('listing_contents_count', 'desc')
      ->take(10)
      ->get();

    $information['categories'] = $categories;

    if ($themeVersion == 2 || $themeVersion == 3) {

      $cities = City::withCount('listing_city')
        ->has('listing_city')
        ->where('language_id', $language->id)
        ->orderBy('listing_city_count', 'desc')
        ->take(10)
        ->get();

      $information['cities'] = $cities;
    }

    $information['secInfo'] = $secInfo;

    $terms = [];
    if (Package::query()->where('status', '1')->where('term', 'monthly')->count() > 0) {
      $terms[] = 'Monthly';
    }
    if (Package::query()->where('status', '1')->where('term', 'yearly')->count() > 0) {
      $terms[] = 'Yearly';
    }
    if (Package::query()->where('status', '1')->where('term', 'lifetime')->count() > 0) {
      $terms[] = 'Lifetime';
    }
    $information['terms'] = $terms;
    if ($themeVersion == 1 || $themeVersion == 2) {
      $listingContentsLimit = 4;
    } else {
      $listingContentsLimit = 6;
    }

    $listing_contents = ListingContent::join('listings', 'listings.id', '=', 'listing_contents.listing_id')
      ->Join('feature_orders', 'listings.id', '=', 'feature_orders.listing_id')
      ->join('listing_categories', 'listing_categories.id', '=', 'listing_contents.category_id')
      ->where('listing_contents.language_id', $language->id)
      ->where('feature_orders.order_status', '=', 'completed')
      ->where([
        ['listings.status', '=', '1'],
        ['listings.visibility', '=', '1']
      ])
      ->when('listings.vendor_id' != "0", function ($query) {
        return $query->leftJoin('memberships', 'listings.vendor_id', '=', 'memberships.vendor_id')
          ->where(function ($query) {
            $query->where([
              ['memberships.status', '=', 1],
              ['memberships.start_date', '<=', now()->format('Y-m-d')],
              ['memberships.expire_date', '>=', now()->format('Y-m-d')],
            ])->orWhere('listings.vendor_id', '=', 0);
          });
      })
      ->when('listings.vendor_id' != "0", function ($query) {
        return $query->leftJoin('vendors', 'listings.vendor_id', '=', 'vendors.id')
          ->where(function ($query) {
            $query->where([
              ['vendors.status', '=', 1],
            ])->orWhere('listings.vendor_id', '=', 0);
          });
      })
      ->whereDate('feature_orders.end_date', '>=', Carbon::now()->format('Y-m-d'))
      ->select(
        'listings.*',
        'listing_contents.title',
        'listing_contents.slug',
        'listing_contents.category_id',
        'listing_contents.city_id',
        'listing_contents.state_id',
        'listing_contents.country_id',
        'listing_contents.description',
        'listing_contents.address',
        'listing_categories.name as category_name',
        'listing_categories.icon as icon',
        'feature_orders.listing_id as feature_order_listing_id'
      )

      ->inRandomOrder()
      ->limit($listingContentsLimit)
      ->get();


    $information['listing_contents'] = $listing_contents;

    $total_listing_contents = ListingContent::join('listings', 'listings.id', '=', 'listing_contents.listing_id')
      ->Join('feature_orders', 'listings.id', '=', 'feature_orders.listing_id')
      ->join('listing_categories', 'listing_categories.id', '=', 'listing_contents.category_id')
      ->where('listing_contents.language_id', $language->id)
      ->where('feature_orders.order_status', '=', 'completed')
      ->where([
        ['listings.status', '=', '1'],
        ['listings.visibility', '=', '1']
      ])
      ->when('listings.vendor_id' != "0", function ($query) {
        return $query->leftJoin('memberships', 'listings.vendor_id', '=', 'memberships.vendor_id')
          ->where(function ($query) {
            $query->where([
              ['memberships.status', '=', 1],
              ['memberships.start_date', '<=', now()->format('Y-m-d')],
              ['memberships.expire_date', '>=', now()->format('Y-m-d')],
            ])->orWhere('listings.vendor_id', '=', 0);
          });
      })
      ->when('listings.vendor_id' != "0", function ($query) {
        return $query->leftJoin('vendors', 'listings.vendor_id', '=', 'vendors.id')
          ->where(function ($query) {
            $query->where([
              ['vendors.status', '=', 1],
            ])->orWhere('listings.vendor_id', '=', 0);
          });
      })
      ->whereDate('feature_orders.end_date', '>=', Carbon::now()->format('Y-m-d'))
      ->select(
        'listings.*',
        'listing_contents.title',
        'listing_contents.slug',
        'listing_contents.category_id',
        'listing_contents.city_id',
        'listing_contents.state_id',
        'listing_contents.country_id',
        'listing_contents.description',
        'listing_contents.address',
        'listing_categories.name as category_name',
        'listing_categories.icon as icon',
        'feature_orders.listing_id as feature_order_listing_id'
      )
      ->get();
    $information['total_listing_contents'] = $total_listing_contents;

    if ($themeVersion == 2) {

      $latest_listing_contents = ListingContent::join('listings', 'listings.id', '=', 'listing_contents.listing_id')
        ->join('listing_categories', 'listing_categories.id', '=', 'listing_contents.category_id')
        ->where('listing_contents.language_id', $language->id)
        ->where([
          ['listings.status', '=', '1'],
          ['listings.visibility', '=', '1']
        ])
        ->when(
          'listings.vendor_id' != "0",
          function ($query) {
            return $query->leftJoin('memberships', 'listings.vendor_id', '=', 'memberships.vendor_id')
              ->where(function ($query) {
                $query->where([
                  ['memberships.status', '=', 1],
                  ['memberships.start_date', '<=', now()->format('Y-m-d')],
                  ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                ])->orWhere('listings.vendor_id', '=', 0);
              });
          }
        )
        ->when(
          'listings.vendor_id' != "0",
          function ($query) {
            return $query->leftJoin('vendors', 'listings.vendor_id', '=', 'vendors.id')
              ->where(function ($query) {
                $query->where([
                  [
                    'vendors.status',
                    '=',
                    1
                  ],
                ])->orWhere('listings.vendor_id', '=', 0);
              });
          }
        )
        ->select(
          'listings.*',
          'listing_contents.title',
          'listing_contents.slug',
          'listing_contents.category_id',
          'listing_contents.city_id',
          'listing_contents.state_id',
          'listing_contents.country_id',
          'listing_contents.description',
          'listing_contents.address',
          'listing_categories.name as category_name',
          'listing_categories.icon as icon',
        )

        ->take(8)
        ->orderBy('listings.id', 'desc')
        ->get();

      $latest_listing_content_total =
        ListingContent::join('listings', 'listings.id', '=', 'listing_contents.listing_id')
        ->join('listing_categories', 'listing_categories.id', '=', 'listing_contents.category_id')
        ->where('listing_contents.language_id', $language->id)
        ->where([
          ['listings.status', '=', '1'],
          ['listings.visibility', '=', '1']
        ])
        ->when(
          'listings.vendor_id' != "0",
          function ($query) {
            return $query->leftJoin('memberships', 'listings.vendor_id', '=', 'memberships.vendor_id')
              ->where(function ($query) {
                $query->where([
                  ['memberships.status', '=', 1],
                  ['memberships.start_date', '<=', now()->format('Y-m-d')],
                  ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                ])->orWhere('listings.vendor_id', '=', 0);
              });
          }
        )
        ->when(
          'listings.vendor_id' != "0",
          function ($query) {
            return $query->leftJoin('vendors', 'listings.vendor_id', '=', 'vendors.id')
              ->where(function ($query) {
                $query->where([
                  [
                    'vendors.status',
                    '=',
                    1
                  ],
                ])->orWhere('listings.vendor_id', '=', 0);
              });
          }
        )
        ->select(
          'listings.*',
          'listing_contents.title',
          'listing_contents.slug',
          'listing_contents.category_id',
          'listing_contents.city_id',
          'listing_contents.state_id',
          'listing_contents.country_id',
          'listing_contents.description',
          'listing_contents.address',
          'listing_categories.name as category_name',
          'listing_categories.icon as icon',
        )
        ->orderBy('listings.id', 'desc')
        ->get();

      $information['latest_listing_content_total'] = $latest_listing_content_total;
      $information['latest_listing_contents'] = $latest_listing_contents;
    }

    if ($themeVersion == 1) {
      return view('frontend.home.index-v1', $information);
    } elseif ($themeVersion == 2) {
      return view('frontend.home.index-v2', $information);
    } elseif ($themeVersion == 3) {
      return view('frontend.home.index-v3', $information);
    } elseif ($themeVersion == 4) {
      return view('frontend.home.index-v4', $information);
    }
  }

  public function about()
  {
    $information['themeVersion'] = Basic::query()->pluck('theme_version')->first();

    $misc = new MiscellaneousController();

    $language = $misc->getLanguage();

    $information['seoInfo'] = $language->seoInfo()->select('meta_keywords_about_page', 'meta_description_about_page')->first();

    $information['pageHeading'] = $misc->getPageHeading($language);

    $information['bgImg'] = $misc->getBreadcrumb();
    $secInfo = Section::query()->first();
    $information['secInfo'] = $secInfo;

    if ($secInfo->work_process_section_status == 1) {
      $information['workProcessSecInfo'] = $language->workProcessSection()->first();
      $information['processes'] = $language->workProcess()->orderBy('serial_number', 'asc')->get();
    }

    if ($secInfo->testimonial_section_status == 1) {
      $information['testimonialSecInfo'] = $language->testimonialSection()->first();
      $information['testimonials'] = $language->testimonial()->orderByDesc('id')->get();
      $information['testimonialSecImage'] = Basic::query()->pluck('testimonial_section_image')->first();
    }

    if ($secInfo->counter_section_status == 1) {
      $information['counterSectionImage'] = Basic::query()->pluck('counter_section_image')->first();
      $information['counterSectionInfo'] = CounterSection::where('language_id', $language->id)->first();
      $information['counters'] = $language->counterInfo()->orderByDesc('id')->get();
    }

    return view('frontend.about-us', $information);
  }
  public function pricing(Request $request)
  {
    $misc = new MiscellaneousController();
    $language = $misc->getLanguage();
    $information['bgImg'] = $misc->getBreadcrumb();
    $information['packageSecInfo'] = PackageSection::where('language_id', $language->id)->first();
    $information['seoInfo'] = $language->seoInfo()->select('meta_keyword_pricing', 'meta_description_pricing')->first();
    $terms = [];
    if (Package::query()->where('status', '1')->where('term', 'monthly')->count() > 0) {
      $terms[] = 'Monthly';
    }
    if (Package::query()->where('status', '1')->where('term', 'yearly')->count() > 0) {
      $terms[] = 'Yearly';
    }
    if (Package::query()->where('status', '1')->where('term', 'lifetime')->count() > 0) {
      $terms[] = 'Lifetime';
    }
    $information['terms'] = $terms;
    $information['pageHeading'] = $misc->getPageHeading($language);
    return view('frontend.pricing', $information);
  }

  //offline
  public function offline()
  {
    return view('frontend.offline');
  }

  public function myfatoorah_callback(Request $request)
  {
    $type = Session::get('myfatoorah_payment_type');
    if ($type == 'buy_plan') {
      $data = new PaymentMyfatoorahController();
      $data = $data->successCallback($request);
      // return redirect($data);
      Session::forget('myfatoorah_payment_type');
      if ($data['status'] == 'success') {
        return redirect()->route('success.page');
      } else {
        $cancel_url = Session::get('cancel_url');
        return redirect($cancel_url);
      }
    } elseif ($type == 'shop') {
      $data = new MyfatoorahController();
      $data = $data->successCallback($request);
      Session::forget('myfatoorah_payment_type');
      if ($data['status'] == 'success') {
        return redirect()->route('shop.purchase_product.complete');
      } else {
        return redirect()->route('shop.checkout')->with(['alert-type' => 'error', 'message' => 'Payment failed']);
      }
    } elseif ($type == 'listing_feature') {
      $data = new FeaturePaymentGetwayMyfatoorahController();
      $data = $data->successCallback($request);
      Session::forget('myfatoorah_payment_type');
      if ($data['status'] == 'success') {
        return redirect()->route('success.page');
      } else {
        $cancel_url = Session::get('cancel_url');
        return redirect($cancel_url);
      }
    }
  }

  public function myfatoorah_cancel(Request $request)
  {
    $type = Session::get('myfatoorah_payment_type');
    if ($type == 'buy_plan') {
      return redirect()->route('membership.cancel');
    } elseif ($type == 'shop') {
      return redirect()->route('shop.checkout')->with(['alert-type' => 'error', 'message' => 'Payment failed']);
    }
  }
}
