<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\ApiHelper\HelperController;
use App\Http\Controllers\Controller;
use App\Http\Helpers\UploadFile;
use App\Models\Admin;
use App\Models\BasicSettings\Basic;
use App\Models\BasicSettings\MailTemplate;
use App\Models\BasicSettings\PageHeading;
use App\Models\Car\Wishlist;
use App\Models\ClaimListing;
use App\Models\Form;
use App\Models\FormInput;
use App\Models\Shop\ProductOrder;
use App\Models\User;
use App\Rules\ImageMimeTypeRule;
use App\Rules\MatchEmailRule;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Session;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Illuminate\Mail\Message;
use Illuminate\Support\Facades\Mail;
use Config;
use Illuminate\Support\Facades\Log;

class UserController extends Controller
{

  private $admin_user_name;

  public function __construct()
  {

    $admin = Admin::select('username')->first();
    $this->admin_user_name = $admin->username;
  }
  /* ******************************
     * Show login page
     * ******************************/
  public function login(Request $request)
  {
    //get language
    $language = HelperController::getLanguage($request);

    $data['page_title'] = PageHeading::where('language_id', $language->id)->pluck('login_page_title')->first();
    $basic_settings = Basic::query()->select('breadcrumb')->first();

    $basic_settings['breadcrumb'] = asset('assets/img/' . $basic_settings->breadcrumb);

    $data['bs'] = $basic_settings;
    return response()->json([
      'success' => true,
      'data' => $data
    ]);
  }

  /* ********************************
     * Submit login for authentication
     * ********************************/
  public function loginSubmit(Request $request)
  {
    $rules = [
      'username' => 'required',
      'password' => 'required'
    ];

    // $info = Basic::select('google_recaptcha_status')->first();
    // if ($info->google_recaptcha_status == 1) {
    //   $rules['g-recaptcha-response'] = 'required|captcha';
    // }

    $messages = [];
    // if ($info->google_recaptcha_status == 1) {
    //   $messages['g-recaptcha-response.required'] = 'Please verify that you are not a robot.';
    //   $messages['g-recaptcha-response.captcha'] = 'Captcha error! try again later or contact site admin.';
    // }


    $validator = Validator::make($request->all(), $rules, $messages);
    if ($validator->fails()) {
      return response()->json([
        'status' => 'validation_error',
        'errors' => $validator->errors()
      ], 422);
    }

    // Attempt login manually using credentials
    $user = User::where('username', $request->username)->first();

    if (!$user || !Hash::check($request->password, $user->password)) {
      return response()->json([
        'status' => 'error',
        'message' => 'Invalid credentials'
      ], 401);
    }

    if (is_null($user->email_verified_at)) {
      return response()->json([
        'status' => 'error',
        'message' => 'Please verify your email address.'
      ], 403);
    }

    if ($user->status == 0) {
      return response()->json([
        'status' => 'error',
        'message' => 'Sorry, your account has been deactivated.'
      ], 403);
    }

    // Delete old tokens and create new one
    $user->tokens()->where('name', 'customer-login')->delete();
    $token = $user->createToken($request->device_name ?? 'unknown-device')->plainTextToken;

    // Add full photo URL if exists
    if (!empty($user->image)) {
      $user->image = asset('assets/img/users/' . $user->image);
    }

    Auth::guard('sanctum')->user($user);

    return response()->json([
      'status' => 'success',
      'customer' => $user,
      'token' => $token
    ], 200);
  }


  /* ******************************
     * forget password
  * ******************************/

  public function forget_password(Request $request)
  {
    $rules = [
      'email' => [
        'required',
        'email:rfc,dns',
        new MatchEmailRule('user')
      ]
    ];

    $validator = Validator::make($request->all(), $rules);
    if ($validator->fails()) {
      return response()->json([
        'success' => false,
        'errors' => $validator->errors()
      ], 422);
    }

    $user = User::where('email', $request->email)->first();
    $token = str_pad(random_int(0, 999999), 6, '0', STR_PAD_LEFT);


    DB::table('password_resets')->updateOrInsert(
      ['email' => $user->email],
      [
        'token' => Hash::make($token),
        'created_at' => now()
      ]
    );


    $mail_status = $this->sendForgetPasswordVerificationMail($user, $token);

    return response()->json([
      'success' => $mail_status ?? false,
      'userEmail' => $user->email,
      'message' => $mail_status == true ? 'A mail has been sent to your email address .' : 'Failed to send email.'
    ]);
  }

  /* ******************************
     * reset password
  * ******************************/

