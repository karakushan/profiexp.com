<?php

namespace App\Jobs;

use App\Http\Controllers\FrontEnd\Shop\PurchaseProcessController;
use App\Models\BasicSettings\Basic;
use App\Models\Shop\ProductOrder;
use App\Models\Shop\ProductPurchaseItem;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use PDF;

class IyzicoPendingProductPurchase implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public $order_id;
    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($order_id)
    {
        $this->order_id = $order_id;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    
    public function handle()
    {
        $orderInfo = ProductOrder::where('id', $this->order_id)->first();
        $conversion_id = $orderInfo->conversation_id;

        $purchaseProcess = new PurchaseProcessController();

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
                        
                        $orderInfo->payment_status = 'completed';
                        $orderInfo->save();

                        $order = ProductOrder::find($orderInfo->id);

                        // generate an invoice in pdf format
                        $invoice = $this->generateInvoice($order);

                        // then, update the invoice field info in database
                        $orderInfo->update(['invoice' => $invoice]);

                        // send a mail to the customer with the invoice
                        $purchaseProcess->prepareMail($orderInfo);

                    } else {
                        $orderInfo->payment_status = 'rejected';
                        $orderInfo->save();
                    }
                } else {
                    $orderInfo->payment_status = 'rejected';
                        $orderInfo->save();
                }
            } else {
                $orderInfo->payment_status = 'rejected';
                        $orderInfo->save();
            }
        }
    }

    public function generateInvoice($orderInfo)
    {
        $fileName = $orderInfo->order_number . '.pdf';

        $data['orderInfo'] = $orderInfo;

        $items = $orderInfo->item()->get();

        $items->map(function ($item) {
            $product = $item->productInfo()->first();
            $item['price'] = $product->current_price * $item->quantity;
        });

        $data['productList'] = $items;

        $directory = public_path('assets/file/invoices/product/');
        @mkdir($directory, 0775, true);

        $fileLocated = $directory . $fileName;

        $data['taxData'] = Basic::select('product_tax_amount')->first();

        PDF::loadView('frontend.shop.invoice', $data)->save($fileLocated);

        return $fileName;
    }
}
