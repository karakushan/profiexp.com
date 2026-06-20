<?php

namespace App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\PaymentGateway\OnlineGateway;
use Omnipay\Omnipay;
use Illuminate\Support\Facades\Session;
use App\Models\FeaturedListingCharge;
use App\Models\FeatureOrder;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Models\Vendor;
use Illuminate\Support\Facades\Response;

class AuthorizeNetController extends Controller
{
    private $gateway;
    public function __construct()
    {
        $data = OnlineGateway::query()->whereKeyword('authorize.net')->first();
        $authorizeNetData = json_decode($data->information, true);
        $this->gateway = Omnipay::create('AuthorizeNetApi_Api');
        $this->gateway->setAuthName($authorizeNetData['login_id']);
        $this->gateway->setTransactionKey($authorizeNetData['transaction_key']);
        if ($authorizeNetData['sandbox_check'] == 1) {
            $this->gateway->setTestMode(true);
        }
    }
    public function index(Request $request, $paymentFor)
    {


        $currencyInfo = $this->getCurrencyInfo();

        // checking whether the currency is set to 'INR' or not
        $allowedCurrencies = array('USD', 'CAD', 'CHF', 'DKK', 'EUR', 'GBP', 'NOK', 'PLN', 'SEK', 'AUD', 'NZD');
        $currencyInfo = $this->getCurrencyInfo();
        // checking whether the base currency is allowed or not
        if (!in_array($currencyInfo->base_currency_text, $allowedCurrencies)) {
            return Response::json(['error' => 'Invalid currency for authorize.net payment.'], 422);
        }

        // put some data in session before redirect to paytm url;
        $charge = FeaturedListingCharge::find($request->charge);



        if ($request->filled('opaqueDataValue') && $request->filled('opaqueDataDescriptor')) {

            // generate a unique merchant site transaction ID
            $transactionId = rand(100000000, 999999999);
            $response = $this->gateway->authorize([
                'amount' => sprintf('%0.2f', $charge->price),
                'currency' => $currencyInfo->base_currency_text,
                'transactionId' => $transactionId,
                'opaqueDataDescriptor' => $request->opaqueDataDescriptor,
                'opaqueDataValue' => $request->opaqueDataValue
            ])->send();

            if ($response->isSuccessful()) {


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
                $order->payment_method = "Authorize.Net";
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
                //cancel payment
                $request->session()->forget('paymentFor');
                $request->session()->forget('arrData');
                $request->session()->forget('paymentId');

                // remove session data
                $request->session()->forget('productCart');
                $request->session()->forget('discount');

                return redirect()->route('shop.purchase_product.cancel');
            }
        } else {
            Session::flash('warning', __('Something Went Wrong') . '!');

            return redirect()->route('vendor.listing_management.listings');
        }

        Session::flash('warning', __('Something Went Wrong') . '!');

        return redirect()->route('vendor.listing_management.listings');
    }
}
