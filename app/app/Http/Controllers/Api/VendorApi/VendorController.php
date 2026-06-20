<?php

namespace App\Http\Controllers\Api\VendorApi;

use App\Http\Controllers\Controller;
use App\Models\Admin;
use App\Models\BasicSettings\Basic;
use App\Models\BasicSettings\MailTemplate;
use App\Models\Language;
use App\Models\Listing\Listing;
use App\Models\Membership;
use App\Models\Package;
use App\Models\Shop\Product;
use App\Models\SupportTicket;
use App\Models\Vendor;
use App\Models\VendorDevice;
use App\Models\VendorInfo;
use App\Rules\MatchEmailRule;
use App\Rules\MatchOldPasswordRule;
use App\Services\VendorNotificationService;
use Carbon\Carbon;
use Config;
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Mail\Message;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class VendorController extends Controller
{
  // GET /api/vendor/signup — return sign-up config data
  public function signup()
  {
    $bs = Basic::select('google_recaptcha_status')->first();

    return response()->json([
      'recaptcha_status' => $bs->google_recaptcha_status,
    ], 200);
  }

  // POST /api/vendor/signup/submit — register a new vendor
  public function create(Request $request)
  {
    $admin = Admin::select('username')->first();
    $admin_username = $admin->username;

    $rules = [
      'username' => "required|unique:vendors|not_in:$admin_username",
      'email'    => 'required|email|unique:vendors',
      'password' => 'required|confirmed|min:6',
    ];

    $messages = [
      'username.required'  => __('The username field is required.'),
      'username.unique'    => __('This username is already taken.'),
      'username.not_in'    => __('This username is not allowed.'),
      'email.required'     => __('The email field is required.'),
      'email.email'        => __('Please enter a valid email address.'),
      'email.unique'       => __('This email is already registered.'),
      'password.required'  => __('The password field is required.'),
      'password.confirmed' => __('The password confirmation does not match.'),
      'password.min'       => __('The password must be at least 6 characters.'),
    ];

    $validator = Validator::make($request->all(), $rules, $messages);
    if ($validator->fails()) {
      return response()->json(['errors' => $validator->errors()], 422);
    }

    if ($request->username === 'admin') {
      return response()->json(['error' => __('You can not use admin as a username') . '!'], 422);
    }

    $setting = DB::table('basic_settings')
      ->where('uniqid', 12345)
      ->select('vendor_email_verification', 'vendor_admin_approval')
      ->first();

    $in = [
      'username' => $request->username,
      'email'    => $request->email,
      'password' => Hash::make($request->password),
    ];

    $emailVerificationSent = false;

    if ($setting->vendor_email_verification == 1) {
      $in['status'] = 0;
      try {
        $this->sendVerificationEmail($request);
        $emailVerificationSent = true;
      } catch (\Exception $e) {
        // Mail failure — continue without email verification
      }
    } else {
      $in['email_verified_at'] = now();
    }

    if ($setting->vendor_admin_approval == 1) {
      $in['status'] = 0;
    }

    if ($setting->vendor_admin_approval == 0 && $setting->vendor_email_verification == 0) {
      $in['status'] = 1;
    }

    $vendor = Vendor::create($in);

    $language = Language::where('is_default', 1)->first();
    VendorInfo::create([
      'language_id' => $language ? $language->id : 1,
      'vendor_id'   => $vendor->id,
    ]);

    $message = $emailVerificationSent
      ? __('A verification mail has been sent to your email address') . '!'
      : __('Sign up successfully completed. Please login now') . '!';

    return response()->json(['success' => true, 'message' => $message], 201);
  }

  // GET /api/vendor/login — return login config data
  public function login()
  {
    $bs = Basic::select('google_recaptcha_status', 'facebook_login_status', 'google_login_status')->first();

    return response()->json([
      'recaptcha_status'      => $bs->google_recaptcha_status,
      'facebook_login_status' => $bs->facebook_login_status,
      'google_login_status'   => $bs->google_login_status,
    ], 200);
  }

  // POST /api/vendor/login/submit — authenticate and return Sanctum token
  public function authentication(Request $request)
  {
    $rules = [
      'username' => 'required',
      'password' => 'required',
    ];

    $validator = Validator::make($request->all(), $rules);
    if ($validator->fails()) {
      return response()->json(['errors' => $validator->errors()], 422);
    }

    if (!Auth::guard('vendor')->attempt(['username' => $request->username, 'password' => $request->password])) {
      return response()->json(['error' => __('Incorrect username or password')], 401);
    }

    $vendor = Auth::guard('vendor')->user();

    $setting = DB::table('basic_settings')
      ->where('uniqid', 12345)
      ->select('vendor_email_verification', 'vendor_admin_approval')
      ->first();

    if ($setting->vendor_email_verification == 1 && $vendor->email_verified_at == null) {
      Auth::guard('vendor')->logout();
      return response()->json(['error' => __('Please verify your email address') . '!'], 403);
    }

    if ($vendor->status == 0) {
      Auth::guard('vendor')->logout();
      return response()->json(['error' => __('Your account is pending admin approval') . '!'], 403);
    }

    $token = $vendor->createToken('vendor-token')->plainTextToken;
    $newDeviceDetected = $this->syncVendorDevice(
      $vendor,
      $request->input('fcm_token'),
      $request->input('device_type')
    );

    if ($newDeviceDetected) {
      VendorNotificationService::send(
        $vendor,
        'vendor_security_login',
        'New device login',
        'Your vendor account was accessed from a new device.',
        [
          'device_type' => $request->input('device_type', 'unknown'),
        ]
      );
    }

    return response()->json([
      'message' => __('Login successful'),
      'token'   => $token,
      'vendor'  => [
        'id'       => $vendor->id,
        'username' => $vendor->username,
        'email'    => $vendor->email,
        'photo'    => $vendor->photo ? asset('assets/admin/img/vendor-photo/' . $vendor->photo) : null,
      ],
    ], 200);
  }

  // GET /api/vendor/email/verify — verify vendor email via token
  public function confirm_email(Request $request)
  {
    $email = $request->input('token');
    $user  = Vendor::where('email', $email)->first();

    if (!$user) {
      return response()->json(['error' => __('Invalid verification link')], 404);
    }

    $user->email_verified_at = now();

    $setting = DB::table('basic_settings')
      ->where('uniqid', 12345)
      ->select('vendor_admin_approval')
      ->first();

    if ($setting->vendor_admin_approval != 1) {
      $user->status = 1;
    }

    $user->save();
    VendorNotificationService::send(
      $user,
      'vendor_email_verified',
      'Email verified',
      'Your email address has been verified successfully.',
      [
        'email' => $user->email,
      ]
    );

    return response()->json(['message' => __('Email verified successfully')], 200);
  }

  // POST /api/vendor/logout
  public function logout(Request $request)
  {
    $vendor = $request->user();
    /** @var \Laravel\Sanctum\PersonalAccessToken $token */
    $token = $vendor->currentAccessToken();
    $token?->delete();

    $fcmToken = trim((string) $request->input('fcm_token', ''));
    if ($fcmToken !== '') {
      VendorDevice::query()
        ->where('vendor_id', $vendor->id)
        ->where('fcm_token', $fcmToken)
        ->delete();
    }

    return response()->json(['message' => __('Logged out successfully')], 200);
  }

  // GET /api/vendor/dashboard
  public function dashboard(Request $request)
  {
    $information['languages'] = Language::get();
    $information['getCurrencyInfo']  = $this->getCurrencyInfo();
    $vendor_id = $request->user()->id;
    $totalListings = Listing::where('vendor_id', $vendor_id)->count();
    $totalProducts = Product::where('vendor_id', $vendor_id)->count();
    $total_support_tickets = SupportTicket::where('user_type', 'vendor')->where('user_id', $vendor_id)->count();

    $total_support_tickets = DB::table('support_tickets')
      ->where('user_type', 'vendor')
      ->where('user_id', $vendor_id)
      ->count();


    $totalCars = DB::table('listings')
      ->select(DB::raw('month(created_at) as month'), DB::raw('count(id) as total'))
      ->groupBy('month')
      ->where('vendor_id', $vendor_id)
      ->whereYear('created_at', date('Y'))
      ->get();

    $totalVisitors = DB::table('visitors')
      ->select(DB::raw('month(date) as month'), DB::raw('count(id) as total'))
      ->groupBy('month')
      ->where('vendor_id', $vendor_id)
      ->whereYear('date', date('Y'))
      ->get();

    $months = $totalCarArr = $totalVisitorArr = [];

    for ($i = 1; $i <= 12; $i++) {
      $months[]          = DateTime::createFromFormat('!m', $i)->format('M');
      $car               = $totalCars->firstWhere('month', $i);
      $totalCarArr[]     = $car ? $car->total : 0;
      $visitor           = $totalVisitors->firstWhere('month', $i);
      $totalVisitorArr[] = $visitor ? $visitor->total : 0;
    }

    $payment_logs_count = Membership::where('vendor_id', $vendor_id)->count();

    $current_membership = Membership::where([
      ['vendor_id', $vendor_id],
      ['start_date', '<=', Carbon::now()->toDateString()],
      ['expire_date', '>=', Carbon::now()->toDateString()],

    ])->where('status', 1)->whereYear('start_date', '<>', '9999')->first();

    $next_membership = null;
    if ($current_membership) {
      $countCurr = Membership::where([
        ['vendor_id', $vendor_id],
        ['start_date', '<=', Carbon::now()->toDateString()],
        ['expire_date', '>=', Carbon::now()->toDateString()],
      ])->where('status', 1)->whereYear('start_date', '<>', '9999')->count();

      $next_membership = $countCurr > 1
        ? Membership::where([
          ['vendor_id', $vendor_id],
          ['start_date', '<=', Carbon::now()->toDateString()],
          ['expire_date', '>=', Carbon::now()->toDateString()],
        ])->where('status', '<>', 2)->whereYear('start_date', '<>', '9999')->orderBy('id', 'DESC')->first()
        : Membership::where([
          ['vendor_id', $vendor_id],
          ['start_date', '>', $current_membership->expire_date],
        ])->whereYear('start_date', '<>', '9999')->where('status', '<>', 2)->first();
    }

    return response()->json([
      'success' => true,
      'data'    => [
        'languages'              => $information['languages'],
        'currency_info'          => $information['getCurrencyInfo'],
        'total_balance'          => $request->user()->amount,
        'total_listings'         => $totalListings,
        'total_products'         => $totalProducts,
        'total_support_tickets'  => $total_support_tickets,
        'payment_logs_count'     => $payment_logs_count,
        'months'                 => $months,
        'total_listings_monthly' => $totalCarArr,
        'visitors_monthly'       => $totalVisitorArr,
        'current_membership'     => $current_membership,
        'next_membership'        => $next_membership,
        'current_package'        => $current_membership ? Package::find($current_membership->package_id) : null,
        'next_package'           => $next_membership ? Package::find($next_membership->package_id) : null,
      ],
    ], 200);
  }

  // POST /api/vendor/update/password
  public function updated_password(Request $request)
  {
    $rules = [
      'current_password'          => ['required', new MatchOldPasswordRule('vendor')],
      'new_password'              => 'required|confirmed',
      'new_password_confirmation' => 'required',
    ];

    $messages = [
      'new_password.confirmed'             => 'Password confirmation does not match.',
      'new_password_confirmation.required' => 'The confirm new password field is required.',
    ];

    $validator = Validator::make($request->all(), $rules, $messages);
    if ($validator->fails()) {
      return response()->json(['errors' => $validator->errors()], 422);
    }

    $request->user()->update([
      'password' => Hash::make($request->new_password),
    ]);
    VendorNotificationService::send(
      $request->user(),
      'vendor_security_password_changed',
      'Password changed',
      'Your vendor account password was changed successfully.',
      [
        'vendor_id' => $request->user()->id,
      ]
    );

    return response()->json(['message' => __('Password updated successfully') . '!'], 200);
  }

  // GET /api/vendor/edit-profile
  public function edit_profile(Request $request)
  {
    $vendor_id = $request->user()->id;
    $vendor    = Vendor::find($vendor_id);

    if ($vendor && $vendor->photo) {
      $vendor->photo = asset('assets/admin/img/vendor-photo/' . $vendor->photo);
    }

    $languages    = Language::get();
    $vendor_infos = [];

    foreach ($languages as $language) {
      $info = VendorInfo::where('vendor_id', $vendor_id)
        ->where('language_id', $language->id)
        ->first();
      $vendor_infos[$language->code] = $info;
    }

    return response()->json([
      'success'      => true,
      'languages'    => $languages,
      'vendor'       => $vendor,
      'vendor_infos' => $vendor_infos,
    ], 200);
  }

  // POST /api/vendor/update/profile
  public function update_profile(Request $request)
  {
    $id             = $request->user()->id;
    $admin_username = Admin::select('username')->first()->username;

    $rules = [
      'username' => [
        'required',
        Rule::unique('vendors', 'username')->ignore($id),
        Rule::notIn([$admin_username]),
      ],
      'email' => [
        'required',
        'email',
        Rule::unique('vendors', 'email')->ignore($id),
      ],
    ];

    if ($request->hasFile('photo')) {
      $rules['photo'] = 'mimes:png,jpeg,jpg|max:2048';
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
      return response()->json(['errors' => $validator->errors()], 422);
    }

    $in     = $request->all();
    $vendor = Vendor::find($id);

    if ($request->hasFile('photo')) {
      $file      = $request->file('photo');
      $directory = public_path('assets/admin/img/vendor-photo/');
      $fileName  = uniqid() . '.' . $file->getClientOriginalExtension();
      @mkdir($directory, 0775, true);
      $file->move($directory, $fileName);
      @unlink($directory . $vendor->photo);
      $in['photo'] = $fileName;
    }

    $in['show_email_addresss'] = $request->show_email_addresss ? 1 : 0;
    $in['show_phone_number']   = $request->show_phone_number ? 1 : 0;
    $in['show_contact_form']   = $request->show_contact_form ? 1 : 0;

    $updateData = [
      'username'          => $in['username'],
      'email'             => $in['email'],
      'phone'             => $in['phone'] ?? null,
      'show_email_addresss' => $in['show_email_addresss'],
      'show_phone_number' => $in['show_phone_number'],
      'show_contact_form' => $in['show_contact_form'],
    ];

    if (isset($in['photo'])) {
      $updateData['photo'] = $in['photo'];
    }

    $vendor->update($updateData);

    foreach ($languages as $language) {
      $vendorInfo              = VendorInfo::where('vendor_id', $id)->where('language_id', $language->id)->firstOrNew();
      $vendorInfo->language_id = $language->id;
      $vendorInfo->vendor_id   = $id;
      $vendorInfo->name        = $request[$language->code . '_name'] ?? null;
      $vendorInfo->country     = $request[$language->code . '_country'] ?? null;
      $vendorInfo->city        = $request[$language->code . '_city'] ?? null;
      $vendorInfo->state       = $request[$language->code . '_state'] ?? null;
      $vendorInfo->zip_code    = $request[$language->code . '_zip_code'] ?? null;
      $vendorInfo->address     = $request[$language->code . '_address'] ?? null;
      $vendorInfo->details     = $request[$language->code . '_details'] ?? null;
      $vendorInfo->save();
    }

    return response()->json(['success' => true, 'message' => __('Profile updated successfully') . '!'], 200);
  }

  // POST /api/vendor/send-forget-mail
  public function forget_mail(Request $request)
  {
    $rules = [
      'email' => ['required', 'email:rfc,dns', new MatchEmailRule('vendor')],
    ];

    $validator = Validator::make($request->all(), $rules);
    if ($validator->fails()) {
      return response()->json(['errors' => $validator->errors()], 422);
    }

    $user = Vendor::where('email', $request->email)->first();

    $mailTemplate = MailTemplate::where('mail_type', 'reset_password')->first();
    $mailSubject  = $mailTemplate ? $mailTemplate->mail_subject : __('Password Reset OTP');

    $info = DB::table('basic_settings')
      ->select('website_title', 'smtp_status', 'smtp_host', 'smtp_port', 'encryption', 'smtp_username', 'smtp_password', 'from_mail', 'from_name')
      ->first();

    $otp = (string) random_int(100000, 999999);
    DB::table('password_resets')->updateOrInsert(
      ['email' => $user->email],
      ['token' => $otp, 'created_at' => now()]
    );

    $mailBody = $mailTemplate
      ? $mailTemplate->mail_body
      : '<p>{customer_name},</p><p>Your OTP for password reset is <strong>{otp}</strong>.</p><p>This OTP expires in 10 minutes.</p><p>{website_title}</p>';

    $mailBody = str_replace('{customer_name}', $user->username, $mailBody);
    $mailBody = str_replace('{otp}', $otp, $mailBody);
    $mailBody = str_replace('{reset_otp}', $otp, $mailBody);
    // Keep legacy templates working if they still use reset-link placeholder.
    $mailBody = str_replace('{password_reset_link}', $otp, $mailBody);
    $mailBody = str_replace('{website_title}', $info->website_title, $mailBody);

    if ($info->smtp_status == 1) {
      try {
        Config::set('mail.mailers.smtp', [
          'transport'  => 'smtp',
          'host'       => $info->smtp_host,
          'port'       => $info->smtp_port,
          'encryption' => $info->encryption,
          'username'   => $info->smtp_username,
          'password'   => $info->smtp_password,
          'timeout'    => null,
          'auth_mode'  => null,
        ]);

        Mail::send([], [], function (Message $message) use ($mailBody, $mailSubject, $request, $info) {
          $message->to($request->email)
            ->subject($mailSubject)
            ->from($info->from_mail, $info->from_name)
            ->html($mailBody, 'text/html');
        });
      } catch (\Exception $e) {
        return response()->json(['error' => __('Mail could not be sent') . '!'], 500);
      }
    }

    return response()->json(['message' => __('A 6-digit OTP has been sent to your email address') . '!'], 200);
  }

  // POST /api/vendor/verify-forget-otp
  public function verify_forget_otp(Request $request)
  {
    $rules = [
      'email' => ['required', 'email:rfc,dns', new MatchEmailRule('vendor')],
      'otp'   => ['required', 'digits:6'],
    ];

    $validator = Validator::make($request->all(), $rules);
    if ($validator->fails()) {
      return response()->json(['errors' => $validator->errors()], 422);
    }

    $reset = DB::table('password_resets')
      ->where('email', $request->email)
      ->where('token', $request->otp)
      ->first();

    if (!$reset) {
      return response()->json(['error' => __('Invalid OTP') . '.'], 404);
    }

    if (!empty($reset->created_at)) {
      $createdAt = Carbon::parse($reset->created_at);
      if ($createdAt->lt(now()->subMinutes(10))) {
        DB::table('password_resets')->where('email', $request->email)->delete();
        return response()->json(['error' => __('OTP has expired. Please request a new one') . '.'], 410);
      }
    }

    return response()->json(['message' => __('OTP verified successfully') . '!'], 200);
  }

  // POST /api/vendor/update-forget-password
  public function update_password(Request $request)
  {
    $rules = [
      'email'                     => ['required', 'email:rfc,dns', new MatchEmailRule('vendor')],
      'otp'                       => 'required|digits:6',
      'new_password'              => 'required|confirmed',
      'new_password_confirmation' => 'required',
    ];

    $messages = [
      'new_password.confirmed'             => 'Password confirmation failed.',
      'new_password_confirmation.required' => 'The confirm new password field is required.',
    ];

    $validator = Validator::make($request->all(), $rules, $messages);
    if ($validator->fails()) {
      return response()->json(['errors' => $validator->errors()], 422);
    }

    $reset = DB::table('password_resets')
      ->where('email', $request->email)
      ->where('token', $request->otp)
      ->first();

    if (!$reset) {
      return response()->json(['error' => __('Invalid OTP') . '.'], 404);
    }

    if (!empty($reset->created_at)) {
      $createdAt = Carbon::parse($reset->created_at);
      if ($createdAt->lt(now()->subMinutes(10))) {
        DB::table('password_resets')->where('email', $request->email)->delete();
        return response()->json(['error' => __('OTP has expired. Please request a new one') . '.'], 410);
      }
    }

    $vendor = Vendor::where('email', $reset->email)->first();
    $vendor->update(['password' => Hash::make($request->new_password)]);
    DB::table('password_resets')->where('email', $request->email)->delete();
    VendorNotificationService::send(
      $vendor,
      'vendor_security_password_reset',
      'Password reset successful',
      'Your vendor account password has been reset successfully.',
      [
        'vendor_id' => $vendor->id,
      ]
    );

    return response()->json(['message' => __('Password reset successfully. Please login now') . '!'], 200);
  }

  // GET /api/vendor/payment-log
  public function payment_log(Request $request)
  {
    $vendor_id = $request->user()->id;

    $memberships = Membership::with(['vendor', 'package'])
      ->when($request->search, function ($query) use ($request) {
        return $query->where('transaction_id', 'like', '%' . $request->search . '%');
      })
      ->where('vendor_id', $vendor_id)
      ->orderBy('id', 'DESC')
      ->paginate(10);

    return response()->json(['success' => true, 'data' => $memberships], 200);
  }

  public function checkRTL($id)
  {
    if (!is_null($id)) {
      $direction = Language::where('id', $id)->pluck('direction')->first();
      return response()->json(['successData' => $direction], 200);
    }

    return response()->json(['errorData' => 'Sorry, an error has occurred!'], 400);
  }

  private function sendVerificationEmail(Request $request): void
  {
    $mailTemplate = MailTemplate::where('mail_type', 'verify_email')->first();
    $info         = DB::table('basic_settings')
      ->select('website_title', 'smtp_status', 'smtp_host', 'smtp_port', 'encryption', 'smtp_username', 'smtp_password', 'from_mail', 'from_name')
      ->first();

    $mailBody = str_replace('{username}', $request->username, $mailTemplate->mail_body);
    $mailBody = str_replace('{verification_link}', url('vendor/email/verify?token=' . $request->email), $mailBody);
    $mailBody = str_replace('{website_title}', $info->website_title, $mailBody);

    if ($info->smtp_status == 1) {
      Config::set('mail.mailers.smtp', [
        'transport'  => 'smtp',
        'host'       => $info->smtp_host,
        'port'       => $info->smtp_port,
        'encryption' => $info->encryption,
        'username'   => $info->smtp_username,
        'password'   => $info->smtp_password,
        'timeout'    => null,
        'auth_mode'  => null,
      ]);

      $subject = $mailTemplate->mail_subject;
      Mail::send([], [], function (Message $message) use ($mailBody, $subject, $request, $info) {
        $message->to($request->email)
          ->subject($subject)
          ->from($info->from_mail, $info->from_name)
          ->html($mailBody, 'text/html');
      });
    }
  }

  private function syncVendorDevice(Vendor $vendor, ?string $fcmToken, ?string $deviceType = null): bool
  {
    $token = trim((string) $fcmToken);
    if ($token === '') {
      return false;
    }

    $existingDevice = VendorDevice::query()->where('fcm_token', $token)->first();

    VendorDevice::query()->updateOrCreate(
      ['fcm_token' => $token],
      [
        'vendor_id' => $vendor->id,
        'device_type' => $deviceType ?: 'unknown',
        'last_seen_at' => now(),
      ]
    );

    return is_null($existingDevice) || (int) $existingDevice->vendor_id !== (int) $vendor->id;
  }

}
