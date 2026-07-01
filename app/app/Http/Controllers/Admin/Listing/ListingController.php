<?php

namespace App\Http\Controllers\Admin\Listing;

use App\Http\Controllers\Controller;
use App\Http\Helpers\VendorPermissionHelper;
use App\Http\Requests\Listing\ListingStoreRequest;
use App\Http\Requests\Listing\ListingUpdateRequest;
use App\Models\BasicSettings\Basic;
use App\Models\BusinessHour;
use App\Models\ClaimListing;
use App\Models\FeaturedListingCharge;
use App\Models\FeatureOrder;
use App\Models\Language;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingContent;
use App\Models\Listing\ListingFeature;
use App\Models\Listing\ListingFeatureContent;
use App\Models\Listing\ListingImage;
use App\Models\Listing\ListingMessage;
use App\Models\Listing\ListingProduct;
use App\Models\Listing\ListingReview;
use App\Models\Listing\ListingSocialMedia;
use App\Models\Listing\ProductMessage;
use App\Models\ListingCategory;
use App\Models\ListingCategoryContent;
use App\Models\Location\City;
use App\Models\Location\Country;
use App\Models\Location\State;
use App\Models\PaymentGateway\OfflineGateway;
use App\Models\PaymentGateway\OnlineGateway;
use App\Models\Vendor;
use App\Models\Visitor;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Mews\Purifier\Facades\Purifier;
use App\Services\VendorNotificationService;

class ListingController extends Controller
{
    public function settings()
    {
        $info = DB::table('basic_settings')->select('listing_view', 'admin_approve_status', 'time_format', 'redeem_token_expire_days')->first();
        return view('admin.listing.settings', ['info' => $info]);
    }

    public function getSearchCity(Request $request)
    {
        $search = $request->input('search');
        $page = $request->input('page', 1);
        $pageSize = 10;

        $language = Language::where('code', $request->lang)->first();

        $query = City::whereHas('contents', fn($q) => $q->where('language_id', $language->id));

        if ($search) {
            $query->whereHas('contents', fn($q) => $q->where('language_id', $language->id)->where('name', 'like', "%{$search}%"));
        }

        $cities = $query->skip(($page - 1) * $pageSize)
            ->take($pageSize + 1)
            ->get();

        $hasMore = count($cities) > $pageSize;
        $results = $hasMore ? $cities->slice(0, $pageSize) : $cities;

        $results = $results->map(function ($city) use ($language) {
            return [
                'id' => $city->id,
                'name' => $city->getName($language->id),
            ];
        });

        return response()->json([
            'results' => $results,
            'more' => $hasMore
        ]);
    }

    public function homeCategories(Request $request)
    {
        $search = $request->input('search');
        $page = $request->input('page', 1);
        $pageSize = 10;

        $language = Language::where('code', $request->lang)->first();

        $query = ListingCategory::whereHas('contents', function ($q) use ($language) {
            $q->where('language_id', $language->id)
              ->whereNotNull('name')
              ->where('name', '!=', '');
        })->with(['contents' => function ($q) use ($language) {
            $q->where('language_id', $language->id);
        }]);

        if ($search) {
            $query->whereHas('contents', function ($q) use ($language, $search) {
                $q->where('language_id', $language->id)
                  ->where('name', 'like', "%{$search}%");
            });
        }

        $categories = $query->skip(($page - 1) * $pageSize)
            ->take($pageSize + 1)
            ->get();

        $hasMore = $categories->count() > $pageSize;
        $results = $hasMore ? $categories->slice(0, $pageSize) : $categories;

        $results = $results->map(function ($category) {
            return [
                'id' => $category->id,
                'name' => $category->contents->first()?->name ?? $category->name,
            ];
        });

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

        $language = Language::where('code', $request->lang)->first();

        $query = State::whereHas('contents', fn($q) => $q->where('language_id', $language->id));

        if ($search) {
            $query->whereHas('contents', fn($q) => $q->where('language_id', $language->id)->where('name', 'like', "%{$search}%"));
        }

        $states = $query->skip(($page - 1) * $pageSize)
            ->take($pageSize + 1)
            ->get();

        $hasMore = count($states) > $pageSize;
        $results = $hasMore ? $states->slice(0, $pageSize) : $states;

        $results = $results->map(function ($state) use ($language) {
            return [
                'id' => $state->id,
                'name' => $state->getName($language->id),
            ];
        });

        return response()->json([
            'results' => $results,
            'more' => $hasMore
        ]);
    }

