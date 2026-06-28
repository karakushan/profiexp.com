<?php

namespace App\Http\Controllers\Api\VendorApi\Listing;

use App\Http\Controllers\Controller;
use App\Http\Helpers\BasicMailer;
use App\Http\Helpers\UploadFile;
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
use App\Models\Location\City;
use App\Models\Location\Country;
use App\Models\Location\State;
use App\Models\PaymentGateway\OfflineGateway;
use App\Models\PaymentGateway\OnlineGateway;
use App\Models\Vendor;
use App\Services\VendorNotificationService;
use App\Models\Visitor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use App\Models\Aminite;
use Carbon\Carbon;
use Mews\Purifier\Facades\Purifier;

class ListingController extends Controller
{
  private const SUPPORTED_FEATURE_MOBILE_GATEWAYS = [
    'paypal',
    'flutterwave',
    'phonepe',
    'mollie',
    'xendit',
    'midtrans',
    'paystack',
    'paytabs',
    'toyyibpay',
    'monnify',
    'authorize.net',
    'mercadopago',
    'myfatoorah',
    'now_payments',
  ];

  // GET /api/vendor/listings
  public function index(Request $request)
  {
    $vendor = $request->user();

    $language = $request->filled('language')
      ? Language::where('code', $request->language)->first()
      ?? Language::where('is_default', 1)->first()
      : Language::where('is_default', 1)->first();

    $languageId = $language->id;

    // Title search: collect matching listing IDs
    $titleFilterIds = null;
    if ($request->filled('search')) {
      $titleFilterIds = ListingContent::where('language_id', $languageId)
        ->where('title', 'like', '%' . $request->search . '%')
        ->pluck('listing_id')
        ->unique()
        ->values()
        ->all();
    }

    $categoryFilterIds = null;
    if ($request->filled('category') && strtolower($request->category) !== 'all') {
      $cat = ListingCategory::find(intval($request->category));

      $categoryFilterIds = $cat
        ? ListingContent::where('language_id', $languageId)
        ->where('category_id', $cat->id)
        ->pluck('listing_id')
        ->unique()
        ->values()
        ->all()
        : [];
    }

    $listings = Listing::with([
      'listing_content' => fn($q) => $q->where('language_id', $languageId)->with('category'),
    ])
      ->where('vendor_id', $vendor->id)
      ->when($titleFilterIds !== null, fn($q) => $q->whereIn('id', $titleFilterIds))
      ->when($categoryFilterIds !== null, fn($q) => $q->whereIn('id', $categoryFilterIds))
      ->when(
        $request->filled('status') && strtolower($request->status) !== 'all',
        function ($q) use ($request) {
          $map = ['approved' => 1, 'pending' => 0, 'rejected' => 2];
          $val = $map[strtolower($request->status)] ?? null;
          if ($val !== null) {
            $q->where('status', $val);
          }
        }
      )
      ->orderByDesc('id')
      ->paginate(10);

    $today  = Carbon::today()->toDateString();

    $items = $listings->getCollection()->map(function ($listing) use ($today) {
      $content = $listing->listing_content->first();

      $featureOrder = FeatureOrder::where('listing_id', $listing->id)
        ->orderByDesc('id')
        ->first();

      if (is_null($featureOrder)) {
        $promotionStatus = 'pay_to_feature';
      } elseif ($featureOrder->order_status === 'completed' && $featureOrder->end_date >= $today) {
        $promotionStatus = 'featured';
      } elseif ($featureOrder->order_status === 'pending') {
        $promotionStatus = 'pending';
      } else {
        $promotionStatus = 'pay_to_feature';
      }

      $statusLabel = match ((int) $listing->status) {
        1       => 'Approved',
        0       => 'Pending',
        2       => 'Rejected',
        default => 'Unknown',
      };

      return [
        'id'               => $listing->id,
        'title'            => $content?->title ?? '',
        'feature_image'    => $listing->feature_image
          ? asset('assets/img/listing/' . $listing->feature_image)
          : null,
        'category'         => $content?->category?->name ?? '',
        'status'           => (int) $listing->status,
        'status_label'     => $statusLabel,
        'visibility'       => (int) $listing->visibility,
        'promotion_status' => $promotionStatus,
      ];
    });

    $categories = ListingCategory::forLanguage($languageId)
      ->select('id', 'name', 'slug')
      ->get();

    return response()->json([
      'status' => 'success',
      'data'   => [
        'listings'   => [
          'data'         => $items,
          'current_page' => $listings->currentPage(),
          'last_page'    => $listings->lastPage(),
          'total'        => $listings->total(),
          'per_page'     => $listings->perPage(),
        ],
        'categories' => $categories,
      ],
    ]);
  }

  public function updateVisibility(Request $request)
  {

    $vendorId = Auth::guard('vendor')->user()->id;
    $current_package = VendorPermissionHelper::packagePermission($vendorId);

    if ($current_package != '[]') {

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
    } else {

      Session::flash('warning', __('Please Buy a plan to manage Hide/Show') . '!');
      return redirect()->route('vendor.listing_management.listings');
    }
  }

  public function create()
  {
    $information = [];
    $languages = Language::get();
    $information['languages'] = $languages;
    $information['vendors'] = Vendor::get();
    return view('vendors.listing.create', $information);
  }
  public function imagesstore(Request $request)
  {
    if ($request->filled('image_url')) {
      $filename = UploadFile::storeFromSource(
        public_path('assets/img/listing-gallery/'),
        (string) $request->input('image_url'),
        'jpg'
      );

      if (!$filename) {
        return response()->json([
          'error' => true,
          'message' => __('Failed to import generated image.')
        ], 400);
      }

      $pi = new ListingImage();
      $pi->image = $filename;
      $pi->save();

      return response()->json([
        'status' => 'success',
        'file_id' => $pi->id,
        'preview_url' => asset('assets/img/listing-gallery/' . $filename)
      ]);
    }

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
    return response()->json([
      'status' => 'success',
      'file_id' => $pi->id,
      'preview_url' => asset('assets/img/listing-gallery/' . $filename)
    ]);
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
    $baseCountryId = $this->getBaseCountryId($request->id, $language);

    $data['states'] = State::where('country_id', $baseCountryId)
        ->where('language_id', $language->id)
        ->get();
    $data['cities'] = City::where('country_id', $baseCountryId)
        ->where('language_id', $language->id)
        ->get();
    return $data;
  }
  public function getCity(Request $request)
  {
    $language = Language::where('code', $request->lang)->first();
    $baseStateId = $this->getBaseStateId($request->id, $language);

    $data = City::where('state_id', $baseStateId)
        ->where('language_id', $language->id)
        ->get();
    return $data;
  }
  public function store(ListingStoreRequest $request)
  {
    if ($request->can_listing_add == 2) {

      Session::flash('warning', __('Listings limit reached or exceeded') . '!');

      return Response::json(['status' => 'error'], 200);
    } elseif ($request->can_listing_add == 1) {

      $featuredImgURL = $request->feature_image;
      $videoImgURL = $request->video_background_image;

      $languages = Language::all();

      $in = $request->all();


      if ($request->hasFile('feature_image')) {
        $featuredImgName = UploadFile::store(public_path('assets/img/listing/'), $request->file('feature_image'));
        $in['feature_image'] = $featuredImgName;
      } elseif ($request->filled('ai_feature_image')) {
        $featuredImgName = UploadFile::storeFromSource(
          public_path('assets/img/listing/'),
          (string) $request->input('ai_feature_image')
        );
        $in['feature_image'] = $featuredImgName;
      }

      if ($request->hasFile('video_background_image')) {
        $videoImgName = UploadFile::store(
          public_path('assets/img/listing/video/'),
          $request->file('video_background_image')
        );
        $in['video_background_image'] = $videoImgName;
      } elseif ($request->filled('ai_video_background_image')) {
        $videoImgName = UploadFile::storeFromSource(
          public_path('assets/img/listing/video/'),
          (string) $request->input('ai_video_background_image')
        );
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
        $listingContent = new ListingContent();

        $listingContent->language_id = $language->id;
        $listingContent->listing_id = $listing->id;
        $listingContent->title = $request[$language->code . '_title'];
        $listingContent->slug = Str::slug($request['en_title'] ?: $request[$language->code . '_title']);
        $listingContent->category_id = $request[$language->code . '_category_id'];
        $listingContent->country_id = $request[$language->code . '_country_id'];
        $listingContent->state_id = $request[$language->code . '_state_id'];
        $listingContent->city_id = $request[$language->code . '_city_id'];
        $listingContent->address = $request[$language->code . '_address'];

        $aminities = $request->input($language->code . '_aminities', []);
        $listingContent->aminities = json_encode($aminities);

        $listingContent->description = Purifier::clean($request[$language->code . '_description'], 'youtube');
        $listingContent->meta_keyword = $request[$language->code . '_meta_keyword'];
        $listingContent->summary = $request[$language->code . '_summary'];
        $listingContent->meta_description = $request[$language->code . '_meta_description'];

        $listingContent->save();
      }

      //adding business hours
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
      Session::flash('success', __('New Listing added successfully') . '!');
      $info = Basic::select('to_mail', 'website_title')->first();
      $vendor = Auth::guard('vendor')->user()->username;

      $mailData['subject'] = "New Listing Posted on $info->website_title";
      $mailBody = "Dear Admin,

I hope this email finds you well. I wanted to bring to your attention that a new listing has been posted on our website by $vendor.

Thank you for your attention to this matter.";

      $mailData['body'] = nl2br($mailBody);
      $mailData['recipient'] = $info->to_mail;

      BasicMailer::sendMail($mailData);

      return Response::json(['status' => 'success'], 200);
    } else {
      Session::flash('warning', __('Please Buy a plan to add a Listing') . '!');

      return Response::json(['status' => 'error'], 200);
    }
  }

