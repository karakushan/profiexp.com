<?php

namespace App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Cartalyst\Stripe\Exception\CardErrorException;
use Cartalyst\Stripe\Exception\UnauthorizedException;
use Cartalyst\Stripe\Laravel\Facades\Stripe;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;
use App\Models\FeaturedListingCharge;
use App\Models\FeatureOrder;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Models\Vendor;

class StripeController extends Controller
{
    public function index(Request $request)
    {
        // card validation start
        $rules = [
            'stripeToken' => 'required',
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        // card validation end

        $charge = FeaturedListingCharge::find($request->charge);


        $currencyInfo = $this->getCurrencyInfo();

        // changing the currency before redirect to Stripe
        if ($currencyInfo->base_currency_text !== 'USD') {
            $rate = floatval($currencyInfo->base_currency_rate);
            $convertedTotal = round(($charge->price / $rate), 2);
        }

        $stripeTotal = $currencyInfo->base_currency_text === 'USD' ? $charge->price : $convertedTotal;

        try {
            // initialize stripe
            $stripe = new Stripe();
            $stripe = Stripe::make(Config::get('services.stripe.secret'));

            try {

                // generate charge
                $charge = $stripe->charges()->create([
                    'source' => $request->stripeToken,
                    'currency' => 'USD',
                    'amount'   => $stripeTotal
                ]);

                if ($charge['status'] == 'succeeded') {


                    $vendor_mail = Vendor::Find(Auth::guard('vendor')->user()->id);

                    if (isset($vendor_mail->to_mail)) {
                        $to_mail = $vendor_mail->to_mail;
                    } else {
                        $to_mail = $vendor_mail->email;
                    }


                    $charge = FeaturedListingCharge::find($request->charge);


                    $startDate = Carbon::now()->startOfDay();
                    $endDate = $startDate->copy()->addDays($charge->days);

                    $order =  FeatureOrder::where('listing_id', $request->listing_id)->first();
                    if (empty($order)) {
                        $order = new FeatureOrder();
                    }

                    $order->listing_id = $request->listing_id;
                    $order->vendor_id = Auth::guard('vendor')->user()->id;
                    $order->vendor_mail = $to_mail;
                    $order->order_number = uniqid();
                    $order->total = $charge->price;
                    $order->payment_method = "Stripe";
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
            } catch (CardErrorException $e) {
                Session::flash('error', $e->getMessage());

                Session::flash('warning', __('Something Went Wrong') . '!');
                return redirect()->route('vendor.listing_management.listings');
            }
        } catch (UnauthorizedException $e) {
            Session::flash('error', $e->getMessage());

            Session::flash('warning', __('Something Went Wrong') . '!');
            return redirect()->route('vendor.listing_management.listings');
        }
    }
}