    public function getCountry(Request $request)
    {
        $search = $request->input('search');
        $page = $request->input('page', 1);
        $pageSize = 10;

        $language = Language::where('code', $request->lang)->first();

        $query = Country::whereHas('contents', fn($q) => $q->where('language_id', $language->id));

        if ($search) {
            $query->whereHas('contents', fn($q) => $q->where('language_id', $language->id)->where('name', 'like', "%{$search}%"));
        }

        $countries = $query->skip(($page - 1) * $pageSize)
            ->take($pageSize + 1)
            ->get();

        $hasMore = count($countries) > $pageSize;
        $results = $hasMore ? $countries->slice(0, $pageSize) : $countries;

        $results = $results->map(function ($country) use ($language) {
            return [
                'id' => $country->id,
                'name' => $country->getName($language->id),
            ];
        });

        return response()->json([
            'results' => $results,
            'more' => $hasMore
        ]);
    }

    public function updateSettings(Request $request)
    {

        $rules = [
            'listing_view' => 'required|numeric',
            'time_format' => 'required|numeric',
            'admin_approve_status' => 'required|numeric',
            'redeem_token_expire_days' => 'required|integer|min:1|max:365',
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator->errors())->withInput();
        }

        // store the tax amount info into db
        DB::table('basic_settings')->updateOrInsert(
            ['uniqid' => 12345],
            [
                'listing_view' => $request->listing_view,
                'admin_approve_status' => $request->admin_approve_status,
                'time_format' => $request->time_format,
                'redeem_token_expire_days' => (int) $request->redeem_token_expire_days,
            ]
        );

        Session::flash('success', __('Updated Listing settings successfully') . '!');

