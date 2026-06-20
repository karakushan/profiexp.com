<?php

namespace App\Http\Controllers\Admin\PaymentGateway;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\PaymentGateway\OnlineGateway;;

use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;
use League\OAuth1\Client\Server\Tumblr;

class OnlineGatewayController extends Controller
{
  public function index()
  {
    $gatewayInfo['paypal'] = OnlineGateway::where('keyword', 'paypal')->first();
    $gatewayInfo['instamojo'] = OnlineGateway::where('keyword', 'instamojo')->first();
    $gatewayInfo['paystack'] = OnlineGateway::where('keyword', 'paystack')->first();
    $gatewayInfo['flutterwave'] = OnlineGateway::where('keyword', 'flutterwave')->first();
    $gatewayInfo['razorpay'] = OnlineGateway::where('keyword', 'razorpay')->first();
    $gatewayInfo['mercadopago'] = OnlineGateway::where('keyword', 'mercadopago')->first();
    $gatewayInfo['mollie'] = OnlineGateway::where('keyword', 'mollie')->first();
    $gatewayInfo['stripe'] = OnlineGateway::where('keyword', 'stripe')->first();
    $gatewayInfo['paytm'] = OnlineGateway::where('keyword', 'paytm')->first();
    $gatewayInfo['anet'] = OnlineGateway::where('keyword', 'authorize.net')->first();
    $gatewayInfo['midtrans'] = OnlineGateway::where('keyword', 'midtrans')->first();
    $gatewayInfo['iyzico'] = OnlineGateway::where('keyword', 'iyzico')->first();
    $gatewayInfo['paytabs'] = OnlineGateway::where('keyword', 'paytabs')->first();
    $gatewayInfo['toyyibpay'] = OnlineGateway::where('keyword', 'toyyibpay')->first();
    $gatewayInfo['phonepe'] = OnlineGateway::where('keyword', 'phonepe')->first();
    $gatewayInfo['yoco'] = OnlineGateway::where('keyword', 'yoco')->first();
    $gatewayInfo['myfatoorah'] = OnlineGateway::where('keyword', 'myfatoorah')->first();
    $gatewayInfo['xendit'] = OnlineGateway::where('keyword', 'xendit')->first();
    $gatewayInfo['perfect_money'] = OnlineGateway::where('keyword', 'perfect_money')->first();

    return view('admin.payment-gateways.online-gateways', $gatewayInfo);
  }