  // GET /api/vendor/listings/{id}/social-links
  public function getSocialLinks(Request $request, $id)
  {
    $vendor  = $request->user();
    Listing::where('vendor_id', $vendor->id)->findOrFail($id);

    $links = ListingSocialMedia::where('listing_id', $id)
      ->select('id', 'link', 'icon')
      ->get();

    return response()->json([
      'status' => 'success',
      'data'   => ['social_links' => $links],
    ]);
  }

  // POST /api/vendor/listings/{id}/social-links
  public function saveSocialLinks(Request $request, $id)
  {
    $vendor  = $request->user();
    Listing::where('vendor_id', $vendor->id)->findOrFail($id);

    $SocialLinkLimit = packageTotalSocialLink($vendor->id);

    $request->validate([
      'links'        => ['required', 'array', 'max:' . $SocialLinkLimit],
      'links.*.link' => ['required', 'string', 'max:500'],
      'links.*.icon' => ['required', 'string', 'max:100'],
    ]);

    ListingSocialMedia::where('listing_id', $id)->delete();

    foreach ($request->links as $row) {
      ListingSocialMedia::create([
        'listing_id' => $id,
        'link'       => $row['link'],
        'icon'       => $row['icon'],
      ]);
    }

    return response()->json(['status' => 'success', 'message' => 'Social links updated successfully.']);
  }

  // GET /api/vendor/listings/{id}/features
  public function getFeatures(Request $request, $id)
  {
    $listing = Listing::where('id', $id)->where('vendor_id', $request->user()->id)->first();
    if (!$listing) {
      return response()->json(['status' => 'error', 'message' => 'Listing not found.'], 404);
    }

    $languages = Language::all()->keyBy('code');
    $features  = ListingFeature::where('listing_id', $id)->orderBy('indx')->get();

    $featureData = [];
    foreach ($features as $feature) {
      $item = ['indx' => $feature->indx];
      foreach ($languages as $code => $lang) {
        $content = ListingFeatureContent::where('listing_feature_id', $feature->id)
          ->where('language_id', $lang->id)
          ->first();
        $item[$code] = [
          'heading' => $content ? $content->feature_heading : '',
          'values'  => $content ? (json_decode($content->feature_value, true) ?? []) : [],
        ];
      }
      $featureData[] = $item;
    }

    return response()->json([
      'status' => 'success',
      'data'   => ['features' => $featureData],
    ]);
  }

  // POST /api/vendor/listings/{id}/features
  public function saveFeatures(Request $request, $id)
  {
    $listing = Listing::where('id', $id)->where('vendor_id', $request->user()->id)->first();
    if (!$listing) {
      return response()->json(['status' => 'error', 'message' => 'Listing not found.'], 404);
    }

    $featureLimit = packageTotalAdditionalSpecification($request->user()->id);
    $request->validate([
      'features'   => ['sometimes', 'array', 'max:' . $featureLimit],
      'features.*' => ['array'],
    ]);

    $languages = Language::all()->keyBy('code');

    // Delete existing features + contents
    $existing = ListingFeature::where('listing_id', $id)->get();
    foreach ($existing as $f) {
      ListingFeatureContent::where('listing_feature_id', $f->id)->delete();
      $f->delete();
    }

    foreach ($request->input('features', []) as $idx => $featureData) {
      $feature = ListingFeature::create([
        'listing_id' => $id,
        'indx'       => $idx,
      ]);
      foreach ($languages as $code => $lang) {
        if (isset($featureData[$code])) {
          ListingFeatureContent::create([
            'language_id'        => $lang->id,
            'listing_feature_id' => $feature->id,
            'feature_heading'    => $featureData[$code]['heading'] ?? '',
            'feature_value'      => json_encode($featureData[$code]['values'] ?? []),
          ]);
        }
      }
    }

    return response()->json(['status' => 'success', 'message' => 'Features updated successfully.']);
  }

  public function manageAdditionalSpecification($id)
  {
    Listing::findOrFail($id);
    $permission = additionalSpecificationsPermission($id);
    if ($permission) {

      $vendor_id = Listing::where('id', $id)->pluck('vendor_id')->first();
      if ($vendor_id == Auth::guard('vendor')->user()->id) {
        $vendorId = Auth::guard('vendor')->user()->id;
        $current_package = VendorPermissionHelper::packagePermission($vendorId);

        if ($current_package != '[]') {

          $information['listing_id'] = $id;
          $information['languages'] = Language::all();
          $information['features'] = ListingFeature::where('listing_id', $id)->get();
          $information['totalFeature'] = ListingFeature::where('listing_id', $id)->count();
          return view('vendors.listing.feature', $information);
        } else {

          Session::flash('warning', __('Please Buy a plan to manage Features') . '!');
          return redirect()->route('vendor.listing_management.listings');
        }
      } else {

        Session::flash('warning', __('You dont have any permission') . '!');

        return redirect()->route('vendor.listing_management.listings');
      }
    } else {
      Session::flash('warning', __('You dont have any permission') . '!');
      return redirect()->route('vendor.listing_management.listings');
    }
  }

  public function updateAdditionalSpecification(Request $request, $id)
  {
    $rules = [];
    $messages = [];
    $languages = Language::all();

    $additionalFeatureLimit = packageTotalAdditionalSpecification(Auth::guard('vendor')->user()->id);
    foreach ($languages as $language) {

      $rules[$language->code . '_feature_heading'] = 'sometimes|array|max:' . $additionalFeatureLimit;
      $rules[$language->code . '_feature_heading.*'] = 'required';


      $messages[$language->code . '_feature_heading.*.required'] = 'The ' . $language->name . ' Feature Heading is required.';
      $messages[$language->code . '_feature_heading.array'] = 'The ' . $language->name . ' Feature Heading must be an array.';
      $messages[$language->code . '_feature_heading.max'] =  'Maximum ' . $additionalFeatureLimit . ' Additional Features can be added per listing for ' . $language->name . ' Language';
    }

    $request->validate($rules, $messages);

    $listingFeatures = ListingFeature::where('listing_id', $id)->get();
    foreach ($listingFeatures as $listingFeature) {
      $listingFeaturesContents = ListingFeatureContent::where('listing_feature_id', $listingFeature->id)->get();
      foreach ($listingFeaturesContents as $listingFeaturesContent) {
        $listingFeaturesContent->delete();
      }
      $listingFeature->delete();
    }

    foreach ($languages as $language) {

      if (!empty(($request[$language->code . '_feature_heading']))) {

        foreach ($request[$language->code . '_feature_heading'] as $key => $v_helper) {
          $feature_value = $request[$language->code . '_feature_value_' . $key];

          $listing_feature = ListingFeature::where([['listing_id', $id], ['indx', $key]])->first();
          if (is_null($listing_feature)) {

            ListingFeature::create([
              'listing_id' => $id,
              'indx' =>  $key
            ]);
          }
          $listing_feature = ListingFeature::where([['listing_id', $id], ['indx', $key]])->first();
          $listing_specification_content = new ListingFeatureContent();
          $listing_specification_content->language_id = $language->id;
          $listing_specification_content->listing_feature_id = $listing_feature->id;
          $listing_specification_content->feature_heading = $v_helper;
          $listing_specification_content->feature_value = json_encode($feature_value);
          $listing_specification_content->save();
        }
      }
    }

    Session::flash('success', __('Feature Updated successfully') . '!');

    return Response::json(['status' => 'success'], 200);
  }

