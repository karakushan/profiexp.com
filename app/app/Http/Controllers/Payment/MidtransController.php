<?php

namespace App\Http\Controllers\Payment;

use Carbon\Carbon;
use Midtrans\Snap;
use App\Models\Package;
use App\Models\Language;
use App\Models\Membership;
use App\Models\VendorInfo;
use Illuminate\Http\Request;
use App\Http\Helpers\MegaMailer;
use App\Models\BasicSettings\Basic;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Midtrans\Config as MidtransConfig;
use Illuminate\Support\Facades\Session;
use App\Http\Helpers\VendorPermissionHelper;
use App\Models\PaymentGateway\OnlineGateway;
use App\Http\Controllers\Vendor\VendorCheckoutController;
use App\Services\ClaimAttachService;

class MidtransController extends Controller
{
    public $public_key;

    public function paymentProcess(Request $request, $userType)
    {
        $currentLang = session()->has('lang') ?
            (Language::where('code', session()->get('lang'))->first())
            : (Language::where('is_default', 1)->first());

        $vendorinfo = VendorInfo::where('vendor_id', Auth::guard('vendor')->user()->id)->where('language_id', $currentLang->id)->with('vendor')->first();

        $data = OnlineGateway::whereKeyword('midtrans')->first();
        $data = json_decode($data->information, true);
        // will come from database
        // MidtransConfig::$serverKey = $data['server_key'];
        MidtransConfig::$serverKey = $data['server_key'];
        if ($data['is_production'] == 1) {
            MidtransConfig::$isProduction = false;
        } elseif ($data['is_production'] == 0) {
            MidtransConfig::$isProduction = true;
        }
        MidtransConfig::$isSanitized = true;
        MidtransConfig::$is3ds = true;


        $params = [
            'transaction_details' => [
                'order_id' => uniqid(),
                'gross_amount' => $request->price * 1000, // will be multiplied by 1000
            ],

            'vendor_details' => [
                'email' => $vendorinfo->vendor->email,
                'phone' => $vendorinfo->vendor->phone,
                'name' => $vendorinfo->name,
            ],

        ];

        $snapToken = Snap::getSnapToken($params);

        // claim,t context keep before redirecting to PayPal
        if ($request->filled(['claim', 't'])) {
            $request->session()->put('claim.redeem', $request->only(['claim', 't']));
        }

        Session::put('paymentInfo', $params);
        Session::put('userType', $userType);
        Session::put('request', $request->all());


        return view('frontend.payment.buy-plan-midtrans', compact('snapToken', 'data'));
    }

    public function creditCardNotify()
    {
        $requestData = Session::get('request');
        $bs = Basic::first();

        $paymentFor = Session::get('paymentFor');

        $package = Package::find($requestData['package_id']);
        $transaction_id = VendorPermissionHelper::uniqidReal(8);
        $transaction_details = "online";

        if ($paymentFor == "membership") {
            $amount = $requestData['price'];
            $password = $requestData['password'];
            $checkout = new VendorCheckoutController();

            $vendor = $checkout->store($requestData, $transaction_id, $transaction_details, $amount, $bs, $password);

            $lastMemb = $vendor->memberships()->orderBy('id', 'DESC')->first();

            $activation = Carbon::parse($lastMemb->start_date);
            $expire = Carbon::parse($lastMemb->expire_date);
            $file_name = $this->makeInvoice($requestData, "membership", $vendor, $password, $amount, "Midtrans", $requestData['phone'], $bs->base_currency_symbol_position, $bs->base_currency_symbol, $bs->base_currency_text, $transaction_id, $package->title, $lastMemb);

            // then, update the invoice field info in database 
            $lastMemb->update(['invoice' => $file_name]);

            $mailer = new MegaMailer();
            $data = [
                'toMail' => $vendor->email,
                'toName' => $vendor->fname,
                'username' => $vendor->username,
                'package_title' => $package->title,
                'package_price' => ($bs->base_currency_text_position == 'left' ? $bs->base_currency_text . ' ' : '') . $package->price . ($bs->base_currency_text_position == 'right' ? ' ' . $bs->base_currency_text : ''),
                'discount' => ($bs->base_currency_text_position == 'left' ? $bs->base_currency_text . ' ' : '') . $lastMemb->discount . ($bs->base_currency_text_position == 'right' ? ' ' . $bs->base_currency_text : ''),
                'total' => ($bs->base_currency_text_position == 'left' ? $bs->base_currency_text . ' ' : '') . $lastMemb->price . ($bs->base_currency_text_position == 'right' ? ' ' . $bs->base_currency_text : ''),
                'activation_date' => $activation->toFormattedDateString(),
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
            $vendor = $checkout->store($requestData, $transaction_id, $transaction_details, $amount, $bs, $password);

            $lastMemb = Membership::where('vendor_id', $vendor->id)->orderBy('id', 'DESC')->first();
            $activation = Carbon::parse($lastMemb->start_date);
            $expire = Carbon::parse($lastMemb->expire_date);

            $file_name = $this->makeInvoice($requestData, "extend", $vendor, $password, $amount, $requestData["payment_method"], $vendor->phone, $bs->base_currency_symbol_position, $bs->base_currency_symbol, $bs->base_currency_text, $transaction_id, $package->title, $lastMemb);

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

            Session::forget('request');
            Session::forget('paymentFor');
            return redirect()->route('success.page');
        }
    }
}
