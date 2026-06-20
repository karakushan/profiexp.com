<?php

namespace App\Http\Controllers\Payment;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Controllers\Vendor\VendorCheckoutController;
use App\Http\Helpers\MegaMailer;
use App\Http\Helpers\VendorPermissionHelper;
use App\Models\BasicSettings\Basic;
use App\Models\Language;
use App\Models\Package;
use App\Models\PaymentGateway\OnlineGateway;
use Carbon\Carbon;
use Razorpay\Api\Api;
use Illuminate\Support\Facades\Session;
use Razorpay\Api\Errors\SignatureVerificationError;
use App\Services\ClaimAttachService;
use Illuminate\Support\Facades\Auth;

class RazorpayController extends Controller
{
    private $key, $secret, $api;

    public function __construct()
    {
        $data = OnlineGateway::whereKeyword('razorpay')->first();
        $razorpayData = json_decode($data->information, true);

        $this->key = $razorpayData['key'];

        $this->secret = $razorpayData['secret'];

        $this->api = new Api($this->key, $this->secret);
    }


    public function paymentProcess(Request $request, $_amount, $_item_number, $_cancel_url, $_success_url, $_title, $_description, $bs)
    {
        $notifyURL = $_success_url;

        // create order data
        $orderData = [
            'receipt'         => "ok",
            'amount'          => intval($_amount * 100),
            'currency'        => 'INR',
            'payment_capture' => 1 // auto capture
        ];

        $razorpayOrder = $this->api->order->create($orderData);

        // claim,t context keep before redirecting to PayPal
        if ($request->filled(['claim', 't'])) {
            $request->session()->put('claim.redeem', $request->only(['claim', 't']));
        }

        Session::put('request', $request->all());
        Session::put('order_payment_id', $razorpayOrder['id']);

        $webInfo = Basic::select('website_title')->first();

        $customerName = $request['billing_name'] . ' ' . $request['billing_name'];
        $customerEmail = $request['billing_email'];
        $customerPhone = $request['billing_phone'];

        // create checkout data
        $checkoutData = [
            'key'               => $this->key,
            'amount'            => $_amount,
            'name'              => $webInfo->website_title,
            'description'       =>   ' via Razorpay.',
            'prefill'           => [
                'name'              => $customerName,
                'email'             => $customerEmail,      
                'contact'           => $customerPhone
            ],
            'order_id'          => $razorpayOrder->id
        ];

        $jsonData = json_encode($checkoutData);

        $request->session()->put('razorpayOrderId', $razorpayOrder->id);

        return view('frontend.payment.razorpay', compact('jsonData', 'notifyURL'));
    }