  public function updatePayPalInfo(Request $request)
  {
    $rules = [
      'paypal_status' => 'required',
      'paypal_sandbox_status' => 'required',
      'paypal_client_id' => 'required',
      'paypal_client_secret' => 'required'
    ];

    $validator = Validator::make($request->all(), $rules);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors());
    }

    $information['sandbox_status'] = $request->paypal_sandbox_status;
    $information['client_id'] = $request->paypal_client_id;
    $information['client_secret'] = $request->paypal_client_secret;

    $paypalInfo = OnlineGateway::where('keyword', 'paypal')->first();


    //mobile app set config file;
    if (isset($request->is_mobile) && $request->is_mobile == 1) {
      $publicConfig =  base_path('public/config.php');
      if (file_exists($publicConfig)) {
        $publicConfig = include base_path('public/config.php');
        $publicConfig['PAYPAL_CLIENT_ID'] = $request->paypal_client_id;
        $publicConfig['PAYPAL_SECRET'] = $request->paypal_client_secret;
        $publicConfig['PAYPAL_BASE'] = $request->paypal_sandbox_status == 1
          ? 'https://api-m.sandbox.paypal.com'
          : 'https://api-m.paypal.com';
        $configContent = "<?php\n\nreturn " . var_export($publicConfig, true) . ";\n";
        file_put_contents(base_path('public/config.php'), $configContent);
      }
      $paypalInfo->update([
        'mobile_information' => json_encode($information),
        'mobile_status' => $request->paypal_status
      ]);
    } else {
      $paypalInfo->update([
        'information' => json_encode($information),
        'status' => $request->paypal_status
      ]);
    }
    Session::flash('success', __('PayPal\'s information updated successfully') . '!');

    return redirect()->back();
  }

  public function updateInstamojoInfo(Request $request)
  {
    $rules = [
      'instamojo_status' => 'required',
      'instamojo_sandbox_status' => 'required',
      'instamojo_key' => 'required',
      'instamojo_token' => 'required'
    ];

    $validator = Validator::make($request->all(), $rules);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors());
    }

    $information['sandbox_status'] = $request->instamojo_sandbox_status;
    $information['key'] = $request->instamojo_key;
    $information['token'] = $request->instamojo_token;

    $instamojoInfo = OnlineGateway::where('keyword', 'instamojo')->first();

    if (isset($request->is_mobile) && $request->is_mobile == 1) {
      //update public/config file for authorize info(used it only for apps)
      $publicConfig = include base_path('public/config.php');
      $publicConfig['INSTAMOJO_API_KEY'] = $request->instamojo_key;
      $publicConfig['INSTAMOJO_AUTH_TOKEN'] = $request->instamojo_token;
      $publicConfig['INSTAMOJO_SANDBOX'] = $request->instamojo_sandbox_status ? true : false;

      $configContent = "<?php\n\nreturn " . var_export($publicConfig, true) . ";\n";
      file_put_contents(base_path('public/config.php'), $configContent);


      $instamojoInfo->update([
        'mobile_information' => json_encode($information),
        'mobile_status' => $request->instamojo_status
      ]);
    } else {

      $instamojoInfo->update([
        'information' => json_encode($information),
        'status' => $request->instamojo_status
      ]);
    }

    Session::flash('success', __('Instamojo\'s information updated successfully') . '!');

    return redirect()->back();
  }

  public function updatePaystackInfo(Request $request)
  {
    $rules = [
      'paystack_status' => 'required',
      'paystack_key' => 'required'
    ];

    $validator = Validator::make($request->all(), $rules);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors());
    }

    $information['key'] = $request->paystack_key;

    $paystackInfo = OnlineGateway::where('keyword', 'paystack')->first();

    if (isset($request->is_mobile) && $request->is_mobile == 1) {
      $publicConfig =  base_path('public/config.php');
      if (file_exists($publicConfig)) {
        //update public/config file for paystack info(used it only for apps)
        $publicConfig = include base_path('public/config.php');
        $publicConfig['PAYSTACK_SECRET_KEY'] = $request->paystack_key;
        $configContent = "<?php\n\nreturn " . var_export($publicConfig, true) . ";\n";
        file_put_contents(base_path('public/config.php'), $configContent);

        $paystackInfo->update([
          'mobile_information' => json_encode($information),
          'mobile_status' => $request->paystack_status
        ]);
      }
    } else {
      $paystackInfo->update([
        'information' => json_encode($information),
        'status' => $request->paystack_status
      ]);
    }
    Session::flash('success', __('Paystack\'s information updated successfully') . '!');
    return redirect()->back();
  }

  public function updateFlutterwaveInfo(Request $request)
  {
    $rules = [
      'flutterwave_status' => 'required',
      'flutterwave_public_key' => 'required',
      'flutterwave_secret_key' => 'required'
    ];

    $validator = Validator::make($request->all(), $rules);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors());
    }

    $information['public_key'] = $request->flutterwave_public_key;
    $information['secret_key'] = $request->flutterwave_secret_key;

    $flutterwaveInfo = OnlineGateway::where('keyword', 'flutterwave')->first();

    if (isset($request->is_mobile) && $request->is_mobile == 1) {
      //mobile app set config file
      $publicConfig = base_path('public/config.php');
      if (file_exists($publicConfig)) {
        $publicConfig = include base_path('public/config.php');
        $publicConfig['FLW_SECRET_KEY'] = $request->flutterwave_secret_key;
        $configContent = "<?php\n\nreturn " . var_export($publicConfig, true) . ";\n";
        file_put_contents(base_path('public/config.php'), $configContent);
      }

      $flutterwaveInfo->mobile_status = $request->flutterwave_status;
      $flutterwaveInfo->mobile_information = json_encode($information);
      $flutterwaveInfo->save();
    } else {
      $flutterwaveInfo->update([
        'information' => json_encode($information),
        'status' => $request->flutterwave_status
      ]);
      $array = [
        'FLW_PUBLIC_KEY' => $request->flutterwave_public_key,
        'FLW_SECRET_KEY' => $request->flutterwave_secret_key
      ];
      setEnvironmentValue($array);
      Artisan::call('config:clear');
    }

    Artisan::call('config:clear');
    Session::flash('success', __('Flutterwave\'s information updated successfully') . '!');

    return redirect()->back();
  }

  public function updateRazorpayInfo(Request $request)
  {
    $rules = [
      'razorpay_status' => 'required',
      'razorpay_key' => 'required',
      'razorpay_secret' => 'required'
    ];

    $validator = Validator::make($request->all(), $rules);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors());
    }

    $information['key'] = $request->razorpay_key;
    $information['secret'] = $request->razorpay_secret;

    $razorpayInfo = OnlineGateway::where('keyword', 'razorpay')->first();

    if (isset($request->is_mobile) && $request->is_mobile == 1) {
      $razorpayInfo->mobile_information = json_encode($information);
      $razorpayInfo->mobile_status = $request->razorpay_status;
      $razorpayInfo->save();
    } else {
      $razorpayInfo->update([
        'information' => json_encode($information),
        'status' => $request->razorpay_status
      ]);
    }
    Session::flash('success', __('Razorpay\'s information updated successfully') . '!');

    return redirect()->back();
  }

  public function updateMercadoPagoInfo(Request $request)
  {
    $rules = [
      'mercadopago_status' => 'required',
      'mercadopago_sandbox_status' => 'required',
      'mercadopago_token' => 'required'
    ];

    $validator = Validator::make($request->all(), $rules);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors());
    }

    $information['sandbox_status'] = $request->mercadopago_sandbox_status;
    $information['token'] = $request->mercadopago_token;

    $mercadopagoInfo = OnlineGateway::where('keyword', 'mercadopago')->first();

    //mobile app set config file
    if (isset($request->is_mobile) && $request->is_mobile == 1) {
      $publicConfig =  base_path('public/config.php');
      if (file_exists($publicConfig)) {
        //update public/config file for mercadopago info(used it only for apps)
        $publicConfig = include base_path('public/config.php');
        $publicConfig['MP_ACCESS_TOKEN'] = $request->mercadopago_token;
        $configContent = "<?php\n\nreturn " . var_export($publicConfig, true) . ";\n";
        file_put_contents(base_path('public/config.php'), $configContent);

        $mercadopagoInfo->update([
          'mobile_information' => json_encode($information),
          'mobile_status' => $request->mercadopago_status
        ]);
      }
    } else {
      $mercadopagoInfo->update([
        'information' => json_encode($information),
        'status' => $request->mercadopago_status
      ]);
    }

    Session::flash('success', __('MercadoPago\'s information updated successfully') . '!');

    return redirect()->back();
  }

  public function updateMollieInfo(Request $request)
  {
    $rules = [
      'mollie_status' => 'required',
      'mollie_key' => 'required'
    ];

    $validator = Validator::make($request->all(), $rules);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors());
    }

    $information['key'] = $request->mollie_key;

    $mollieInfo = OnlineGateway::where('keyword', 'mollie')->first();

    if (isset($request->is_mobile) && $request->is_mobile == 1) {
      $publicConfig =  base_path('public/config.php');
      if (file_exists($publicConfig)) {
        $publicConfig = include base_path('public/config.php');
        $publicConfig['MOLLIE_API_KEY'] = $request->mollie_key;
        $configContent = "<?php\n\nreturn " . var_export($publicConfig, true) . ";\n";
        file_put_contents(base_path('public/config.php'), $configContent);
        $mollieInfo->update([
          'mobile_information' => json_encode($information),
          'mobile_status' => $request->mollie_status
        ]);
      }
    } else {
      $mollieInfo->update([
        'information' => json_encode($information),
        'status' => $request->mollie_status
      ]);
      $array = ['MOLLIE_KEY' => $request->mollie_key];
      setEnvironmentValue($array);
      Artisan::call('config:clear');
    }

    Session::flash('success', __('Mollie\'s information updated successfully') . '!');

    return redirect()->back();
  }

  public function updateStripeInfo(Request $request)
  {
    $rules = [
      'stripe_status' => 'required',
      'stripe_key' => 'required',
      'stripe_secret' => 'required'
    ];

    $validator = Validator::make($request->all(), $rules);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors());
    }

    $information['key'] = $request->stripe_key;
    $information['secret'] = $request->stripe_secret;

    $stripeInfo = OnlineGateway::where('keyword', 'stripe')->first();

    if (isset($request->is_mobile) && $request->is_mobile == 1) {
      $publicConfig =  base_path('public/config.php');
      if (file_exists($publicConfig)) {
        $publicConfig = include base_path('public/config.php');
        $publicConfig['STRIPE_SECRET_KEY'] = $request->stripe_secret;
        $configContent = "<?php\n\nreturn " . var_export($publicConfig, true) . ";\n";
        file_put_contents(base_path('public/config.php'), $configContent);
        $stripeInfo->update([
          'mobile_information' => json_encode($information),
          'mobile_status' => $request->stripe_status
        ]);
      }
    } else {
      $stripeInfo->update([
        'information' => json_encode($information),
        'status' => $request->stripe_status
      ]);

      $array = [
        'STRIPE_KEY' => $request->stripe_key,
        'STRIPE_SECRET' => $request->stripe_secret
      ];

      setEnvironmentValue($array);
      Artisan::call('config:clear');
    }
    Session::flash('success', __('Stripe\'s information updated successfully') . '!');
    return redirect()->back();
  }

  public function updatePaytmInfo(Request $request)
  {
    $rules = [
      'paytm_status' => 'required',
      'paytm_environment' => 'required',
      'paytm_merchant_key' => 'required',
      'paytm_merchant_mid' => 'required',
      'paytm_merchant_website' => 'required',
      'paytm_industry_type' => 'required'
    ];

    $validator = Validator::make($request->all(), $rules);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors());
    }

    $information['environment'] = $request->paytm_environment;
    $information['merchant_key'] = $request->paytm_merchant_key;
    $information['merchant_mid'] = $request->paytm_merchant_mid;
    $information['merchant_website'] = $request->paytm_merchant_website;
    $information['industry_type'] = $request->paytm_industry_type;

    $paytmInfo = OnlineGateway::where('keyword', 'paytm')->first();


    if (isset($request->is_mobile) && $request->is_mobile == 1) {
      //update public/config file for authorize info(used it only for apps)
      $publicConfig = include base_path('public/config.php');
      $publicConfig['PAYTM_ENV'] = $request->paytm_environment;
      $publicConfig['PAYTM_MERCHANT_KEY'] = $request->paytm_merchant_key;
      $publicConfig['PAYTM_MERCHANT_ID'] = $request->paytm_merchant_mid;
      $publicConfig['PAYTM_WEBSITE'] = $request->paytm_merchant_website;

      $configContent = "<?php\n\nreturn " . var_export($publicConfig, true) . ";\n";
      file_put_contents(base_path('public/config.php'), $configContent);


      $paytmInfo->update([
        'mobile_information' => json_encode($information),
        'mobile_status' => $request->paytm_status
      ]);
    } else {

      $paytmInfo->update([
        'information' => json_encode($information),
        'status' => $request->paytm_status
      ]);

      $array = [
        'PAYTM_ENVIRONMENT' => $request->paytm_environment,
        'PAYTM_MERCHANT_KEY' => $request->paytm_merchant_key,
        'PAYTM_MERCHANT_ID' => $request->paytm_merchant_mid,
        'PAYTM_MERCHANT_WEBSITE' => $request->paytm_merchant_website,
        'PAYTM_INDUSTRY_TYPE' => $request->paytm_industry_type
      ];
      setEnvironmentValue($array);
    }
    Artisan::call('config:clear'); 

    Session::flash('success', __('Paytm\'s information updated successfully') . '!');

    return redirect()->back();
  }

  public function updateAnetInfo(Request $request)
  {
    $information = [];
    $information['login_id'] = $request->login_id;
    $information['transaction_key'] = $request->transaction_key;
    $information['public_key'] = $request->public_key;
    $information['sandbox_check'] = $request->sandbox_check;
    $information['text'] = "Pay via your Authorize.net account.";


    $anet = OnlineGateway::where('keyword', 'authorize.net')->first();

    if (isset($request->is_mobile) && $request->is_mobile == 1) {
      //update public/config file for authorize info(used it only for apps)
      $publicConfig = include base_path('public/config.php');
      $publicConfig['AUTHORIZE_LOGIN_ID'] = $request->login_id;
      $publicConfig['AUTHORIZE_TRANSACTION_KEY'] = $request->transaction_key;
      $publicConfig['AUTHORIZE_ENV'] = $request->sandbox_check ? 'sandbox' : 'production';
      $configContent = "<?php\n\nreturn " . var_export($publicConfig, true) . ";\n";
      file_put_contents(base_path('public/config.php'), $configContent);

      $anet->mobile_status = $request->status;
      $anet->mobile_information = json_encode($information);
      $anet->save();
    } else {
      $anet->status = $request->status;
      $anet->information = json_encode($information);
      $anet->save();
    }

    Session::flash('success', __('Authorize.net informations updated successfully') . '!');
    return back();
  }



  public function updateIyzicoInfo(Request $request)
  {

    $iyzico =  OnlineGateway::where('keyword', 'iyzico')->first();

    $information = [];
    $information['api_key'] = $request->api_key;
    $information['secrect_key'] = $request->secrect_key;
    $information['iyzico_mode'] = $request->iyzico_mode;

    if (isset($request->is_mobile) && $request->is_mobile == 1) {
      //update public/config file for authorize info(used it only for apps)
      $publicConfig = include base_path('public/config.php');
      $publicConfig['IYZICO_API_KEY'] = $request->api_key;
      $publicConfig['IYZICO_SECRET_KEY'] = $request->secrect_key;
      $publicConfig['IYZICO_MODE'] = $request->iyzico_mode;

      $configContent = "<?php\n\nreturn " . var_export($publicConfig, true) . ";\n";
      file_put_contents(base_path('public/config.php'), $configContent);

      $iyzico->mobile_status = $request->status;
      $iyzico->mobile_information = json_encode($information);
      $iyzico->save();
    } else {

      $iyzico->information = json_encode($information);
      $iyzico->status = $request->status;
      $iyzico->save();
    }

    Session::flash('success', __('Iyzico\'s informations updated successfully') . '!');

    return back();
  }
  public function updateMidtransInfo(Request $request)
  {
    $data = OnlineGateway::where('keyword', 'midtrans')->first();

    $information = [
      "is_production" => $request->is_production,
      "server_key" => $request->server_key
    ];
    if (isset($request->is_mobile) && $request->is_mobile == 1) {
      //update public/config file for midtrans info(used it only for apps)
      $publicConfig = include base_path('public/config.php');
      $publicConfig['MIDTRANS_SERVER_KEY'] = $request->server_key;
      $publicConfig['MIDTRANS_BASE'] = $request->is_production == 1 ? 'https://app.sandbox.midtrans.com/snap/v1/transactions' :
        'https://app.midtrans.com/snap/v1/transactions';
      $configContent = "<?php\n\nreturn " . var_export($publicConfig, true) . ";\n";
      file_put_contents(base_path('public/config.php'), $configContent);

      $data->mobile_status = $request->status;
      $data->mobile_information = json_encode($information);
      $data->save();
    } else {
      $data->status = $request->status;
      $data->information = json_encode($information);
      $data->save();
    }

    Session::flash('success', __('Midtrans informations updated successfully') . '!');
    return back();
  }
  public function updateMyFatoorahInfo(Request $request)
  {
    $rules = [
      'status' => 'required',
      'sandbox_status' => 'required',
      'token' => 'required',
    ];

    $validator = Validator::make($request->all(), $rules);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors());
    }

    $information = [
      'token' => $request->token,
      'sandbox_status' => $request->sandbox_status
    ];

    $data = OnlineGateway::where('keyword', 'myfatoorah')->first();

    if (isset($request->is_mobile) && $request->is_mobile == 1) {

      $publicConfig =  base_path('public/config.php');
      if (file_exists($publicConfig)) {
        $publicConfig = include base_path('public/config.php');
        $publicConfig['MYFATOORAH_API_KEY'] = $request->token;
        $publicConfig['MYFATOORAH_BASE'] = $request->sandbox_status == 1
          ? 'https://apitest.myfatoorah.com'
          : 'https://api.myfatoorah.com';
        $configContent = "<?php\n\nreturn " . var_export($publicConfig, true) . ";\n";
        file_put_contents(base_path('public/config.php'), $configContent);

        $data->update([
          'mobile_information' => json_encode($information),
          'mobile_status' => $request->status
        ]);
      }
    } else {

      $data->update([
        'information' => json_encode($information),
        'status' => $request->status
      ]);
      $array = [
        'MYFATOORAH_TOKEN' => $request->token,
        'MYFATOORAH_CALLBACK_URL' => route('myfatoorah_callback'),
        'MYFATOORAH_ERROR_URL' => route('myfatoorah_cancel'),
      ];
      setEnvironmentValue($array);
      Artisan::call('config:clear');
    }
    Session::flash('success', __('Updated Myfatoorah\'s Information Successfully') . '!');

    return redirect()->back();
  }
  public function updatePhonepeInfo(Request $request)
  {
    $rules = [
      'status' => 'required',
      'sandbox_status' => 'required',
      'merchant_id' => 'required',
      'salt_key' => 'required',
      'salt_index' => 'required'
    ];

    $validator = Validator::make($request->all(), $rules);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors());
    }

    $information['merchant_id'] = $request->merchant_id;
    $information['sandbox_status'] = $request->sandbox_status;
    $information['salt_key'] = $request->salt_key;
    $information['salt_index'] = $request->salt_index;

    $data = OnlineGateway::where('keyword', 'phonepe')->first();

    if (isset($request->is_mobile) && $request->is_mobile == 1) {
      $publicConfig =  base_path('public/config.php');
      if (file_exists($publicConfig)) {
        $publicConfig = include base_path('public/config.php');
        $publicConfig['PHONEPE_MERCHANT_ID'] = $request->merchant_id;
        $publicConfig['PHONEPE_SALT_KEY'] = $request->salt_key;
        $publicConfig['PHONEPE_SALT_INDEX'] = $request->salt_index;
        $publicConfig['PHONEPE_BASE'] = $request->sandbox_status == 1 ? 'https://api-preprod.phonepe.com/apis/pg-sandbox' : 'https://api.phonepe.com/apis/hermes';
        $configContent = "<?php\n\nreturn " . var_export($publicConfig, true) . ";\n";
        file_put_contents(base_path('public/config.php'), $configContent);

        $data->update([
          'mobile_information' => json_encode($information),
          'mobile_status' => $request->status
        ]);
      }
    } else {
      $data->update([
        'information' => json_encode($information),
        'status' => $request->status
      ]);
    }

    Session::flash('success', __('Updated Phonepe\'s Information Successfully') . '!');

    return redirect()->back();
  }
  public function updateYocoInfo(Request $request)
  {
    $rules = [
      'status' => 'required',
      'secret_key' => 'required',
    ];

    $validator = Validator::make($request->all(), $rules);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors());
    }

    $information['secret_key'] = $request->secret_key;

    $data = OnlineGateway::where('keyword', 'yoco')->first();

    if (isset($request->is_mobile) && $request->is_mobile == 1) {
      $publicConfig =  base_path('public/config.php');
      if (file_exists($publicConfig)) {
        $publicConfig = include base_path('public/config.php');
        $publicConfig['YOCO_SECRET_KEY'] = $request->secret_key;
        $configContent = "<?php\n\nreturn " . var_export($publicConfig, true) . ";\n";
        file_put_contents(base_path('public/config.php'), $configContent);

        $data->update([
          'mobile_information' => json_encode($information),
          'mobile_status' => $request->status
        ]);
      }
    } else {

      $data->update([
        'information' => json_encode($information),
        'status' => $request->status
      ]);
    }

    Session::flash('success', __('Updated Yoco\'s Information Successfully') . '!');

    return redirect()->back();
  }
  public function updateToyyibpayInfo(Request $request)
  {
    $rules = [
      'status' => 'required',
      'sandbox_status' => 'required',
      'secret_key' => 'required',
      'category_code' => 'required'
    ];

    $validator = Validator::make($request->all(), $rules);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors());
    }

    $information['sandbox_status'] = $request->sandbox_status;
    $information['secret_key'] = $request->secret_key;
    $information['category_code'] = $request->category_code;

    $data = OnlineGateway::where('keyword', 'toyyibpay')->first();

    if (isset($request->is_mobile) && $request->is_mobile == 1) {
      $publicConfig =  base_path('public/config.php');
      if (file_exists($publicConfig)) {
        $publicConfig = include base_path('public/config.php');
        $publicConfig['TOYYIBPAY_SECRET_KEY'] = $request->secret_key;
        $publicConfig['TOYYIBPAY_CATEGORY_CODE'] = $request->category_code;
        $publicConfig['TOYYIBPAY_BASE'] = $request->sandbox_status == 1 ? 'https://dev.toyyibpay.com' : 'https://www.toyyibpay.com';
        $configContent = "<?php\n\nreturn " . var_export($publicConfig, true) . ";\n";
        file_put_contents(base_path('public/config.php'), $configContent);
      }
      $data->update([
        'mobile_information' => json_encode($information),
        'mobile_status' => $request->status
      ]);
    } else {
      $data->update([
        'information' => json_encode($information),
        'status' => $request->status
      ]);
    }

    Session::flash('success', __('Updated Toyyibpas\'s Information Successfully') . '!');

    return redirect()->back();
  }
  public function updatePaytabsInfo(Request $request)
  {
    $rules = [
      'status' => 'required',
      'country' => 'required',
      'server_key' => 'required',
      'profile_id' => 'required',
      'api_endpoint' => 'required'
    ];

    $validator = Validator::make($request->all(), $rules);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors());
    }

    $information['server_key'] = $request->server_key;
    $information['profile_id'] = $request->profile_id;
    $information['country'] = $request->country;
    $information['api_endpoint'] = $request->api_endpoint;

    $data = OnlineGateway::where('keyword', 'paytabs')->first();

    if (isset($request->is_mobile) && $request->is_mobile == 1) {
      //update public/config file for authorize info(used it only for apps)
      $publicConfig = include base_path('public/config.php');
      $publicConfig['PAYTABS_PROFILE_ID'] = $request->profile_id;
      $publicConfig['PAYTABS_SERVER_KEY'] = $request->server_key;
      $publicConfig['PAYTABS_BASE_URL'] = $request->api_endpoint;

      $configContent = "<?php\n\nreturn " . var_export($publicConfig, true) . ";\n";
      file_put_contents(base_path('public/config.php'), $configContent);


      $data->update([
        'mobile_information' => json_encode($information),
        'mobile_status' => $request->status
      ]);
    } else {

      $data->update([
        'information' => json_encode($information),
        'status' => $request->status
      ]);
    }

    Session::flash('success', __('Updated Paytabs\'s Information Successfully') . '!');

    return redirect()->back();
  }

  public function updatePerfectMoneyInfo(Request $request)
  {
    $rules = [
      'status' => 'required',
      'perfect_money_wallet_id' => 'required'
    ];

    $validator = Validator::make($request->all(), $rules);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors());
    }

    $information = [
      'perfect_money_wallet_id' => $request->perfect_money_wallet_id,
      'perfect_money_password' => $request->perfect_money_password,
      'perfect_money_name' => $request->perfect_money_name
    ];

    $data = OnlineGateway::where('keyword', 'perfect_money')->first();

    if (isset($request->is_mobile) && $request->is_mobile == 1) {
      //update public/config file for authorize info(used it only for apps)
      $publicConfig = include base_path('public/config.php');
      $publicConfig['PM_WALLET'] = $request->perfect_money_wallet_id;
      $publicConfig['PM_PASS'] = $request->perfect_money_password;
      $publicConfig['PM_NAME'] = $request->perfect_money_name;

      $configContent = "<?php\n\nreturn " . var_export($publicConfig, true) . ";\n";
      file_put_contents(base_path('public/config.php'), $configContent);


      $data->update([
        'mobile_information' => json_encode($information),
        'mobile_status' => $request->status
      ]);
    } else {

      $data->update([
        'information' => json_encode($information),
        'status' => $request->status
      ]);
    }


    Session::flash('success', __('Updated Perfect Money\'s Information Successfully') . '!');

    return redirect()->back();
  }

  public function updateXenditInfo(Request $request)
  {
    $rules = [
      'status' => 'required',
      'secret_key' => 'required',
    ];

    $validator = Validator::make($request->all(), $rules);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors());
    }

    $information['secret_key'] = $request->secret_key;

    $data = OnlineGateway::where('keyword', 'xendit')->first();
    if (isset($request->is_mobile) && $request->is_mobile == 1) {
      $publicConfig =  base_path('public/config.php');
      if (file_exists($publicConfig)) {
        $publicConfig = include base_path('public/config.php');
        $publicConfig['XENDIT_SECRET_KEY'] = $request->secret_key;
        $configContent = "<?php\n\nreturn " . var_export($publicConfig, true) . ";\n";
        file_put_contents(base_path('public/config.php'), $configContent);
        $data->update([
          'mobile_information' => json_encode($information),
          'mobile_status' => $request->status
        ]);
      }
    } else {
      $data->update([
        'information' => json_encode($information),
        'status' => $request->status
      ]);
      $array = [
        'XENDIT_SECRET_KEY' => $request->secret_key,
      ];
      setEnvironmentValue($array);
      Artisan::call('config:clear');
    }

    Session::flash('success', __('Updated Xendit\' Information Successfully') . '!');
    return redirect()->back();
  }

  public function updateMonify(Request $request)
  {
    $data = OnlineGateway::where('keyword', 'monnify')->first();

    $information = [
      "sandbox_status" => $request->sandbox_status,
      "api_key" => $request->api_key,
      "secret_key" => $request->secret_key,
      "wallet_account_number" => $request->wallet_account_number
    ];


    if (isset($request->is_mobile) && $request->is_mobile == 1) {
      //update public/config file for monnify info(used it only for apps)
      $publicConfig = include base_path('public/config.php');
      $publicConfig['MONNIFY_API_KEY'] = $request->api_key;
      $publicConfig['MONNIFY_SECRET_KEY'] = $request->secret_key;
      $publicConfig['MONNIFY_CONTRACT_CODE'] = $request->wallet_account_number;
      $publicConfig['MONNIFY_BASE'] = $request->sandbox_status == 1 ? 'https://sandbox.monnify.com' : 'https://api.monnify.com';
      $configContent = "<?php\n\nreturn " . var_export($publicConfig, true) . ";\n";
      file_put_contents(base_path('public/config.php'), $configContent);

      $data->mobile_status = $request->status;
      $data->mobile_information = json_encode($information);
      $data->save();
    } else {
      $data->status = $request->status;
      $data->information = json_encode($information);
      $data->save();
    }

    session()->flash('success', __('Updated Successfully'));
    return back();
  }

  /**
   * update nowpayments info
   */
  public function updateNowPayments(Request $request)
  {
    $rules = [
      'status' => 'required',
      'api_key' => 'required'
    ];

    $validator = Validator::make($request->all(), $rules);

    if ($validator->fails()) {
      return redirect()->back()->withErrors($validator->errors());
    }

    $nowPaymentsInfo = OnlineGateway::where('keyword', 'now_payments')->first();
    $information['api_key'] = $request->api_key;


    if (isset($request->is_mobile) && $request->is_mobile == 1) {

      //update public/config file for now_payments info(used it only for apps)
      $publicConfig = include base_path('public/config.php');
      $publicConfig['NOWPAYMENTS_API_KEY'] = $request->api_key;
      $configContent = "<?php\n\nreturn " . var_export($publicConfig, true) . ";\n";
      file_put_contents(base_path('public/config.php'), $configContent);
      $nowPaymentsInfo->update([
        'mobile_information' => json_encode($information),
        'mobile_status' => $request->status
      ]);
    } else {
      $nowPaymentsInfo->update([
        'information' => json_encode($information),
        'status' => $request->status
      ]);
    }


    session()->flash('success', __("NowPayments's information updated successfully!"));
    return redirect()->back();
  }
}