  public function reset_password_submit(Request $request)
  {
    $rules = [
      'email' => 'required|email',
      'code' => 'required',
      'new_password' => 'required|confirmed',
      'new_password_confirmation' => 'required'
    ];

    $validator = Validator::make($request->all(), $rules);

    if ($validator->fails()) {
      return response()->json([
        'success' => false,
        'errors' => $validator->errors()
      ], 422);
    }

    // find the reset record by email
    $record = DB::table('password_resets')
      ->where('email', $request->email)
      ->first();

    if (!$record) {
      return response()->json([
        'status' => 'error',
        'message' => __('Invalid email or token')
      ], 400);
    }

    // check the token
    if (!Hash::check($request->code, $record->token)) {
      return response()->json([
        'status' => 'error',
        'message' => __('Invalid email or expired code')
      ], 400);
    }

    // update password
    User::where('email', $request->email)->update([
      'password' => Hash::make($request->new_password),
    ]);

    // delete reset record
    DB::table('password_resets')
      ->where('email', $request->email)
      ->delete();

    return response()->json([
      'status' => 'success',
      'message' => __('Password updated successfully')
    ]);
  }


  public function authentication_fail()
  {
    return response()->json([
      'success' => false,
      'message' => 'Unauthenticated.'
    ], 401);
  }

  /* ******************************
     * Show customer signup page
     * ******************************/
  public function signup(Request $request)
  {
    //get language
    $language = HelperController::getLanguage($request);

    $data['page_title'] = PageHeading::where('language_id', $language->id)->pluck('signup_page_title')->first();

    $basic_settings = Basic::query()->select('breadcrumb')->first();
    $basic_settings['breadcrumb'] = asset('assets/img/' . $basic_settings->breadcrumb);

    $data['bs'] = $basic_settings;
    return response()->json([
      'success' => true,
      'data' => $data
    ], 200);
  }

  /* **************************************
     * Request for sign up as a new customer
     * **************************************/
  public function signupSubmit(Request $request)
  {
    //validation rules
    $rules = [
      'email' => 'required|email:rfc,dns|unique:users|max:255',
      'password' => 'required|confirmed',
      'password_confirmation' => 'required',
      'username' => [
        'required',
        'alpha_dash',
        "not_in:$this->admin_user_name",
        Rule::unique('users', 'username')
      ],
    ];

    // $info = Basic::select('google_recaptcha_status')->first();
    // if ($info->google_recaptcha_status == 1) {
    //   $rules['g-recaptcha-response'] = 'required|captcha';
    // }

    $messages = [];
    // if ($info->google_recaptcha_status == 1) {
    //   $messages['g-recaptcha-response.required'] = __('Please verify that you are not a robot.');
    //   $messages['g-recaptcha-response.captcha'] = __('Captcha error! try again later or contact site admin.');
    // }

    $validator = Validator::make($request->all(), $rules, $messages);
    if ($validator->fails()) {
      return response()->json([
        'success' => false,
        'errors' => $validator->errors()
      ], 422);
    }
    //validation end

    $in = $request->all();
    $in['password'] = Hash::make($request->password);
    // first, generate a random string
    $randStr = Str::random(20);

    // second, generate a token
    $token = rand(000000, 999999);

    $varification_code = $token;

    // send a mail to user for verify his/her email address

    $mail_status = $this->sendSignUpVerificationMail($request, $varification_code);

    $user = new User();
    $user->username = $request->username;
    $user->email = $request->email;
    $user->status = 1;
    $user->password = Hash::make($request->password);
    $user->save();

    return response()->json([
      'success' => true,
      'message' => $mail_status ? __('A verification mail has been sent to your email address') : __('Failed to send email.'),
      'data' => $user
    ], 200);
  }

  /* ****************************
     * Customer Dashboard
     * ****************************/
  public function dashboard(Request $request)
  {
    $user = Auth::guard('sanctum')->user();
    $language = HelperController::getLanguage($request);
    $data['page_title'] = PageHeading::where('language_id', $language->id)->pluck('dashboard_page_title')->first();

    $basic_settings = Basic::query()->select('breadcrumb')->first();

    $basic_settings['breadcrumb'] = asset('assets/img/' . $basic_settings->breadcrumb);
    if (!empty($user->image)) {
      $user->image = asset('assets/img/users/' . $user->image);
    }
    $information['userInfo'] = $user;

    $wishlists = Wishlist::where('user_id', $user->id)
      ->join('listings', 'listings.id', '=', 'wishlists.listing_id')
      ->join('listing_contents', 'listing_contents.listing_id', '=', 'listings.id')
      ->where('listing_contents.language_id', '=', $language->id)
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
      ->select('listings.*', 'listing_contents.title', 'wishlists.listing_id as listing_id', 'wishlists.id as wishlist_id')
      ->get()->map(function ($item) use ($language) {
        return HelperController::formatWishlistForApi($item, $language->id);
      });

    $information['total_orders'] = ProductOrder::where('user_id', $user->id)->orderBy('id', 'desc')->get()->count();
    $information['total_wishlist'] = $wishlists->count();
    $information['wishlists'] = $wishlists;

    return response()->json([
      'success' => true,
      'data' => $information
    ], 200);
  }

