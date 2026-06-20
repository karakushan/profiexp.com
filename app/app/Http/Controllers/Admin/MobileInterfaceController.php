<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Helpers\UploadFile;
use App\Models\Language;
use App\Models\MobileInterfaceSetting;
use App\Models\PaymentGateway\OnlineGateway;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use DB;
use Illuminate\Support\Facades\Session;

class MobileInterfaceController extends Controller
{
  //Mobile App Settings main page
  public function index(Request $request)
  {
    $language = Language::where('code', $request->language)->firstOrFail();
    $information['language'] = $language;
    return view('admin.mobile-interface.index', $information);
  }

  //general setting view and update function
  public function setting(Request $request)
  {
    $language = Language::where('code', $request->language)->firstOrFail();
    $data['language'] = $language;
    $data['data'] = DB::table('basic_settings')->select('app_logo', 'app_fav', 'app_primary_color', 'app_breadcrumb_color', 'app_breadcrumb_overlay_opacity', 'app_google_map_status', 'app_firebase_json_file')
      ->first();
    $data['config'] = include(public_path('config.php'));
    return view('admin.mobile-interface.general-settings', $data);
  }

  public function settingUpdate(Request $request)
  {
    $bs = DB::table('basic_settings')->select('app_fav', 'app_logo')->first();
    $rules = [
      'api_base_url' => 'required|url',
      'app_primary_color' => 'required',
      'app_breadcrumb_color' => 'required',
      'app_breadcrumb_overlay_opacity' => 'required',
    ];

    if (is_null($bs->app_fav)) {
      $rules['app_fav'] = 'required|mimes:png,jpg,jpeg,svg';
    }
    if (is_null($bs->app_logo)) {
      $rules['app_logo'] = 'required|mimes:png,jpg,jpeg,svg';
    }

    $validator = Validator::make($request->all(), $rules);
    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors())->withInput();
    }
    $publicConfig = include base_path('public/config.php');
    $publicConfig['PUBLIC_API_BASE'] = $request->api_base_url;
    $configContent = "<?php\n\nreturn " . var_export($publicConfig, true) . ";\n";
    file_put_contents(base_path('public/config.php'), $configContent);


    if ($request->hasFile('app_fav')) {
      if (isset($bs->app_fav)) {
        $favicon = UploadFile::update(public_path('assets/img/mobile-interface/'), $request->file('app_fav'), $bs->app_fav);
      } else {
        $favicon = UploadFile::store(public_path('assets/img/mobile-interface/'), $request->file('app_fav'));
      }
    } else {
      $favicon = $bs->app_fav;
    }

    if ($request->hasFile('app_logo')) {
      if (!empty($bs->app_logo)) {
        $app_logo = UploadFile::update(public_path('assets/img/mobile-interface/'), $request->file('app_logo'), $bs->app_logo);
      } else {
        $app_logo = UploadFile::store(public_path('assets/img/mobile-interface/'), $request->file('app_logo'));
      }
    } else {
      $app_logo = $bs->app_logo;
    }



    DB::table('basic_settings')->updateOrInsert(
      ['uniqid' => 12345],
      [
        'app_fav' => $favicon ?? "",
        'app_logo' => $app_logo ?? "",

        'app_primary_color' => $request->app_primary_color,
        'app_breadcrumb_color' => $request->app_breadcrumb_color,
        'app_breadcrumb_overlay_opacity' => $request->app_breadcrumb_overlay_opacity,
      ]
    );

    return redirect()->back()->with('success', __('Updated Successfully'));
  }

  //payment gateways view and update function
  public function paymentGateways(Request $request)
  {
    $data['data'] = include(public_path('config.php'));
    $language = Language::where('code', $request->language)->firstOrFail();
    $data['language'] = $language;
    $gateways = [
      'paypal',
      'paystack',
      'flutterwave',
      'mercadopago',
      'mollie',
      'stripe',
      'authorize.net',
      'phonepe',
      'paytabs',
      'midtrans',
      'toyyibpay',
      'myfatoorah',
      'xendit',
      'monnify',
      'now_payments',
      'razorpay',
      'yoco',
      'iyzico',
      'instamojo',
      'paytabs',
      'perfect_money',
      'paytm'
    ];

    foreach ($gateways as $gateway) {
      $key = str_replace('.', '_', $gateway);

      $data[$key] = OnlineGateway::where('keyword', $gateway)
        ->select('mobile_status', 'mobile_information')
        ->first();
    }
    return view('admin.mobile-interface.gateway', $data);
  }

  //plugins view function
  public function plugins(Request $request)
  {
    $data['data'] = DB::table('basic_settings')->select('app_firebase_json_file', 'app_google_map_status')
      ->first();
    $language = Language::where('code', $request->language)->firstOrFail();
    $data['language'] = $language;
    return view('admin.mobile-interface.plugins', $data);
  }

  public function updateFirebase(Request $request)
  {
    $request->validate([
      'app_firebase_json_file' => 'required|mimes:json',
    ], [
      'app_firebase_json_file.required' => __('The admin sdk json file is required.'),
      'app_firebase_json_file.mimes' => __('Only json files are supported.'),
    ]);

    $bs = DB::table('basic_settings')
      ->select('app_firebase_json_file')
      ->where('uniqid', 12345)
      ->first();

    // if json file already exists and user wants to update it
    if ($request->hasFile('app_firebase_json_file') && !is_null($bs->app_firebase_json_file)) {
      $file = UploadFile::update(public_path('assets/file/'), $request->file('app_firebase_json_file'), $bs->app_firebase_json_file);
    }

    //if json file doesn't exist and user wants to upload it
    if ($request->hasFile('app_firebase_json_file') && is_null($bs->app_firebase_json_file)) {
      $file = UploadFile::store(public_path('assets/file/'), $request->file('app_firebase_json_file'));
    }

    DB::table('basic_settings')->updateOrInsert(
      ['uniqid' => 12345],
      [
        'app_firebase_json_file' => $request->hasFile('app_firebase_json_file') ? $file : $bs->app_firebase_json_file,
      ]
    );

    session()->flash('success', __('Updated successfully!'));
    return redirect()->back();
  }

  public function updateGeo(Request $request)
  {
    $rules = [
      'app_google_map_status' => 'required',
    ];
    $messages = [];
    $validator = Validator::make($request->all(), $rules, $messages);
    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator);
    }

    DB::table('basic_settings')->updateOrInsert(
      ['uniqid' => 12345],
      [
        'app_google_map_status' => $request->app_google_map_status
      ]
    );

    Session::flash('success', 'Updated Successfully');
    return redirect()->back();
  }

  public function content(Request $request)
  {
    $language = Language::where('code', $request->language)->firstOrFail();
    $data['langs']  = Language::get();
    $data['data'] = MobileInterfaceSetting::where('language_id', $language->id)->first();
    $data['language'] = $language;
    return view('admin.mobile-interface.content', $data);
  }
  public function update(Request $request)
  {

    $language = Language::where('code', $request->language)->firstOrFail();
    $mobileInterface = MobileInterfaceSetting::where('language_id', $language->id)->first();
    $rules = [
      'category_listing_section_title' => 'required | max:255',
      'featured_listing_section_title' => 'required | max:255',
      'banner_title' => 'required | max:255',
      'banner_button_text' => 'required | max:255',
      'banner_button_url' => 'required | max:255',
    ];

    if (empty($mobileInterface->banner_background_image)) {
      $rules['banner_background_image'] = 'required';
    }

    if (empty($mobileInterface->banner_image)) {
      $rules['banner_image'] = 'required';
    }

    $validator = Validator::make($request->all(), $rules);
    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors())->withInput();
    }


    if ($request->hasFile('banner_background_image')) {
      if (!empty($mobileInterface->banner_background_image)) {
        $banner_background_image = UploadFile::update(public_path('assets/img/mobile-interface/'), $request->file('banner_background_image'), $mobileInterface->banner_background_image);
      } else {
        $banner_background_image = UploadFile::store(public_path('assets/img/mobile-interface/'), $request->file('banner_background_image'));
      }
    } else {
      $banner_background_image =  $mobileInterface->banner_background_image;
    }


    if ($request->hasFile('banner_image')) {
      if (!empty($mobileInterface->banner_image)) {
        $banner_image = UploadFile::update(public_path('assets/img/mobile-interface/'), $request->file('banner_image'), $mobileInterface->banner_image);
      } else {
        $banner_image = UploadFile::store(public_path('assets/img/mobile-interface/'), $request->file('banner_image'));
      }
    } else {
      $banner_image =  $mobileInterface->banner_image;
    }

    MobileInterfaceSetting::updateOrInsert(
      ['language_id' => $language->id],
      [
        'category_listing_section_title' => $request->category_listing_section_title,
        'featured_listing_section_title' => $request->featured_listing_section_title,

        'banner_image' => $banner_image ?? "",
        'banner_background_image' => $banner_background_image ?? "",
        'banner_title' => $request->banner_title,
        'banner_button_text' => $request->banner_button_text,
        'banner_button_url' => $request->banner_button_url,
      ]
    );

    session()->flash('success', __('Updated successfully'));
    return redirect()->back()->with('success', __('Updated Successfully'));
  }
}
