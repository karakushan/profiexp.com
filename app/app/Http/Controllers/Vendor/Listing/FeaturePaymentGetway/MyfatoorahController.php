<?php

namespace App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway;

use App\Http\Controllers\Controller;
use App\Models\FeaturedListingCharge;
use App\Models\PaymentGateway\OnlineGateway;
use App\Models\Vendor;
use Auth;
use Basel\MyFatoorah\MyFatoorah;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use App\Models\FeatureOrder;

class MyfatoorahController extends Controller
{
  public $myfatoorah;

  public function __construct()
  {
    $this->myfatoorah = MyFatoorah::getInstance(true);
  }

  public function  index(Request $request, $_amount, $_title, $_cancel_url)
  {
    try {
      /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            ~~~~~~ Package Info ~~~~~~~~~~
            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
      $charge = FeaturedListingCharge::find($request->charge);

      $title = $_title;
      $price = $charge->price;
      $price = round($price, 2);
      $cancel_url = $_cancel_url;

      Session::put('request', $request->all());

      /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            ~~~~~~~~~~~~~~~~~ Payment Gateway Info ~~~~~~~~~~~~~~
            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
      $info = OnlineGateway::where('keyword', 'myfatoorah')->first();
      $information = json_decode(
        $info->information,
        true
      );
      $random_1 = rand(999, 9999);
      $random_2 = rand(9999, 99999);
      $result = $this->myfatoorah->sendPayment(
        Auth::guard('vendor')->user()->username,
        $price,
        [
          'CustomerMobile' => $information['sandbox_status'] == 1 ? '56562123544' : $request->phone,
          'CustomerReference' => "$random_1",  //orderID
          'UserDefinedField' => "$random_2", //clientID
          "InvoiceItems" => [
            [
              "ItemName" => "Listing Feature",
              "Quantity" => 1,
              "UnitPrice" => $price
            ]
          ]
        ]
      );
      if ($result && $result['IsSuccess'] == true) {
        $request->session()->put('myfatoorah_payment_type', 'listing_feature');
        $request->session()->put('chargeId', $request->charge);
        $request->session()->put('listingId', $request->listing_id);
        return response()->json(['redirectURL' => $result['Data']['InvoiceURL']]);
      }
    } catch (Exception $e) {
      return redirect($cancel_url)->with('error', 'Payment Canceled');
    }
  }

  public function successCallback(Request $request)
  {
    if (!empty($request->paymentId)) {
      $result = $this->myfatoorah->getPaymentStatus('paymentId', $request->paymentId);
      if ($result && $result['IsSuccess'] == true && $result['Data']['InvoiceStatus'] == "Paid") {
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
        $order->payment_method = "Myfatoorah";
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
        return [
          'status' => 'success'
        ];
      } else {
        return [
          'status' => 'fail'
        ];
      }
    } else {
      return [
        'status' => 'fail'
      ];
    }
  }

  public function failCallback(Request $request)
  {
    $cancel_url = Session::get('cancel_url');
    return redirect($cancel_url);
  }
}
