<?php

namespace App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\PaymentGateway\OnlineGateway;
use App\Models\FeaturedListingCharge;
use App\Models\FeatureOrder;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Models\Vendor;
use Illuminate\Support\Facades\Response;

class PaystackController extends Controller
{
    private $api_key;

    public function __construct()
    {
        $data = OnlineGateway::whereKeyword('paystack')->first();
        $paystackData = json_decode($data->information, true);

        $this->api_key = $paystackData['key'];
    }

    public function index(Request $request)
    {

        $charge = FeaturedListingCharge::find($request->charge);

        $currencyInfo = $this->getCurrencyInfo();

        // checking whether the currency is set to 'NGN' or not
        if ($currencyInfo->base_currency_text !== 'NGN') {
            return Response::json(['error' => 'Invalid currency for paystack payment.'], 422);
        }

        $notifyURL = route('vendor.listing_management.listing.purchase_feature.paystack.notify');

        $vendor_mail = Vendor::Find(Auth::guard('vendor')->user()->id);

        if (isset($vendor_mail->to_mail)) {
            $vendorEmail = $vendor_mail->to_mail;
        } else {
            $vendorEmail = $vendor_mail->email;
        }

        $curl = curl_init();

        curl_setopt_array($curl, array(
            CURLOPT_URL            => 'https://api.paystack.co/transaction/initialize',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_CUSTOMREQUEST  => 'POST',
            CURLOPT_POSTFIELDS     => json_encode([
                'amount'       => intval($charge->price) * 100,
                'email'        => $vendorEmail,
                'callback_url' => $notifyURL
            ]),
            CURLOPT_HTTPHEADER     => [
                'authorization: Bearer ' . $this->api_key,
                'content-type: application/json',
                'cache-control: no-cache'
            ]
        ));

        $response = curl_exec($curl);

        curl_close($curl);

        $transaction = json_decode($response, true);

        // put some data in session before redirect to paystack url
        $request->session()->put('chargeId', $request->charge);
        $request->session()->put('listingId', $request->listing_id);

        if ($transaction['status'] == true) {
            return response()->json(['redirectURL' => $transaction['data']['authorization_url']]);
        } else {
            return Response::json(['error' => $transaction['message']], 422);
        }
    }

    public function notify(Request $request)
    {
        // get the information from session
        $paymentId = $request->session()->get('paymentId');
        $chargeId = $request->session()->get('chargeId');
        $listingId = $request->session()->get('listingId');

        $urlInfo = $request->all();

        if ($urlInfo['trxref'] === $urlInfo['reference']) {


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
            $order->payment_method = "PayStack";
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
        } else {
            $request->session()->forget('paymentFor');
            $request->session()->forget('arrData');

            // remove session data
            $request->session()->forget('productCart');
            $request->session()->forget('discount');

            return redirect()->route('shop.purchase_product.cancel');
        }
    }
}
