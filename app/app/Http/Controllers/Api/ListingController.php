<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\ApiHelper\HelperController;
use App\Http\Controllers\Controller;
use App\Http\Controllers\FrontEnd\MiscellaneousController;
use App\Http\Helpers\GeoSearch;
use App\Http\Helpers\UploadFile;
use App\Models\Aminite;
use App\Models\BasicSettings\Basic;
use App\Models\BasicSettings\MailTemplate;
use App\Models\BusinessHour;
use App\Models\ClaimListing;
use App\Models\Form;
use App\Models\FormInput;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingContent;
use App\Models\Listing\ListingFaq;
use App\Models\Listing\ListingFeature;
use App\Models\Listing\ListingImage;
use App\Models\Listing\ListingMessage;
use App\Models\Listing\ListingReview;
use App\Models\Listing\ListingSocialMedia;
use App\Models\Listing\ProductMessage;
use App\Models\ListingCategory;
use App\Models\Location\City;
use App\Models\Location\Country;
use App\Models\Language;
use App\Models\Location\State;
use App\Models\Shop\Product;
use App\Models\Vendor;
use App\Services\VendorNotificationService;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Validator;
use Illuminate\Mail\Message;
use Illuminate\Support\Facades\Config;
use Exception;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class ListingController extends Controller
{
    public function index(Request $request)
    {
        $language = HelperController::getLanguage($request);

        $information['seoInfo'] = $language->seoInfo()->select('meta_keyword_listings', 'meta_description_listings')->first();
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
        if ($request->filled('category_id')) {
            $category_content = ListingCategory::find(intval($request->category_id));

            if (!empty($category_content)) {
                $contents = ListingContent::where('language_id', $language->id)
                    ->where('category_id', $category_content->id)
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
                'listing_categories.name as category_name',
                'listing_categories.icon as icon',
                'feature_orders.listing_id as feature_order_listing_id'
            )
            ->distinct()
            ->inRandomOrder()
            ->get()->unique('id')->map(function ($list) use ($language) {
                return HelperController::formatListForApi($list, $language->id);
            });

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
                'listing_categories.slug as category_slug',
            )
            ->distinct()
            ->orderBy($order_by_column, $order)
            ->get()->unique('id')->map(function ($list) use ($language) {
                return HelperController::formatListForApi($list, $language->id);
            });



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

        // $information['listingQuery'] = $listingQuery;
        $information['listing_contents'] = $listing_contents;
        $information['featured_contents'] = $featured_contents;
        $information['perPage'] = $perPage;
        $information['listingbs'] = $bs;


        $allCategories = ListingCategory::forLanguage($language->id)->active()
            ->orderBy('serial_number', 'asc')->paginate(10);

        $information['categories'] = $allCategories;

        $information['vendors'] = Vendor::join('memberships', 'vendors.id', '=', 'memberships.vendor_id')
            ->where([
                ['memberships.status', '=', 1],
                ['memberships.start_date', '<=', Carbon::now()->format('Y-m-d')],
                ['memberships.expire_date', '>=', Carbon::now()->format('Y-m-d')]
            ])
            ->get();


        $information['aminites'] = Aminite::where('language_id', $language->id)
            ->orderBy('updated_at', 'asc')->get();

        $information['countries'] = Country::forLanguage($language->id)
            ->orderBy('id', 'asc')->get();

        $information['states'] = State::forLanguage($language->id)
            ->orderBy('id', 'asc')->get();

        if ($request->city) {
            $searchCity = City::forLanguage($language->id)->where('id', $request->city)->first();

            if ($searchCity) {
                $information['searchCity'] = $searchCity->getName($language->id);
            }
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


        return response()->json([
            'success' => true,
            'data' => $information
        ], 200);
    }
    public function details(Request $request, $slug, $id)
    {
        $language = HelperController::getLanguage($request);
        $vendorId = Listing::where('id', $id)->pluck('vendor_id')->first();


        $listing = Listing::join('listing_contents', 'listings.id', '=', 'listing_contents.listing_id')
            ->leftJoin('listing_categories', 'listing_categories.id', '=', 'listing_contents.category_id')
            ->leftJoin('country_contents', function ($join) use ($language) {
                $join->on('country_contents.country_id', '=', 'listing_contents.country_id')
                    ->where('country_contents.language_id', $language->id);
            })
            ->leftJoin('state_contents', function ($join) use ($language) {
                $join->on('state_contents.state_id', '=', 'listing_contents.state_id')
                    ->where('state_contents.language_id', $language->id);
            })
            ->leftJoin('city_contents', function ($join) use ($language) {
                $join->on('city_contents.city_id', '=', 'listing_contents.city_id')
                    ->where('city_contents.language_id', $language->id);
            })
            ->where('listing_contents.language_id', $language->id)
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

            ->select(
                'listings.*',
                'listing_contents.slug as slug',
                'listing_contents.title as title',
                'listing_contents.summary as summary',
                'listing_contents.address as address',
                'listing_contents.description as description',
                'country_contents.name as country_name',
                'state_contents.name as state_name',
                'city_contents.name as city_name',
                'listing_categories.name as category_name',
                'listing_categories.icon as category_icon',
                'listing_categories.slug as category_slug'
            )
            ->where('listings.id', $id)
            ->first();
        if (is_null($listing)) {
            return response()->json([
                'success' => false,
                'message' => 'Listing not found'
            ], 404);
        }

        $listing->feature_image = HelperController::getImagePath('assets/img/listing/', $listing->feature_image);

        $listing->video_background_image = HelperController::getImagePath('assets/img/listing/video/', $listing->video_background_image);

        $vendor_id = $listing->vendor_id;
        $information['listing'] = $listing;

        //listing images and social links
        $information['listingImages'] = ListingImage::Where('listing_id', $id)->get()->map(function ($image) {
            return [
                'id' => $image->id,
                'image' => HelperController::getImagePath('assets/img/listing-gallery/', $image->image),
            ];
        });

        $information['socialLinks'] = ListingSocialMedia::where('listing_id', $id)->get()->map(function ($social) {
            return [
                'id' => $social->id,
                'link' => $social->link,
                'icon' => $social->icon,
            ];
        });

        $information['businessHours'] = BusinessHour::query()->where('listing_id', '=', $id)->orderBy('id')->get()->map(function ($hour) {
            return [
                'day' => $hour->day,
                'start_time' => $hour->start_time,
                'end_time' => $hour->end_time,
                'is_closed' => $hour->holiday == 0 ? true : false,
            ];
        });


        if ($vendorId == 0) {
            $information['vendor'] = HelperController::formatVendorForApi($vendor_id, $language->id, 'admin');
        } else {
            $information['vendor'] = HelperController::formatVendorForApi($vendor_id, $language->id, 'vendor');
        }

        $reviews = ListingReview::query()->where('listing_id', '=', $id)->orderByDesc('id')->get();

        $reviews = $reviews->map(function ($review) {
            $user = $review->userInfo()->select('id', 'name', 'username', 'image')->first();

            return [
                'id'         => $review->id,
                'rating'     => $review->rating,
                'review'     => $review->review,
                'created_at' => $review->created_at->toDateTimeString(),
                'updated_at' => $review->updated_at->toDateTimeString(),
                'user'       => [
                    'name'     => $user->name ?? null,
                    'username' => $user->username ?? null,
                    'image'    => $user?->image ? asset('assets/img/users/' . $user->image) : null,
                ],
            ];
        });


        $information['reviews'] = $reviews;
        $numOfReview = count($reviews);
        $information['numOfReview'] = $numOfReview;

        $information['faqs'] = ListingFaq::where('listing_id', $id)
            ->where('language_id', $language->id)
            ->orderBy('serial_number', 'asc')
            ->get()->map(function ($faq) {
                return [
                    'question' => $faq->question,
                    'answer' => $faq->answer,
                ];
            });

        $listing_aminites =   $listing->listing_content->first()->aminities ??  [];
        $information['aminities'] = Aminite::where('language_id', $language->id)->get()->filter(function ($item) use ($listing_aminites) {
            return in_array($item->id, json_decode($listing_aminites));
        });

        $information['listing_features'] = ListingFeature::join(
            'listing_feature_contents',
            'listing_features.id',
            '=',
            'listing_feature_contents.listing_feature_id'
        )
            ->where('listing_id', $id)
            ->where('listing_feature_contents.language_id', $language->id)
            ->get()->map(function ($item) {
                $item->feature_value = !empty($item->feature_value) ?  json_decode($item->feature_value) : [];
                return $item;
            });

        $product_contents = Product::join('product_contents', 'products.id', '=', 'product_contents.product_id')
            ->where('products.status', '=', 'show')
            ->where('products.placement_type', '!=', 1)
            ->where('product_contents.language_id', '=', $language->id)
            ->select(
                'products.id',
                'products.featured_image',
                'products.average_rating',
                'product_contents.title',
                'product_contents.slug',
                'products.current_price',
                'products.previous_price',
                'products.product_type',
                'products.stock',
                'products.placement_type'
            )
            ->get()->map(function ($item) use ($language) {
                return  HelperController::formetProductForApi($item, $language->id);
            });

        $information['product_contents'] = $product_contents;
        $information['currencyInfo'] = $this->getCurrencyInfo();

        return response()->json([
            'success' => true,
            'data' => $information
        ]);
    }

    public function storeReview(Request $request, $id)
    {

        // Define the validation rules
        $rules = [
            'rating' => 'required'
        ];
        // Create a validator instance
        $validator = Validator::make($request->all(), $rules);

        // Check if validation fails
        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        $user = Auth::guard('sanctum')->user();

        if ($user) {
            $review = ListingReview::updateOrCreate(
                ['user_id' => $user->id, 'listing_id' => $id],
                ['review' => $request->review, 'rating' => $request->rating]
            );
            if ($review->wasRecentlyCreated) {
                $listing = Listing::find($id);
                VendorNotificationService::send(
                    $listing?->vendor,
                    'vendor_listing_review_received',
                    'New listing review',
                    'You received a new review on one of your listings.',
                    [
                        'listing_id' => $id,
                        'review_id' => $review->id,
                    ]
                );
            }

            // now, get the average rating of this product
            $reviews = ListingReview::where('listing_id', $id)->get();

            $totalRating = 0;

            foreach ($reviews as $review) {
                $totalRating += $review->rating;
            }

            $numOfReview = count($reviews);

            $averageRating = $totalRating / $numOfReview;

            // finally, store the average rating of this Listing
            Listing::find($id)->update(['average_rating' => $averageRating]);

            return response()->json([
                'success' => true,
                'message' =>  __('Your review submitted successfully')
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'message' => __('You have to Login First!')
            ], 422);
        }
    }

    public function contact(Request $request)
    {
        // Define the validation rules
        $rules = [
            'name' => 'required',
            'email' => 'required|email',
            'phone' => 'required',
            'message' => 'required',
            'listing_id' => 'required',
        ];
        // Create a validator instance
        $validator = Validator::make($request->all(), $rules);

        // Check if validation fails
        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 422);
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
        $be = Basic::select('smtp_status', 'smtp_host', 'smtp_port', 'encryption', 'smtp_username', 'smtp_password', 'from_mail', 'from_name', 'to_mail', 'website_title')->firstOrFail();
        $misc = new MiscellaneousController();
        $language = $misc->getLanguage();

        $listing = Listing::with(['listing_content' => function ($query) use ($language) {
            return $query->where('language_id', $language->id);
        }])->where('id', $request->listing_id)->first();

        $listing_name = $listing->listing_content[0]->title;
        $slug = $listing->listing_content[0]->slug;
        $url = route('frontend.listing.details', ['slug' => $slug, 'id' => $listing->id]);
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
                    return response()->json([
                        'success' => false,
                        'message' =>  $e->getMessage()
                    ], 422);
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

                return response()->json([
                    'success' => true,
                    'message' =>  __('Message sent successfully')
                ], 200);
            } catch (Exception $e) {
                return response()->json([
                    'success' => false,
                    'message' => $e->getMessage()
                ], 422);
            }
        }
    }

    public function productContact(Request $request)
    {
        // Base validation rules
        $rules = [
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'email'],
            'product_id' => ['required', 'integer'],
            'vendor_id' => ['nullable', 'integer'],
        ];

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


        // if ($info->google_recaptcha_status == 1) {
        //     $rules['g-recaptcha-response'] = ['required', 'captcha'];
        // }

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
            return response()->json([
                'success' => false,
                'errors'  => $validator->errors()
            ], 422);
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
                $url = route('frontend.listing.details', ['slug' => $slug, 'id' => $listing->id]);
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
                return response()->json([
                    'success' => false,
                    'message' =>  $e->getMessage()
                ], 200);
            }

            try {
                Mail::send([], [], function ($message) use ($send_email_address, $body, $be, $product_title) {
                    $message->to($send_email_address)
                        ->subject('Inquiry about ' . $product_title)
                        ->from($be->from_mail, $be->from_name)
                        ->html($body);
                });

                return response()->json([
                    'success' => true,
                    'message' =>  __('Message sent successfully')
                ], 200);
            } catch (\Exception $e) {

                return response()->json([
                    'success' => false,
                    'message' =>  __('Sending email failed.')
                ], 200);
            }
        }
    }

    public function getState(Request $request)
    {
        $language = HelperController::getLanguage($request);
        $rules = [
            'country_id' => 'required',
        ];
        // Create a validator instance
        $validator = Validator::make($request->all(), $rules);
        // Check if validation fails
        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        $data = [];

        $data['states'] = State::forLanguage($language->id)
            ->where('country_id', $request->country_id)
            ->get();

        $data['cities'] = City::forLanguage($language->id)
            ->where('country_id', $request->country_id)
            ->get();

        return response()->json([
            'success' => true,
            'data' => $data
        ], 200);
    }

    public function getCity(Request $request)
    {
        $language = HelperController::getLanguage($request);
        $rules = [
            'state_id' => 'required',
        ];
        // Create a validator instance
        $validator = Validator::make($request->all(), $rules);
        // Check if validation fails
        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        $data['cities'] = City::forLanguage($language->id)
            ->where('state_id', $request->state_id)
            ->get();

        return response()->json([
            'success' => true,
            'data' => $data
        ], 200);
    }


}
