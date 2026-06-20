<?php

namespace App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway;

use App\Http\Controllers\Controller;
use App\Models\FeaturedListingCharge;
use App\Models\FeatureOrder;
use App\Models\Language;
use App\Models\PaymentGateway\OnlineGateway;
use App\Models\Vendor;
use App\Models\VendorInfo;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;
use Midtrans\Snap;
use Midtrans\Config as MidtransConfig;

class MidtransController extends Controller
{
    public $public_key;

    public function paymentProcess(Request $request, $userType)
    {
        $charge = FeaturedListingCharge::find($request->charge);
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
                'gross_amount' => $charge->price * 1000, // will be multiplied by 1000
            ],

            'vendor_details' => [
                'email' => $vendorinfo->vendor->email,
                'phone' => $vendorinfo->vendor->phone,
                'name' => $vendorinfo->name,
            ],

        ];

        $snapToken = Snap::getSnapToken($params);

        Session::put('paymentInfo', $params);
        Session::put('userType', $userType);
        Session::put('request', $request->all());
        $request->session()->put('chargeId', $request->charge);
        $request->session()->put('listingId', $request->listing_id);

        return view('frontend.payment.listing-feature-midtrans', compact('snapToken', 'data'));
    }

    public function creditCardNotify(Request $request)
    {
        $chargeId = $request->session()->get('chargeId');
        $listingId = $request->session()->get('listingId');
        $vendor_mail = Vendor::Find(Auth::guard('vendor')->user()->id);

        if (isset($vendor_mail->to_mail)) {
            $to_mail = $vendor_mail->to_mail;
        } else {
            $to_mail = $vendor_mail->email;
        }


        $charge = FeaturedListingCharge::find($chargeId);


        $startDate = Carbon::now()->startOfDay();
        $endDate = $startDate->copy()->addDays($charge->days);

        $order =  FeatureOrder::where('listing_id', $listingId)->first();
        if (empty($order)) {
            $order = new FeatureOrder();
        }

        $order->listing_id = $listingId;
        $order->vendor_id = Auth::guard('vendor')->user()->id;
        $order->vendor_mail = $to_mail;
        $order->order_number = uniqid();
        $order->total = $charge->price;
        $order->payment_method = "Midtrans";
        $order->gateway_type = "online";
        $order->payment_status = "completed";
        $order->order_status = 'pending';
        $order->days = $charge->days;
        $order->start_date = $startDate;
        $order->end_date = $endDate;

        $order->save();

        $listingFeature = new ListingFeatureController();

        // generate an invoice in pdf format 
        $invoice = $listingFeature->generateInvoice($order);

        // then, update the invoice field info in database 
        $order->update(['invoice' => $invoice]);

        // send a mail to the vendor 
        $listingFeature->prepareMail($to_mail, $charge->price, $order->payment_method, $order->invoice);

        
        $request->session()->forget('chargeId');
        $request->session()->forget('listingId');
        return redirect()->route('success.page');
    }
}