  // GET /api/vendor/listings/{id}/edit
  public function edit(Request $request, $id)
  {
    $vendor  = $request->user();
    $listing = Listing::with(['galleries'])
      ->where('vendor_id', $vendor->id)
      ->findOrFail($id);

    $languages = Language::all();
    $currencyInfo = $this->getCurrencyInfo();

    // Per-language content keyed by language code
    $contents = [];
    foreach ($languages as $language) {
      $content = ListingContent::where('listing_id', $id)
        ->where('language_id', $language->id)
        ->first();

      $contents[$language->code] = [
        'language_id'      => $language->id,
        'title'            => $content?->title ?? '',
        'slug'             => $content?->slug ?? '',
        'category_id'      => $content?->category_id,
        'country_id'       => $content?->country_id,
        'state_id'         => $content?->state_id,
        'city_id'          => $content?->city_id,
        'address'          => $content?->address ?? '',
        'summary'          => $content?->summary ?? '',
        'description'      => $content?->description ?? '',
        'meta_keyword'     => $content?->meta_keyword ?? '',
        'meta_description' => $content?->meta_description ?? '',
        'aminities'        => json_decode($content?->aminities ?? '[]', true) ?? [],
      ];
    }

// Countries list
        $countries = Country::select('id', 'name')->get();

        // Collect all country_ids and state_ids used across any language content
        $allCountryIds = collect($contents)->pluck('country_id')->filter()->unique()->values();
        $allStateIds   = collect($contents)->pluck('state_id')->filter()->unique()->values();

        // States for all countries used by any language content
        $states = $allCountryIds->isNotEmpty()
            ? State::whereIn('country_id', $allCountryIds)->select('id', 'name', 'country_id')->get()
            : collect();

        // Cities for all states used by any language content
        $cities = $allStateIds->isNotEmpty()
            ? City::whereIn('state_id', $allStateIds)->select('id', 'name', 'state_id')->get()
      : collect();

    // Categories per language
    $categories = [];
    foreach ($languages as $language) {
      $categories[$language->code] = ListingCategory::forLanguage($language->id)
        ->select('id', 'name', 'slug')
        ->get();
    }

    // Amenities per language (from DB, not hardcoded)
    $aminitiesAvailable = [];
    foreach ($languages as $language) {
      $aminitiesAvailable[$language->code] = Aminite::where('language_id', $language->id)
        ->select('id', 'title')
        ->get();
    }

    // Gallery images
    $gallery = $listing->galleries->map(fn($img) => [
      'id'  => $img->id,
      'url' => asset('assets/img/listing-gallery/' . $img->image),
    ]);

    return response()->json([
      'status' => 'success',
      'data'   => [
        'listing'   => [
          'id'                     => $listing->id,
          'mail'                   => $listing->mail ?? '',
          'phone'                  => $listing->phone ?? '',
          'video_url'              => $listing->video_url ?? '',
          'latitude'               => $listing->latitude ?? '',
          'longitude'              => $listing->longitude ?? '',
          'min_price'              => $listing->min_price ?? '',
          'max_price'              => $listing->max_price ?? '',
          'visibility'             => (int) $listing->visibility,
          'feature_image'          => $listing->feature_image
            ? asset('assets/img/listing/' . $listing->feature_image)
            : null,
          'video_background_image' => $listing->video_background_image
            ? asset('assets/img/listing/video/' . $listing->video_background_image)
            : null,
        ],
        'contents'   => $contents,
        'languages'  => $languages,
        'categories' => $categories,
        'countries'           => $countries,
        'states'              => $states,
        'cities'              => $cities,
        'gallery'             => $gallery,
        'amenities_available' => $aminitiesAvailable,
        'currency'            => [
          'base_currency_text'            => $currencyInfo->base_currency_text,
          'base_currency_rate'            => $currencyInfo->base_currency_rate,
          'base_currency_symbol'          => $currencyInfo->base_currency_symbol,
          'base_currency_symbol_position' => $currencyInfo->base_currency_symbol_position,
        ],
      ],
    ]);
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
      $listingContent =  ListingContent::where('listing_id', $request->listing_id)->where('language_id', $language->id)->first();
      if (empty($listingContent)) {
        $listingContent = new ListingContent();
      }
      $listingContent->language_id = $language->id;
      $listingContent->title = $request[$language->code . '_title'];
      $listingContent->slug = createSlug($request[$language->code . '_title']);
      $listingContent->category_id = $request[$language->code . '_category_id'];
      $listingContent->country_id = $request[$language->code . '_country_id'];
      $listingContent->state_id = $request[$language->code . '_state_id'];
      $listingContent->city_id = $request[$language->code . '_city_id'];
      $listingContent->address = $request[$language->code . '_address'];
      $aminities = $request->input($language->code . '_aminities', []);
      $listingContent->aminities = json_encode($aminities);
      $listingContent->description = Purifier::clean($request[$language->code . '_description'], 'youtube');
      $listingContent->meta_keyword = $request[$language->code . '_meta_keyword'];
      $listingContent->summary = $request[$language->code . '_summary'];
      $listingContent->meta_description = $request[$language->code . '_meta_description'];
      $listingContent->save();
    }

    Session::flash('success', __('Listing Updated successfully') . '!');

