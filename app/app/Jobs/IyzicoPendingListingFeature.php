<?php

namespace App\Jobs;

use App\Http\Controllers\Vendor\Listing\FeaturePaymentGetway\ListingFeatureController;
use App\Models\FeatureOrder;
use App\Models\Vendor;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

class IyzicoPendingListingFeature implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;
    public $feature_id;
    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($feature_id)
    {
        $this->feature_id = $feature_id;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $order = FeatureOrder::where('id', $this->feature_id)->first();
        $conversion_id = $order->conversation_id;

        $listingFeature = new ListingFeatureController();

        $vendor_mail = Vendor::Find($order->vendor_id);

        if (isset($vendor_mail->to_mail)) {
            $to_mail = $vendor_mail->to_mail;
        } else {
            $to_mail = $vendor_mail->email;
        }

        $options = options();
        $request = new \Iyzipay\Request\ReportingPaymentDetailRequest();
        $request->setPaymentConversationId($conversion_id);

        $paymentResponse = \Iyzipay\Model\ReportingPaymentDetail::create($request, $options);

        $result = (array) $paymentResponse;
        foreach ($result as $key => $data) {
            $data = json_decode($data, true);
            if ($data['status'] == 'success' && !is_null($data['payments'])) {

                if (is_array($data['payments']) && !empty($data['payments'])) {
                    if ($data['payments'][0]['paymentStatus'] == 1) {

                        //success 
                        $order->payment_status = 'completed';
                        $order->save();

                        // generate an invoice in pdf format 
                        $invoice = $listingFeature->generateInvoice($order);

                        // then, update the invoice field info in database 
                        $order->update(['invoice' => $invoice]);

                        // send a mail to the vendor 
                        $listingFeature->prepareMail($to_mail, $order->total, $order->payment_method, $order->invoice);
                    } else {
                        $order->payment_status = 'rejected';
                        $order->order_status = 'rejected';
                        $order->save();
                    }
                } else {
                    $order->payment_status = 'rejected';
                    $order->order_status = 'rejected';
                    $order->save();
                }
            } else {
                $order->payment_status = 'rejected';
                $order->order_status = 'rejected';
                $order->save();
            }
        }
    }
}
