<?php

namespace App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway;

use App\Http\Controllers\Controller;
use App\Models\FeaturedListingCharge;
use App\Models\FeatureOrder;
use App\Models\Vendor;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;
use Str;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Response;




use Illuminate\Mail\Message;
use Illuminate\Support\Facades\Mail;


class XenditController extends Controller
{
    public function index(Request $request, $paymentFor)
    {
        $charge = FeaturedListingCharge::find($request->charge);

        $currencyInfo = $this->getCurrencyInfo();
        $allowed_currency = array('IDR', 'PHP', 'USD', 'SGD', 'MYR');

        if (!in_array($currencyInfo->base_currency_text, $allowed_currency)) {
            return Response::json(['error' => 'Invalid currency for Xendit payment.'], 422);
        }

        /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        ~~~~~~~~~~~~~~~~~ Payment Gateway Info ~~~~~~~~~~~~~~
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
        $external_id = Str::random(10);
        $secret_key = 'Basic ' . config('xendit.key_auth');

        $data_request = Http::withHeaders([
            'Authorization' => $secret_key
        ])->post('https://api.xendit.co/v2/invoices', [
            'external_id' => $external_id,
            'amount' => $charge->price,
            'currency' => $currencyInfo->base_currency_text,
            'success_redirect_url' => route('vendor.listing_management.listing.purchase_feature.xendit.notify')
        ]);
        $response = $data_request->object();
        $response = json_decode(json_encode($response), true);
        if (!empty($response['success_redirect_url'])) {
            // put some data in session before redirect to paytm url
            $request->session()->put('paymentFor', $paymentFor);
            $request->session()->put('chargeId', $request->charge);
            $request->session()->put('listingId', $request->listing_id);
            $request->session()->put('xendit_id', $response['id']);
            $request->session()->put('secret_key', config('xendit.key_auth'));
            $request->session()->put('xendit_payment_type', 'shop');

            return response()->json(['redirectURL' => $response['invoice_url']]);
        } else {
            return Response::json(['error' => 'Something went Wrong.'], 422);
        }
    }


    // return to success page
    public function notify(Request $request)
    {
        // get the information from session
        $chargeId = $request->session()->get('chargeId');
        $listingId = $request->session()->get('listingId');
        $xendit_id = Session::get('xendit_id');
        $secret_key = Session::get('secret_key');
        if (!is_null($xendit_id) && $secret_key == config('xendit.key_auth')) {




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
            $order->payment_method = "Xendit";
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
            Session::flash('warning', __('Something Went Wrong') . '!');
            return redirect()->route('vendor.listing_management.listings');
        }
    }
}