        return redirect()->back();
    }

    public function index(Request $request)
    {
        $information['currencyInfo'] = $this->getCurrencyInfo();
        $information['langs'] = Language::all();

        if ($request->language) {
            $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        } else {
            $language = Language::where('is_default', 1)->first();
        }
        $information['language'] = $language;

        $language_id = $language->id;
        $status = $vendor_id = $title = $category = $featured =  null;

        if (request()->filled('status') && request()->input('status') !== "All") {
            $status = request()->input('status');
        }


        $category_listingIds = [];
        if ($request->filled('category') && $request->input('category') !== "All") {
            $slug = $request->input('category');
            $categoryContent = ListingCategoryContent::where('language_id', $language->id)
                ->where('slug', $slug)
                ->first();

            if ($categoryContent) {
                $contents = ListingContent::where('language_id', $language->id)
                    ->where('category_id', $categoryContent->listing_category_id)
                    ->get()
                    ->pluck('listing_id');
                foreach ($contents as $content) {
                    if (!in_array($content, $category_listingIds)) {
                        array_push($category_listingIds, $content);
                    }
                }
                $category = true;
            }
        }
        $featured_listingIds = [];
        if ($request->filled('featured') && $request->input('featured') !== "All") {
            $featured = $request->input('featured');

            if ($featured == 'active') {
                $contents = FeatureOrder::where('order_status', '=', 'completed')
                    ->where('payment_status', '=', 'completed')
                    ->whereDate('end_date', '>=', Carbon::now()->format('Y-m-d'))
                    ->get()
                    ->pluck('listing_id');
                foreach ($contents as $content) {
                    if (!in_array($content, $featured_listingIds)) {
                        array_push($featured_listingIds, $content);
                    }
                }
            }
            if ($featured == 'pending') {
                $contents = FeatureOrder::where('order_status', '=', 'pending')
                    ->get()
                    ->pluck('listing_id');
                foreach ($contents as $content) {
                    if (!in_array($content, $featured_listingIds)) {
                        array_push($featured_listingIds, $content);
                    }
                }
            }
            if ($featured == 'rejected') {
                $contents = FeatureOrder::where('order_status', '=', 'pending')
                    ->get()
                    ->pluck('listing_id');
                foreach ($contents as $content) {
                    if (!in_array($content, $featured_listingIds)) {
                        array_push($featured_listingIds, $content);
                    }
                }
                $contentss = FeatureOrder::where('order_status', '=', 'completed')
                    ->where('payment_status', '=', 'completed')
                    ->whereDate('end_date', '>=', Carbon::now()->format('Y-m-d'))
                    ->get()
                    ->pluck('listing_id');
                foreach ($contentss as $conten) {
                    if (!in_array($conten, $featured_listingIds)) {
                        array_push($featured_listingIds, $conten);
                    }
                }
            }
        }

        if (request()->filled('vendor_id') && request()->input('vendor_id') !== "All") {
            $vendor_id = request()->input('vendor_id');
        }

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

        $information['listings'] = Listing::with([
            'listing_content' => function ($q) use ($language_id) {
                $q->where('language_id', $language_id);
            },
            'listing_content.category.contents',
            'listing_content_all' => fn($q) => $q->with('language'),
        ])
            ->when($category, function ($query) use ($category_listingIds) {

                return $query->whereIn('listings.id', $category_listingIds);
            })
            ->when($featured, function ($query) use ($featured_listingIds, $featured) {
                if ($featured !== 'rejected') {
                    return $query->whereIn('listings.id', $featured_listingIds);
                } else {
                    return $query->whereNotIn('listings.id', $featured_listingIds);
                }
            })
            ->when($status, function ($query) use ($status) {

                if ($status === 'approved') {
                    return $query->where('status', 1);
                } elseif ($status === 'pending') {
                    return $query->where('status', 0);
                } else {
                    return $query->where('status', 2);
                }
            })
            ->when($vendor_id, function ($query) use ($vendor_id) {
                if ($vendor_id === 'admin') {
                    return $query->where('vendor_id', '0');
                } else {
                    return $query->where('vendor_id', $vendor_id);
                }
            })
            ->when($title, function ($query) use ($listingIds) {
                return $query->whereIn('listings.id', $listingIds);
            })
            ->orderBy('listings.id', 'desc')
            ->paginate(10);
          

        $information['categories'] = ListingCategory::forLanguage($language_id)->with('contents')->get();


        // hhhhhhhhhhhhhhhh
        $information['onlineGateways'] = OnlineGateway::where('status', 1)->get();

        $information['offline_gateways'] = OfflineGateway::where('status', 1)->orderBy('serial_number', 'asc')->get();

        $information['vendors'] = Vendor::where('id', '!=', 0)->get();
        $charges = FeaturedListingCharge::orderBy('days')->get();
        $information['charges'] = $charges;
        return view('admin.listing.index', $information);
    }
    public function create($id)
    {
        if ($id != 0) {
            $package = VendorPermissionHelper::packagePermission($id);
            if ($package != '[]') {

                $information = [];
                $languages = Language::get();
                $information['languages'] = $languages;
                $information['vendor_id'] = $id;
                return view('admin.listing.create', $information);
            } else {

                Session::flash('warning', __('This vendor doesn\'t have a membership') . '!');
                return redirect()->route('admin.listing_management.select_vendor');
            }
        } else {
            $information = [];
            $languages = Language::get();
            $information['languages'] = $languages;
            $information['vendor_id'] = $id;

            return view('admin.listing.create', $information);
        }
    }

    public function selectVendor()
    {
        $information = [];
        $languages = Language::get();
        $information['languages'] = $languages;
        $information['vendors'] = Vendor::join('memberships', 'vendors.id', '=', 'memberships.vendor_id')
            ->where([
                ['memberships.status', '=', 1],
                ['memberships.start_date', '<=', Carbon::now()->format('Y-m-d')],
                ['memberships.expire_date', '>=', Carbon::now()->format('Y-m-d')]
            ])
            ->select('vendors.id', 'vendors.username')
            ->get();
        return view('admin.listing.select-vendor', $information);
    }
    public function findVendor(Request $request)
    {
        return redirect()->route('admin.listing_management.create_listing', ['vendor_id' => $request->vendor_id ?? 0]);
    }

    public function imagesstore(Request $request)
    {
        $img = $request->file('file');
        $allowedExts = array('jpg', 'png', 'jpeg', 'svg', 'webp');
        $rules = [
            'file' => [
                function ($attribute, $value, $fail) use ($img, $allowedExts) {
                    $ext = $img->getClientOriginalExtension();
                    if (!in_array($ext, $allowedExts)) {
                        return $fail("Only png, jpg, jpeg images are allowed");
                    }
                },
            ]
        ];
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            $validator->getMessageBag()->add('error', 'true');
            return response()->json($validator->errors());
        }
        $filename = uniqid() . '.jpg';

        $directory = public_path('assets/img/listing-gallery/');
        @mkdir($directory, 0775, true);
        $img->move($directory, $filename);

        $pi = new ListingImage();
        $pi->image = $filename;
        $pi->save();
        return response()->json(['status' => 'success', 'file_id' => $pi->id]);
    }
    public function imagermv(Request $request)
    {
        $pi = ListingImage::findOrFail($request->fileid);
        $image_count = ListingImage::where('listing_id', $pi->listing_id)->get()->count();
        if ($image_count > 1) {
            @unlink(public_path('assets/img/listing-gallery/') . $pi->image);
            $pi->delete();
            return $pi->id;
        } else {
            return 'false';
        }
    }
    public function imagedbrmv(Request $request)
    {
        $pi = ListingImage::findOrFail($request->fileid);
        $image_count = ListingImage::where('listing_id', $pi->listing_id)->get()->count();
        if ($image_count > 1) {
            @unlink(public_path('assets/img/listing-gallery/') . $pi->image);
            $pi->delete();
            Session::flash('success', __('Slider image deleted successfully') . '!');

            return Response::json(['status' => 'success'], 200);
        } else {
            Session::flash('warning', __('You can\'t delete all images') . '!');

            return Response::json(['status' => 'success'], 200);
        }
    }

    public function getState(Request $request)
    {
        $language = Language::where('code', $request->lang)->first();

        if ($language) {
            $states = State::forLanguage($language->id)
                ->where('country_id', $request->id)
                ->get();
            $cities = City::forLanguage($language->id)
                ->where('country_id', $request->id)
                ->get();

            $data['states'] = $states->map(function ($state) use ($language) {
                return [
                    'id' => $state->id,
                    'name' => $state->getName($language->id),
                ];
            });

            $data['cities'] = $cities->map(function ($city) use ($language) {
                return [
                    'id' => $city->id,
                    'name' => $city->getName($language->id),
                ];
            });
        } else {
            $data['states'] = [];
            $data['cities'] = [];
        }

        return $data;
    }
    public function getVideo(Request $request)
    {
        return view('admin.listing.video')->render();
    }

    public function getCity(Request $request)
    {
        $language = Language::where('code', $request->lang)->first();

        if ($language) {
            $data = City::forLanguage($language->id)
                ->where('state_id', $request->id)
                ->get()
                ->map(function ($city) use ($language) {
                    return [
                        'id' => $city->id,
                        'name' => $city->getName($language->id),
                    ];
                });
        } else {
            $data = [];
        }

        return $data;
    }

    public function store(ListingStoreRequest $request)
    {
        if ($request->can_listing_add == 2) {

            Session::flash('warning', __('Listings limit reached or exceeded') . '!');

            return Response::json(['status' => 'success'], 200);
        } elseif ($request->can_listing_add == 1) {

            DB::transaction(function () use ($request) {

                $featuredImgURL = $request->feature_image;
                $videoImgURL = $request->video_background_image;

                $languages = Language::all();

                $in = $request->all();
                if ($featuredImgURL) {
                    $featuredImgExt = $featuredImgURL->getClientOriginalExtension();
                    // set a name for the featured image and store it to local storage
                    $featuredImgName = time() . '.' . $featuredImgExt;
                    $featuredDir = public_path('assets/img/listing/');

                    if (!file_exists($featuredDir)) {
                        @mkdir($featuredDir, 0777, true);
                    }
                    copy($featuredImgURL, $featuredDir . $featuredImgName);
                    $in['feature_image'] = $featuredImgName;
                }

                if ($videoImgURL) {
                    $videoImgExt = $videoImgURL->getClientOriginalExtension();
                    // set a name for the featured image and store it to local storage
                    $videoImgName = time() . '.' . $videoImgExt;
                    $videoDir = public_path('assets/img/listing/video/');

                    if (!file_exists($videoDir)) {
                        @mkdir($videoDir, 0777, true);
                    }
                    copy($videoImgURL, $videoDir . $videoImgName);
                    $in['video_background_image'] = $videoImgName;
                }
                $videoLink = $request->video_url;
                if ($videoLink) {
                    if (strpos($videoLink, "&") != false) {
                        $videoLink = substr($videoLink, 0, strpos($videoLink, "&"));
                    }
                    $in['video_url'] = $videoLink;
                }

                $listing = Listing::create($in);

                $listing->translated_languages = '{}';
                $listing->save();

                $siders = $request->slider_images;
                if ($siders) {
                    $pis = ListingImage::findOrFail($siders);

                    foreach ($pis as $key => $pi) {
                        $pi->listing_id = $listing->id;
                        $pi->save();
                    }
                }

                foreach ($languages as $language) {
                    $title = $request[$language->code . '_title'];
                    if (empty($title)) {
                        continue;
                    }

                    $listingContent = new ListingContent();

                    $listingContent->language_id = $language->id;
                    $listingContent->listing_id = $listing->id;
                    $listingContent->title = $title;
                    $listingContent->slug = Str::slug($request['en_title'] ?: $title);
                    $listingContent->category_id = $request->category_id;
                    $listingContent->country_id = $request->country_id;
                    $listingContent->state_id = $request->state_id;
                    $listingContent->city_id = $request->city_id;
                    $listingContent->address = $request[$language->code . '_address'];

                    $listingContent->summary = $request[$language->code . '_summary'];
                    $listingContent->description = Purifier::clean($request[$language->code . '_description'], 'youtube');
                    $listingContent->meta_keyword = $request[$language->code . '_meta_keyword'];
                    $listingContent->meta_description = $request[$language->code . '_meta_description'];


                    $listingContent->save();
                }

                $aminities = $request->input('aminities', []);
                foreach ($languages as $lang) {
                    $lc = ListingContent::where('listing_id', $listing->id)->where('language_id', $lang->id)->first();
                    if ($lc) {
                        $lc->aminities = json_encode($aminities);
                        $lc->save();
                    }
                }

                $days = ['Saturday', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
                foreach ($days as $day) {
                    $businessHours = new BusinessHour();

                    $businessHours->listing_id = $listing->id;
                    $businessHours->day = $day;
                    $businessHours->start_time = "10:00 AM";
                    $businessHours->end_time = "07:00 PM";
                    $businessHours->holiday = 1;

                    $businessHours->save();
                }
            });
            Session::flash('success', __('New Listing added successfully') . '!');

            return Response::json(['status' => 'success'], 200);
        } else {
            Session::flash('success', __('This vendor hasn\'t purchased a plan') . '!');

            return Response::json(['status' => 'error'], 200);
        }
    }
    public function updateStatus(Request $request)
    {
        $listing = Listing::findOrFail($request->listingId);

        if ($request->status == 1) {
            $listing->update(['status' => 1]);
            $message = 'Your listing has been approved by admin.';

            Session::flash('success', __('Listing Approved successfully') . '!');
        } elseif ($request->status == 2) {
            $listing->update(['status' => 2]);
            $message = 'Your listing has been rejected by admin.';

            Session::flash('success', __('Listing Rejected successfully') . '!');
        } else {
            $listing->update(['status' => 0]);
            $message = 'Your listing status has been moved to pending review.';
            Session::flash('success', __('Listing Pending successfully') . '!');
        }

        VendorNotificationService::send(
            $listing->vendor,
            'vendor_listing_status_updated',
            'Listing status updated',
            $message,
            [
                'listing_id' => $listing->id,
                'status' => $listing->status,
            ]
        );

        return redirect()->back();
    }
    public function updateVisibility(Request $request)
    {
        $listing = Listing::findOrFail($request->listingId);

        if ($request->visibility == 1) {
            $listing->update(['visibility' => 1]);

            Session::flash('success', __('Listing Show successfully') . '!');
        }
        if ($request->visibility == 0) {
            $listing->update(['visibility' => 0]);

            Session::flash('success', __('Listing Hide successfully') . '!');
        }

        return redirect()->back();
    }

    public function updateFeatured(Request $request)
    {
        $rules = [
            'charge' => 'required',
        ];

        $message = [
            'charge.required' => 'The charge field is required.'
        ];

        $validator = Validator::make($request->all(), $rules, $message);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()
            ], 400);
        }

        if (!$request->exists('charge')) {

            $errorMessageKey = "select_days_" . $request->listing_id;
            Session::flash($errorMessageKey,  __('Please select promotion list') . '!');
            return redirect()->back()->withInput();
        }
        $gatewayId = $request->gateway;
        $offlineGateway = OfflineGateway::query()->find($gatewayId);
        $chargeID = $request->charge;
        $charge = FeaturedListingCharge::findorfail($chargeID);
        $startDate = Carbon::now()->startOfDay();
        $endDate = $startDate->copy()->addDays($charge->days);

        $vendor_id = Listing::where('id', $request->listing_id)->pluck('vendor_id')->first();

        $be = Basic::select('to_mail')->firstOrFail();
        if ($vendor_id != 0) {
            $vendor = Vendor::where('id', $vendor_id)->select('to_mail', 'username', 'email')->first();

            if (isset($vendor->to_mail)) {
                $to_mail = $vendor->to_mail;
            } else {
                $to_mail = $vendor->email;
            }
        } else {
            $to_mail = $be->to_mail;
        }

        $order =  FeatureOrder::where('listing_id', $request->listing_id)->first();
        if (empty($order)) {
            $order = new FeatureOrder();
        }

        $order->listing_id = $request->listing_id;
        $order->vendor_id = $vendor_id;
        $order->vendor_mail = $to_mail;
        $order->order_number = uniqid();
        $order->total = $charge->price;
        $order->payment_method = $offlineGateway ? $offlineGateway->name : $gatewayId;
        $order->gateway_type = "offline";
        $order->payment_status = "completed";
        $order->order_status = 'completed';
        $order->attachment = null;
        $order->days = $charge->days;
        $order->start_date = $startDate;
        $order->end_date = $endDate;
        $order->save();

        Session::flash('success', __('Listing Featured successfully') . '!');
        return  redirect()->back();
    }

    public function edit($id)
    {
        $vendorId = Listing::where('id', $id)->pluck('vendor_id')->first();
        $defaultLang = Language::query()->where('is_default', 1)->first();
        if ($vendorId != 0) {
            $current_package = VendorPermissionHelper::packagePermission($vendorId);

            if ($current_package != '[]') {
                $listing = Listing::with('galleries')->findOrFail($id);
                $information['listing'] = $listing;
                $information['languages'] = Language::all();
                $information['vendors'] = Vendor::get();
                $information['listingAddress'] = ListingContent::where([
                    ['language_id', $defaultLang->id],
                    [
                        'listing_id',
                        $id
                    ]
                ])->pluck('address')->first();

                return view('admin.listing.edit', $information);
            } else {

                Session::flash('warning', __('This vendor has not a plan') . '!');
                return redirect()->route('admin.listing_management.listings');
            }
        } else {
            $listing = Listing::with('galleries')->findOrFail($id);
            $information['listing'] = $listing;
            $information['languages'] = Language::all();
            $information['vendors'] = Vendor::get();
            $information['listingAddress'] = ListingContent::where([
                ['language_id', $defaultLang->id],
                [
                    'listing_id',
                    $id
                ]
            ])->pluck('address')->first();

            return view('admin.listing.edit', $information);
        }
    }

    public function videoImageRemove($id)
    {

        $Listing = Listing::Where('id', $id)->first();
        $Listing->video_background_image = null;

        $Listing->save();

        Session::flash('success', __('Successfully Delete Video Image') . '!');

        return Response::json(['status' => 'success'], 200);
    }

    public function update(ListingUpdateRequest $request, $id)
    {
        $featuredImgURL = $request->thumbnail;
        $videoImgURL = $request->video_background_image;

        $allowedExts = array('jpg', 'png', 'jpeg', 'svg');
        if ($request->hasFile('thumbnail')) {
            $rules['thumbnail'] = [
                'required',
                function ($attribute, $value, $fail) use ($featuredImgURL, $allowedExts) {
                    $ext = $featuredImgURL->getClientOriginalExtension();
                    if (!in_array($ext, $allowedExts)) {
                        return $fail("Only png, jpg, jpeg images are allowed");
                    }
                },
            ];
        }

        if ($request->hasFile('video_background_image')) {
            $rules['video_background_image'] = [
                'required',
                function ($attribute, $value, $fail) use ($featuredImgURL, $allowedExts) {
                    $ext = $featuredImgURL->getClientOriginalExtension();
                    if (!in_array($ext, $allowedExts)) {
                        return $fail("Only png, jpg, jpeg images are allowed");
                    }
                },
            ];
        }

        $languages = Language::all();

        $in = $request->all();
        $listing = Listing::findOrFail($request->listing_id);
        if ($request->hasFile('thumbnail')) {
            $featuredImgExt = $featuredImgURL->getClientOriginalExtension();

            $featuredImgName = time() . '.' . $featuredImgExt;
            $featuredDir = public_path('assets/img/listing/');

            if (!file_exists($featuredDir)) {
                mkdir($featuredDir, 0777, true);
            }
            copy($featuredImgURL, $featuredDir . $featuredImgName);
            @unlink(public_path('assets/img/listing/') . $listing->feature_image);

            $in['feature_image'] = $featuredImgName;
        }

        if ($request->hasFile('video_background_image')) {
            $videoImgExt = $videoImgURL->getClientOriginalExtension();

            $videoImgName = time() . '.' . $videoImgExt;
            $videoDir = public_path('assets/img/listing/video/');

            if (!file_exists($videoDir)) {
                mkdir($videoDir, 0777, true);
            }
            copy($videoImgURL, $videoDir . $videoImgName);
            @unlink(public_path('assets/img/listing/video/') . $listing->video_background_image);

            $in['video_background_image'] = $videoImgName;
        }
        $videoLink = $request->video_url;
        if ($videoLink) {
            if (strpos($videoLink, "&") != false) {
                $videoLink = substr($videoLink, 0, strpos($videoLink, "&"));
            }
            $in['video_url'] = $videoLink;
        }

        $listing = $listing->update($in);

        $slders = $request->slider_images;
        if ($slders) {
            $pis = ListingImage::findOrFail($slders);
            foreach ($pis as $key => $pi) {
                $pi->listing_id = $request->listing_id;
                $pi->save();
            }
        }

        foreach ($languages as $language) {
            $title = $request[$language->code . '_title'];
            if (empty($title)) {
                continue;
            }

            $listingContent =  ListingContent::where('listing_id', $request->listing_id)->where('language_id', $language->id)->first();
            if (empty($listingContent)) {
                $listingContent = new ListingContent();
            }
            $listingContent->language_id = $language->id;
            $listingContent->title = $title;
            $listingContent->slug = Str::slug($request['en_title'] ?: $title);
            $listingContent->category_id = $request->category_id;
            $listingContent->country_id = $request->country_id;
            $listingContent->state_id = $request->state_id;
            $listingContent->city_id = $request->city_id;
            $listingContent->address = $request[$language->code . '_address'];
                    $listingContent->summary = $request[$language->code . '_summary'];
                    $listingContent->description = Purifier::clean($request[$language->code . '_description'], 'youtube');
                    $listingContent->meta_keyword = $request[$language->code . '_meta_keyword'];
                    $listingContent->meta_description = $request[$language->code . '_meta_description'];


                    $listingContent->save();
                }

                $aminities = $request->input('aminities', []);
                foreach ($languages as $lang) {
                    $lc = ListingContent::where('listing_id', $request->listing_id)->where('language_id', $lang->id)->first();
                    if ($lc) {
                        $lc->aminities = json_encode($aminities);
                        $lc->save();
                    }
                }

                $days = ['Saturday', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
        foreach ($days as $day) {

            $businessHours =  BusinessHour::where('id', $request[$day . '_id'])->first();

            if (empty($businessHours)) {
                $businessHours = new BusinessHour();
            }
            $businessHours->start_time = $request[$day . '_start_time'];
            $businessHours->end_time = $request[$day . '_end_time'];

            $businessHours->save();
        }
        Session::flash('success', __('Business Hours Updated successfully') . '!');
        return back();
    }

    public function delete($id)
    {
        $listing = Listing::findOrFail($id);

        $listing->listing_content()->each(fn($c) => $c->delete());

        if (!is_null($listing->feature_image)) {
            @unlink(public_path('assets/img/listing/') . $listing->feature_image);
        }
        if (!is_null($listing->video_background_image)) {
            @unlink(public_path('assets/img/listing/video/') . $listing->video_background_image);
        }

        $listing->galleries()->each(function ($g) {
            @unlink(public_path('assets/img/listing-gallery/') . $g->image);
            $g->delete();
        });

        $listing->specifications()->each(function ($f) {
            ListingFeatureContent::where('listing_feature_id', $f->id)->each(fn($fc) => $fc->delete());
            $f->delete();
        });

        FeatureOrder::where('listing_id', $id)->each(function ($o) {
            @unlink(public_path('assets/file/attachments/feature-activation/') . $o->attachment);
            @unlink(public_path('assets/file/invoices/listing-feature/') . $o->invoice);
            $o->delete();
        });

        ListingMessage::where('listing_id', $id)->each(fn($m) => $m->delete());
        ListingReview::where('listing_id', $id)->each(fn($r) => $r->delete());
        Visitor::where('listing_id', $id)->each(fn($v) => $v->delete());
        $listing->listingFaqs()->each(fn($f) => $f->delete());
        $listing->sociallinks()->each(fn($s) => $s->delete());
        BusinessHour::where('listing_id', $id)->delete();

        ClaimListing::where('listing_id', $id)->each(function ($claim) {
            if ($claim->information) {
                foreach (json_decode($claim->information, true) ?? [] as $fieldData) {
                    if (($fieldData['type'] ?? null) == 8 && !empty($fieldData['value'])) {
                        @unlink(public_path('assets/file/zip-files/' . $fieldData['value']));
                    }
                }
            }
            $claim->delete();
        });

        ListingProduct::where('listing_id', $id)->each(function ($product) {
            $product->listing_product_content()->each(fn($pc) => $pc->delete());
            @unlink(public_path('assets/img/listing/product/') . $product->feature_image);
            $product->galleries()->each(function ($pg) {
                @unlink(public_path('assets/img/listing/product-gallery/') . $pg->image);
                $pg->delete();
            });
            ProductMessage::where('product_id', $product->id)->each(fn($pm) => $pm->delete());
            $product->delete();
        });

        $listing->delete();

        Session::flash('success', __('Listing deleted successfully') . '!');
        return redirect()->back();
    }

    public function bulkDelete(Request $request)
    {
        $ids = $request->ids;
        foreach ($ids as $id) {
            $listing = Listing::find($id);
            if (!$listing) continue;

            $listing->listing_content()->each(fn($c) => $c->delete());

            if (!is_null($listing->feature_image)) {
                @unlink(public_path('assets/img/listing/') . $listing->feature_image);
            }
            if (!is_null($listing->video_background_image)) {
                @unlink(public_path('assets/img/listing/video/') . $listing->video_background_image);
            }

            $listing->galleries()->each(function ($g) {
                @unlink(public_path('assets/img/listing-gallery/') . $g->image);
                $g->delete();
            });

            FeatureOrder::where('listing_id', $id)->each(fn($o) => $o->delete());
            ListingMessage::where('listing_id', $id)->each(fn($m) => $m->delete());
            ListingReview::where('listing_id', $id)->each(fn($r) => $r->delete());
            Visitor::where('listing_id', $id)->each(fn($v) => $v->delete());
            BusinessHour::where('listing_id', $id)->delete();
            ClaimListing::where('listing_id', $id)->each(fn($c) => $c->delete());
            ListingProduct::where('listing_id', $id)->each(fn($p) => $p->delete());

            $listing->delete();
        }
        Session::flash('success', __('Listings deleted successfully') . '!');
        return Response::json(['status' => 'success'], 200);
    }

    public function plugins($id, Request $request)
    {
        Listing::findOrFail($id);

        $information['title'] = ListingContent::where([['listing_id', $request->listingId], ['language_id', $request->languageId]])->first();
        $information['data'] = DB::table('listings')
            ->where('id', $id)
            ->select('whatsapp_status', 'whatsapp_number', 'whatsapp_header_title', 'whatsapp_popup_status', 'whatsapp_popup_message', 'tawkto_status', 'tawkto_direct_chat_link', 'telegram_status', 'telegram_username', 'messenger_status', 'messenger_direct_chat_link')
            ->first();
        $information['id'] = $id;

        return view('admin.listing.plugins', $information);
    }

    public function businessHours($id)
    {
        Listing::findOrFail($id);

        $information['id'] = $id;
        $information['days'] = BusinessHour::where('listing_id', $id)->get();
        $information['title'] = ListingContent::where('listing_id', $id)->first();

        if ($information['days']->isEmpty()) {
            $dayNames = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];
            foreach ($dayNames as $day) {
                BusinessHour::create([
                    'listing_id' => $id,
                    'day' => $day,
                    'start_time' => '09:00',
                    'end_time' => '18:00',
                ]);
            }
            $information['days'] = BusinessHour::where('listing_id', $id)->get();
        }

        return view('admin.listing.business-hours', $information);
    }

    public function manageSocialLink($id)
    {
        $listing = Listing::findOrFail($id);

        $information['socialLinks'] = $listing->sociallinks;
        $information['id'] = $id;
        $information['listing_id'] = $id;

        return view('admin.listing.social-link', $information);
    }

    public function updateSocialLink(Request $request, $id)
    {
        $rules = [
            'icon' => 'required',
            'url' => 'required|url',
            'serial_number' => 'required|numeric',
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return Response::json(['errors' => $validator->getMessageBag()], 400);
        }

        ListingSocialMedia::updateOrCreate(
            ['id' => $request->social_link_id],
            [
                'listing_id' => $id,
                'icon' => $request->icon,
                'url' => $request->url,
                'serial_number' => $request->serial_number,
            ]
        );

        Session::flash('success', __('Social link updated successfully') . '!');
        return Response::json(['status' => 'success'], 200);
    }

    public function manageAdditionalSpecification($id)
    {
        $listing = Listing::findOrFail($id);

        $information['features'] = $listing->specifications()->get();
        $information['id'] = $id;
        $information['listing_id'] = $id;
        $information['languages'] = Language::all();

        return view('admin.listing.feature', $information);
    }

    public function updateAdditionalSpecification(Request $request, $id)
    {
        $rules = [];
        $messages = [];
        $languages = Language::all();

        foreach ($languages as $language) {
            $rules[$language->code . '_feature_heading'] = 'sometimes|array';
            $rules[$language->code . '_feature_heading.*'] = 'required';

            $messages[$language->code . '_feature_heading.*.required'] = 'The ' . $language->name . ' Feature Heading is required.';
        }

        $validator = Validator::make($request->all(), $rules, $messages);
        if ($validator->fails()) {
            return Response::json(['errors' => $validator->getMessageBag()], 400);
        }

        $listingFeatures = ListingFeature::where('listing_id', $id)->get();
        foreach ($listingFeatures as $listingFeature) {
            ListingFeatureContent::where('listing_feature_id', $listingFeature->id)->each(fn($fc) => $fc->delete());
            $listingFeature->delete();
        }

        foreach ($languages as $language) {
            if (!empty($request[$language->code . '_feature_heading'])) {
                foreach ($request[$language->code . '_feature_heading'] as $key => $heading) {
                    $featureValue = $request[$language->code . '_feature_value_' . $key];

                    $listingFeature = ListingFeature::where([['listing_id', $id], ['indx', $key]])->first();
                    if (is_null($listingFeature)) {
                        $listingFeature = ListingFeature::create(['listing_id' => $id, 'indx' => $key]);
                    }

                    ListingFeatureContent::create([
                        'language_id' => $language->id,
                        'listing_feature_id' => $listingFeature->id,
                        'feature_heading' => $heading,
                        'feature_value' => json_encode($featureValue),
                    ]);
                }
            }
        }

        Session::flash('success', __('Feature Updated successfully') . '!');
        return Response::json(['status' => 'success'], 200);
    }

    public function updateBusinessHours(Request $request, $id)
    {
        $days = ['Saturday', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
        foreach ($days as $day) {
            $businessHours = BusinessHour::where('id', $request[$day . '_id'])->first();
            if (empty($businessHours)) {
                $businessHours = new BusinessHour();
            }
            $businessHours->start_time = $request[$day . '_start_time'];
            $businessHours->end_time = $request[$day . '_end_time'];
            $businessHours->save();
        }
        Session::flash('success', __('Business Hours Updated successfully') . '!');
        return back();
    }

    public function updateHoliday(Request $request)
    {
        $businessHour = BusinessHour::findOrFail($request->holidayId);
        $businessHour->update(['holiday' => $request->holiday == 1 ? 1 : 0]);
        Session::flash('success', __('Holiday Updated successfully') . '!');
        return Response::json(['status' => 'success'], 200);
    }

    public function featureDelete(Request $request)
    {
        $listing_feature = ListingFeature::find($request->spacificationId);
        $listing_feature_contents = ListingFeatureContent::where('listing_feature_id', $listing_feature->id)->get();
        foreach ($listing_feature_contents as $listing_feature_content) {
            $listing_feature_content->delete();
        }
        $listing_feature->delete();

        Session::flash('success', __('Feature deleted successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }
}