  /*
  * Edit profile
  */
  public function edit_profile(Request $request)
  {
    // Authenticate customer
    $user = Auth::guard('sanctum')->user();
    if (!$user) {
      return response()->json([
        'success' => false,
        'message' => 'Unauthenticated.'
      ], 401);
    }
    $language = HelperController::getLanguage($request);
    $data['page_title'] = PageHeading::where('language_id', $language->id)->pluck('edit_profile_page_title')->first();

    $basic_settings = Basic::query()->select('breadcrumb')->first();

    $data['breadcrumb'] = asset('assets/img/' . $basic_settings->breadcrumb);
    $user->image = !empty($user->image) ? asset('assets/img/users/' . $user->image) : asset('assets/img/blank-user.jpg');
    $data['user_info'] = $user;

    return response()->json([
      'success' => true,
      'data'    => $data,
    ], 200);
  }

  /*
  * Update profile
  */
  public function update_profile(Request $request)
  {

    $user = Auth::guard('sanctum')->user();
    if ($request->image) {
      $image = true;
    } else {
      $image = false;
    }

    $rules = [
      'image' => $image ? [
        'required',
        'dimensions:width=80,height=80',
        new ImageMimeTypeRule()
      ] : '',
      'name' => 'required',
      'username' => [
        'required',
        'alpha_dash',
        Rule::unique('users', 'username')->ignore($user->id),
      ],
      'email' => [
        'required',
        'email',
        Rule::unique('users', 'email')->ignore($user->id)
      ],
    ];

    $validator = Validator::make($request->all(), $rules);
    if ($validator->fails()) {
      return response()->json([
        'success' => false,
        'errors' => $validator->errors()
      ], 422);
    }

    $in = $request->all();
    $file = $request->file('image');
    if ($file) {
      $extension = $file->getClientOriginalExtension();
      @unlink(public_path('assets/img/users/') . $user->image);
      $directory = public_path('assets/img/users/');
      $fileName = uniqid() . '.' . $extension;
      @mkdir($directory, 0775, true);
      $file->move($directory, $fileName);
      $in['image'] = $fileName;
    }
    $user->update($in);
    return response()->json([
      'success' => true,
      'message'    => __('Updated Successfully'),
    ], 200);
  }

  /*
  * updated profile
  */
  public function updated_password(Request $request)
  {
    // Authenticate customer
    $user = Auth::guard('sanctum')->user();

    $rules = [
      'current_password' => 'required',
      'new_password' => 'required|confirmed',
      'new_password_confirmation' => 'required'
    ];

    $messages = [
      'new_password.confirmed' => __('Password confirmation does not match.'),
      'new_password_confirmation.required' => __('The confirm new password field is required.')
    ];

    $validator = Validator::make($request->all(), $rules, $messages);
    if ($validator->fails()) {
      return response()->json([
        'success' => false,
        'errors' => $validator->errors()
      ], 422);
    }

    $user = User::where('id', $user->id)->first();
    if (!Hash::check($request->current_password, $user->password)) {
      return response()->json([
        'success' => false,
        'errors' => ['current_password' => ['Current password is incorrect.']]
      ], 422);
    }

    $user->update([
      'password' => Hash::make($request->new_password)
    ]);

    return response()->json([
      'status' => true,
      'message' => 'Password updated successfully'
    ]);
  }

  /* **************************
     * Logout customer
     * **************************/
  public function logoutSubmit(Request $request)
  {
    $request->user()->currentAccessToken()->delete();
    return response()->json([
      'status' => 'success',
      'message' => 'Logout successfully'
    ], 200);
  }

