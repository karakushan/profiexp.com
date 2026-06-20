<?php

namespace App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Mollie\Laravel\Facades\Mollie;
use App\Models\FeaturedListingCharge;
use App\Models\FeatureOrder;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Models\Vendor;
use Illuminate\Support\Facades\Response;

class MollieController extends Controller
{
    public function index(Request $request)
    {
        $charge = FeaturedListingCharge::find($request->charge);

        $allowedCurrencies = array('AED', 'AUD', 'BGN', 'BRL', 'CAD', 'CHF', 'CZK', 'DKK', 'EUR', 'GBP', 'HKD', 'HRK', 'HUF', 'ILS', 'ISK', 'JPY', 'MXN', 'MYR', 'NOK', 'NZD', 'PHP', 'PLN', 'RON', 'RUB', 'SEK', 'SGD', 'THB', 'TWD', 'USD', 'ZAR');

        $currencyInfo = $this->getCurrencyInfo();

        // checking whether the base currency is allowed or not
        if (!in_array($currencyInfo->base_currency_text, $allowedCurrencies)) {
            return Response::json(['error' => 'Invalid currency for mollie payment.'], 422);
        }


        $title = 'Activation Feature';
        $notifyURL = route('vendor.listing_management.listing.purchase_feature.mollie.notify');


        $payment = Mollie::api()->payments->create([
            'amount' => [
                'currency' => $currencyInfo->base_currency_text,
                'value' => sprintf('%0.2f', $charge->price)
            ],
            'description' => $title . ' via Mollie',
            'redirectUrl' => $notifyURL
        ]);

        // put some data in session before redirect to mollie url
        $request->session()->put('payment', $payment);
        $request->session()->put('chargeId', $request->charge);
        $request->session()->put('listingId', $request->listing_id);

        return response()->json(['redirectURL' => $payment->getCheckoutUrl(), 303]);
    }

    public function notify(Request $request)
    {

        $productList = $request->session()->get('productCart');

        // get the information from session
        $payment = $request->session()->get('payment');
        $chargeId = $request->session()->get('chargeId');
        $listingId = $request->session()->get('listingId');

        $paymentInfo = Mollie::api()->payments->get($payment->id);

        if ($paymentInfo->isPaid() == true) {

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
            $order->payment_method = "Mollie";
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
