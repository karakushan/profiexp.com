<?php

namespace App\Jobs;

use App\Http\Controllers\Controller;
use App\Http\Helpers\MegaMailer;
use App\Models\BasicSettings\Basic;
use App\Models\Membership;
use App\Models\Package;
use App\Models\Vendor;
use Carbon\Carbon;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use App\Services\ClaimAttachService;
use Illuminate\Support\Facades\Auth;

class IyzicoPendingMembership implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;
    public $memberhip_id;
    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($memberhip_id)
    {
        $this->memberhip_id = $memberhip_id;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $memberhip = Membership::where('id', $this->memberhip_id)->first();

        $conversion_id = $memberhip->conversation_id;

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
                        $memberhip->status = 1;
                        $memberhip->save();

                        $vendor = Vendor::findorFail($memberhip->vendor_id);
                        $package = Package::findOrFail($memberhip->package_id);
                        $settings = json_decode($memberhip->settings, true);
                        $activation = Carbon::parse($package->start_date);
                        $expire = Carbon::parse($package->expire_date);

                        $password = "123";
                        $bs = Basic::first();

                        $vv = new Controller();

                        $file_name = $vv->makeInvoice($memberhip, "membership", $vendor, $password, $package->price, "Iyzico", $vendor->phone, $settings['base_currency_symbol_position'], $bs->base_currency_symbol, $settings['base_currency_text'], $memberhip->transaction_id, $package->title, $memberhip);


                        // then, update the invoice field info in database 
                        $memberhip->update(['invoice' => $file_name]);

                        $mailer = new MegaMailer();
                        $data = [
                                'toMail' => $vendor->email,
                                'toName' => $vendor->fname,
                                'username' => $vendor->username,
                                'package_title' => $package->title,
                                'package_price' => ($bs->base_currency_text_position == 'left' ? $bs->base_currency_text . ' ' : '') . $package->price . ($bs->base_currency_text_position == 'right' ? ' ' . $bs->base_currency_text : ''),
                                'discount' => ($bs->base_currency_text_position == 'left' ? $bs->base_currency_text . ' ' : '') . $memberhip->discount . ($bs->base_currency_text_position == 'right' ? ' ' . $bs->base_currency_text : ''),
                                'total' => ($bs->base_currency_text_position == 'left' ? $bs->base_currency_text . ' ' : '') . $memberhip->price . ($bs->base_currency_text_position == 'right' ? ' ' . $bs->base_currency_text : ''),
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
                    } else {
                        $memberhip->status = 2;
                        $memberhip->save();
                    }
                } else {
                    $memberhip->status = 2;
                    $memberhip->save();
                }
            } else {
                $memberhip->status = 2;
                $memberhip->save();
            }
        }
    }
}
