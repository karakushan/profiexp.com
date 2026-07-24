<?php

namespace App\Http\Controllers\FrontEnd;

use App\Http\Controllers\Admin\AdminController;
use App\Http\Controllers\Controller;
use App\Http\Helpers\GeoSearch;
use App\Http\Helpers\UploadFile;
use App\Models\Admin;
use Illuminate\Pagination\LengthAwarePaginator;
use App\Models\Aminite;
use App\Models\BasicSettings\Basic;
use App\Models\BasicSettings\MailTemplate;
use App\Models\BusinessHour;
use App\Models\ClaimListing;
use App\Models\Form;
use App\Models\FormInput;
use App\Models\Language;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingContent;
use App\Models\Listing\ListingFaq;
use App\Models\Listing\ListingFeature;
use App\Models\Listing\ListingImage;
use App\Models\Listing\ListingMessage;
use App\Models\Listing\ListingProduct;
use App\Models\Listing\ListingReview;
use App\Services\ReviewService;
use App\Models\Listing\ListingSocialMedia;
use App\Models\Listing\ProductMessage;
use App\Models\ListingCategory;
use App\Models\ListingCategoryContent;
use App\Models\Location\City;
use App\Models\Location\CityContent;
use App\Models\Location\Country;
use App\Models\Location\State;
use App\Models\Location\StateContent;
use App\Models\Location\ListingCityCategory;
use App\Models\Location\ListingCityCategoryContent;
use App\Models\Shop\Product;
use App\Models\Vendor;
use App\Models\VendorInfo;
use App\Models\Visitor;
use App\Services\VendorNotificationService;
use Config;
use DB;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Mail\Message;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class ListingContoller extends Controller
{
  public function cityCategoryListings(Request $request, string $langOrSlug, ?string $localizedSlug = null)
  {
    $slug = $localizedSlug ?? $langOrSlug;
    $language = (new MiscellaneousController())->getLanguage();
    $content = ListingCityCategoryContent::with('listingCityCategory')
      ->where('language_id', $language->id)->where('slug', $slug)->first();

    if (!$content) {
      $content = ListingCityCategoryContent::with('listingCityCategory')
        ->where('slug', $slug)->firstOrFail();
    }

    $request->merge([
      'city' => $content->listingCityCategory->city_id,
      'category_id' => $content->listingCityCategory->listing_category_id,
    ]);
    $request->attributes->set('city_category_content', $content);
    $request->attributes->set('skip_redirect', true);

    return $this->index($request);
  }

  public function cityListings(Request $request, string $langOrSlug, ?string $localizedSlug = null)
  {
    $slug = $localizedSlug ?? $langOrSlug;
    $language = (new MiscellaneousController())->getLanguage();
    $city = CityContent::where('language_id', $language->id)->where('slug', $slug)->firstOrFail();

    $request->merge(['city' => $city->city_id]);

    return $this->index($request);
  }

  public function stateListings(Request $request, string $langOrSlug, ?string $localizedSlug = null)
  {
    $slug = $localizedSlug ?? $langOrSlug;
    $language = (new MiscellaneousController())->getLanguage();
    $state = StateContent::where('language_id', $language->id)->where('slug', $slug)->firstOrFail();

    $request->merge(['state' => $state->state_id]);

    return $this->index($request);
  }

  public function getState(Request $request)
  {
    $misc = new MiscellaneousController();
    $language = $misc->getLanguage();
    $data = [];
    if ($request->id) {
      $data['states'] = State::forLanguage($language->id)
          ->where('country_id', $request->id)
          ->get()
          ->map(function ($state) use ($language) {
              $state->name = $state->getName($language->id);
              return $state;
          });
      $data['cities'] = City::forLanguage($language->id)
          ->where('country_id', $request->id)
          ->get()
          ->map(function ($city) use ($language) {
              $city->name = $city->getName($language->id);
              return $city;
          });
    }
    return $data;
  }

  public function getAddress(Request $request)
  {
    $misc = new MiscellaneousController();
    $language = $misc->getLanguage();
    if ($request->country_id) {
      $country = Country::find($request->country_id)?->getName($language->id);
    }
    if ($request->state_id) {
      $state = State::find($request->state_id)?->getName($language->id);
    }
    if ($request->city_id) {
      $city = City::find($request->city_id)?->getName($language->id);
    }
    $address = '';
    if ($request->city_id) {
      if ($city) {
        $address .= $city;
      }
    }
    if ($request->state_id) {
      if ($state) {
        $address .= ($address ? ', ' : '') . $state;
      }
    }
    if ($request->country_id) {
      if ($country) {
        $address .= ($address ? ', ' : '') . $country;
      }
    }

    return $address;
  }

  public function getCity(Request $request)
  {
    $misc = new MiscellaneousController();
    $language = $misc->getLanguage();
    if ($request->id) {
      $data = City::forLanguage($language->id)
          ->where('state_id', $request->id)
          ->get()
          ->map(function ($city) use ($language) {
              $city->name = $city->getName($language->id);
              return $city;
          });
    } else {
      $data = City::forLanguage($language->id)
          ->get()
          ->map(function ($city) use ($language) {
              $city->name = $city->getName($language->id);
              return $city;
          });
    }
    return $data;
  }

  public function index(Request $request)
  {
    // dd($request->alL());
    $view = Basic::query()->pluck('listing_view')->first();
    $misc = new MiscellaneousController();
    $language = $misc->getLanguage();
    $allowedKeys = ['category_id', 'page', 'view'];

    if ($request->filled('category_id') && !$request->attributes->get('skip_redirect') && collect(array_keys($request->query()))->diff($allowedKeys)->isEmpty()) {
      $category = ListingCategory::query()->active()->find((int) $request->category_id);
      $categorySlug = $category?->getSlug($language->id);

      if (!empty($categorySlug)) {
        return redirect()->to(listing_category_url($category, $language->code) . $this->buildCategoryQueryString($request), 301);
      }
    }

    $information['bgImg'] = $misc->getBreadcrumb();

    $information['pageHeading'] = $misc->getPageHeading($language);

    $information['language'] = $language;
    $information['seoInfo'] = $language->seoInfo()->select('meta_title_listings', 'meta_keyword_listings', 'meta_description_listings')->first();

    $information['currencyInfo'] = $this->getCurrencyInfo();

    $title = $location = $category_id = $max_val = $min_val = $city = $address = $price_not_mentioned = null;

    $listingIds = [];
    if ($request->filled('title')) {
      $title = $request->title;
      $listing_contents = ListingContent::where('language_id', $language->id)
        ->where('title', 'like', '%' . $title . '%')
        ->get()
        ->pluck('listing_id');
      foreach ($listing_contents as $listing_content) {
        if (!in_array($listing_content, $listingIds)) {
          array_push($listingIds, $listing_content);
        }
      }
    }

    $cityIds = [];
    if ($request->filled('city')) {
      $city = $request->city;
      $city_content = City::forLanguage($language->id)->where('id', $city)->first();

      if (!empty($city_content)) {
        $city_id = $city_content->id;
        $listing_contents = ListingContent::where('language_id', $language->id)
          ->where('city_id', $city_id)
          ->get()
          ->pluck('listing_id');
        foreach ($listing_contents as $listing_content) {
          if (!in_array($listing_content, $cityIds)) {
            array_push($cityIds, $listing_content);
          }
        }
      }
    }

    //search by location

    $bs = Basic::select('google_map_api_key_status', 'radius', 'google_map_api_key')->first();
    $radius = $bs->google_map_api_key_status == 1 ? $bs->radius : 5000;

    $locationIds = [];
    $lat_long = [];
    $locationSearchPerformed = false;

    if ($request->filled('location')) {
      $location = $request->location;
      $locationSearchPerformed = true;

      if ($bs->google_map_api_key_status == 1) {
        $geoResult = GeoSearch::getCoordinates($location, $bs->google_map_api_key);
        if (is_array($geoResult) && isset($geoResult['lat']) && isset($geoResult['lng'])) {
          $lat_long = ['lat' => $geoResult['lat'], 'lng' => $geoResult['lng']];

          $locationQuery = Listing::join('listing_contents', 'listings.id', '=', 'listing_contents.listing_id')
            ->where('listing_contents.language_id', $language->id)
            ->whereRaw("
                    (6371000 * acos(
                        cos(radians(?)) *
                        cos(radians(listings.latitude)) *
                        cos(radians(listings.longitude) - radians(?)) +
                        sin(radians(?)) *
                        sin(radians(listings.latitude))
                    )) <= ?
                ", [$lat_long['lat'], $lat_long['lng'], $lat_long['lat'], $radius])
            ->where('listings.status', 1)
            ->where('listings.visibility', 1)
            ->distinct()
            ->pluck('listings.id');

          $locationIds = $locationQuery->toArray();
        }
      } else {
        $listingContentResults = ListingContent::where('language_id', $language->id)
          ->where('address', 'like', '%' . $location . '%')
          ->distinct()
          ->pluck('listing_id')
          ->toArray();

        if (!empty($listingContentResults)) {
          $firstListing = Listing::whereIn('id', $listingContentResults)
            ->whereNotNull('latitude')
            ->whereNotNull('longitude')
            ->first(['latitude', 'longitude', 'id']);

          if ($firstListing) {
            $lat_long = ['lat' => $firstListing->latitude, 'lng' => $firstListing->longitude];

            $locationQuery = Listing::whereRaw("
                    (6371000 * acos(
                        cos(radians(?)) *
                        cos(radians(latitude)) *
                        cos(radians(longitude) - radians(?)) +
                        sin(radians(?)) *
                        sin(radians(latitude))
                    )) <= ?
                ", [$lat_long['lat'], $lat_long['lng'], $lat_long['lat'], $radius])
              ->where('status', 1)
              ->where('visibility', 1)
              ->pluck('id');

            $locationIds = $locationQuery->toArray();
          }
        }
      }
    }


    $category_listingIds = [];
    $category_content = null;
    $childCategories = collect();
    if ($request->filled('category_id')) {
      $category_content = ListingCategory::find(intval($request->category_id));

      if (!empty($category_content)) {
        $category_id = $category_content->id;

        $childCategories = $category_content->children()
          ->where('status', 1)
          ->with('contents')
          ->orderBy('serial_number', 'asc')
          ->get();

        $allCategoryIds = collect([$category_id]);
        if ($childCategories->isNotEmpty()) {
          $allCategoryIds = $allCategoryIds->merge($childCategories->pluck('id'));
        }

        $contents = ListingContent::where('language_id', $language->id)
          ->whereIn('category_id', $allCategoryIds)
          ->get()
          ->pluck('listing_id');
        foreach ($contents as $content) {
          if (!in_array($content, $category_listingIds)) {
            array_push($category_listingIds, $content);
          }
        }
      }
    }


    // ==========  Price Not Mentioned Filter ==========
    $priceNotMentionedIds = [];
    $price_not_mentioned = false;
    if (
      $request->has('price_not_mentioned') &&
      !empty($request->price_not_mentioned) &&
      $request->price_not_mentioned === '1'
    ) {

      $price_not_mentioned = true;

      $priceNotMentionedIds = Listing::whereNull('min_price')
        ->whereNull('max_price')
        ->pluck('id')
        ->toArray();
    }

    if ($request->filled('sort')) {
      switch ($request['sort']) {
        case 'old':
          $order_by_column = 'listings.id';
          $order = 'asc';
          break;
        case 'high':
          $order_by_column = 'listings.max_price';
          $order = 'desc';
          break;
        case 'low':
          $order_by_column = 'listings.min_price';
          $order = 'asc';
          break;
        case 'close-by':
        case 'distance-away':
          // These will be handled after distance calculation
          $order_by_column = 'distance';
          $order = $request['sort'] == 'close-by' ? 'asc' : 'desc';
          break;
        default: // 'new' or others
          $order_by_column = 'listings.id';
          $order = 'desc';
      }
    } else {
      $order_by_column = 'listings.id';
      $order = 'desc';
    }


    $featured_contents = ListingContent::join('listings', 'listings.id', '=', 'listing_contents.listing_id')
      ->Join('feature_orders', 'listings.id', '=', 'feature_orders.listing_id')
      ->join('listing_categories', 'listing_categories.id', '=', 'listing_contents.category_id')
      ->where('listing_contents.language_id', $language->id)
      ->where('feature_orders.order_status', '=', 'completed')
      ->where([
        ['listings.status', '=', '1'],
        ['listings.visibility', '=', '1']
      ])
      ->whereDate('feature_orders.end_date', '>=', Carbon::now()->format('Y-m-d'))
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
      ->when($title, function ($query) use ($listingIds) {
        return $query->whereIn('listings.id', $listingIds);
      })
      ->when($category_id, function ($query) use ($category_listingIds) {
        return $query->whereIn('listings.id', $category_listingIds);
      })

      ->when($request->filled('min_val') && $request->filled('max_val') && !$price_not_mentioned, function ($query) use ($request) {
        $min_val = intval($request->min_val);
        $max_val = intval($request->max_val);

        return $query->where(function ($q) use ($min_val, $max_val) {
          $q->whereNotNull('listings.min_price')
            ->whereNotNull('listings.max_price')
            ->where(function ($subQ) use ($min_val, $max_val) {
              $subQ->whereBetween('listings.min_price', [$min_val, $max_val])
                ->orWhereBetween('listings.max_price', [$min_val, $max_val])
                ->orWhere(function ($rangeQ) use ($min_val, $max_val) {
                  $rangeQ->where('listings.min_price', '<=', $min_val)
                    ->where('listings.max_price', '>=', $max_val);
                });
            });
        });
      })
      ->when($price_not_mentioned, function ($query) use ($priceNotMentionedIds) {
        return $query->whereIn('listings.id', $priceNotMentionedIds);
      })

      ->when($city, function ($query) use ($cityIds) {
        return $query->whereIn('listings.id', $cityIds);
      })

      ->when($locationSearchPerformed, function ($query) use ($locationIds) {
        if (empty($locationIds)) {
          return $query->whereRaw('1 = 0');
        }
        return $query->whereIn('listings.id', $locationIds);
      })
      ->leftJoin('listing_category_contents', function ($j) use ($language) {
        $j->on('listing_categories.id', '=', 'listing_category_contents.listing_category_id')
          ->where('listing_category_contents.language_id', '=', $language->id);
      })
      ->select(
        'listings.*',
        'listing_contents.title',
        'listing_contents.slug',
        'listing_contents.summary',
        'listing_contents.category_id',
        'listing_contents.city_id',
        'listing_contents.state_id',
        'listing_contents.country_id',
        'listing_contents.description',
        'listing_contents.address',
        DB::raw('COALESCE(listing_category_contents.name, listing_categories.name) as category_name'),
        'listing_categories.icon as icon',
        'feature_orders.listing_id as feature_order_listing_id'
      )
      ->distinct()
      ->inRandomOrder()
      ->get()->unique('id');

    if ($bs->google_map_api_key_status == 1 &&  is_array($lat_long) && array_key_exists('lat', $lat_long) && array_key_exists('lng', $lat_long)) {

      $featured_contents = $featured_contents->transform(function ($item) use ($lat_long) {
        $item->distance = GeoSearch::getDistance($item->latitude, $item->longitude, $lat_long['lat'], $lat_long['lng']);
        return $item;
      })->filter(function ($item) use ($bs) {
        $item = floatval($item->distance) <=  $bs->radius;
        return $item;
      })->values()
        ->sortBy('distance')
        ->take(3);
    } else {
      $featured_contents = $featured_contents->take(3);
    }

    $totalFeatured_content = Count($featured_contents);

    $featured_contentsIds = [];
    if ($featured_contents) {

      foreach ($featured_contents as $content) {
        if (!in_array($content->id, $featured_contentsIds)) {
          array_push($featured_contentsIds, $content->id);
        }
      }
    }

    $listing_contents = ListingContent::join('listings', 'listings.id', '=', 'listing_contents.listing_id')
      ->join('listing_categories', 'listing_categories.id', '=', 'listing_contents.category_id')
      ->where('listing_contents.language_id', $language->id)
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
      ->when($title, function ($query) use ($listingIds) {
        return $query->whereIn('listings.id', $listingIds);
      })
      ->when($category_id, function ($query) use ($category_listingIds) {
        return $query->whereIn('listings.id', $category_listingIds);
      })

      ->when($request->filled('min_val') && $request->filled('max_val') && !$price_not_mentioned, function ($query) use ($request) {
        $min_val = intval($request->min_val);
        $max_val = intval($request->max_val);

        return $query->where(function ($q) use ($min_val, $max_val) {

          $q->whereNotNull('listings.min_price')
            ->whereNotNull('listings.max_price')
            ->where(function ($subQ) use ($min_val, $max_val) {
              $subQ->whereBetween('listings.min_price', [$min_val, $max_val])
                ->orWhereBetween('listings.max_price', [$min_val, $max_val])
                ->orWhere(function ($rangeQ) use ($min_val, $max_val) {
                  $rangeQ->where('listings.min_price', '<=', $min_val)
                    ->where('listings.max_price', '>=', $max_val);
                });
            });
        });
      })
      ->when($price_not_mentioned, function ($query) use ($priceNotMentionedIds) {
        return $query->whereIn('listings.id', $priceNotMentionedIds);
      })
      ->when($city, function ($query) use ($cityIds) {
        return $query->whereIn('listings.id', $cityIds);
      })
      ->when($featured_contents, function ($query) use ($featured_contentsIds) {
        return $query->whereNotIn('listings.id', $featured_contentsIds);
      })

      ->when($locationSearchPerformed, function ($query) use ($locationIds) {
        if (empty($locationIds)) {
          return $query->whereRaw('1 = 0');
        }
        return $query->whereIn('listings.id', $locationIds);
      })
      ->leftJoin('listing_category_contents', function ($j) use ($language) {
        $j->on('listing_categories.id', '=', 'listing_category_contents.listing_category_id')
          ->where('listing_category_contents.language_id', '=', $language->id);
      })
      ->select(
        'listings.*',
        'listing_contents.title',
        'listing_contents.slug',
        'listing_contents.summary',
        'listing_contents.category_id',
        'listing_contents.city_id',
        'listing_contents.state_id',
        'listing_contents.country_id',
        'listing_contents.description',
        'listing_contents.address',
        DB::raw('COALESCE(listing_category_contents.name, listing_categories.name) as category_name'),
        'listing_categories.icon as icon',
      )
      ->distinct()
      ->orderBy($order_by_column, $order)
      ->get()->unique('id');


    $listingQuery = $listing_contents;

    if ($totalFeatured_content == 3) {
      $perPage = 9;
    } elseif ($totalFeatured_content == 2) {
      $perPage = 10;
    } elseif ($totalFeatured_content == 1) {
      $perPage = 11;
    } else {
      $perPage = 12;
    }

    if ($bs->google_map_api_key_status == 1 &&  is_array($lat_long) && array_key_exists('lat', $lat_long) && array_key_exists('lng', $lat_long)) {
      $listing_contents = $listing_contents->map(function ($item) use ($lat_long) {
        $item->distance = GeoSearch::getDistance($item->latitude, $item->longitude, $lat_long['lat'], $lat_long['lng']);
        return $item;
      })->filter(function ($item) use ($bs) {
        $item = floatval($item->distance) <= $bs->radius;
        return $item;
      });


      if ($order === 'close-by') {
        $listing_contents = $listing_contents->sortBy('distance'); // Nearest first
      } elseif ($order === 'distance-away') {
        $listing_contents = $listing_contents->sortByDesc('distance'); // Farthest first
      } else {
        $listing_contents = $listing_contents->sortBy('distance');
      }

      $page = $request->query('page', 1);
      $offset = ($page - 1) * $perPage;
      $listingQuery = $listing_contents;

      $paginated = new LengthAwarePaginator(
        $listing_contents->slice($offset, $perPage)->values(),
        $listing_contents->count(),
        $perPage,
        $page,
        ['path' => request()->url(), 'query' => request()->query()]
      );
      $listing_contents =  $paginated;
    } else {

      $page = $request->input('page', 1);
      $offset = ($page - 1) * $perPage;

      $paginated = new LengthAwarePaginator(
        $listing_contents->slice($offset, $perPage)->values(),
        $listing_contents->count(),
        $perPage,
        $page,
        ['path' => request()->url(), 'query' => request()->query()]
      );

      $listing_contents = $paginated;
    }

    $information['listingQuery'] = $listingQuery;
    $information['listing_contents'] = $listing_contents;
    $information['featured_contents'] = $featured_contents;
    $information['perPage'] = $perPage;
    $information['listingbs'] = $bs;


    if ($category_content && $childCategories->isNotEmpty()) {
      $information['categories'] = $childCategories;
      $information['hasMore'] = false;
    } else {
      $allCategories = ListingCategory::with(['contents', 'children.contents'])->forLanguage($language->id)->active()
        ->whereNull('parent_id')
        ->orderBy('serial_number', 'asc')->get();

      $information['categories'] = $allCategories->take(10);
      $information['hasMore'] = $allCategories->count() > 10;
    }
    $information['childCategories'] = collect();

    $information['vendors'] = Vendor::join('memberships', 'vendors.id', '=', 'memberships.vendor_id')
      ->where([
        ['memberships.status', '=', 1],
        ['memberships.start_date', '<=', Carbon::now()->format('Y-m-d')],
        ['memberships.expire_date', '>=', Carbon::now()->format('Y-m-d')]
      ])
      ->get();


    $information['aminites'] = Aminite::with(['contents' => function ($q) use ($language) {
      $q->where('language_id', $language->id);
    }])->orderBy('updated_at', 'asc')->get();

    $information['countries'] = Country::forLanguage($language->id)
      ->orderBy('id', 'asc')->get();

    $information['states'] = State::forLanguage($language->id)
      ->orderBy('id', 'asc')->get();

    $information['searchCity'] = null;
    $metaCityName = null;
    $metaStateName = null;
    $metaCountryName = null;

    if ($request->city) {
      $cityModel = City::with('country', 'state')->find($request->city);

      if ($cityModel) {
        $metaCityName = $cityModel->getName($language->id);
        $information['searchCity'] = $metaCityName;
        $metaStateName = $cityModel->state?->getName($language->id);
        $metaCountryName = $cityModel->country?->getName($language->id);

        // Fallback to default language for city name when current language has no translation
        if (!$metaCityName) {
          $metaCityName = $cityModel->getName($language->id);
          $defaultLang = Language::where('is_default', 1)->first();
          if ($defaultLang && $defaultLang->id !== $language->id) {
            $metaCityName = $cityModel->getName($defaultLang->id) ?: null;
            if (!$metaStateName) {
              $metaStateName = $cityModel->state?->getName($defaultLang->id) ?: null;
            }
            if (!$metaCountryName) {
              $metaCountryName = $cityModel->country?->getName($defaultLang->id) ?: null;
            }
          }
        }
      }
    } elseif ($request->filled('title') && !empty($listingIds)) {
      $cityId = ListingContent::where('language_id', $language->id)
        ->whereIn('listing_id', $listingIds)
        ->whereNotNull('city_id')
        ->groupBy('city_id')
        ->orderByRaw('COUNT(*) DESC')
        ->value('city_id');

      if ($cityId) {
        $cityModel = City::with('country', 'state')->find($cityId);
        if ($cityModel) {
          $metaCityName = $cityModel->getName($language->id);

          // Fallback to default language for city name
          if (!$metaCityName) {
            $defaultLang = Language::where('is_default', 1)->first();
            if ($defaultLang && $defaultLang->id !== $language->id) {
              $metaCityName = $cityModel->getName($defaultLang->id);
            }
          }

          $metaStateName = $cityModel->state?->getName($language->id);
          $metaCountryName = $cityModel->country?->getName($language->id);

          // Fallback to default language for state/country
          if ((!$metaStateName || !$metaCountryName) && isset($defaultLang)) {
            if (!$metaStateName) {
              $metaStateName = $cityModel->state?->getName($defaultLang->id) ?: null;
            }
            if (!$metaCountryName) {
              $metaCountryName = $cityModel->country?->getName($defaultLang->id) ?: null;
            }
          }
        }
      }
    }

    $categoryName = null;
    if (!empty($category_content)) {
      $categoryTranslation = $category_content->getTranslation($language->id);
      $categoryName = $categoryTranslation?->name;
    }

    $siteTitle = Basic::value('website_title');

    if ($metaCityName || $request->filled('title')) {
      $searchTerm = $request->filled('title') ? $request->title : '';

      $metaListingsQuery = ListingContent::join('listings', 'listings.id', '=', 'listing_contents.listing_id')
        ->where('listing_contents.language_id', $language->id)
        ->where('listings.status', 1)
        ->where('listings.visibility', 1);

      if ($categoryName) {
        $metaListingsQuery->where('listing_contents.category_id', $category_content->id);
      } elseif ($searchTerm) {
        $metaListingsQuery->where('listing_contents.title', 'like', "%$searchTerm%");
      }

      // Fix: filter by city when selected
      if ($request->city) {
        $metaListingsQuery->where('listing_contents.city_id', $request->city);
      } elseif (!empty($listingIds)) {
        $metaListingsQuery->whereIn('listing_contents.listing_id', $listingIds);
      }

      $listingCount = $metaListingsQuery->count();

      $categoryNames = ListingCategory::root()->active()
        ->forLanguage($language->id)
        ->with(['contents' => fn ($q) => $q->where('language_id', $language->id)])
        ->orderBy('serial_number')
        ->get()
        ->map(fn ($c) => $c->getName($language->id))
        ->filter()
        ->values()
        ->toArray();

      $month = now()->translatedFormat('F');
      $year = date('Y');
      $siteName = $siteTitle ?? '';

      // Always show at least 10 in meta (Yelp-style)
      $metaCount = max($listingCount, 10);

      $labelBase = $categoryName ? $categoryName : __('Services');

      // Pluralization for the meta label (RU, UK)
      $labelForTitle = $labelBase;
      $labelForDesc = $labelBase;
      if (in_array($language->code, ['ru', 'uk'])) {
        $lowerLabel = mb_strtolower($labelBase);
        $pluralForms = [];
        if ($language->code === 'ru') {
          $pluralForms = [
            'услуги' => ['Услуга', 'Услуги', 'Услуг'],
            'Услуги' => ['Услуга', 'Услуги', 'Услуг'],
          ];
        } else {
          $pluralForms = [
            'послуги' => ['Послуга', 'Послуги', 'Послуг'],
            'Послуги' => ['Послуга', 'Послуги', 'Послуг'],
          ];
        }
        if (isset($pluralForms[$labelBase]) || isset($pluralForms[$lowerLabel])) {
          $forms = $pluralForms[$lowerLabel] ?? $pluralForms[$labelBase];
          $mod10 = $metaCount % 10;
          $mod100 = $metaCount % 100;
          if ($mod10 == 1 && $mod100 != 11) {
            $labelForTitle = $forms[0];
            $labelForDesc = mb_strtolower($forms[0]);
          } elseif (in_array($mod10, [2, 3, 4]) && !in_array($mod100, [12, 13, 14])) {
            $labelForTitle = $forms[1];
            $labelForDesc = mb_strtolower($forms[1]);
          } else {
            $labelForTitle = $forms[2];
            $labelForDesc = mb_strtolower($forms[2]);
          }
        }
      }

      if ($metaCityName) {
        $cityPart = $metaCityName;
        if ($metaStateName) {
          $cityPart .= ", $metaStateName";
        }
        if ($metaCountryName) {
          $cityPart .= ", $metaCountryName";
        }
        $information['cityMetaTitle'] = trans_choice(':count BEST :label in :city - Updated :year', $metaCount, [
          'count' => $metaCount,
          'label' => mb_strtoupper($labelForTitle),
          'city' => $cityPart,
          'year' => $year,
        ]);
        $desc = trans_choice('Top :count Best :label in :city - Last Updated :month :year - :site', $metaCount, [
          'count' => $metaCount,
          'label' => $labelForDesc,
          'city' => $cityPart,
          'month' => $month,
          'year' => $year,
          'site' => $siteName,
        ]);
      } else {
        $information['cityMetaTitle'] = trans_choice(':count BEST :label - Updated :year', $metaCount, [
          'count' => $metaCount,
          'label' => mb_strtoupper($labelForTitle),
          'year' => $year,
        ]);
        $desc = trans_choice('Top :count Best :label - Last Updated :month :year - :site', $metaCount, [
          'count' => $metaCount,
          'label' => $labelForDesc,
          'month' => $month,
          'year' => $year,
          'site' => $siteName,
        ]);
      }

      // Append page number to meta data when not on first page
      if ((int) $page > 1) {
        $pageLabel = ' — ' . __('Page :num', ['num' => $page]);
        $information['cityMetaTitle'] .= $pageLabel;
        $desc .= $pageLabel;
      }

      if (!empty($categoryNames)) {
        $desc .= ' — ' . implode(', ', $categoryNames);
      }

      $information['cityMetaDescription'] = $desc;
    }

    $information['min'] = Listing::where([
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
      ->min('listings.min_price');
    $information['max'] = Listing::where([
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
      })->max('max_price');

    $form = Form::query()->where([
      ['vendor_id', null],
      ['type', 'claim_request'],
      ['language_id', $language->id]
    ])->first();

    if ($form) {
      $information['inputFields'] = FormInput::query()->where('form_id', $form->id)->orderBy('order_no', 'asc')->get();
    } else {
      $information['inputFields'] = [];
    }


    // Find which listings have pending claims
    $claimedPendingIds = ClaimListing::query()
      ->where('status', '!=', 'fulfilled')
      ->pluck('listing_id')
      ->toArray();

    // Attach has_pending_claim flag to featured contents
    $featured_contents = collect($featured_contents)->map(function ($listing) use ($claimedPendingIds) {
      $listing->has_pending_claim = in_array($listing->id, $claimedPendingIds);
      return $listing;
    });

    // Attach has_pending_claim flag to listing contents
    if ($listing_contents instanceof \Illuminate\Pagination\LengthAwarePaginator) {
      // For paginated results
      $listing_contents->getCollection()->transform(function ($listing) use ($claimedPendingIds) {
        $listing->has_pending_claim = in_array($listing->id, $claimedPendingIds);
        return $listing;
      });
    } else {
      // For non-paginated collection
      $listing_contents = collect($listing_contents)->map(function ($listing) use ($claimedPendingIds) {
        $listing->has_pending_claim = in_array($listing->id, $claimedPendingIds);
        return $listing;
      });
    }


    $information['listing_contents'] = $listing_contents;
    $information['featured_contents'] = $featured_contents;
    $information['categoryInfo'] = $category_content;
    $information['categoryContent'] = $category_content ? $category_content->getTranslation($language->id) : null;
    $information['cityCategoryContent'] = $request->attributes->get('city_category_content');
    if ($information['cityCategoryContent']) {
      $information['categoryContent'] = $information['cityCategoryContent'];
      $information['cityCategoryH1'] = $information['cityCategoryContent']->name;
      $information['cityMetaTitle'] = $information['cityCategoryContent']->meta_title ?: $information['cityCategoryContent']->name;
      $information['cityMetaDescription'] = $information['cityCategoryContent']->meta_description;
    }

    $information['otherCities'] = collect();
    if ($category_content && !$information['cityCategoryContent']) {
      $otherCities = ListingCityCategory::with(['contents' => fn($q) => $q->where('language_id', $language->id), 'city.contents' => fn($q) => $q->where('language_id', $language->id)])
        ->where('listing_category_id', $category_content->id)
        ->get();

      $information['otherCities'] = $otherCities->map(function ($item) use ($language) {
        $content = $item->getTranslation($language->id);
        return [
          'name' => $item->city->getName($language->id),
          'url' => $content?->slug ? localized_route('frontend.listing.city_category', ['slug' => $content->slug], $language->code) : null,
        ];
      })->filter(fn($item) => $item['url'] && $item['name'])->values();
    }

    if ($view == 0) {
      return view('frontend.listing.listing-map', $information);
    } elseif ($view == 1) {

      return view('frontend.listing.listing-gird', $information);
    } else {

      return view('frontend.listing.listing-list', $information);
    }
  }

  //search country
  public function getCountry(Request $request)
  {
    $search = $request->input('search');
    $page = $request->input('page', 1);
    $pageSize = 10;

    $misc = new MiscellaneousController();
    $language = $misc->getLanguage();
    $query = Country::join('country_contents', 'countries.id', '=', 'country_contents.country_id')
      ->where('country_contents.language_id', $language->id);

    if ($search) {
      $query->where('country_contents.name', 'like', "%{$search}%");
    }

    // Add pagination
    $countries = $query->skip(($page - 1) * $pageSize)
      ->take($pageSize + 1)
      ->get(['countries.id', 'country_contents.name']);


    // Check if there's more data
    $hasMore = count($countries) > $pageSize;
    $results = $hasMore ? $countries->slice(0, $pageSize) : $countries;

    return response()->json([
      'results' => $results,
      'more' => $hasMore
    ]);
  }

  public function getSearchCity(Request $request)
  {
    $search = $request->input('search');
    $page = $request->input('page', 1);
    $pageSize = 10;

    $misc = new MiscellaneousController();
    $language = $misc->getLanguage();

    $query = City::join('city_contents', 'cities.id', '=', 'city_contents.city_id')
      ->where('city_contents.language_id', $language->id);

    if ($search) {
      $query->where('city_contents.name', 'like', "%{$search}%");
    }

    // Add pagination
    $cities = $query->skip(($page - 1) * $pageSize)
      ->take($pageSize + 1)
      ->get(['cities.id', 'city_contents.name']);

    // Check if there's more data
    $hasMore = count($cities) > $pageSize;
    $results = $hasMore ? $cities->slice(0, $pageSize) : $cities;

    return response()->json([
      'results' => $results,
      'more' => $hasMore
    ]);
  }

  public function searchSate(Request $request)
  {
    $search = $request->input('search');
    $page = $request->input('page', 1);
    $pageSize = 10;

    $misc = new MiscellaneousController();
    $language = $misc->getLanguage();

    $query = State::join('state_contents', 'states.id', '=', 'state_contents.state_id')
      ->where('state_contents.language_id', $language->id);

    if ($search) {
      $query->where('state_contents.name', 'like', "%{$search}%");
    }

    // Add pagination
    $cities = $query->skip(($page - 1) * $pageSize)
      ->take($pageSize + 1)
      ->get(['states.id', 'state_contents.name']);

    // Check if there's more data
    $hasMore = count($cities) > $pageSize;
    $results = $hasMore ? $cities->slice(0, $pageSize) : $cities;

    return response()->json([
      'results' => $results,
      'more' => $hasMore
    ]);
  }

  public function search_listing(Request $request)
  {

    $view = Basic::query()->pluck('listing_view')->first();
    $misc = new MiscellaneousController();
    $language = $misc->getLanguage();
    $information['language'] = $language;
    $information['seoInfo'] = $language->seoInfo()->select('meta_title_listings', 'meta_keyword_listings', 'meta_description_listings')->first();

    $information['currencyInfo'] = $this->getCurrencyInfo();
    $title = $location = $category_id = $max_val = $min_val  = $ratings = $amenitie = $vendor = $country = $state = $city = $price_not_mentioned = null;


    $listingIds = [];
    if ($request->filled('title')) {
      $title = $request->title;
      $listing_contents = ListingContent::where('language_id', $language->id)
        ->where('title', 'like', '%' . $title . '%')
        ->get()
        ->pluck('listing_id');
      foreach ($listing_contents as $listing_content) {
        if (!in_array($listing_content, $listingIds)) {
          array_push($listingIds, $listing_content);
        }
      }
    }
    $countryIds = [];
    if ($request->filled('country')) {
      $country = $request->country;
      $listing_contents = ListingContent::where('language_id', $language->id)
        ->where('country_id', $country)
        ->get()
        ->pluck('listing_id');
      foreach ($listing_contents as $listing_content) {
        if (!in_array($listing_content, $countryIds)) {
          array_push($countryIds, $listing_content);
        }
      }
    }

    $stateIds = [];
    if ($request->filled('state')) {
      $state = $request->state;
      $listing_contents = ListingContent::where('language_id', $language->id)
        ->where('state_id', $state)
        ->get()
        ->pluck('listing_id');
      foreach ($listing_contents as $listing_content) {
        if (!in_array($listing_content, $stateIds)) {
          array_push($stateIds, $listing_content);
        }
      }
    }

    $cityIds = [];
    if ($request->filled('city')) {
      $city = $request->city;
      $city_content = City::forLanguage($language->id)->where('id', $city)->first();

      if (!empty($city_content)) {
        $city_id = $city_content->id;
        $listing_contents = ListingContent::where('language_id', $language->id)
          ->where('city_id', $city_id)
          ->get()
          ->pluck('listing_id');
        foreach ($listing_contents as $listing_content) {
          if (!in_array($listing_content, $cityIds)) {
            array_push($cityIds, $listing_content);
          }
        }
      }
    }

    $vendorIds = [];
    if ($request->filled('vendor')) {
      $vendor = $vendor == 'admin' ? 0 : $request->vendor;
      $listing_contents = Listing::where('vendor_id', $vendor)
        ->get()
        ->pluck('id');
      foreach ($listing_contents as $listing_content) {
        if (!in_array($listing_content, $vendorIds)) {
          array_push($vendorIds, $listing_content);
        }
      }
    }

    //search by location

    $locationIds = [];
    $lat_long = [];
    $locationSearchPerformed = false;

    $bs = Basic::select('google_map_api_key_status', 'radius', 'google_map_api_key')->first();
    $radius = $bs->google_map_api_key_status == 1 ? $bs->radius : 5000;

    if ($request->filled('location_val')) {
      $location = $request->location_val;
      $locationSearchPerformed = true;

      if ($bs->google_map_api_key_status == 1) {
        $geoResult = GeoSearch::getCoordinates($location, $bs->google_map_api_key);
        if (is_array($geoResult) && isset($geoResult['lat']) && isset($geoResult['lng'])) {
          $lat_long = ['lat' => $geoResult['lat'], 'lng' => $geoResult['lng']];

          $locationQuery = Listing::join('listing_contents', 'listings.id', '=', 'listing_contents.listing_id')
            ->where('listing_contents.language_id', $language->id)
            ->whereRaw("
                    (6371000 * acos(
                        cos(radians(?)) *
                        cos(radians(listings.latitude)) *
                        cos(radians(listings.longitude) - radians(?)) +
                        sin(radians(?)) *
                        sin(radians(listings.latitude))
                    )) <= ?
                ", [$lat_long['lat'], $lat_long['lng'], $lat_long['lat'], $radius])
            ->where('listings.status', 1)
            ->where('listings.visibility', 1)
            ->distinct()
            ->pluck('listings.id');

          $locationIds = $locationQuery->toArray();
        }
      } else {
        $listingContentResults = ListingContent::where('language_id', $language->id)
          ->where('address', 'like', '%' . $location . '%')
          ->distinct()
          ->pluck('listing_id')
          ->toArray();

        if (!empty($listingContentResults)) {
          $firstListing = Listing::whereIn('id', $listingContentResults)
            ->whereNotNull('latitude')
            ->whereNotNull('longitude')
            ->first(['latitude', 'longitude', 'id']);

          if ($firstListing) {
            $lat_long = ['lat' => $firstListing->latitude, 'lng' => $firstListing->longitude];

            $locationQuery = Listing::whereRaw("
                    (6371000 * acos(
                        cos(radians(?)) *
                        cos(radians(latitude)) *
                        cos(radians(longitude) - radians(?)) +
                        sin(radians(?)) *
                        sin(radians(latitude))
                    )) <= ?
                ", [$lat_long['lat'], $lat_long['lng'], $lat_long['lat'], $radius])
              ->where('status', 1)
              ->where('visibility', 1)
              ->pluck('id');

            $locationIds = $locationQuery->toArray();
          }
        }
      }
    }

    $category_listingIds = [];
    if ($request->filled('category_id')) {
      $category_content = ListingCategory::find(intval($request->category_id));

      if (!empty($category_content)) {
        $category_id = $category_content->id;

        $childCategories = $category_content->children()
          ->where('status', 1)
          ->with('contents')
          ->orderBy('serial_number', 'asc')
          ->get();

        $allCategoryIds = collect([$category_id]);
        if ($childCategories->isNotEmpty()) {
          $allCategoryIds = $allCategoryIds->merge($childCategories->pluck('id'));
        }

        $contents = ListingContent::where('language_id', $language->id)
          ->whereIn('category_id', $allCategoryIds)
          ->get()
          ->pluck('listing_id');
        foreach ($contents as $content) {
          if (!in_array($content, $category_listingIds)) {
            array_push($category_listingIds, $content);
          }
        }
      }
    }


    // ========== Price Not Mentioned Filter ==========
    $priceNotMentionedIds = [];
    $price_not_mentioned = false;
    if (
      $request->has('price_not_mentioned') &&
      !empty($request->price_not_mentioned) &&
      $request->price_not_mentioned === '1'
    ) {

      $price_not_mentioned = true;

      $priceNotMentionedIds = Listing::whereNull('min_price')
        ->whereNull('max_price')
        ->pluck('id')
        ->toArray();
    }

    $ratingIds = [];
    if ($request->filled('ratings')) {
      $ratings = $request->ratings;
      $contents = Listing::where('average_rating', '>=', $ratings)
        ->get()
        ->pluck('id');
      foreach ($contents as $content) {
        if (!in_array($content, $ratingIds)) {
          array_push($ratingIds, $content);
        }
      }
    }

    $amenitieIds = [];
    if ($request->filled('amenitie')) {
      $amenitie = $request->amenitie;
      $array = explode(',', $amenitie);

      $contents = ListingContent::where('language_id', $language->id)
        ->get(['listing_id', 'aminities']);

      foreach ($contents as $content) {
        $aminities = (json_decode($content->aminities));
        $listingId = $content->listing_id;
        $diff1 = array_diff($array, $aminities);
        $diff2 = array_diff($array, $aminities);

        if (empty($diff1) && empty($diff2)) {

          array_push($amenitieIds, $listingId);
        }
      }
    }

    // Sorting
    if ($request->filled('sort')) {
      switch ($request['sort']) {
        case 'old':
          $order_by_column = 'listings.id';
          $order = 'asc';
          break;
        case 'high':
          $order_by_column = 'listings.max_price';
          $order = 'desc';
          break;
        case 'low':
          $order_by_column = 'listings.min_price';
          $order = 'asc';
          break;
        default: // 'new' or others
          $order_by_column = 'listings.id';
          $order = 'desc';
      }
    } else {
      $order_by_column = 'listings.id';
      $order = 'desc';
    }

    $featured_contents = ListingContent::join('listings', 'listings.id', '=', 'listing_contents.listing_id')
      ->Join('feature_orders', 'listings.id', '=', 'feature_orders.listing_id')
      ->join('listing_categories', 'listing_categories.id', '=', 'listing_contents.category_id')
      ->where('listing_contents.language_id', $language->id)
      ->where('feature_orders.order_status', '=', 'completed')
      ->where([
        ['listings.status', '=', '1'],
        ['listings.visibility', '=', '1']
      ])
      ->whereDate('feature_orders.end_date', '>=', Carbon::now()->format('Y-m-d'))
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


      ->when($title, function ($query) use ($listingIds) {
        return $query->whereIn('listings.id', $listingIds);
      })
      ->when($vendor, function ($query) use ($vendorIds) {
        return $query->whereIn('listings.id', $vendorIds);
      })
      ->when($category_id, function ($query) use ($category_listingIds) {
        return $query->whereIn('listings.id', $category_listingIds);
      })

      ->when($request->filled('min_val') && $request->filled('max_val') && !$price_not_mentioned, function ($query) use ($request) {
        $min_val = intval($request->min_val);
        $max_val = intval($request->max_val);

        return $query->where(function ($q) use ($min_val, $max_val) {
          $q->whereNotNull('listings.min_price')
            ->whereNotNull('listings.max_price')
            ->where(function ($subQ) use ($min_val, $max_val) {
              $subQ->whereBetween('listings.min_price', [$min_val, $max_val])
                ->orWhereBetween('listings.max_price', [$min_val, $max_val])
                ->orWhere(function ($rangeQ) use ($min_val, $max_val) {
                  $rangeQ->where('listings.min_price', '<=', $min_val)
                    ->where('listings.max_price', '>=', $max_val);
                });
            });
        });
      })
      // ==========  Apply Price Not Mentioned Filter ==========
      ->when($price_not_mentioned, function ($query) use ($priceNotMentionedIds) {
        return $query->whereIn('listings.id', $priceNotMentionedIds);
      })
      ->when($ratings, function ($query) use ($ratingIds) {
        return $query->whereIn('listings.id', $ratingIds);
      })
      ->when($amenitie, function ($query) use ($amenitieIds) {
        return $query->whereIn('listings.id', $amenitieIds);
      })
      ->when($country, function ($query) use ($countryIds) {
        return $query->whereIn('listings.id', $countryIds);
      })
      ->when($state, function ($query) use ($stateIds) {
        return $query->whereIn('listings.id', $stateIds);
      })
      ->when($city, function ($query) use ($cityIds) {
        return $query->whereIn('listings.id', $cityIds);
      })

      ->when($locationSearchPerformed, function ($query) use ($locationIds) {
        if (empty($locationIds)) {
          return $query->whereRaw('1 = 0');
        }
        return $query->whereIn('listings.id', $locationIds);
      })
      ->leftJoin('listing_category_contents', function ($j) use ($language) {
        $j->on('listing_categories.id', '=', 'listing_category_contents.listing_category_id')
          ->where('listing_category_contents.language_id', '=', $language->id);
      })
      ->select(
        'listings.*',
        'listing_contents.title',
        'listing_contents.slug',
        'listing_contents.summary',
        'listing_contents.category_id',
        'listing_contents.city_id',
        'listing_contents.state_id',
        'listing_contents.country_id',
        'listing_contents.description',
        'listing_contents.address',
        DB::raw('COALESCE(listing_category_contents.name, listing_categories.name) as category_name'),
        'listing_categories.icon as icon',
        'feature_orders.listing_id as feature_order_listing_id'
      )
      ->distinct(['listings.id'])
      ->inRandomOrder()
      ->get();

    if ($bs->google_map_api_key_status == 1 &&  is_array($lat_long) && array_key_exists('lat', $lat_long) && array_key_exists('lng', $lat_long)) {

      $featured_contents = $featured_contents->transform(function ($item) use ($lat_long) {
        $item->distance = GeoSearch::getDistance($item->latitude, $item->longitude, $lat_long['lat'], $lat_long['lng']);
        return $item;
      })->filter(function ($item) use ($bs) {
        $item = floatval($item->distance) <=  $bs->radius;
        return $item;
      })->values()
        ->sortBy('distance')
        ->take(3);
    } else {
      $featured_contents = $featured_contents->take(3);
    }


    $totalFeatured_content = Count($featured_contents);
    $featured_contentsIds = [];
    if ($featured_contents) {

      foreach ($featured_contents as $content) {
        if (!in_array($content->id, $featured_contentsIds)) {
          array_push($featured_contentsIds, $content->id);
        }
      }
    }

    $listing_contents = ListingContent::join('listings', 'listings.id', '=', 'listing_contents.listing_id')
      ->join('listing_categories', 'listing_categories.id', '=', 'listing_contents.category_id')
      ->where('listing_contents.language_id', $language->id)
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
      ->when($title, function ($query) use ($listingIds) {
        return $query->whereIn('listings.id', $listingIds);
      })
      ->when($vendor, function ($query) use ($vendorIds) {
        return $query->whereIn('listings.id', $vendorIds);
      })
      ->when($category_id, function ($query) use ($category_listingIds) {
        return $query->whereIn('listings.id', $category_listingIds);
      })

      ->when($request->filled('min_val') && $request->filled('max_val') && !$price_not_mentioned, function ($query) use ($request) {
        $min_val = intval($request->min_val);
        $max_val = intval($request->max_val);

        return $query->where(function ($q) use ($min_val, $max_val) {
          $q->whereNotNull('listings.min_price')
            ->whereNotNull('listings.max_price')
            ->where(function ($subQ) use ($min_val, $max_val) {
              $subQ->whereBetween('listings.min_price', [$min_val, $max_val])
                ->orWhereBetween('listings.max_price', [$min_val, $max_val])
                ->orWhere(function ($rangeQ) use ($min_val, $max_val) {
                  $rangeQ->where('listings.min_price', '<=', $min_val)
                    ->where('listings.max_price', '>=', $max_val);
                });
            });
        });
      })
      //  Apply Price Not Mentioned Filter
      ->when($price_not_mentioned, function ($query) use ($priceNotMentionedIds) {
        return $query->whereIn('listings.id', $priceNotMentionedIds);
      })
      ->when($ratings, function ($query) use ($ratingIds) {
        return $query->whereIn('listings.id', $ratingIds);
      })
      ->when($amenitie, function ($query) use ($amenitieIds) {
        return $query->whereIn('listings.id', $amenitieIds);
      })
      ->when($country, function ($query) use ($countryIds) {
        return $query->whereIn('listings.id', $countryIds);
      })
      ->when($state, function ($query) use ($stateIds) {
        return $query->whereIn('listings.id', $stateIds);
      })
      ->when($city, function ($query) use ($cityIds) {
        return $query->whereIn('listings.id', $cityIds);
      })
      ->when($featured_contents, function ($query) use ($featured_contentsIds) {
        return $query->whereNotIn('listings.id', $featured_contentsIds);
      })

      ->when($locationSearchPerformed, function ($query) use ($locationIds) {
        if (empty($locationIds)) {
          return $query->whereRaw('1 = 0');
        }
        return $query->whereIn('listings.id', $locationIds);
      })
      ->leftJoin('listing_category_contents', function ($j) use ($language) {
        $j->on('listing_categories.id', '=', 'listing_category_contents.listing_category_id')
          ->where('listing_category_contents.language_id', '=', $language->id);
      })
      ->select(
        'listings.*',
        'listing_contents.title',
        'listing_contents.slug',
        'listing_contents.summary',
        'listing_contents.category_id',
        'listing_contents.city_id',
        'listing_contents.state_id',
        'listing_contents.country_id',
        'listing_contents.description',
        'listing_contents.address',
        DB::raw('COALESCE(listing_category_contents.name, listing_categories.name) as category_name'),
        'listing_categories.icon as icon',
      )
      ->distinct(['listings.id'])
      ->orderBy($order_by_column, $order)
      ->get();

    $listingQuery = $listing_contents;

    if ($totalFeatured_content == 3) {
      $perPage = 9;
    } elseif ($totalFeatured_content == 2) {
      $perPage = 10;
    } elseif ($totalFeatured_content == 1) {
      $perPage = 11;
    } else {
      $perPage = 12;
    }


    if ($bs->google_map_api_key_status == 1 &&  is_array($lat_long) && array_key_exists('lat', $lat_long) && array_key_exists('lng', $lat_long)) {
      $listing_contents = $listing_contents->map(function ($item) use ($lat_long) {
        $item->distance = GeoSearch::getDistance($item->latitude, $item->longitude, $lat_long['lat'], $lat_long['lng']);
        return $item;
      })->filter(function ($item) use ($bs) {
        $item = floatval($item->distance) <= $bs->radius;
        return $item;
      });


      if ($request->filled('sort') && $request->input('sort') == 'distance-away') {
        $listing_contents = $listing_contents->sortByDesc('distance');
      } else {
        $listing_contents = $listing_contents->sortBy('distance');
      }

      $page = $request->query('page', 1);
      $offset = ($page - 1) * $perPage;
      $listingQuery = $listing_contents;

      $paginated = new LengthAwarePaginator(
        $listing_contents->slice($offset, $perPage)->values(),
        $listing_contents->count(),
        $perPage,
        $page,
        ['path' => request()->url(), 'query' => request()->query()]
      );
      $listing_contents =  $paginated;
    } else {

      $page = $request->input('page', 1);
      $offset = ($page - 1) * $perPage;

      $paginated = new LengthAwarePaginator(
        $listing_contents->slice($offset, $perPage)->values(),
        $listing_contents->count(),
        $perPage,
        $page,
        ['path' => request()->url(), 'query' => request()->query()]
      );

      $listing_contents = $paginated;
    }

    $information['listingQuery'] = $listingQuery;
    $information['listing_contents'] = $listing_contents;
    $information['featured_contents'] = $featured_contents;
    $information['perPage'] = $perPage;
    $information['listingbs'] = $bs;


    // Find which listings have pending claims
    $claimedPendingIds = ClaimListing::query()
      ->where('status', '!=', 'fulfilled')
      ->pluck('listing_id')
      ->toArray();

    // Attach has_pending_claim flag to featured contents
    $featured_contents = collect($featured_contents)->map(function ($listing) use ($claimedPendingIds) {
      $listing->has_pending_claim = in_array($listing->id, $claimedPendingIds);
      return $listing;
    });

    // Attach has_pending_claim flag to listing contents
    if ($listing_contents instanceof \Illuminate\Pagination\LengthAwarePaginator) {
      // For paginated results
      $listing_contents->getCollection()->transform(function ($listing) use ($claimedPendingIds) {
        $listing->has_pending_claim = in_array($listing->id, $claimedPendingIds);
        return $listing;
      });
    } else {
      // For non-paginated collection
      $listing_contents = collect($listing_contents)->map(function ($listing) use ($claimedPendingIds) {
        $listing->has_pending_claim = in_array($listing->id, $claimedPendingIds);
        return $listing;
      });
    }

    $information['listing_contents'] = $listing_contents;
    $information['featured_contents'] = $featured_contents;

    if ($view == 2) {

      return view('frontend.listing.search-listing-list', $information);
    } else {
      return view('frontend.listing.search-listing', $information);
    }
  }

  public function moreCategories(Request $request)
  {
    $offset = $request->query('offset', 10);

    $misc = new MiscellaneousController();
    $language = $misc->getLanguage();

    $categories = ListingCategory::with('contents')->forLanguage($language->id)
      ->where('status', 1)
      ->whereNull('parent_id')
      ->orderBy('serial_number', 'asc')
      ->skip($offset)
      ->take(50)
      ->get()
      ->map(function ($cat) use ($language) {
        $cat->translated_name = $cat->getName($language->id);
        return $cat;
      });

    return response()->json([
      'categories' => $categories,
      'hasMore' => $categories->count() == 50
    ]);
  }

  public function homeCategories(Request $request)
  {
    $search = $request->input('search');

    $misc = new MiscellaneousController();
    $language = $misc->getLanguage();

    $results = $this->flatCategoryTree($language, null, '', $search);

    return response()->json([
      'results' => $results,
      'more' => false
    ]);
  }

  private function flatCategoryTree($language, $parentId, $prefix, $search)
  {
    $categories = ListingCategory::where('status', 1)
      ->where('parent_id', $parentId)
      ->with(['contents' => function ($q) use ($language) {
        $q->where('language_id', $language->id);
      }])
      ->orderBy('serial_number')
      ->get();

    $result = [];
    foreach ($categories as $category) {
      $name = $category->contents->first()?->name ?? $category->name;
      $displayName = $prefix . $name;
      if (!$search || mb_stripos($name, $search) !== false) {
        $result[] = ['id' => $category->id, 'name' => $displayName];
      }
      $result = array_merge($result, $this->flatCategoryTree($language, $category->id, $prefix . '— ', $search));
    }
    return $result;
  }

  public function showBySlug(Request $request, $langOrSlug, $slug = null)
  {
    if ($slug === null) {
      $slug = $langOrSlug;
    }

    $misc = new MiscellaneousController();
    $language = $misc->getLanguage();

    $listingContent = ListingContent::query()
      ->where('language_id', $language->id)
      ->where('slug', $slug)
      ->first();

    if ($listingContent) {
      $request->route()->action['as'] = 'frontend.listing.details';
      return $this->renderDetails($listingContent->listing_id, $language);
    }

    $category = ListingCategory::query()->active()->bySlug($language->id, $slug)->first();

    if ($category) {
      $request->route()->action['as'] = 'frontend.listings.category';
      $request->merge(['category_id' => $category->id]);
      $request->attributes->set('skip_redirect', true);

      return $this->index($request);
    }

    abort(404);
  }

  public function details($slug, $id)
  {
    $misc = new MiscellaneousController();
    $language = $misc->getLanguage();
    $listingContent = ListingContent::query()
      ->where('language_id', $language->id)
      ->where('listing_id', $id)
      ->firstOrFail();

    return redirect()->to(listing_url($listingContent->slug, $language->code), 301);
  }

  public function detailsLocalized(Request $request, $lang, $slug, $id)
  {
    $languageCode = $lang ?: default_front_locale();
    $language = Language::query()->where('code', $languageCode)->firstOrFail();
    $listingContent = ListingContent::query()
      ->where('language_id', $language->id)
      ->where('listing_id', $id)
      ->firstOrFail();

    return $this->renderDetails($listingContent->listing_id, $language);
  }

  private function renderDetails(int $listingId, $language)
  {
    $misc = new MiscellaneousController();
    $vendorId = Listing::where('id', $listingId)->pluck('vendor_id')->first();
    $information['bs'] = Basic::query()->select('google_recaptcha_status', 'facebook_login_status', 'google_login_status')->first();

    $listing = Listing::with(['listing_content' => function ($query) use ($language) {
      return $query->where('language_id', $language->id);
    },])
      ->when($vendorId && $vendorId != 0, function ($query) {
        $query->join('memberships', 'listings.vendor_id', '=', 'memberships.vendor_id')
          ->where([
            ['memberships.status', '=', 1],
            ['memberships.start_date', '<=', now()->format('Y-m-d')],
            ['memberships.expire_date', '>=', now()->format('Y-m-d')],
          ]);
      })
      ->where([
        ['listings.status', '=', '1'],
        ['listings.visibility', '=', '1']
      ])
      ->select('listings.*')
      ->where('listings.id', $listingId)
      ->firstOrFail();

    $vendor_id = $listing->vendor_id;

    $information['bgImg'] = $misc->getBreadcrumb();
    $information['listing'] = $listing;
    $information['listingImages'] = ListingImage::Where('listing_id', $listingId)->get();

    $listing_content = ListingContent::where('language_id', $language->id)->where('listing_id', $listingId)->first();
    $information['socialLinks'] = ListingSocialMedia::where('listing_id', $listingId)->get();

    if (is_null($listing_content)) {
      Session::flash('error', __('No listing information found for') . ' ' . $language->name);

      return redirect()->route('index');
    }

    $information['language'] = $language;

    $listing_features = ListingFeature::join('listing_feature_contents', 'listing_features.id', '=', 'listing_feature_contents.listing_feature_id')
      ->where('listing_id', $listingId)
      ->where('listing_feature_contents.language_id', $language->id)->get();

    $information['listing_features'] = $listing_features;
    if ($vendorId == 0) {
      $information['vendor'] = Admin::first();
      $information['userName'] = 'admin';
    } else {
      $information['vendor'] = Vendor::Where('id', $vendor_id)->first();
      $information['userName'] = $information['vendor']->username;
      $information['vendorInfo'] = VendorInfo::Where('vendor_id', $vendor_id)
        ->where('language_id', $language->id)
        ->first();
    }

    $reviews = ListingReview::query()->where('listing_id', '=', $listingId)
      ->where('status', 'approved')
      ->orderByDesc('id')->get();

    $reviews->map(function ($review) use ($language) {
      $review['user'] = $review->userInfo()->first();
      ReviewService::setDisplayText($review, $language->id);
    });

    $information['reviews'] = $reviews;
    $numOfReview = count($reviews);
    $information['numOfReview'] = $numOfReview;

    $information['info'] = Basic::select('google_recaptcha_status')->first();

    $product_contents = Product::join('product_contents', 'products.id', '=', 'product_contents.product_id')
      ->where('products.status', '=', 'show')
      ->where('products.listing_id',  $listingId)
      ->where('product_contents.language_id', '=', $language->id)
      ->select('products.id', 'products.featured_image', 'products.average_rating', 'product_contents.title', 'product_contents.slug', 'products.current_price', 'products.previous_price', 'products.product_type', 'products.stock')
      ->paginate(9);
    $information['product_contents'] = $product_contents;

    $businessHours = BusinessHour::query()->where('listing_id', '=', $listingId)->orderBy('id')->get();
    $information['businessHours'] = $businessHours;

    $faqs = ListingFaq::where('listing_id', $listingId)
      ->where('language_id', $language->id)
      ->orderBy('serial_number', 'asc')
      ->get();
    $information['faqs'] = $faqs;

    return view('frontend.listing.listing-details', $information);
  }

  private function buildCategoryQueryString(Request $request): string
  {
    $query = $request->only(['page', 'view']);

    return empty($query) ? '' : ('?' . http_build_query($query));
  }

  public function contact(Request $request)
  {
    // Define the validation rules
    $rules = [
      'name' => 'required',
      'email' => 'required|email',
      'phone' => 'required',
      'message' => 'required',
    ];

    // Fetch the Google reCAPTCHA status
    $info = Basic::select('google_recaptcha_status')->first();
    if ($info->google_recaptcha_status == 1) {
      $rules['g-recaptcha-response'] = 'required|captcha';
    }

    // Define custom validation messages
    $messages = [];
    if ($info->google_recaptcha_status == 1) {
      $messages['g-recaptcha-response.required'] = 'Please verify that you are not a robot.';
      $messages['g-recaptcha-response.captcha'] = 'Captcha error! Try again later or contact site admin.';
    }

    // Create a validator instance
    $validator = Validator::make($request->all(), $rules, $messages);

    // Check if validation fails
    if ($validator->fails()) {
      return redirect()->back()
        ->withErrors($validator) // This will include the validation error messages
        ->withInput();
    }

    $in = $request->all();
      $listing = ListingMessage::create($in);
      $vendor = !empty($listing->vendor_id) ? Vendor::find($listing->vendor_id) : null;
      VendorNotificationService::send(
        $vendor,
        'vendor_listing_message_received',
        'New listing inquiry',
        'A customer sent a new message about one of your listings.',
        [
          'listing_id' => $listing->listing_id,
          'message_id' => $listing->id,
        ]
      );

    $mail_template = MailTemplate::where('mail_type', 'inquiry_about_listing')->first();

    $info = Basic::select('google_recaptcha_status')->first();
    if ($info->google_recaptcha_status == 1) {
      $rules['g-recaptcha-response'] = 'required|captcha';
    }

    $be = Basic::select('smtp_status', 'smtp_host', 'smtp_port', 'encryption', 'smtp_username', 'smtp_password', 'from_mail', 'from_name', 'to_mail', 'website_title')->firstOrFail();

    $misc = new MiscellaneousController();

    $language = $misc->getLanguage();

    $listing = Listing::with(['listing_content' => function ($query) use ($language) {
      return $query->where('language_id', $language->id);
    }])->where('id', $request->listing_id)->first();

    $listing_name = $listing->listing_content[0]->title;
    $slug = $listing->listing_content[0]->slug;
    $url = listing_url($slug, $language->code);


    if ($listing->vendor_id != 0) {
      $vendor = Vendor::where('id', $listing->vendor_id)->select('to_mail', 'username', 'email')->first();

      if (isset($vendor->to_mail)) {
        $send_email_address = $vendor->to_mail;
      } else {
        $send_email_address = $vendor->email;
      }
      $user_name = $vendor->username;
    } else {
      $send_email_address = $be->to_mail;
      $user_name = 'Admin';
    }

    if ($be->smtp_status == 1) {
      $subject = 'Inquiry about ' . $listing_name;

      $body = $mail_template->mail_body;
      $body = preg_replace("/{username}/", $user_name, $body);
      $body = preg_replace("/{listing_name}/", "<a href=" . $url . ">$listing_name</a>", $body);
      $body = preg_replace("/{enquirer_name}/", $request->name, $body);
      $body = preg_replace("/{enquirer_email}/", $request->email, $body);
      $body = preg_replace("/{enquirer_phone}/", $request->phone, $body);
      $body = preg_replace("/{enquirer_message}/", nl2br($request->message), $body);
      $body = preg_replace("/{website_title}/", $be->website_title, $body);

      // if smtp status == 1, then set some value for PHPMailer
      if ($be->smtp_status == 1) {
        try {
          $smtp = [
            'transport' => 'smtp',
            'host' => $be->smtp_host,
            'port' => $be->smtp_port,
            'encryption' => $be->encryption,
            'username' => $be->smtp_username,
            'password' => $be->smtp_password,
            'timeout' => null,
            'auth_mode' => null,
          ];
          Config::set('mail.mailers.smtp', $smtp);
        } catch (\Exception $e) {
          Session::flash('error', $e->getMessage());
          return back();
        }
      }
      try {
        $data = [
          'to' => $send_email_address,
          'subject' => $subject,
          'body' => $body,
        ];
        
        if ($be->smtp_status == 1) {
          Mail::send([], [], function (Message $message) use ($data, $be) {
            $fromMail = $be->from_mail;
            $fromName = $be->from_name;
            $message->to($data['to'])
              ->subject($data['subject'])
              ->from($fromMail, $fromName)
              ->html($data['body'], 'text/html');
          });
        }

        Session::flash('success', __('Message sent successfully') . '!');
        return back();
      } catch (Exception $e) {
        Session::flash('error', __('Something went wrong.'));
        return back();
      }
    }
  }


  public function productContact(Request $request)
  {
    $mail_template = MailTemplate::where('mail_type', 'inquiry_about_product')->first();
    $info = Basic::select('google_recaptcha_status')->first();

    $misc = new MiscellaneousController();
    $language = $misc->getLanguage();

    $be = Basic::select(
      'smtp_status',
      'smtp_host',
      'smtp_port',
      'encryption',
      'smtp_username',
      'smtp_password',
      'from_mail',
      'from_name',
      'to_mail',
      'website_title'
    )->firstOrFail();

    // Fetch the form and inputs for dynamic validation
    $form = Form::query()
      ->where([
        ['vendor_id', $request->vendor_id],
        ['type', 'quote_request'],
        ['language_id', $language->id]
      ])->first();

    $inputFields = $form ? $form->input()->orderBy('order_no', 'asc')->get() : collect();

    // Base validation rules
    $rules = [
      'name' => ['required', 'string', 'max:255'],
      'email' => ['required', 'email'],
      'product_id' => ['required', 'integer'],
      'vendor_id' => ['nullable', 'integer'],
    ];

    if ($info->google_recaptcha_status == 1) {
      $rules['g-recaptcha-response'] = ['required', 'captcha'];
    }

    // Add rules for dynamic inputs
    foreach ($inputFields as $field) {
      $baseName = $field->name;
      $isRequired = (int)$field->is_required === 1;
      $type = (int)$field->type;
      $inputName = $type === 8 ? ('form_builder_' . $baseName) : $baseName;

      if ($type === 4) {
        $rules[$inputName] = $isRequired ? ['required', 'array', 'min:1'] : ['nullable', 'array'];
        $options = array_values((array) json_decode($field->options, true) ?: []);
        $rules[$inputName . '.*'] = !empty($options) ? [\Illuminate\Validation\Rule::in($options)] : ['string'];
        continue;
      }

      $fieldRules = [];
      $fieldRules[] = $isRequired ? 'required' : 'nullable';

      switch ($type) {
        case 1:
          $fieldRules[] = 'string';
          $fieldRules[] = 'max:1000';
          break;
        case 2:
          $fieldRules[] = 'numeric';
          break;
        case 3:
          $options = array_values((array) json_decode($field->options, true) ?: []);
          if (!empty($options)) {
            $fieldRules[] = \Illuminate\Validation\Rule::in($options);
          } else {
            $fieldRules[] = 'string';
          }
          break;
        case 5:
          $fieldRules[] = 'string';
          $fieldRules[] = 'max:5000';
          break;
        case 6:
          $fieldRules[] = 'date';
          break;
        case 7:
          $fieldRules[] = 'date_format:H:i';
          break;
        case 8:
          $fieldRules[] = 'file';
          $fieldRules[] = 'mimes:zip';
          $fieldRules[] = 'max:10240';
          break;
        default:
          $fieldRules[] = 'string';
          break;
      }

      $rules[$inputName] = $fieldRules;
    }

    $validator = Validator::make($request->all(), $rules);

    if ($validator->fails()) {
      return response()->json(['errors' => $validator->errors()->toArray()], 400);
    }

    $product = Product::with(['content' => function ($q) use ($language) {
      return $q->where('language_id', $language->id);
    }])->find($request->product_id);

    if (!$product) {
      return response()->json(['message' => 'Product not found'], 404);
    }

    $listing = null;
    $listing_name = '';
    $url = '';

    if ($product->listing_id) {
      $listing = Listing::with(['listing_content' => function ($q) use ($language) {
        return $q->where('language_id', $language->id);
      }])->find($product->listing_id);

      if ($listing && isset($listing->listing_content[0])) {
        $listing_name = $listing->listing_content[0]->title;
        $slug = $listing->listing_content[0]->slug;
        $url = listing_url($slug, $language->code);
      }
    }

    $product_title = $product->content[0]->title ?? 'Product';

    // Collect dynamic info
    $infos = [];
    foreach ($inputFields as $field) {
      $type = (int)$field->type;
      $baseName = $field->name;
      $inputName = $type === 8 ? ('form_builder_' . $baseName) : $baseName;

      if ($type === 8 && $request->hasFile($inputName)) {
        $originalName = $request->file($inputName)->getClientOriginalName();
        $path = UploadFile::store('./assets/file/zip-files/', $request->file($inputName));
        $infos[$baseName] = [
          'originalName' => $originalName,
          'value' => $path,
          'type' => $type,
        ];
      } elseif ($request->has($inputName)) {
        $infos[$baseName] = [
          'value' => $request->input($inputName),
          'type' => $type,
        ];
      }
    }

    $vendorId = !empty($product->vendor_id) ? (int) $product->vendor_id : null;

    if (empty($vendorId) && !empty($listing?->vendor_id)) {
      $vendorId = (int) $listing->vendor_id;
    }

    if (empty($vendorId) && !empty($request->vendor_id)) {
      $vendorId = (int) $request->vendor_id;
    }

    $productMessage = ProductMessage::create([
      'product_id' => $request->product_id,
      'vendor_id' => $vendorId ?: null,
      'name' => $request->name,
      'email' => $request->email,
      'message' => !empty($infos) ? json_encode($infos) : null,
    ]);

    $vendor = !empty($vendorId) ? Vendor::find($vendorId) : null;

    VendorNotificationService::send(
      $vendor,
      'vendor_product_message_received',
      'New product inquiry',
      'A customer sent a new message about one of your products.',
      [
        'product_id' => $productMessage->product_id,
        'message_id' => $productMessage->id,
      ]
    );

    // Determine recipient mail if vendor id exists
    $send_email_address = $be->to_mail;
    $user_name = 'Admin';

    if ($vendorId) {
      $vendor = Vendor::where('id', $vendorId)->select('to_mail', 'email', 'username')->first();
      if ($vendor) {
        $send_email_address = $vendor->to_mail ?: $vendor->email ?: $send_email_address;
        $user_name = $vendor->username ?: $user_name;
      }
    }

    // Prepare email body
    $body = $mail_template->mail_body;
    $body = preg_replace("/{username}/", $user_name, $body);
    $body = preg_replace("/{product_title}/", $product_title, $body);
    if ($url) {
      $body = preg_replace("/{listing_name}/", "<a href=\"$url\">$listing_name</a>", $body);
    } else {
      $body = preg_replace("/{listing_name}/", $listing_name, $body);
    }
    $body = preg_replace("/{enquirer_name}/", $request->name, $body);
    $body = preg_replace("/{enquirer_email}/", $request->email, $body);
    $body = preg_replace("/{enquirer_message}/", nl2br($request->message), $body);
    $body = preg_replace("/{website_title}/", $be->website_title, $body);

    // Send mail if SMTP enabled
    if ($be->smtp_status == 1) {
      try {
        $smtp = [
          'transport' => 'smtp',
          'host' => $be->smtp_host,
          'port' => $be->smtp_port,
          'encryption' => $be->encryption,
          'username' => $be->smtp_username,
          'password' => $be->smtp_password,
        ];
        Config::set('mail.mailers.smtp', $smtp);
      } catch (\Exception $e) {
        Session::flash('error', $e->getMessage());
        return back();
      }

      try {
        Mail::send([], [], function ($message) use ($send_email_address, $body, $be, $product_title) {
          $message->to($send_email_address)
            ->subject('Inquiry about ' . $product_title)
            ->from($be->from_mail, $be->from_name)
            ->html($body);
        });

        Session::flash('success', __('Message sent successfully'));
        return response()->json(['message' => __('Message sent successfully')], 200);
      } catch (\Exception $e) {

        Session::flash('error', __('Sending email failed.'));
        return response()->json(['message' => __('Sending email failed.')], 400);
      }
    }

    return response()->json(['message' => 'Message sent successfully'], 200);
  }

  public function storeReview(Request $request, $id)
  {

    $rule = ['rating' => 'required'];
    $validator = Validator::make($request->all(), $rule);

    if ($validator->fails()) {
      return redirect()->back()
        ->with('error', __('The rating field is required for product review.'))
        ->withInput();
    }

    $user = Auth::guard('web')->user();

    if ($user) {
        $review = ListingReview::updateOrCreate(
          ['user_id' => $user->id, 'listing_id' => $id],
          [
            'review' => $request->review,
            'rating' => $request->rating,
            'status' => 'pending',
            'language_id' => ReviewService::languageId(),
          ]
        ); 
        if ($review->wasRecentlyCreated) {
          $listing = Listing::find($id);
          VendorNotificationService::send(
            $listing?->vendor,
            'vendor_listing_review_received',
            __('New listing review'),
            __('You received a new review on one of your listings.'),
            [
              'listing_id' => $id,
              'review_id' => $review->id,
            ]
          );
        }

      ReviewService::recalculate(ReviewService::TYPE_LISTING, (int) $id);

      Session::flash('success', __('Your review submitted and is awaiting moderation') . '.');
    } else {
      Session::flash('error', __('You have to Login First!'));
    }
    return redirect()->back();
  }
  public function store_visitor(Request $request)
  {
    $request->validate([
      'listing_id'
    ]);
    $ipAddress = \Request::ip();
    $check = Visitor::where([['listing_id', $request->listing_id], ['ip_address', $ipAddress], ['date', Carbon::now()->format('y-m-d')]])->first();
    $listing = Listing::where('id', $request->listing_id)->first();
    if ($listing) {
      if (!$check) {
        $visitor = new Visitor();
        $visitor->listing_id = $request->listing_id;
        $visitor->ip_address = $ipAddress;
        $visitor->vendor_id = $listing->vendor_id;
        $visitor->date = Carbon::now()->format('y-m-d');
        $visitor->save();
      }
    }
  }

  public function claimListing(Request $request, $id)
  {
    // Verify the user is authenticated and matches the user_id
    if (!Auth::guard('web')->check()) {
      return redirect()->back()->with('error', __('Unauthorized access' . '.'));
    }

    $user_id = Auth::guard('web')->check() ? Auth::guard('web')->user()->id : null;

    // Verify the listing exists
    $listing = Listing::find($id);
    if (!$listing) {
      return redirect()->back()->with('error', __('Listing not found' . '.'));
    }

    // Check if the user has already claimed this listing
    $existingClaim = ClaimListing::where('listing_id', $id)
      ->where('user_id', $user_id)
      ->first();
    if ($existingClaim) {
      return redirect()->back()->with('error', __('You have already claimed this listing' . '.'));
    }

    // Create the claim
    ClaimListing::create([
      'listing_id' => $id,
      'user_id' => $user_id,
      'status' => 'pending',
    ]);

    return redirect()->back()->with('success', __('Claim submitted successfully. We will review your claim shortly' . '.'));
  }


  public function storeClaimRequestInfo(Request $request)
  {
    if (!Auth::guard('web')->check()) {
      return redirect()->route('user.login', ['redirectPath' => 'claim-listing']);
    }

    $misc = new MiscellaneousController();
    $language = $misc->getLanguage();

    // Load dynamic inputs
    $form = Form::query()->find($request->form_id);
    $inputFields = $form ? $form->input()->orderBy('order_no', 'asc')->get() : collect();

    // Base rules for static inputs
    $rules = [
      'form_id' => ['required', 'integer'],
      'listing_id' => ['required', 'integer'],
      'user_id' => ['required', 'integer'],
      'vendor_id' => ['nullable', 'integer'],
      'name' => ['required', 'string', 'max:255'],
      'phone' => ['nullable', 'string', 'max:50'],
    ];

    // Build dynamic rules
    foreach ($inputFields as $field) {
      $baseName = $field->name;
      $isRequired = (int)$field->is_required === 1;
      $label = $field->label;
      $type = (int)$field->type;

      // file type uses prefixed input name
      $inputName = $type === 8 ? ('form_builder_' . $baseName) : $baseName;

      // Start with nullable unless required
      $fieldRules = [];
      if ($isRequired) {
        $fieldRules[] = 'required';
      } else {
        // validate if present, and allow null
        $fieldRules[] = 'nullable';
      }

      if ($type === 1) {
        $fieldRules[] = 'string';
        $fieldRules[] = 'max:1000';
      } elseif ($type === 2) {
        $fieldRules[] = 'numeric';
      } elseif ($type === 3) {
        // options are in JSON
        $options = array_values((array) json_decode($field->options, true) ?: []);
        if (!empty($options)) {
          $fieldRules[] = Rule::in($options);
        } else {
          // If no options defined, allow string
          $fieldRules[] = 'string';
        }
      } elseif ($type === 4) {
        $parentRules = $isRequired ? ['required', 'array', 'min:1'] : ['nullable', 'array'];
        $rules[$inputName] = $parentRules;

        // Validate each selected item is among options
        $options = array_values((array) json_decode($field->options, true) ?: []);
        $rules[$inputName . '.*'] = !empty($options)
          ? [Rule::in($options)]
          : ['string'];

        continue;
      } elseif ($type === 5) {
        $fieldRules[] = 'string';
        $fieldRules[] = 'max:5000';
      } elseif ($type === 6) {
        $fieldRules[] = 'date';
      } elseif ($type === 7) {
        $fieldRules[] = 'date_format:H:i';
      } elseif ($type === 8) {
        $fieldRules[] = 'file';
        $fieldRules[] = 'mimes:zip';

        $fieldRules[] = 'max:10240';
      } else {
        // Fallback as string
        $fieldRules[] = 'string';
      }

      // Attach the computed rule
      $rules[$inputName] = $fieldRules;
    }

    // Validate now
    $validator = Validator::make($request->all(), $rules);
    if ($validator->fails()) {
      return back()->withErrors($validator)->withInput()->with('open_claim_modal', true);
    }

    // Unique claim check
    $existingClaim = ClaimListing::where([
      ['listing_id', $request->listing_id],
      ['user_id', $request->user_id],
      ['vendor_id', $request->vendor_id],
    ])->first();

    if ($existingClaim) {
      return redirect()->back()->with('error', __('You have already claimed this listing') . '.');
    }

    // Build infos only after validation succeeded
    $infos = [];
    foreach ($inputFields as $inputField) {
      $type = (int)$inputField->type;
      $baseName = $inputField->name;
      $inputName = $type === 8 ? ('form_builder_' . $baseName) : $baseName;

      if ($type === 8 && $request->hasFile($inputName)) {
        $originalName = $request->file($inputName)->getClientOriginalName();
        $uniqueName = UploadFile::store('./assets/file/zip-files/', $request->file($inputName));
        $infos[$baseName] = [
          'originalName' => $originalName,
          'value' => $uniqueName,
          'type' => $type,
        ];
      } elseif ($request->has($inputName)) {
        $infos[$baseName] = [
          'value' => $request->input($inputName),
          'type' => $type,
        ];
      }
    }

    $claimListing = new ClaimListing();
    $claimListing->listing_id = $request->listing_id;
    $claimListing->user_id = $request->user_id;
    $claimListing->vendor_id = $request->vendor_id ?: null;
    $claimListing->language_id = $language->id;
    $claimListing->status = 'pending';
    $claimListing->customer_name = $request->name;
    $claimListing->customer_email = $request->email_address;
    $claimListing->customer_phone = $request->phone;
    $claimListing->information = !empty($infos) ? json_encode($infos) : null;
    $claimListing->save();

    session()->flash('success', __('Your claim request has been successfully submitted') . '.');
    return redirect()->back();
  }

}