  public function sendSignUpVerificationMail(Request $request, $varification_code)
  {

    $mail_status = true;
    // first get the mail template information from db
    $mailTemplate = MailTemplate::where('mail_type', 'verify_email_app')->first();
    $mailSubject = $mailTemplate->mail_subject;
    $mailBody = $mailTemplate->mail_body;

    // second get the website title & mail's smtp information from db
    $info = DB::table('basic_settings')
      ->select('website_title', 'smtp_status', 'smtp_host', 'smtp_port', 'encryption', 'smtp_username', 'smtp_password', 'from_mail', 'from_name')
      ->first();


    $mailBody = str_replace('{username}', $request->username, $mailBody);
    $mailBody = str_replace('{verification_code}', $varification_code, $mailBody);
    $mailBody = str_replace('{website_title}', $info->website_title, $mailBody);

    // finally add other informations and send the mail
    try {

      if ($info->smtp_status == 1) {
        $data = [
          'to' => $request->email,
          'subject' => $mailSubject,
          'body' => $mailBody,
        ];
        $smtp = [
          'transport' => 'smtp',
          'host' => $info->smtp_host,
          'port' => $info->smtp_port,
          'encryption' => $info->encryption,
          'username' => $info->smtp_username,
          'password' => $info->smtp_password,
          'timeout' => null,
          'auth_mode' => null,
        ];
        Config::set('mail.mailers.smtp', $smtp);
        Mail::send([], [], function (Message $message) use ($data, $info) {
          $fromMail = $info->from_mail;
          $fromName = $info->from_name;
          $message->to($data['to'])
            ->subject($data['subject'])
            ->from($fromMail, $fromName)
            ->html($data['body'], 'text/html');
        });
      }

      $mail_status = true;
      Session::flash('success', 'A verification mail has been sent to your email address.');
    } catch (Exception $e) {
      $mail_status = false;
    }
    return $mail_status;
  }

  public function sendForgetPasswordVerificationMail($user, $varification_code)
  {

    $mail_status = true;
    // first get the mail template information from db
    $mailTemplate = MailTemplate::where('mail_type', 'reset_password_app')->first();
    $mailSubject = $mailTemplate->mail_subject;
    $mailBody = $mailTemplate->mail_body;

    // second get the website title & mail's smtp information from db
    $info = DB::table('basic_settings')
      ->select(
        'website_title',
        'smtp_status',
        'smtp_host',
        'smtp_port',
        'encryption',
        'smtp_username',
        'smtp_password',
        'from_mail',
        'from_name'
      )
      ->first();


    $mailBody = str_replace('{username}', $user->username, $mailBody);
    $mailBody = str_replace('{verification_code}', $varification_code, $mailBody);
    $mailBody = str_replace('{website_title}', $info->website_title, $mailBody);

    // finally add other informations and send the mail
    try {
      if ($info->smtp_status == 1) {
        $data = [
          'to' => $user->email,
          'subject' => $mailSubject,
          'body' => $mailBody,
        ];
        $smtp = [
          'transport' => 'smtp',
          'host' => $info->smtp_host,
          'port' => $info->smtp_port,
          'encryption' => $info->encryption,
          'username' => $info->smtp_username,
          'password' => $info->smtp_password,
          'timeout' => null,
          'auth_mode' => null,
        ];
        Config::set('mail.mailers.smtp', $smtp);
        Mail::send([], [], function (Message $message) use ($data, $info) {
          $fromMail = $info->from_mail;
          $fromName = $info->from_name;
          $message->to($data['to'])
            ->subject($data['subject'])
            ->from($fromMail, $fromName)
            ->html($data['body'], 'text/html');
        });
      }
      $mail_status = true;
    } catch (Exception $e) {
      $mail_status = false;
    }
    return $mail_status;
  }

  public function getClaimRequest()
  {

    $form = Form::where('type', 'claim_request')->first();
    $inputFields = FormInput::query()
      ->where('form_id', $form->id)
      ->orderBy('order_no', 'asc')
      ->get();

    $information['form_id'] =  $form->id;
    $information['inputFields'] = !empty($inputFields) ? $inputFields : [];

    return response()->json([
      'success' => true,
      'data'    => $information,
    ], 200);
  }


  public function storeClaimRequestInfo(Request $request)
  {
    $user = Auth::guard('sanctum')->user();
    $language = HelperController::getLanguage($request);
    $request['user_id'] = $user->id;

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
      'email' => ['required', 'string', 'max:255'],
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
      return response()->json([
        'success' => false,
        'errors' => $validator->errors()
      ], 422);
    }

    // Unique claim check
    $existingClaim = ClaimListing::where([
      ['listing_id', $request->listing_id],
      ['user_id', $request->user_id],
      ['vendor_id', $request->vendor_id],
    ])->first();

    if ($existingClaim) {
      return response()->json([
        'success' => false,
        'message'    => __('You have already claimed this listing'),
      ], 200);
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

    return response()->json([
      'success' => true,
      'message'    => __('Your claim request has been successfully submitted'),
    ], 200);
  }
}
