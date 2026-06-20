<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Helpers\MegaMailer;
use App\Http\Helpers\VendorPermissionHelper;
use App\Models\Admin;
use App\Models\BasicSettings\Basic;
use App\Models\BusinessHour;
use App\Models\ClaimListing;
use App\Models\FeaturedListingCharge;
use App\Models\FeatureOrder;
use App\Models\Language;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingFeatureContent;
use App\Models\Listing\ListingMessage;
use App\Models\Listing\ListingProduct;
use App\Models\Listing\ListingReview;
use App\Models\Listing\ProductMessage;
use App\Models\Membership;
use App\Models\Package;
use App\Models\PaymentGateway\OfflineGateway;
use App\Models\PaymentGateway\OnlineGateway;
use App\Models\SupportTicket;
use App\Models\Vendor;
use App\Models\VendorInfo;
use App\Models\Visitor;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use App\Services\VendorNotificationService;

class VendorManagementController extends Controller
{
    public function settings()
    {
        $setting = DB::table('basic_settings')->where('uniqid', 12345)->select('vendor_email_verification', 'vendor_admin_approval', 'admin_approval_notice')->first();
        return view('admin.end-user.vendor.settings', compact('setting'));
    }
    //update_setting
    public function update_setting(Request $request)
    {
        if ($request->vendor_email_verification) {
            $vendor_email_verification = 1;
        } else {
            $vendor_email_verification = 0;
        }
        if ($request->vendor_admin_approval) {
            $vendor_admin_approval = 1;
        } else {
            $vendor_admin_approval = 0;
        }
        // finally, store the favicon into db
        DB::table('basic_settings')->updateOrInsert(
            ['uniqid' => 12345],
            [
                'vendor_email_verification' => $vendor_email_verification,
                'vendor_admin_approval' => $vendor_admin_approval,
                'admin_approval_notice' => $request->admin_approval_notice,
            ]
        );

        Session::flash('success', __('Update Settings Successfully') . '!');
        return back();
    }

    public function index(Request $request)
    {
        $searchKey = null;

        if ($request->filled('info')) {
            $searchKey = $request['info'];
        }

        $vendors = Vendor::when($searchKey, function ($query, $searchKey) {
            return $query->where('username', 'like', '%' . $searchKey . '%')
                ->orWhere('email', 'like', '%' . $searchKey . '%');
        })
            ->where('id', '!=', 0)
            ->orderBy('id', 'desc')
            ->paginate(10);


        return view('admin.end-user.vendor.index', compact('vendors'));
    }