    return Response::json(['status' => 'success'], 200);
  }

  public function videoImageRemove($id)
  {

    $Listing = Listing::Where('id', $id)->first();


    $Listing->video_background_image = null;

    $Listing->save();

    Session::flash('success', __('Successfully Delete Video Image') . '!');

    return Response::json(['status' => 'success'], 200);
  }
  public function delete($id)
  {
    $listing = Listing::findOrFail($id);

    //delete all the contents of this listing
    $contents = $listing->listing_content()->get();

    foreach ($contents as $content) {
      $content->delete();
    }

    // delete feature_image image and video image of this listing
    if (!is_null($listing->feature_image)) {
      @unlink(public_path('assets/img/listing/') . $listing->feature_image);
    }
    if (!is_null($listing->video_background_image)) {
      @unlink(public_path('assets/img/listing/video/') . $listing->video_background_image);
    }

    //delete all the images of this listing
    $galleries = $listing->galleries()->get();

    foreach ($galleries as $gallery) {
      @unlink(public_path('assets/img/listing-gallery/') . $gallery->image);
      $gallery->delete();
    }
    //delete all Features for this listing
    $listingFeatures =  $listing->specifications()->get();
    foreach ($listingFeatures as $listingFeature) {
      $listingFeaturesContents = ListingFeatureContent::where('listing_feature_id', $listingFeature->id)->get();
      foreach ($listingFeaturesContents as $listingFeaturesContent) {
        $listingFeaturesContent->delete();
      }
      $listingFeature->delete();
    }

    //delete feature order
    $featureOrders = FeatureOrder::where('listing_id', $id)->get();
    if (!is_null($featureOrders)) {

      foreach ($featureOrders as $order) {
        if (!is_null($order->attachment)) {
          @unlink(public_path('assets/file/attachments/feature-activation/') . $order->attachment);
          @unlink(public_path('assets/file/invoices/listing-feature/') . $order->invoice);
        }
        $order->delete();
      }
    }
    //delete all message for this listing
    $listingMessages = ListingMessage::where('listing_id', $id)->get();
    if (!is_null($listingMessages)) {

      foreach ($listingMessages as $message) {
        $message->delete();
      }
    }
    //delete all reviews for this listing
    $reviews = ListingReview::where('listing_id', $id)->get();
    if (!is_null($reviews)) {
      foreach ($reviews as $review) {
        $review->delete();
      }
    }
    //delete all visitoirs for this listing
    $visitors  = Visitor::where('listing_id', $id)->get();
    if (!is_null($visitors)) {
      foreach ($visitors as $visitor) {
        $visitor->delete();
      }
    }

    //delete all faq for this listing
    $faqs = $listing->listingFaqs()->get();
    foreach ($faqs as $faq) {
      $faq->delete();
    }
    //delete all follow us  for this listing
    $sociallinks = $listing->sociallinks()->get();
    foreach ($sociallinks as $sociallink) {
      $sociallink->delete();
    }

    //delete all business hours for this listing
    BusinessHour::where('listing_id', $id)->delete();

    //delete claims
    $claims = ClaimListing::where('listing_id', $id)->get();

    foreach ($claims as $claim) {

      if ($claim->information) {
        $information = json_decode($claim->information, true);

        if (!empty($information)) {
          foreach ($information as $fieldData) {
            // Type 8 = File upload
            if (isset($fieldData['type']) && $fieldData['type'] == 8) {
              if (isset($fieldData['value'])) {
                $filePath = public_path('assets/file/zip-files/' . $fieldData['value']);

                if (File::exists($filePath)) {
                  File::delete($filePath);
                }
              }
            }
          }
        }
      }

      $claim->delete();
    }


    //delete all products
    $products = ListingProduct::where('listing_id', $id)->get();

    if (!is_null($products)) {

      foreach ($products as $product) {

        $productcontents = $product->listing_product_content()->get();
        //delete all product contents
        foreach ($productcontents as $productcontent) {
          $productcontent->delete();
        }
        //delete product feature image
        if (!is_null($product->feature_image)) {
          @unlink(public_path('assets/img/listing/product/') . $product->feature_image);
        }

        //delete all product slider images
        $galleries = $product->galleries()->get();

        foreach ($galleries as $gallery) {
          @unlink(public_path('assets/img/listing/product-gallery/') . $gallery->image);
          $gallery->delete();
        }
        //delete this product
        //delete all message for this product
        $productMessages = ProductMessage::where('product_id', $product->id)->get();
        if (!is_null($productMessages)) {
          foreach ($productMessages as $message) {
            $message->delete();
          }
        }
        $product->delete();
      }
    }
    // finally, delete this listing
    $listing->delete();

    Session::flash('success', __('Listing deleted successfully') . '!');

    return redirect()->back();
  }
  public function bulkDelete(Request $request)
  {
    $ids = $request->ids;

    foreach ($ids as $id) {
      $listing = Listing::findOrFail($id);

      //delete all the contents of this listing
      $contents = $listing->listing_content()->get();

      foreach ($contents as $content) {
        $content->delete();
      }

      // delete feature_image image and video image of this listing
      if (!is_null($listing->feature_image)) {
        @unlink(public_path('assets/img/listing/') . $listing->feature_image);
      }
      if (!is_null($listing->video_background_image)) {
        @unlink(public_path('assets/img/listing/video/') . $listing->video_background_image);
      }

      //delete all the images of this listing
      $galleries = $listing->galleries()->get();

      foreach ($galleries as $gallery) {
        @unlink(public_path('assets/img/listing-gallery/') . $gallery->image);
        $gallery->delete();
      }

      //delete claims
      $claims = ClaimListing::where('listing_id', $id)->get();

      foreach ($claims as $claim) {

        if ($claim->information) {
          $information = json_decode($claim->information, true);

          if (!empty($information)) {
            foreach ($information as $fieldData) {
              // Type 8 = File upload
              if (isset($fieldData['type']) && $fieldData['type'] == 8) {
                if (isset($fieldData['value'])) {
                  $filePath = public_path('assets/file/zip-files/' . $fieldData['value']);

                  if (File::exists($filePath)) {
                    File::delete($filePath);
                  }
                }
              }
            }
          }
        }

        $claim->delete();
      }


      //delete all Features for this listing
      $listingFeatures =  $listing->specifications()->get();
      foreach ($listingFeatures as $listingFeature) {
        $listingFeaturesContents = ListingFeatureContent::where('listing_feature_id', $listingFeature->id)->get();
        foreach ($listingFeaturesContents as $listingFeaturesContent) {
          $listingFeaturesContent->delete();
        }
        $listingFeature->delete();
      }

      //delete feature order
      $featureOrders = FeatureOrder::where('listing_id', $id)->get();
      if (!is_null($featureOrders)) {

        foreach ($featureOrders as $order) {
          if (!is_null($order->attachment)) {
            @unlink(public_path('assets/file/attachments/feature-activation/') . $order->attachment);
            @unlink(public_path('assets/file/invoices/listing-feature/') . $order->invoice);
          }
          $order->delete();
        }
      }
      //delete all message for this listing
      $listingMessages = ListingMessage::where('listing_id', $id)->get();
      if (!is_null($listingMessages)) {

        foreach ($listingMessages as $message) {
          $message->delete();
        }
      }
      //delete all reviews for this listing
      $reviews = ListingReview::where('listing_id', $id)->get();
      if (!is_null($reviews)) {
        foreach ($reviews as $review) {
          $review->delete();
        }
      }
      //delete all visit for this listing
      $visitors  = Visitor::where('listing_id', $id)->get();
      if (!is_null($visitors)) {
        foreach ($visitors as $visitor) {
          $visitor->delete();
        }
      }
      //delete all faq for this listing
      $faqs = $listing->listingFaqs()->get();
      foreach ($faqs as $faq) {
        $faq->delete();
      }
      //delete all follow us  for this listing
      $sociallinks = $listing->sociallinks()->get();
      foreach ($sociallinks as $sociallink) {
        $sociallink->delete();
      }

      //delete all business hours for this listing
      BusinessHour::where('listing_id', $id)->delete();


      //delete all products
      $products = ListingProduct::where('listing_id', $id)->get();

      if (!is_null($products)) {

        foreach ($products as $product) {

          $productcontents = $product->listing_product_content()->get();
          //delete all product contents
          foreach ($productcontents as $productcontent) {
            $productcontent->delete();
          }
          //delete product feature image
          if (!is_null($product->feature_image)) {
            @unlink(public_path('assets/img/listing/product/') . $product->feature_image);
          }

          //delete all product slider images
          $galleries = $product->galleries()->get();

          foreach ($galleries as $gallery) {
            @unlink(public_path('assets/img/listing/product-gallery/') . $gallery->image);
            $gallery->delete();
          }
          //delete this product
          //delete all message for this listing
          $productMessages = ProductMessage::where('product_id', $product->id)->get();
          if (!is_null($productMessages)) {
            foreach ($productMessages as $message) {
              $message->delete();
            }
          }
          $product->delete();
        }
      }
      // finally, delete this listing
      $listing->delete();
    }

    Session::flash('success', __('Listing deleted successfully') . '!');

    return response()->json(['status' => 'success'], 200);
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
  public function socialDelete(Request $request)
  {
    $listing_feature = ListingSocialMedia::find($request->socialID);

    $listing_feature->delete();

    Session::flash('success', __('Socail Link deleted successfully') . '!');

    return Response::json(['status' => 'success'], 200);
  }
  public function aminitieUpdate(Request $request)
  {
    $Listing = ListingContent::Where([['listing_id', $request->listingId], ['language_id', $request->languageId]])->first();


    $aminities = $request->aminities;
    $aminitiesArray = explode(',', $aminities);
    $aminitiesArray = array_map('strval', $aminitiesArray);
    $Listing->aminities = $aminitiesArray;

    $Listing->save();

    Session::flash('success', __('Aminities updated successfully') . '!');

    return Response::json(['status' => 'success'], 200);
  }

  public function plugins($id, Request $request)
  {
    Listing::findorFail($id);
    $vendorId = Auth::guard('vendor')->user()->id;
    $current_package = VendorPermissionHelper::packagePermission($vendorId);

    if ($current_package != '[]') {

      $information['title'] = ListingContent::Where([['listing_id', $request->listingId], ['language_id', $request->languageId]])->first();

      $information['data'] = DB::table('listings')
        ->where('id', $id)
        ->select('whatsapp_status', 'whatsapp_number', 'whatsapp_header_title', 'whatsapp_popup_status', 'whatsapp_popup_message',  'tawkto_status', 'tawkto_direct_chat_link', 'telegram_status', 'telegram_username', 'messenger_status', 'messenger_direct_chat_link')
        ->first();
      $information['id'] = $id;

      return view('vendors.listing.plugins', $information);
    } else {

      Session::flash('warning', __('Please Buy a plan to manage plugins') . '!');
      return redirect()->route('vendor.listing_management.listings');
    }
  }
  public function updateTawkTo(Request $request, $id)
  {
    $rules = [
      'tawkto_status' => 'required',
      'tawkto_direct_chat_link' => 'required|url|starts_with:https://embed.tawk.to/'
    ];

    $messages = [
      'tawkto_status.required' => 'The tawk.to status field is required.',
      'tawkto_direct_chat_link.required' => 'The tawk.to direct chat link field is required.',
      'tawkto_direct_chat_link.url' => 'The tawk.to direct chat link must be a valid URL.',
      'tawkto_direct_chat_link.starts_with' => 'The tawk.to direct chat link must start with https://embed.tawk.to/.'
    ];

    $validator = Validator::make($request->all(), $rules, $messages);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors());
    }

    DB::table('listings')->where('id', $id)->update(
      [
        'tawkto_status' => $request->tawkto_status,
        'tawkto_direct_chat_link' => $request->tawkto_direct_chat_link
      ]
    );

    Session::flash('success', __('Tawk.To info updated successfully') . '!');

    return redirect()->back();
  }
  public function updateTelegram(Request $request, $id)
  {
    $rules = [
      'telegram_status' => 'required',
      'telegram_username' => 'required'
    ];

    $messages = [
      'telegram_status.required' => 'The Telegram status field is required.',
      'telegram_username.required' => 'The Telegram Username field is required.'
    ];

    $validator = Validator::make($request->all(), $rules, $messages);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors());
    }

    DB::table('listings')->where('id', $id)->update(
      [
        'telegram_status' => $request->telegram_status,
        'telegram_username' => $request->telegram_username
      ]
    );

    Session::flash('success', __('Telegram info updated successfully') . '!');

    return redirect()->back();
  }
  public function updateWhatsApp(Request $request, $id)
  {
    $rules = [
      'whatsapp_status' => 'required',
      'whatsapp_number' => 'required',
      'whatsapp_header_title' => 'required',
      'whatsapp_popup_status' => 'required',
      'whatsapp_popup_message' => 'required'
    ];

    $validator = Validator::make($request->all(), $rules);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors());
    }

    DB::table('listings')->where('id', $id)->update(
      [
        'whatsapp_status' => $request->whatsapp_status,
        'whatsapp_number' => $request->whatsapp_number,
        'whatsapp_header_title' => $request->whatsapp_header_title,
        'whatsapp_popup_status' => $request->whatsapp_popup_status,
        'whatsapp_popup_message' => $request->whatsapp_popup_message
      ]
    );

    Session::flash('success', __('WhatsApp info updated successfully') . '!');

    return redirect()->back();
  }
  public function updateMessanger(Request $request, $id)
  {
    $rules = [
      'messenger_status' => 'required',
      'messenger_direct_chat_link' => 'required'
    ];

    $validator = Validator::make($request->all(), $rules);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors());
    }

    DB::table('listings')->where('id', $id)->update(
      [
        'messenger_status' => $request->messenger_status,
        'messenger_direct_chat_link' => $request->messenger_direct_chat_link
      ]
    );

    Session::flash('success', __('Messanger info updated successfully') . '!');

    return redirect()->back();
  }
  // GET /api/vendor/listings/{id}/plugins
  public function getPlugins(Request $request, $id)
  {
    $vendor = $request->user();
    Listing::where('vendor_id', $vendor->id)->findOrFail($id);

    $data = DB::table('listings')
      ->where('id', $id)
      ->select(
        'whatsapp_status',
        'whatsapp_number',
        'whatsapp_header_title',
        'whatsapp_popup_status',
        'whatsapp_popup_message',
        'tawkto_status',
        'tawkto_direct_chat_link',
        'telegram_status',
        'telegram_username',
        'messenger_status',
        'messenger_direct_chat_link'
      )
      ->first();

    return response()->json(['status' => 'success', 'data' => $data]);
  }

  // POST /api/vendor/listings/{id}/plugins/tawkto
  public function saveTawkTo(Request $request, $id)
  {
    $vendor = $request->user();
    Listing::where('vendor_id', $vendor->id)->findOrFail($id);

    $request->validate([
      'tawkto_status'          => 'required|integer',
      'tawkto_direct_chat_link' => 'required|url|starts_with:https://embed.tawk.to/',
    ]);

    DB::table('listings')->where('id', $id)->update([
      'tawkto_status'           => $request->tawkto_status,
      'tawkto_direct_chat_link' => $request->tawkto_direct_chat_link,
    ]);

    return response()->json(['status' => 'success', 'message' => 'Tawk.To info updated successfully.']);
  }

  // POST /api/vendor/listings/{id}/plugins/telegram
  public function saveTelegram(Request $request, $id)
  {
    $vendor = $request->user();
    Listing::where('vendor_id', $vendor->id)->findOrFail($id);

    $request->validate([
      'telegram_status'   => 'required|integer',
      'telegram_username' => 'required|string',
    ]);

    DB::table('listings')->where('id', $id)->update([
      'telegram_status'   => $request->telegram_status,
      'telegram_username' => $request->telegram_username,
    ]);

    return response()->json(['status' => 'success', 'message' => 'Telegram info updated successfully.']);
  }

  // POST /api/vendor/listings/{id}/plugins/whatsapp
  public function saveWhatsApp(Request $request, $id)
  {
    $vendor = $request->user();
    Listing::where('vendor_id', $vendor->id)->findOrFail($id);

    $request->validate([
      'whatsapp_status'        => 'required|integer',
      'whatsapp_number'        => 'required|string',
      'whatsapp_header_title'  => 'required|string',
      'whatsapp_popup_status'  => 'required|integer',
      'whatsapp_popup_message' => 'required|string',
    ]);

    DB::table('listings')->where('id', $id)->update([
      'whatsapp_status'        => $request->whatsapp_status,
      'whatsapp_number'        => $request->whatsapp_number,
      'whatsapp_header_title'  => $request->whatsapp_header_title,
      'whatsapp_popup_status'  => $request->whatsapp_popup_status,
      'whatsapp_popup_message' => $request->whatsapp_popup_message,
    ]);

    return response()->json(['status' => 'success', 'message' => 'WhatsApp info updated successfully.']);
  }

  // POST /api/vendor/listings/{id}/plugins/messenger
  public function saveMessenger(Request $request, $id)
  {
    $vendor = $request->user();
    Listing::where('vendor_id', $vendor->id)->findOrFail($id);

    $request->validate([
      'messenger_status'           => 'required|integer',
      'messenger_direct_chat_link' => 'required|string',
    ]);

    DB::table('listings')->where('id', $id)->update([
      'messenger_status'           => $request->messenger_status,
      'messenger_direct_chat_link' => $request->messenger_direct_chat_link,
    ]);

    return response()->json(['status' => 'success', 'message' => 'Messenger info updated successfully.']);
  }

  // GET /api/vendor/listings/{id}/business-hours
  public function getBusinessHours(Request $request, $id)
  {
    $vendor  = $request->user();
    $listing = Listing::where('vendor_id', $vendor->id)->findOrFail($id);

    $hours = BusinessHour::where('listing_id', $id)
      ->select('id', 'day', 'start_time', 'end_time', 'holiday')
      ->get();

    return response()->json([
      'status' => 'success',
      'data'   => ['business_hours' => $hours],
    ]);
  }

  // POST /api/vendor/listings/{id}/business-hours
  public function saveBusinessHours(Request $request, $id)
  {
    $vendor  = $request->user();
    Listing::where('vendor_id', $vendor->id)->findOrFail($id);

    $request->validate([
      'hours'               => 'required|array',
      'hours.*.id'          => 'required|integer|exists:business_hours,id',
      'hours.*.start_time'  => 'required|string',
      'hours.*.end_time'    => 'required|string',
      'hours.*.holiday'     => 'required|boolean',
    ]);

    foreach ($request->hours as $row) {
      BusinessHour::where('id', $row['id'])
        ->where('listing_id', $id)
        ->update([
          'start_time' => $row['start_time'],
          'end_time'   => $row['end_time'],
          'holiday'    => $row['holiday'] ? 1 : 0,
        ]);
    }

    return response()->json(['status' => 'success', 'message' => 'Business hours updated successfully.']);
  }

  public function businessHours($id)
  {
    Listing::findorFail($id);
    $vendor_id = Listing::where('id', $id)->pluck('vendor_id')->first();
    if ($vendor_id == Auth::guard('vendor')->user()->id) {
      $vendorId = Auth::guard('vendor')->user()->id;
      $current_package = VendorPermissionHelper::packagePermission($vendorId);

      if ($current_package != '[]') {

        $permissions = businessHoursPermission($id);

        if ($permissions) {
          $information['id'] = $id;

          $information['days'] = DB::table('business_hours')
            ->Where('listing_id', $id)
            ->get();

          $language = vendorLanguage();
          $information['title'] = ListingContent::where([['language_id', $language->id], ['listing_id', $id]])
            ->select('title')
            ->first();

          return view('vendors.listing.business-hours', $information);
        } else {

          Session::flash('warning', __('Your Business Hours Permission is not granted') . '!');
          return redirect()->route('vendor.listing_management.listings');
        }
      } else {

        Session::flash('warning', __('Please Buy a plan to manage business hours') . '!');
        return redirect()->route('vendor.listing_management.listings');
      }
    } else {

      Session::flash('warning', __('You dont have any permission') . '!');
      return redirect()->route('vendor.listing_management.listings');
    }
  }
  public function updateHoliday(Request $request)
  {
    $listing = BusinessHour::findOrFail($request->holidayId);

    if ($request->holiday == 1) {
      $listing->update(['holiday' => 1]);

      Session::flash('success', __('Holiday Updated successfully') . '!');
    } else {
      $listing->update(['holiday' => 0]);

      Session::flash('success', __('Holiday Updated successfully') . '!');
    }

    return Response::json(['status' => 'success'], 200);
  }
  public function updateBusinessHours(Request $request, $id)
  {
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


  public function getSearchCity(Request $request)
  {
    $search = $request->input('search');
    $page = $request->input('page', 1);
    $pageSize = 10;

    $language = Language::where('code', $request->lang)->first();

    $query = City::where('language_id', $language->id);

    if ($search) {
      $query->where('name', 'like', "%{$search}%");
    }

    // Add pagination
    $cities = $query->skip(($page - 1) * $pageSize)
      ->take($pageSize + 1)
      ->get(['id', 'name']);

    // Check if there's more data
    $hasMore = count($cities) > $pageSize;
    $results = $hasMore ? $cities->slice(0, $pageSize) : $cities;

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


    $query = ListingCategory::forLanguage($language->id);

    if ($search) {
      $query->where('name', 'like', "%{$search}%")
        ->orWhere('slug', 'like', "%{$search}%");
    }

    // Add pagination
    $categories = $query->skip(($page - 1) * $pageSize)
      ->take($pageSize + 1)
      ->get(['id', 'name']);

    // Check if there's more data
    $hasMore = count($categories) > $pageSize;
    $results = $hasMore ? $categories->slice(0, $pageSize) : $categories;


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

    $query = State::where('language_id', $language->id);

    if ($search) {
      $query->where('name', 'like', "%{$search}%");
    }

    // Add pagination
    $cities = $query->skip(($page - 1) * $pageSize)
      ->take($pageSize + 1)
      ->get(['id', 'name']);

    // Check if there's more data
    $hasMore = count($cities) > $pageSize;
    $results = $hasMore ? $cities->slice(0, $pageSize) : $cities;

    return response()->json([
      'results' => $results,
      'more' => $hasMore
    ]);
  }
  //search country
  public function getCountry(Request $request)
  {
    $search = $request->input('search');
    $page = $request->input('page', 1);
    $pageSize = 10;

    $language = Language::where('code', $request->lang)->first();
    $query = Country::where('language_id', $language->id);

    if ($search) {
      $query->where('name', 'like', "%{$search}%");
    }

    // Add pagination
    $countries = $query->skip(($page - 1) * $pageSize)
      ->take($pageSize + 1)
      ->get(['id', 'name']);


    // Check if there's more data
    $hasMore = count($countries) > $pageSize;
    $results = $hasMore ? $countries->slice(0, $pageSize) : $countries;

    return response()->json([
      'results' => $results,
      'more' => $hasMore
    ]);
  }

  // GET /api/vendor/listings/create
  public function getCreateForm(Request $request)
  {
    $languages = Language::all();
    $currencyInfo = $this->getCurrencyInfo();

    $categories = [];
    $aminitiesAvailable = [];
    foreach ($languages as $language) {
      $categories[$language->code] = ListingCategory::forLanguage($language->id)
        ->select('id', 'name', 'slug')
        ->get();
      $aminitiesAvailable[$language->code] = Aminite::where('language_id', $language->id)
        ->select('id', 'title')
        ->get();
    }

    $countries = Country::select('id', 'name')->get();

    return response()->json([
      'status' => 'success',
      'data'   => [
        'listing' => [
          'id'                     => 0,
          'mail'                   => '',
          'phone'                  => '',
          'video_url'              => '',
          'latitude'               => '',
          'longitude'              => '',
          'min_price'              => '',
          'max_price'              => '',
          'visibility'             => 1,
          'feature_image'          => null,
          'video_background_image' => null,
        ],
        'contents'            => (object) [],
        'languages'           => $languages,
        'categories'          => $categories,
        'countries'           => $countries,
        'states'              => [],
        'cities'              => [],
        'gallery'             => [],
        'amenities_available' => $aminitiesAvailable,
        'currency'            => [
          'base_currency_text'            => $currencyInfo->base_currency_text,
          'base_currency_rate'            => $currencyInfo->base_currency_rate,
          'base_currency_symbol'          => $currencyInfo->base_currency_symbol,
          'base_currency_symbol_position' => $currencyInfo->base_currency_symbol_position,
        ],
      ],
    ]);
  }

  // POST /api/vendor/listings
  public function apiStore(Request $request)
  {
    $vendor = $request->user();

    // Check package listing limit
    $totalAllowed = packageTotalListing($vendor->id);
    $existing = Listing::where('vendor_id', $vendor->id)->count();

    if ($totalAllowed <= 0) {
      return response()->json([
        'status'  => 'error',
        'message' => 'Please buy a plan to add a listing.',
      ], 422);
    }

    if ($existing >= $totalAllowed) {
      return response()->json([
        'status'  => 'error',
        'message' => 'Listings limit reached. Please upgrade your plan.',
      ], 422);
    }

    $languages = Language::all();

    // Validate required fields
    $request->validate([
      'mail'          => 'required|email|max:255',
      'phone'         => 'required|string|max:50',
      'feature_image' => 'required|file|mimes:jpg,jpeg,png,webp|max:4096',
    ]);

    // Handle feature image
    $featuredImgName = null;
    if ($request->hasFile('feature_image')) {
      $directory = public_path('assets/img/listing/');
      @mkdir($directory, 0775, true);
      $featuredImgName = UploadFile::store($directory, $request->file('feature_image'));
    }

    // Handle video background image
    $videoImgName = null;
    if ($request->hasFile('video_background_image')) {
      $directory = public_path('assets/img/listing/video/');
      @mkdir($directory, 0775, true);
      $videoImgName = UploadFile::store($directory, $request->file('video_background_image'));
    }

    // Clean video URL
    $videoLink = $request->video_url;
    if ($videoLink && strpos($videoLink, '&') !== false) {
      $videoLink = substr($videoLink, 0, strpos($videoLink, '&'));
    }

    // Create listing
    $listing = Listing::create([
      'vendor_id'              => $vendor->id,
      'mail'                   => $request->mail,
      'phone'                  => $request->phone,
      'video_url'              => $videoLink ?? '',
      'min_price'              => $request->min_price ?? '',
      'max_price'              => $request->max_price ?? '',
      'visibility'             => $request->visibility ?? 1,
      'latitude'               => $request->latitude ?? '',
      'longitude'              => $request->longitude ?? '',
      'feature_image'          => $featuredImgName,
      'video_background_image' => $videoImgName,
      'status'                 => 0,
    ]);

    // Handle gallery images
    if ($request->hasFile('images')) {
      $galleryDir = public_path('assets/img/listing-gallery/');
      @mkdir($galleryDir, 0775, true);
      foreach ($request->file('images') as $galleryFile) {
        $galleryName = UploadFile::store($galleryDir, $galleryFile);
        $pi = new ListingImage();
        $pi->listing_id = $listing->id;
        $pi->image = $galleryName;
        $pi->save();
      }
    }

    // Per-language content
    foreach ($languages as $language) {
      $code = $language->code;
      $listingContent = new ListingContent();
      $listingContent->language_id   = $language->id;
      $listingContent->listing_id    = $listing->id;
      $listingContent->title         = $request->input($code . '_title', '');
      $listingContent->slug          = createSlug($request->input($code . '_title', ''));
      $listingContent->category_id   = $request->input($code . '_category_id');
      $listingContent->country_id    = $request->input($code . '_country_id');
      $listingContent->state_id      = $request->input($code . '_state_id');
      $listingContent->city_id       = $request->input($code . '_city_id');
      $listingContent->address       = $request->input($code . '_address', '');
      $listingContent->description   = Purifier::clean($request->input($code . '_description', ''), 'youtube');
      $listingContent->summary       = $request->input($code . '_summary', '');
      $listingContent->meta_keyword  = $request->input($code . '_meta_keyword', '');
      $listingContent->meta_description = $request->input($code . '_meta_description', '');
      $aminities = $request->input($code . '_aminities', []);
      $listingContent->aminities     = json_encode(is_array($aminities) ? $aminities : []);
      $listingContent->save();
    }

    // Default business hours
    $days = ['Saturday', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
    foreach ($days as $day) {
      $bh = new BusinessHour();
      $bh->listing_id = $listing->id;
      $bh->day        = $day;
      $bh->start_time = '10:00 AM';
      $bh->end_time   = '07:00 PM';
      $bh->holiday    = 1;
      $bh->save();
    }

    return response()->json([
      'status'  => 'success',
      'message' => 'Listing created successfully.',
      'data'    => ['listing_id' => $listing->id],
    ]);
  }

  // POST /api/vendor/listings/{id}/update
  public function apiUpdate(Request $request, $id)
  {
    $vendor  = $request->user();
    $listing = Listing::where('vendor_id', $vendor->id)->findOrFail($id);

    $languages = Language::all();

    // Handle feature image
    if ($request->hasFile('feature_image')) {
      $directory = public_path('assets/img/listing/');
      @mkdir($directory, 0775, true);
      $newName = UploadFile::store($directory, $request->file('feature_image'));
      if ($listing->feature_image) {
        @unlink($directory . $listing->feature_image);
      }
      $listing->feature_image = $newName;
    }

    // Handle video background image
    if ($request->hasFile('video_background_image')) {
      $directory = public_path('assets/img/listing/video/');
      @mkdir($directory, 0775, true);
      $newName = UploadFile::store($directory, $request->file('video_background_image'));
      if ($listing->video_background_image) {
        @unlink($directory . $listing->video_background_image);
      }
      $listing->video_background_image = $newName;
    }

    // Clean video URL
    $videoLink = $request->video_url;
    if ($videoLink && strpos($videoLink, '&') !== false) {
      $videoLink = substr($videoLink, 0, strpos($videoLink, '&'));
    }

    $listing->mail       = $request->mail ?? $listing->mail;
    $listing->phone      = $request->phone ?? $listing->phone;
    $listing->video_url  = $videoLink ?? $listing->video_url ?? '';
    $listing->min_price  = $request->min_price ?? $listing->min_price ?? '';
    $listing->max_price  = $request->max_price ?? $listing->max_price ?? '';
    $listing->visibility = $request->visibility ?? $listing->visibility ?? 1;
    $listing->latitude   = $request->latitude ?? $listing->latitude ?? '';
    $listing->longitude  = $request->longitude ?? $listing->longitude ?? '';
    $listing->save();

    // Remove gallery images explicitly requested for deletion
    if ($request->has('remove_gallery_ids')) {
      $removeIds = $request->input('remove_gallery_ids');
      if (is_string($removeIds)) {
        $removeIds = json_decode($removeIds, true) ?? [];
      }
      foreach ((array)$removeIds as $gid) {
        $img = ListingImage::where('id', $gid)->where('listing_id', $id)->first();
        if ($img) {
          @unlink(public_path('assets/img/listing-gallery/') . $img->image);
          $img->delete();
        }
      }
    }

    // Add new gallery images uploaded as images[]
    if ($request->hasFile('images')) {
      $galleryDir = public_path('assets/img/listing-gallery/');
      @mkdir($galleryDir, 0775, true);
      foreach ($request->file('images') as $galleryFile) {
        $galleryName = UploadFile::store($galleryDir, $galleryFile);
        $pi = new ListingImage();
        $pi->listing_id = $id;
        $pi->image      = $galleryName;
        $pi->save();
      }
    }

    // Per-language content
    foreach ($languages as $language) {
      $code = $language->code;
      $listingContent = ListingContent::where('listing_id', $id)
        ->where('language_id', $language->id)
        ->first() ?? new ListingContent();

      $listingContent->language_id      = $language->id;
      $listingContent->listing_id       = $id;
      $listingContent->title            = $request->input($code . '_title', $listingContent->title ?? '');
      $listingContent->slug             = createSlug($request->input($code . '_title', ''));
      $listingContent->category_id      = $request->input($code . '_category_id', $listingContent->category_id);
      $listingContent->country_id       = $request->input($code . '_country_id', $listingContent->country_id);
      $listingContent->state_id         = $request->input($code . '_state_id', $listingContent->state_id);
      $listingContent->city_id          = $request->input($code . '_city_id', $listingContent->city_id);
      $listingContent->address          = $request->input($code . '_address', $listingContent->address ?? '');
      $listingContent->description      = Purifier::clean($request->input($code . '_description', $listingContent->description ?? ''), 'youtube');
      $listingContent->summary          = $request->input($code . '_summary', $listingContent->summary ?? '');
      $listingContent->meta_keyword     = $request->input($code . '_meta_keyword', $listingContent->meta_keyword ?? '');
      $listingContent->meta_description = $request->input($code . '_meta_description', $listingContent->meta_description ?? '');
      $aminities = $request->input($code . '_aminities');
      if ($aminities !== null) {
        $listingContent->aminities = json_encode(is_array($aminities) ? $aminities : []);
      }
      $listingContent->save();
    }

    return response()->json([
      'status'  => 'success',
      'message' => 'Listing updated successfully.',
    ]);
  }

  // GET /api/vendor/listings/{id}/feature-options
  public function featureOptions(Request $request, $id)
  {
    $vendor = $request->user();
    Listing::where('vendor_id', $vendor->id)->findOrFail($id);
    $currencyInfo = $this->getCurrencyInfo();
    $pgwBaseUrl = rtrim($request->root(), '/') . '/pgw';

    $charges = FeaturedListingCharge::query()
      ->select('id', 'days', 'price')
      ->orderBy('days')
      ->get();

    $onlineGateways = OnlineGateway::query()
      ->where('mobile_status', 1)
      ->whereIn('keyword', self::SUPPORTED_FEATURE_MOBILE_GATEWAYS)
      ->select('id', 'name', 'keyword')
      ->get()
      ->map(fn($g) => [
        'id'      => (int)$g->id,
        'name'    => $g->name,
        'keyword' => $g->keyword,
        'type'    => 'online',
      ]);

    $offlineGateways = OfflineGateway::query()
      ->where('status', 1)
      ->select('id', 'name')
      ->orderBy('serial_number')
      ->get()
      ->map(fn($g) => [
        'id'      => (int)$g->id,
        'name'    => $g->name,
        'keyword' => 'offline_' . $g->id,
        'type'    => 'offline',
      ]);

    return response()->json([
      'status' => 'success',
      'data'   => [
        'charges'  => $charges,
        'gateways' => $onlineGateways->values()->merge($offlineGateways->values())->values(),
        'currency' => [
          'base_currency_text'            => $currencyInfo->base_currency_text,
          'base_currency_rate'            => $currencyInfo->base_currency_rate,
          'base_currency_symbol'          => $currencyInfo->base_currency_symbol,
          'base_currency_symbol_position' => $currencyInfo->base_currency_symbol_position,
        ],
        'pgw_base_url' => $pgwBaseUrl,
      ],
    ]);
  }

  // POST /api/vendor/listings/{id}/feature-request
  public function requestFeature(Request $request, $id)
  {
    $vendor = $request->user();
    $listing = Listing::where('vendor_id', $vendor->id)->findOrFail($id);

    $request->validate([
      'charge_id'    => 'required|integer|exists:featured_listing_charges,id',
      'gateway_type' => 'required|in:online,offline',
      'gateway_id'   => 'required|integer',
    ]);

    $currentPackage = VendorPermissionHelper::packagePermission($vendor->id);
    if ($currentPackage == '[]') {
      return response()->json([
        'status'  => 'error',
        'message' => 'Please buy a plan to request feature listing.',
      ], 422);
    }

    $charge = FeaturedListingCharge::findOrFail($request->charge_id);
    $vendorRecord = Vendor::find($vendor->id);
    $toMail = null;
    if (!empty($vendorRecord) && !empty($vendorRecord->to_mail)) {
      $toMail = $vendorRecord->to_mail;
    } elseif (!empty($vendorRecord) && !empty($vendorRecord->email)) {
      $toMail = $vendorRecord->email;
    } elseif (!empty($vendor->email)) {
      $toMail = $vendor->email;
    }

    if ($request->gateway_type === 'online') {
      $gateway = OnlineGateway::query()
        ->where('mobile_status', 1)
        ->whereIn('keyword', self::SUPPORTED_FEATURE_MOBILE_GATEWAYS)
        ->find($request->gateway_id);
    } else {
      $gateway = OfflineGateway::query()->where('status', 1)->find($request->gateway_id);
    }

    if (!$gateway) {
      return response()->json([
        'status'  => 'error',
        'message' => 'Selected payment gateway is not available.',
      ], 422);
    }

    if ($request->gateway_type === 'online') {
      return response()->json([
        'status' => 'success',
        'payment_required' => true,
        'gateway' => $gateway->keyword,
        'gateway_name' => $gateway->name,
        'amount' => (float) $charge->price,
        'data' => [
          'listing_id' => (int) $listing->id,
          'charge_id' => (int) $charge->id,
        ],
      ], 200);
    }

    $startDate = Carbon::now()->startOfDay();
    $endDate = $startDate->copy()->addDays($charge->days);

    $order = FeatureOrder::where('listing_id', $listing->id)->first();
    if (empty($order)) {
      $order = new FeatureOrder();
    }

    $order->listing_id = $listing->id;
    $order->vendor_id = $vendor->id;
    $order->vendor_mail = $toMail;
    $order->order_number = $order->order_number ?? uniqid('feature_');
    $order->total = $charge->price;
    $order->payment_method = $gateway->name;
    $order->gateway_type = $request->gateway_type;
    $order->payment_status = 'pending';
    $order->order_status = 'pending';
      $order->attachment = null;
      $order->invoice = null;
      $order->days = $charge->days;
      $order->start_date = $startDate;
      $order->end_date = $endDate;
      $order->save();
      VendorNotificationService::send(
        $vendor,
        'vendor_feature_request_submitted',
        'Feature request submitted',
        'Your featured listing request has been submitted and is waiting for review.',
        [
          'feature_order_id' => $order->id,
          'listing_id' => $listing->id,
        ]
      );

      return response()->json([
      'status'  => 'success',
      'message' => 'Feature request submitted successfully.',
      'data'    => [
        'listing_id'        => (int)$listing->id,
        'promotion_status'  => 'pending',
        'feature_order_id'  => (int)$order->id,
      ],
    ]);
  }

  // POST /api/vendor/listings/{id}/feature-payment-verifier
  public function featurePaymentVerifier(Request $request, $id)
  {
    $vendor = $request->user();
    Listing::where('vendor_id', $vendor->id)->findOrFail($id);

    $validator = Validator::make($request->all(), [
      'charge_id' => 'required|integer|exists:featured_listing_charges,id',
      'gateway' => 'required|string',
    ]);

    if ($validator->fails()) {
      return response()->json(['errors' => $validator->errors()], 422);
    }

    $charge = FeaturedListingCharge::findOrFail((int) $request->input('charge_id'));
    $sourceAmount = (float) $charge->price;

    $gatewayInput = strtolower(trim((string) $request->input('gateway')));
    if ($gatewayInput === 'myfatorah') {
      $gatewayInput = 'myfatoorah';
    }
    if ($gatewayInput === 'nowpayments') {
      $gatewayInput = 'now_payments';
    }

    $onlineGateway = OnlineGateway::query()
      ->where('mobile_status', 1)
      ->whereIn('keyword', self::SUPPORTED_FEATURE_MOBILE_GATEWAYS)
      ->where(function ($query) use ($gatewayInput) {
        $query->whereRaw('LOWER(keyword) = ?', [$gatewayInput])
          ->orWhereRaw('LOWER(name) = ?', [$gatewayInput]);
      })
      ->first();

    if (!$onlineGateway) {
      return response()->json([
        'error' => 'Invalid or inactive online gateway.',
      ], 422);
    }

    $currencyInfo = Basic::query()
      ->select('base_currency_text', 'base_currency_rate')
      ->first();

    $baseCurrency = strtoupper((string) ($currencyInfo->base_currency_text ?? 'USD'));
    $baseRate = (float) ($currencyInfo->base_currency_rate ?? 1);
    $gatewayKeyword = strtolower((string) $onlineGateway->keyword);

    $verifiedAmount = round($sourceAmount, 2);
    $verifiedCurrency = $baseCurrency;

    switch ($gatewayKeyword) {
      case 'paypal':
        if ($baseCurrency !== 'USD') {
          if ($baseRate <= 0) {
            return response()->json([
              'error' => 'Invalid base currency conversion rate.',
            ], 422);
          }
          $verifiedAmount = round($sourceAmount / $baseRate, 2);
        }
        $verifiedCurrency = 'USD';
        break;

      case 'paystack':
        if ($baseCurrency !== 'NGN') {
          return response()->json([
            'error' => 'Invalid currency for paystack payment.',
          ], 422);
        }
        $verifiedAmount = round($sourceAmount, 2);
        $verifiedCurrency = 'NGN';
        break;

      case 'paytabs':
        $allowedCurrencies = ['AED', 'SAR', 'QAR', 'OMR', 'BHD', 'KWD', 'JOD', 'EGP', 'USD', 'EUR', 'GBP', 'MYR'];
        if (!in_array($baseCurrency, $allowedCurrencies, true)) {
          return response()->json([
            'error' => 'Invalid currency for paytabs payment.',
          ], 422);
        }
        $verifiedAmount = round($sourceAmount, 2);
        break;

      case 'flutterwave':
        $allowedCurrencies = ['BIF', 'CAD', 'CDF', 'CVE', 'EUR', 'GBP', 'GHS', 'GMD', 'GNF', 'KES', 'LRD', 'MWK', 'MZN', 'NGN', 'RWF', 'SLL', 'STD', 'TZS', 'UGX', 'USD', 'XAF', 'XOF', 'ZMK', 'ZMW', 'ZWD'];
        if (!in_array($baseCurrency, $allowedCurrencies, true)) {
          return response()->json([
            'error' => 'Invalid currency for flutterwave payment.',
          ], 422);
        }
        $verifiedAmount = (float) intval($sourceAmount);
        break;

      case 'razorpay':
        if ($baseCurrency !== 'INR') {
          return response()->json([
            'error' => 'Invalid currency for razorpay payment.',
          ], 422);
        }
        $verifiedAmount = round($sourceAmount, 2);
        $verifiedCurrency = 'INR';
        break;

      case 'mercadopago':
        $allowedCurrencies = ['ARS', 'BOB', 'BRL', 'CLF', 'CLP', 'COP', 'CRC', 'CUC', 'CUP', 'DOP', 'EUR', 'GTQ', 'HNL', 'MXN', 'NIO', 'PAB', 'PEN', 'PYG', 'USD', 'UYU', 'VEF', 'VES'];
        if (!in_array($baseCurrency, $allowedCurrencies, true)) {
          return response()->json([
            'error' => 'Invalid currency for mercadopago payment.',
          ], 422);
        }
        $verifiedAmount = (float) intval($sourceAmount);
        break;

      case 'phonepe':
        if ($baseCurrency !== 'INR') {
          return response()->json([
            'error' => 'Invalid currency for phonepe payment.',
          ], 422);
        }
        $verifiedAmount = round($sourceAmount, 2);
        $verifiedCurrency = 'INR';
        break;

      case 'mollie':
        $allowedCurrencies = ['AED', 'AUD', 'BGN', 'BRL', 'CAD', 'CHF', 'CZK', 'DKK', 'EUR', 'GBP', 'HKD', 'HRK', 'HUF', 'ILS', 'ISK', 'JPY', 'MXN', 'MYR', 'NOK', 'NZD', 'PHP', 'PLN', 'RON', 'RUB', 'SEK', 'SGD', 'THB', 'TWD', 'USD', 'ZAR'];
        if (!in_array($baseCurrency, $allowedCurrencies, true)) {
          return response()->json([
            'error' => 'Invalid currency for mollie payment.',
          ], 422);
        }
        $verifiedAmount = (float) sprintf('%0.2f', $sourceAmount);
        break;

      case 'stripe':
        if ($baseCurrency !== 'USD') {
          if ($baseRate <= 0) {
            return response()->json([
              'error' => 'Invalid base currency conversion rate.',
            ], 422);
          }
          $verifiedAmount = round(($sourceAmount / $baseRate), 2);
        }
        $verifiedCurrency = 'USD';
        break;

      case 'authorize.net':
        $allowedCurrencies = ['USD', 'CAD', 'CHF', 'DKK', 'EUR', 'GBP', 'NOK', 'PLN', 'SEK', 'AUD', 'NZD'];
        if (!in_array($baseCurrency, $allowedCurrencies, true)) {
          return response()->json([
            'error' => 'Invalid currency for authorize.net payment.',
          ], 422);
        }
        $verifiedAmount = (float) sprintf('%0.2f', $sourceAmount);
        break;

      case 'myfatoorah':
        $allowedCurrencies = ['KWD', 'SAR', 'BHD', 'AED', 'QAR', 'OMR', 'JOD'];
        if (!in_array($baseCurrency, $allowedCurrencies, true)) {
          return response()->json([
            'error' => 'Invalid currency for myfatoorah payment.',
          ], 422);
        }
        $verifiedAmount = (float) intval($sourceAmount);
        break;

      case 'midtrans':
        $allowedCurrencies = ['IDR'];
        if (!in_array($baseCurrency, $allowedCurrencies, true)) {
          return response()->json([
            'error' => 'Invalid currency for midtrans payment.',
          ], 422);
        }
        $verifiedAmount = (float) round($sourceAmount);
        $verifiedCurrency = 'IDR';
        break;

      case 'toyyibpay':
        $allowedCurrencies = ['RM', 'MYR'];
        if (!in_array($baseCurrency, $allowedCurrencies, true)) {
          return response()->json([
            'error' => 'Invalid currency for toyyibpay payment.',
          ], 422);
        }
        $verifiedAmount = round($sourceAmount, 2);
        $verifiedCurrency = $baseCurrency === 'RM' ? 'MYR' : $baseCurrency;
        break;

      case 'xendit':
        $allowedCurrencies = ['IDR', 'PHP', 'USD', 'SGD', 'MYR'];
        if (!in_array($baseCurrency, $allowedCurrencies, true)) {
          return response()->json([
            'error' => 'Invalid currency for xendit payment.',
          ], 422);
        }
        $verifiedAmount = round($sourceAmount, 2);
        break;

      case 'monnify':
        $allowedCurrencies = ['NGN'];
        if (!in_array($baseCurrency, $allowedCurrencies, true)) {
          return response()->json([
            'error' => 'Invalid currency for monnify payment.',
          ], 422);
        }
        $verifiedAmount = round($sourceAmount, 2);
        $verifiedCurrency = 'NGN';
        break;

      case 'now_payments':
        $allowedCurrencies = ['USD', 'EUR', 'GBP', 'USDT', 'BTC', 'ETH'];
        if (!in_array($baseCurrency, $allowedCurrencies, true)) {
          return response()->json([
            'error' => 'Invalid currency for now_payments payment.',
          ], 422);
        }
        $verifiedAmount = round($sourceAmount, 2);
        break;

      case 'iyzico':
        $allowedCurrencies = ['TRY'];
        if (!in_array($baseCurrency, $allowedCurrencies, true)) {
          return response()->json([
            'error' => 'Invalid currency for iyzico payment.',
          ], 422);
        }
        $verifiedAmount = round($sourceAmount, 2);
        $verifiedCurrency = 'TRY';
        break;

      case 'yoco':
        $allowedCurrencies = ['ZAR'];
        if (!in_array($baseCurrency, $allowedCurrencies, true)) {
          return response()->json([
            'error' => 'Invalid currency for yoco payment.',
          ], 422);
        }
        $verifiedAmount = round($sourceAmount, 2);
        $verifiedCurrency = 'ZAR';
        break;

      default:
        $verifiedAmount = (float) intval($sourceAmount);
        break;
    }

    $verifiedAmountMinor = (int) round($verifiedAmount * 100);
    if ($verifiedAmountMinor <= 0) {
      return response()->json([
        'error' => 'Invalid verified amount for checkout.',
      ], 422);
    }

    return response()->json([
      'success' => true,
      'data' => [
        'charge_id' => (int) $charge->id,
        'gateway' => $gatewayKeyword,
        'gateway_name' => $onlineGateway->name,
        'source_amount' => round($sourceAmount, 2),
        'source_currency' => $baseCurrency,
        'verified_amount' => $verifiedAmount,
        'verified_currency' => $verifiedCurrency,
        'verified_amount_minor' => $verifiedAmountMinor,
      ],
    ], 200);
  }

  // POST /api/vendor/listings/{id}/feature-complete-online
  public function completeFeatureOnline(Request $request, $id)
  {
    $vendor = $request->user();
    $listing = Listing::where('vendor_id', $vendor->id)->findOrFail($id);

    $validator = Validator::make($request->all(), [
      'charge_id' => 'required|integer|exists:featured_listing_charges,id',
      'payment_method' => 'required|string|max:191',
      'transaction_id' => 'required|string|max:191',
      'transaction_details' => 'nullable',
    ]);

    if ($validator->fails()) {
      return response()->json(['errors' => $validator->errors()], 422);
    }

    $charge = FeaturedListingCharge::findOrFail((int) $request->input('charge_id'));

    $onlineGateway = OnlineGateway::query()
      ->where('name', $request->input('payment_method'))
      ->where('mobile_status', 1)
      ->whereIn('keyword', self::SUPPORTED_FEATURE_MOBILE_GATEWAYS)
      ->first();

    if (!$onlineGateway) {
      return response()->json([
        'error' => 'Invalid payment method.',
      ], 422);
    }

    $transactionId = trim((string) $request->input('transaction_id'));
    $existingOrder = FeatureOrder::query()
      ->where('listing_id', $listing->id)
      ->where('order_number', $transactionId)
      ->first();

    if (!empty($existingOrder)) {
      $promotionStatus = 'pending';
      if (
        $existingOrder->order_status === 'completed'
        && !empty($existingOrder->end_date)
        && $existingOrder->end_date >= Carbon::today()->toDateString()
      ) {
        $promotionStatus = 'featured';
      }

      return response()->json([
        'status' => 'success',
        'message' => 'Feature request already processed.',
        'data' => [
          'listing_id' => (int) $listing->id,
          'promotion_status' => $promotionStatus,
          'feature_order_id' => (int) $existingOrder->id,
        ],
      ], 200);
    }

    $vendorRecord = Vendor::find($vendor->id);
    $toMail = null;
    if (!empty($vendorRecord) && !empty($vendorRecord->to_mail)) {
      $toMail = $vendorRecord->to_mail;
    } elseif (!empty($vendorRecord) && !empty($vendorRecord->email)) {
      $toMail = $vendorRecord->email;
    } elseif (!empty($vendor->email)) {
      $toMail = $vendor->email;
    }

    $startDate = Carbon::now()->startOfDay();
    $endDate = $startDate->copy()->addDays($charge->days);

    $order = FeatureOrder::where('listing_id', $listing->id)->first();
    if (empty($order)) {
      $order = new FeatureOrder();
    }

    $order->listing_id = $listing->id;
    $order->vendor_id = $vendor->id;
    $order->vendor_mail = $toMail;
    $order->order_number = $transactionId;
    $order->total = $charge->price;
    $order->payment_method = $onlineGateway->name;
    $order->gateway_type = 'online';
    $order->payment_status = 'completed';
    $order->order_status = 'pending';
      $order->attachment = null;
      $order->invoice = null;
      $order->days = $charge->days;
      $order->start_date = $startDate;
      $order->end_date = $endDate;
      $order->save();
      VendorNotificationService::send(
        $vendor,
        'vendor_feature_request_submitted',
        'Feature request submitted',
        'Your featured listing request has been submitted and is waiting for review.',
        [
          'feature_order_id' => $order->id,
          'listing_id' => $listing->id,
        ]
      );

      // Keep this endpoint fast for mobile app flow.
    // Invoice generation and mail sending are intentionally skipped here.

    return response()->json([
      'status' => 'success',
      'message' => 'Feature request submitted successfully.',
      'data' => [
        'listing_id' => (int) $listing->id,
        'promotion_status' => 'pending',
        'feature_order_id' => (int) $order->id,
      ],
    ], 200);
  }

  // POST /api/vendor/listings/{id}/visibility
  public function apiUpdateVisibility(Request $request, $id)
  {
    $vendor = $request->user();

    $request->validate([
      'visibility' => 'required|in:0,1',
    ]);

    $currentPackage = VendorPermissionHelper::packagePermission($vendor->id);
    if ($currentPackage == '[]') {
      return response()->json([
        'status'  => 'error',
        'message' => 'Please buy a plan to manage hide/show.',
      ], 422);
    }

    $listing = Listing::where('vendor_id', $vendor->id)->findOrFail($id);
    $listing->update([
      'visibility' => (int) $request->visibility,
    ]);

    return response()->json([
      'status'  => 'success',
      'message' => (int) $request->visibility === 1
        ? 'Listing shown successfully.'
        : 'Listing hidden successfully.',
      'data'    => [
        'id'         => $listing->id,
        'visibility' => (int) $listing->visibility,
      ],
    ]);
  }

  // POST /api/vendor/listings/{id}/delete
  public function apiDelete(Request $request, $id)
  {
    $vendor = $request->user();
    $listing = Listing::where('vendor_id', $vendor->id)->findOrFail($id);

    // Reuse existing deep cleanup routine used by web vendor flow.
    $this->delete($listing->id);

    return response()->json([
      'status'  => 'success',
      'message' => 'Listing deleted successfully.',
    ]);
  }

  private function getBaseCountryId($countryId, $language)
  {
    $position = Country::where('language_id', $language->id)
        ->orderBy('id')
        ->pluck('id')
        ->search($countryId);

    if ($position === false) {
      return $countryId;
    }

    $enLang = Language::where('code', 'en')->first();
    return Country::where('language_id', $enLang->id)
        ->orderBy('id')
        ->skip($position)
        ->value('id') ?: $countryId;
  }

  private function getBaseStateId($stateId, $language)
  {
    $position = State::where('language_id', $language->id)
        ->orderBy('id')
        ->pluck('id')
        ->search($stateId);

    if ($position === false) {
      return $stateId;
    }

    $enLang = Language::where('code', 'en')->first();
    return State::where('language_id', $enLang->id)
        ->orderBy('id')
        ->skip($position)
        ->value('id') ?: $stateId;
  }
}