    public function successPayment(Request $request)
    {
        $requestData = Session::get('request');
        if (session()->has('lang')) {
            $currentLang = Language::where('code', session()->get('lang'))->first();
        } else {
            $currentLang = Language::where('is_default', 1)->first();
        }
        $bs = Basic::first();
        /** Get the payment ID before session clear **/
        $payment_id = Session::get('order_payment_id');
        $success = true;
        if (empty($request['razorpay_payment_id']) === false) {

            try {
                $attributes = array(
                    'razorpay_order_id' => $payment_id,
                    'razorpay_payment_id' => $request['razorpay_payment_id'],
                    'razorpay_signature' => $request['razorpay_signature']
                );

                $this->api->utility->verifyPaymentSignature($attributes);
            } catch (SignatureVerificationError $e) {
                $success = false;
            }
        }

        if ($success === true) {
            $package = Package::find($requestData['package_id']);
            $paymentFor = Session::get('paymentFor');
            $transaction_id = VendorPermissionHelper::uniqidReal(8);
            $transaction_details = json_encode($request);
            if ($paymentFor == "membership") {
                $amount = $requestData['price'];
                $password = $requestData['password'];
                $checkout = new VendorCheckoutController();
                $vendor = $checkout->store($requestData, $transaction_id, $transaction_details, $amount, $bs, $password);

                $lastMemb = $vendor->memberships()->orderBy('id', 'DESC')->first();
                $activation = Carbon::parse($lastMemb->start_date);
                $expire = Carbon::parse($lastMemb->expire_date);
                $file_name = $this->makeInvoice($requestData, "membership", $vendor, $password, $amount, "Razorpay", $requestData['phone'], $bs->base_currency_symbol_position, $bs->base_currency_symbol, $bs->base_currency_text, $transaction_id, $package->title, $lastMemb);

                // then, update the invoice field info in database 
                $lastMemb->update(['invoice' => $file_name]);

                $mailer = new MegaMailer();
                $data = [
                    'toMail' => $vendor->email,
                    'toName' => $vendor->fname,
                    'username' => $vendor->username,
                    'package_title' => $package->title,
                    'package_price' => ($bs->base_currency_text_position == 'left' ? $bs->base_currency_text . ' ' : '') . $package->price . ($bs->base_currency_text_position == 'right' ? ' ' . $bs->base_currency_text : ''),
                    'activation_date' => $activation->toFormattedDateString(),
                    'discount' => ($bs->base_currency_text_position == 'left' ? $bs->base_currency_text . ' ' : '') . $lastMemb->discount . ($bs->base_currency_text_position == 'right' ? ' ' . $bs->base_currency_text : ''),
                    'total' => ($bs->base_currency_text_position == 'left' ? $bs->base_currency_text . ' ' : '') . $lastMemb->price . ($bs->base_currency_text_position == 'right' ? ' ' . $bs->base_currency_text : ''),
                    'expire_date' => Carbon::parse($expire->toFormattedDateString())->format('Y') == '9999' ? 'Lifetime' : $expire->toFormattedDateString(),
                    'membership_invoice' => $file_name,
                    'website_title' => $bs->website_title,
                    'templateType' => 'package_purchase',
                    'type' => 'registrationWithPremiumPackage'
                ];
                $mailer->mailFromAdmin($data);

                //attach listing after successful membership purchase
                $ctx = session()->pull('claim.redeem');
                $vendorId = Auth::guard('vendor')->id();
                if ($ctx && $vendorId) {
                    app(ClaimAttachService::class)->attachFromSession((int)$vendorId, $ctx);
                }

                session()->flash('success', 'Your payment has been completed.');
                Session::forget('request');
                Session::forget('paymentFor');
                return redirect()->route('success.page');
            } elseif ($paymentFor == "extend") {
                $amount = $requestData['price'];
                $password = uniqid('qrcode');
                $checkout = new VendorCheckoutController();
                $user = $checkout->store($requestData, $transaction_id, $transaction_details, $amount, $bs, $password);

                $lastMemb = $user->memberships()->orderBy('id', 'DESC')->first();
                $activation = Carbon::parse($lastMemb->start_date);
                $expire = Carbon::parse($lastMemb->expire_date);
                $file_name = $this->makeInvoice($requestData, "extend", $user, $password, $amount, $requestData["payment_method"], $user->phone, $bs->base_currency_symbol_position, $bs->base_currency_symbol, $bs->base_currency_text, $transaction_id, $package->title, $lastMemb);

                // then, update the invoice field info in database 
                $lastMemb->update(['invoice' => $file_name]);

                $mailer = new MegaMailer();
                $data = [
                    'toMail' => $user->email,
                    'toName' => $user->fname,
                    'username' => $user->username,
                    'package_title' => $package->title,
                    'package_price' => ($bs->base_currency_text_position == 'left' ? $bs->base_currency_text . ' ' : '') . $package->price . ($bs->base_currency_text_position == 'right' ? ' ' . $bs->base_currency_text : ''),
                    'activation_date' => $activation->toFormattedDateString(),
                    'expire_date' => Carbon::parse($expire->toFormattedDateString())->format('Y') == '9999' ? 'Lifetime' : $expire->toFormattedDateString(),
                    'membership_invoice' => $file_name,
                    'website_title' => $bs->website_title,
                    'templateType' => 'package_purchase',
                    'type' => 'membershipExtend'
                ];
                $mailer->mailFromAdmin($data);

                //attach listing after successful membership purchase
                $ctx = session()->pull('claim.redeem');
                $vendorId = Auth::guard('vendor')->id();
                if ($ctx && $vendorId) {
                    app(ClaimAttachService::class)->attachFromSession((int)$vendorId, $ctx);
                }
                
                session()->flash('success', __('successful_payment'));
                Session::forget('request');
                Session::forget('paymentFor');
                return redirect()->route('success.page');
            }
        }
        $requestData = Session::get('request');
        session()->flash('warning', __('Payment Canceled'));

        return redirect()->route('vendor.plan.extend.checkout', ['package_id' => $requestData['package_id']])->withInput($requestData);
    }

    public function cancelPayment()
    {
        $requestData = Session::get('request');
        session()->flash('warning', __('Payment Canceled'));

        return redirect()->route('vendor.plan.extend.checkout', ['package_id' => $requestData['package_id']])->withInput($requestData);
    }
}