    //add
    public function add(Request $request)
    {
        // first, get the language info from db
        $language = Language::query()->where('code', '=', $request->language)->first();
        $information['language'] = $language;
        $information['languages'] = Language::get();
        return view('admin.end-user.vendor.create', $information);
    }
    public function create(Request $request)
    {
        $admin = Admin::select('username')->first();
        $admin_username = $admin->username;
        $rules = [
            'username' => "required|unique:vendors|not_in:$admin_username",
            'email' => 'required|email|unique:vendors',
            'password' => 'required|min:6',
        ];


        $languages = Language::get();
        foreach ($languages as $language) {
            $rules[$language->code . '_name'] = 'required';
        }
        $messages = [];
        foreach ($languages as $language) {
            $messages[$language->code . '_name.required'] = "The Name field is required for {$language->name} Language";
        }

        $validator = Validator::make($request->all(), $rules, $messages);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()
            ], 400);
        }

        $in = $request->all();
        $in['password'] = Hash::make($request->password);
        $in['status'] = 1;

        $file = $request->file('photo');
        if ($file) {
            $extension = $file->getClientOriginalExtension();
            $directory = public_path('assets/admin/img/vendor-photo/');
            $fileName = uniqid() . '.' . $extension;
            @mkdir($directory, 0775, true);
            $file->move($directory, $fileName);
            $in['photo'] = $fileName;
        }
        $in['email_verified_at'] = Carbon::now();
        $vendor = Vendor::create($in);

        $vendor_id = $vendor->id;
        foreach ($languages as $language) {
            $vendorInfo = new VendorInfo();
            $vendorInfo->language_id = $language->id;
            $vendorInfo->vendor_id = $vendor_id;
            $vendorInfo->name = $request[$language->code . '_name'];
            $vendorInfo->country = $request[$language->code . '_country'];
            $vendorInfo->city = $request[$language->code . '_city'];
            $vendorInfo->state = $request[$language->code . '_state'];
            $vendorInfo->zip_code = $request[$language->code . '_zip_code'];
            $vendorInfo->address = $request[$language->code . '_address'];
            $vendorInfo->details = $request[$language->code . '_details'];
            $vendorInfo->save();
        }


        Session::flash('success', __('Add Vendor Successfully') . '!');
        return Response::json(['status' => 'success'], 200);
    }

    public function show($id)
    {

        $information['langs'] = Language::all();
        $information['currencyInfo'] = $this->getCurrencyInfo();
        $charges = FeaturedListingCharge::orderBy('days')->get();
        $information['charges'] = $charges;
        $information['onlineGateways'] = OnlineGateway::where('status', 1)->get();

        $information['offline_gateways'] = OfflineGateway::where('status', 1)->orderBy('serial_number', 'asc')->get();

        $stripe = OnlineGateway::where('keyword', 'stripe')->first();
        $stripe_info = json_decode($stripe->information, true);
        $information['stripe_key'] = $stripe_info['key'];

        $authorizenet = OnlineGateway::query()->whereKeyword('authorize.net')->first();
        $anetInfo = json_decode($authorizenet->information);

        if ($anetInfo->sandbox_check == 1) {
            $information['anetSource'] = 'https://jstest.authorize.net/v1/Accept.js';
        } else {
            $information['anetSource'] = 'https://js.authorize.net/v1/Accept.js';
        }

        $currency_info = $this->getCurrencyInfo();
        $information['currency_info'] = $currency_info;

        $language = Language::where('code', request()->input('language'))->firstOrFail();
        $information['language'] = $language;
        $vendor = Vendor::with([
            'vendor_info' => function ($query) use ($language) {
                return $query->where('language_id', $language->id);
            }
        ])->where('id', $id)->firstOrFail();
        $information['vendor'] = $vendor;

        $information['langs'] = Language::all();
        $information['packages'] = Package::query()->where('status', '1')->get();
        $online = OnlineGateway::query()->where('status', 1)->get();
        $offline = OfflineGateway::where('status', 1)->get();
        $information['gateways'] = $online->merge($offline);

        $information['listings'] = Listing::with([
            'listing_content' => function ($q) use ($language) {
                $q->where('language_id', $language->id);
            },
        ])->where('vendor_id', $id)
            ->orderBy('id', 'desc')
            ->get();

        return view('admin.end-user.vendor.details', $information);
    }
    public function updateAccountStatus(Request $request, $id)
    {

        $user = Vendor::find($id);
        if ($request->account_status == 1) {
            $user->update(['status' => 1]);
            $message = 'Your vendor account has been activated by admin.';
        } else {
            $user->update(['status' => 0]);
            $message = 'Your vendor account has been deactivated by admin.';
        }
        VendorNotificationService::send(
            $user,
            'vendor_account_status_updated',
            'Account status updated',
            $message,
            [
                'vendor_id' => $user->id,
                'status' => $user->status,
            ]
        );
        Session::flash('success', __('Account status updated successfully') . '!');

        return redirect()->back();
    }

    public function updateEmailStatus(Request $request, $id)
    {
        $vendor = Vendor::find($id);
        if ($request->email_status == 1) {
            $vendor->update(['email_verified_at' => now()]);
            $message = 'Your vendor email address has been marked as verified.';
        } else {
            $vendor->update(['email_verified_at' => NULL]);
            $message = 'Your vendor email verification status has been removed.';
        }
        VendorNotificationService::send(
            $vendor,
            'vendor_email_status_updated',
            'Email status updated',
            $message,
            [
                'vendor_id' => $vendor->id,
                'email' => $vendor->email,
            ]
        );
        Session::flash('success', __('Email status updated successfully') . '!');

        return redirect()->back();
    }
    public function changePassword($id)
    {
        $userInfo = Vendor::findOrFail($id);

        return view('admin.end-user.vendor.change-password', compact('userInfo'));
    }
    public function updatePassword(Request $request, $id)
    {
        $rules = [
            'new_password' => 'required|confirmed',
            'new_password_confirmation' => 'required'
        ];

        $messages = [
            'new_password.confirmed' => 'Password confirmation does not match.',
            'new_password_confirmation.required' => 'The confirm new password field is required.'
        ];

        $validator = Validator::make($request->all(), $rules, $messages);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()->toArray()
            ], 400);
        }

        $user = Vendor::find($id);

        $user->update([
            'password' => Hash::make($request->new_password)
        ]);
        VendorNotificationService::send(
            $user,
            'vendor_security_password_changed',
            'Password changed',
            'Your vendor account password was changed by admin.',
            [
                'vendor_id' => $user->id,
            ]
        );

        Session::flash('success', __('Password updated successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }

    public function edit($id)
    {
        $information['languages'] = Language::get();
        $vendor = Vendor::where('id', $id)->firstOrFail();
        $information['vendor'] = $vendor;
        $information['currencyInfo'] = $this->getCurrencyInfo();
        return view('admin.end-user.vendor.edit', $information);
    }

    //update
    public function update(Request $request, $id, Vendor $vendor)
    {
        $admin = Admin::select('username')->first();
        $admin_username = $admin->username;
        $rules = [

            'username' => [
                'required',
                Rule::unique('vendors', 'username')->ignore($id),
                Rule::notIn([$admin_username]),
            ],
            'email' => [
                'required',
                'email',
                Rule::unique('vendors', 'email')->ignore($id)
            ]
        ];

        if ($request->hasFile('photo')) {
            $rules['photo'] = 'mimes:png,jpeg,jpg|dimensions:min_width=80,max_width=80,min_width=80,min_height=80';
        }

        $languages = Language::get();
        foreach ($languages as $language) {
            $rules[$language->code . '_name'] = 'required';
        }

        $messages = [];

        foreach ($languages as $language) {
            $messages[$language->code . '_name.required'] = "The Name field is required for {$language->name} Language";
        }

        $validator = Validator::make($request->all(), $rules, $messages);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()
            ], 400);
        }


        $in = $request->all();
        $vendor  = Vendor::where('id', $id)->first();
        $file = $request->file('photo');
        if ($file) {
            $extension = $file->getClientOriginalExtension();
            $directory = public_path('assets/admin/img/vendor-photo/');
            $fileName = uniqid() . '.' . $extension;
            @mkdir($directory, 0775, true);
            $file->move($directory, $fileName);

            @unlink(public_path('assets/admin/img/vendor-photo/') . $vendor->photo);
            $in['photo'] = $fileName;
        }


        if ($request->show_email_addresss) {
            $in['show_email_addresss'] = 1;
        } else {
            $in['show_email_addresss'] = 0;
        }
        if ($request->show_phone_number) {
            $in['show_phone_number'] = 1;
        } else {
            $in['show_phone_number'] = 0;
        }
        if ($request->show_contact_form) {
            $in['show_contact_form'] = 1;
        } else {
            $in['show_contact_form'] = 0;
        }



        $vendor->update($in);

        $languages = Language::get();
        $vendor_id = $vendor->id;
        foreach ($languages as $language) {
            $vendorInfo = VendorInfo::where('vendor_id', $vendor_id)->where('language_id', $language->id)->first();
            if ($vendorInfo == NULL) {
                $vendorInfo = new VendorInfo();
            }
            $vendorInfo->language_id = $language->id;
            $vendorInfo->vendor_id = $vendor_id;
            $vendorInfo->name = $request[$language->code . '_name'];
            $vendorInfo->country = $request[$language->code . '_country'];
            $vendorInfo->city = $request[$language->code . '_city'];
            $vendorInfo->state = $request[$language->code . '_state'];
            $vendorInfo->zip_code = $request[$language->code . '_zip_code'];
            $vendorInfo->address = $request[$language->code . '_address'];
            $vendorInfo->details = $request[$language->code . '_details'];
            $vendorInfo->save();
        }
        Session::flash('success', __('Vendor updated successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }


    public function sendMail($memb, $package, $paymentMethod, $vendor, $bs, $mailType, $replacedPackage = NULL, $removedPackage = NULL)
    {

        if ($mailType != 'admin_removed_current_package' && $mailType != 'admin_removed_next_package') {
            $transaction_id = VendorPermissionHelper::uniqidReal(8);
            $activation = $memb->start_date;
            $expire = $memb->expire_date;
            $info['start_date'] = $activation->toFormattedDateString();
            $info['expire_date'] = $expire->toFormattedDateString();
            $info['payment_method'] = $paymentMethod;
            $lastMemb = $vendor->memberships()->orderBy('id', 'DESC')->first();

            $file_name = $this->makeInvoice($info, "membership", $vendor, NULL, $package->price, "Stripe", $vendor->phone, $bs->base_currency_symbol_position, $bs->base_currency_symbol, $bs->base_currency_text, $transaction_id, $package->title, $lastMemb);
        }

        $mailer = new MegaMailer();
        $data = [
            'toMail' => $vendor->email,
            'toName' => $vendor->username,
            'username' => $vendor->username,
            'website_title' => $bs->website_title,
            'templateType' => $mailType
        ];

        if ($mailType != 'admin_removed_current_package' && $mailType != 'admin_removed_next_package') {
            $data['package_title'] = $package->title;
            $data['package_price'] = ($bs->base_currency_text_position == 'left' ? $bs->base_currency_text . ' ' : '') . $package->price . ($bs->base_currency_text_position == 'right' ? ' ' . $bs->base_currency_text : '');
            $data['activation_date'] = $activation->toFormattedDateString();
            $data['expire_date'] = Carbon::parse($expire->toFormattedDateString())->format('Y') == '9999' ? 'Lifetime' : $expire->toFormattedDateString();
            $data['membership_invoice'] = $file_name;
        }
        if ($mailType != 'admin_removed_current_package' || $mailType != 'admin_removed_next_package') {
            $data['removed_package_title'] = $removedPackage;
        }

        if (!empty($replacedPackage)) {
            $data['replaced_package'] = $replacedPackage;
        }

        $mailer->mailFromAdmin($data);
        @unlink(public_path('assets/front/invoices/' . $file_name));
    }

    public function addCurrPackage(Request $request)
    {
        $vendor_id = $request->vendor_id;
        $vendor = Vendor::where('id', $vendor_id)->first();
        $bs = Basic::first();

        $selectedPackage = Package::find($request->package_id);

        // calculate expire date for selected package
        if ($selectedPackage->term == 'monthly') {
            $exDate = Carbon::now()->addMonth()->format('d-m-Y');
        } elseif ($selectedPackage->term == 'yearly') {
            $exDate = Carbon::now()->addYear()->format('d-m-Y');
        } elseif ($selectedPackage->term == 'lifetime') {
            $exDate = Carbon::maxValue()->format('d-m-Y');
        }
        // store a new membership for selected package
        $selectedMemb = Membership::create([
            'price' => $selectedPackage->price,
            'currency' => $bs->base_currency_text,
            'currency_symbol' => $bs->base_currency_symbol,
            'payment_method' => $request->payment_method,
            'transaction_id' => uniqid(),
            'status' => 1,
            'receipt' => NULL,
            'transaction_details' => NULL,
            'settings' => null,
            'package_id' => $selectedPackage->id,
            'vendor_id' => $vendor_id,
            'start_date' => Carbon::parse(Carbon::now()->format('d-m-Y')),
            'expire_date' => Carbon::parse($exDate),
            'is_trial' => 0,
            'trial_days' => 0,
            'ai_engine' => $selectedPackage->ai_engine ?? null,
            'ai_token_limit' => $selectedPackage->ai_token_limit ?? 0,
            'ai_image_limit' => $selectedPackage->ai_image_limit ?? 0,
        ]);

        $this->sendMail($selectedMemb, $selectedPackage, $request->payment_method, $vendor, $bs, 'admin_added_current_package');
        VendorNotificationService::send(
            $vendor,
            'vendor_current_package_updated',
            'Current package updated',
            'Admin added "' . $selectedPackage->title . '" as your current package.',
            [
                'package_id' => $selectedPackage->id,
                'membership_id' => $selectedMemb->id,
            ]
        );

        Session::flash('success', __('Current Package has been added successfully') . '!');
        return response()->json(['status' => 'success'], 200);
    }


    public function changeCurrPackage(Request $request)
    {
        $vendor_id = $request->vendor_id;
        $vendor = Vendor::findOrFail($vendor_id);
        $currMembership = VendorPermissionHelper::currMembOrPending($vendor_id);
        $nextMembership = VendorPermissionHelper::nextMembership($vendor_id);

        $bs = Basic::first();

        $selectedPackage = Package::find($request->package_id);

        // if the vendor has a next package to activate & selected package is 'lifetime' package
        if (!empty($nextMembership) && $selectedPackage->term == 'lifetime') {
            Session::flash('warning', __('To add a Lifetime package as Current Package, You have to remove the next package') . '!');
            return back();
        }

        // expire the current package
        $currMembership->expire_date = Carbon::parse(Carbon::now()->subDay()->format('d-m-Y'));
        $currMembership->modified = 1;
        if ($currMembership->status == 0) {
            $currMembership->status = 2;
        }
        $currMembership->save();

        // calculate expire date for selected package
        if ($selectedPackage->term == 'monthly') {
            $exDate = Carbon::now()->addMonth()->format('d-m-Y');
        } elseif ($selectedPackage->term == 'yearly') {
            $exDate = Carbon::now()->addYear()->format('d-m-Y');
        } elseif ($selectedPackage->term == 'lifetime') {
            $exDate = Carbon::maxValue()->format('d-m-Y');
        }
        // store a new membership for selected package
        $selectedMemb = Membership::create([
            'price' => $selectedPackage->price,
            'currency' => $bs->base_currency_text,
            'currency_symbol' => $bs->base_currency_symbol,
            'payment_method' => $request->payment_method,
            'transaction_id' => uniqid(),
            'status' => 1,
            'receipt' => NULL,
            'transaction_details' => NULL,
            'settings' => null,
            'package_id' => $selectedPackage->id,
            'vendor_id' => $vendor_id,
            'start_date' => Carbon::parse(Carbon::now()->format('d-m-Y')),
            'expire_date' => Carbon::parse($exDate),
            'is_trial' => 0,
            'trial_days' => 0,
            'ai_engine' => $selectedPackage->ai_engine ?? null,
            'ai_token_limit' => $selectedPackage->ai_token_limit ?? 0,
            'ai_image_limit' => $selectedPackage->ai_image_limit ?? 0,
        ]);

        // if the user has a next package to activate & selected package is not 'lifetime' package
        if (!empty($nextMembership) && $selectedPackage->term != 'lifetime') {
            $nextPackage = Package::find($nextMembership->package_id);

            // calculate & store next membership's start_date
            $nextMembership->start_date = Carbon::parse(Carbon::parse($exDate)->addDay()->format('d-m-Y'));

            // calculate & store expire date for next membership
            if ($nextPackage->term == 'monthly') {
                $exDate = Carbon::parse(Carbon::parse(Carbon::parse($exDate)->addDay()->format('d-m-Y'))->addMonth()->format('d-m-Y'));
            } elseif ($nextPackage->term == 'yearly') {
                $exDate = Carbon::parse(Carbon::parse(Carbon::parse($exDate)->addDay()->format('d-m-Y'))->addYear()->format('d-m-Y'));
            } else {
                $exDate = Carbon::parse(Carbon::maxValue()->format('d-m-Y'));
            }
            $nextMembership->expire_date = $exDate;
            $nextMembership->save();
        }

        $currentPackage = Package::select('title')->findOrFail($currMembership->package_id);
        $this->sendMail($selectedMemb, $selectedPackage, $request->payment_method, $vendor, $bs, 'admin_changed_current_package', $currentPackage->title);
        VendorNotificationService::send(
            $vendor,
            'vendor_current_package_updated',
            'Current package updated',
            'Admin changed your current package to "' . $selectedPackage->title . '".',
            [
                'package_id' => $selectedPackage->id,
                'membership_id' => $selectedMemb->id,
            ]
        );

        Session::flash('success', __('Current Package changed successfully') . '!');
        return back();
    }

    public function removeCurrPackage(Request $request)
    {
        $vendor_id = $request->vendor_id;
        $vendor = Vendor::where('id', $vendor_id)->firstOrFail();
        $currMembership = VendorPermissionHelper::currMembOrPending($vendor_id);
        $currPackage = Package::select('title')->findOrFail($currMembership->package_id);
        $nextMembership = VendorPermissionHelper::nextMembership($vendor_id);
        $bs = Basic::first();

        $today = Carbon::now();

        // just expire the current package
        $currMembership->expire_date = $today->subDay();
        $currMembership->modified = 1;
        if ($currMembership->status == 0) {
            $currMembership->status = 2;
        }
        $currMembership->save();

        // if next package exists
        if (!empty($nextMembership)) {
            $nextPackage = Package::find($nextMembership->package_id);

            $nextMembership->start_date = Carbon::parse(Carbon::today()->format('d-m-Y'));
            if ($nextPackage->term == 'monthly') {
                $nextMembership->expire_date = Carbon::parse(Carbon::today()->addMonth()->format('d-m-Y'));
            } elseif ($nextPackage->term == 'yearly') {
                $nextMembership->expire_date = Carbon::parse(Carbon::today()->addYear()->format('d-m-Y'));
            } elseif ($nextPackage->term == 'lifetime') {
                $nextMembership->expire_date = Carbon::parse(Carbon::maxValue()->format('d-m-Y'));
            }
            $nextMembership->save();
        }

        $this->sendMail(NULL, NULL, $request->payment_method, $vendor, $bs,  'admin_removed_current_package', NULL, $currPackage->title);
        VendorNotificationService::send(
            $vendor,
            'vendor_current_package_updated',
            'Current package removed',
            'Admin removed your current package "' . $currPackage->title . '".',
            [
                'vendor_id' => $vendor->id,
            ]
        );

        Session::flash('success', __('Current Package removed successfully') . '!');
        return back();
    }

    public function addNextPackage(Request $request)
    {
        $vendor_id = $request->vendor_id;

        $hasPendingMemb = VendorPermissionHelper::hasPendingMembership($vendor_id);
        if ($hasPendingMemb) {
            Session::flash('warning', __('This user already has a Pending Package. Please take an action (change / remove / approve / reject) for that package first') . '!');
            return response()->json(['status' => 'success'], 200);
        }

        $currMembership = VendorPermissionHelper::userPackage($vendor_id);
        $currPackage = Package::find($currMembership->package_id);
        $vendor = Vendor::where('id', $vendor_id)->first();
        $bs = Basic::first();

        $selectedPackage = Package::find($request->package_id);

        if ($currMembership->is_trial == 1) {
            Session::flash('warning', __('If your current package is trial package, then you have to change / remove the current package first') . '!');
            return response()->json(['status' => 'success'], 200);
        }


        // if current package is not lifetime package
        if ($currPackage->term != 'lifetime') {
            // calculate expire date for selected package
            if ($selectedPackage->term == 'monthly') {
                $exDate = Carbon::parse($currMembership->expire_date)->addDay()->addMonth()->format('d-m-Y');
            } elseif ($selectedPackage->term == 'yearly') {
                $exDate = Carbon::parse($currMembership->expire_date)->addDay()->addYear()->format('d-m-Y');
            } elseif ($selectedPackage->term == 'lifetime') {
                $exDate = Carbon::parse(Carbon::maxValue()->format('d-m-Y'));
            }
            // store a new membership for selected package
            $selectedMemb = Membership::create([
                'price' => $selectedPackage->price,
                'currency' => $bs->base_currency_text,
                'currency_symbol' => $bs->base_currency_symbol,
                'payment_method' => $request->payment_method,
                'transaction_id' => uniqid(),
                'status' => 1,
                'receipt' => NULL,
                'transaction_details' => NULL,
                'settings' => null,
                'package_id' => $selectedPackage->id,
                'vendor_id' => $vendor_id,
                'start_date' => Carbon::parse(Carbon::parse($currMembership->expire_date)->addDay()->format('d-m-Y')),
                'expire_date' => Carbon::parse($exDate),
                'is_trial' => 0,
                'trial_days' => 0,
                'ai_engine' => $selectedPackage->ai_engine ?? null,
                'ai_token_limit' => $selectedPackage->ai_token_limit ?? 0,
                'ai_image_limit' => $selectedPackage->ai_image_limit ?? 0,
            ]);

            $this->sendMail($selectedMemb, $selectedPackage, $request->payment_method, $vendor, $bs, 'admin_added_next_package');
            VendorNotificationService::send(
                $vendor,
                'vendor_next_package_updated',
                'Next package scheduled',
                'Admin scheduled "' . $selectedPackage->title . '" as your next package.',
                [
                    'package_id' => $selectedPackage->id,
                    'membership_id' => $selectedMemb->id,
                ]
            );
        } else {
            Session::flash('warning', __('If your current package is lifetime package, then you have to change / remove the current package first') . '!');
            return response()->json(['status' => 'success'], 200);
        }

        Session::flash('success', __('Next Package has been added successfully') . '!');
        return response()->json(['status' => 'success'], 200);
    }

    public function changeNextPackage(Request $request)
    {
        $vendor_id = $request->vendor_id;
        $vendor = Vendor::where('id', $vendor_id)->first();
        $bs = Basic::first();
        $nextMembership = VendorPermissionHelper::nextMembership($vendor_id);
        $nextPackage = Package::find($nextMembership->package_id);
        $selectedPackage = Package::find($request->package_id);

        $prevStartDate = $nextMembership->start_date;
        // set the start_date to unlimited
        $nextMembership->start_date = Carbon::parse(Carbon::maxValue()->format('d-m-Y'));
        $nextMembership->modified = 1;
        $nextMembership->save();

        // calculate expire date for selected package
        if ($selectedPackage->term == 'monthly') {
            $exDate = Carbon::parse($prevStartDate)->addMonth()->format('d-m-Y');
        } elseif ($selectedPackage->term == 'yearly') {
            $exDate = Carbon::parse($prevStartDate)->addYear()->format('d-m-Y');
        } elseif ($selectedPackage->term == 'lifetime') {
            $exDate = Carbon::parse(Carbon::maxValue()->format('d-m-Y'));
        }

        // store a new membership for selected package
        $selectedMemb = Membership::create([
            'price' => $selectedPackage->price,
            'currency' => $bs->base_currency_text,
            'currency_symbol' => $bs->base_currency_symbol,
            'payment_method' => $request->payment_method,
            'transaction_id' => uniqid(),
            'status' => 1,
            'receipt' => NULL,
            'transaction_details' => NULL,
            'settings' => json_encode($bs),
            'package_id' => $selectedPackage->id,
            'vendor_id' => $vendor_id,
            'start_date' => Carbon::parse($prevStartDate),
            'expire_date' => Carbon::parse($exDate),
            'is_trial' => 0,
            'trial_days' => 0,
            'ai_engine' => $selectedPackage->ai_engine ?? null,
            'ai_token_limit' => $selectedPackage->ai_token_limit ?? 0,
            'ai_image_limit' => $selectedPackage->ai_image_limit ?? 0,
        ]);

        $this->sendMail($selectedMemb, $selectedPackage, $request->payment_method, $vendor, $bs, 'admin_changed_next_package', $nextPackage->title);
        VendorNotificationService::send(
            $vendor,
            'vendor_next_package_updated',
            'Next package updated',
            'Admin changed your next package to "' . $selectedPackage->title . '".',
            [
                'package_id' => $selectedPackage->id,
                'membership_id' => $selectedMemb->id,
            ]
        );

        Session::flash('success', __('Next Package changed successfully') . '!');
        return back();
    }

    public function removeNextPackage(Request $request)
    {
        $vendor_id = $request->vendor_id;
        $vendor = Vendor::where('id', $vendor_id)->first();
        $bs = Basic::first();
        $nextMembership = VendorPermissionHelper::nextMembership($vendor_id);
        // set the start_date to unlimited
        $nextMembership->start_date = Carbon::parse(Carbon::maxValue()->format('d-m-Y'));
        $nextMembership->modified = 1;
        $nextMembership->save();

        $nextPackage = Package::select('title')->findOrFail($nextMembership->package_id);


        $this->sendMail(NULL, NULL, $request->payment_method, $vendor, $bs, 'admin_removed_next_package', NULL, $nextPackage->title);
        VendorNotificationService::send(
            $vendor,
            'vendor_next_package_updated',
            'Next package removed',
            'Admin removed your next package "' . $nextPackage->title . '".',
            [
                'vendor_id' => $vendor->id,
            ]
        );

        Session::flash('success', __('Next Package removed successfully') . '!');
        return back();
    }

    //secrtet login
    public function secret_login($id)
    {
        Session::put('secret_login', 1);
        $vendor = Vendor::where('id', $id)->first();
        Auth::guard('vendor')->login($vendor);
        return redirect()->route('vendor.dashboard');
    }

    public function destroy($id)
    {
        $vendor = Vendor::findOrFail($id);
        // vendor memeberships
        $memberships = $vendor->memberships()->get();
        foreach ($memberships as $membership) {
            @unlink(public_path('assets/front/img/membership/receipt/') . $membership->receipt);
            $membership->delete();
        }
        //vendor infos 
        $vendor_infos = $vendor->vendor_infos()->get();
        foreach ($vendor_infos as $info) {
            $info->delete();
        }
        //delete vendor cars
        $listings = $vendor->listings()->get();
        foreach ($listings as $listing) {

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
            $featureOrders = FeatureOrder::where('listing_id', $listing->id)->get();
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
            $listingMessages = ListingMessage::where('listing_id', $listing->id)->get();
            if (!is_null($listingMessages)) {

                foreach ($listingMessages as $message) {
                    $message->delete();
                }
            }
            //delete all reviews for this listing
            $reviews = ListingReview::where('listing_id', $listing->id)->get();
            if (!is_null($reviews)) {
                foreach ($reviews as $review) {
                    $review->delete();
                }
            }
            //delete all visit for this listing
            $visitors  = Visitor::where('listing_id', $listing->id)->get();
            if (!is_null($visitors)) {
                foreach ($visitors as $visitor) {
                    $visitor->delete();
                }
            }

            //delete claims
            $claims = ClaimListing::where('listing_id', $listing->id)->get();

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
            BusinessHour::where('listing_id', $listing->id)->delete();


            //delete all products
            $products = ListingProduct::where('listing_id', $listing->id)->get();

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
        //delete all vendor's support ticket
        $support_tickets = SupportTicket::where([['user_id', $vendor->id], ['user_type', 'vendor']])->get();
        foreach ($support_tickets as $support_ticket) {
            //delete conversation 
            $messages = $support_ticket->messages()->get();
            foreach ($messages as $message) {
                @unlink(public_path('assets/admin/img/support-ticket/' . $message->file));
                $message->delete();
            }
            @unlink(public_path('assets/admin/img/support-ticket/attachment/') . $support_ticket->attachment);
            $support_ticket->delete();
        }

        //finally delete the vendor
        @unlink(public_path('assets/admin/img/vendor-photo/') . $vendor->photo);
        $vendor->delete();

        return redirect()->back()->with('success', __('Vendor info deleted successfully') . '!');
    }

    public function bulkDestroy(Request $request)
    {
        $ids = $request->ids;

        foreach ($ids as $id) {
            $vendor = Vendor::findOrFail($id);
            // vendor memeberships
            $memberships = $vendor->memberships()->get();
            foreach ($memberships as $membership) {
                @unlink(public_path('assets/front/img/membership/receipt/') . $membership->receipt);
                $membership->delete();
            }
            //vendor infos 
            $vendor_infos = $vendor->vendor_infos()->get();
            foreach ($vendor_infos as $info) {
                $info->delete();
            }
            //delete vendor listings
            $listings = $vendor->listings()->get();
            foreach ($listings as $listing) {

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

                //delete claims
                $claims = ClaimListing::where('listing_id', $listing->id)->get();

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

                //delete feature order
                $featureOrders = FeatureOrder::where('listing_id', $listing->id)->get();
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
                $listingMessages = ListingMessage::where('listing_id', $listing->id)->get();
                if (!is_null($listingMessages)) {

                    foreach ($listingMessages as $message) {
                        $message->delete();
                    }
                }
                //delete all reviews for this listing
                $reviews = ListingReview::where('listing_id', $listing->id)->get();
                if (!is_null($reviews)) {
                    foreach ($reviews as $review) {
                        $review->delete();
                    }
                }
                //delete all visit for this listing
                $visitors  = Visitor::where('listing_id', $listing->id)->get();
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
                BusinessHour::where('listing_id', $listing->id)->delete();


                //delete all products
                $products = ListingProduct::where('listing_id', $listing->id)->get();

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
            //delete all vendor's support ticket
            $support_tickets = SupportTicket::where([['user_id', $vendor->id], ['user_type', 'vendor']])->get();
            foreach ($support_tickets as $support_ticket) {
                //delete conversation 
                $messages = $support_ticket->messages()->get();
                foreach ($messages as $message) {
                    @unlink(public_path('assets/admin/img/support-ticket/' . $message->file));
                    $message->delete();
                }
                @unlink(public_path('assets/admin/img/support-ticket/attachment/') . $support_ticket->attachment);
                $support_ticket->delete();
            }

            //finally delete the vendor
            @unlink(public_path('assets/admin/img/vendor-photo/') . $vendor->photo);
            $vendor->delete();
        }
        Session::flash('success', __('Vendors info deleted successfully') . '!');


        return Response::json(['status' => 'success'], 200);
    }
}
