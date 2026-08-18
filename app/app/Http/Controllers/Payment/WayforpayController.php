<?php

namespace App\Http\Controllers\Payment;

use App\Http\Controllers\Controller;
use App\Http\Controllers\Vendor\VendorCheckoutController;
use App\Http\Helpers\MegaMailer;
use App\Http\Helpers\VendorPermissionHelper;
use App\Models\BasicSettings\Basic;
use App\Models\Membership;
use App\Models\Package;
use App\Models\PaymentGateway\OnlineGateway;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Http;
use App\Services\ClaimAttachService;
use Illuminate\Support\Facades\Auth;

class WayforpayController extends Controller
{
    public static function index(Request $request, $_amount, $_title, $_cancel_url)
    {
        $title = $_title;
        $price = $_amount;
        $price = round($price, 2);
        $cancel_url = $_cancel_url;

        $websiteInfo = Basic::first();
        $wayforpay = OnlineGateway::where('keyword', 'wayforpay')->first();
        $info = json_decode($wayforpay->information, true);

        $randomNo = substr(uniqid(), 0, 8);
        $apiInfo = $info['api'];
        $merchantAccount = $apiInfo['merchant_account'];
        $merchantDomainName = request()->getHost();
        $orderReference = $randomNo;
        $orderDate = time();
        // WayForPay's Purchase documentation uses UAH as the order currency.
        // Convert the site's base currency through USD and use WayForPay's
        // current USD -> UAH rate for the actual order amount.
        $currency = 'UAH';
        $usdToUahRate = Cache::remember(
            'wayforpay_usd_to_uah_rate',
            now()->addMinutes(15),
            fn () => self::fetchUsdToUahRate($apiInfo)
        );

        if ($usdToUahRate === null || $usdToUahRate <= 0) {
            return redirect()->back()
                ->with('warning', __('Unable to get the current WayForPay USD to UAH exchange rate.'))
                ->withInput($request->all());
        }

        $baseCurrency = strtoupper((string) $websiteInfo->base_currency_text);
        if ($baseCurrency === 'UAH') {
            $amount = $price;
        } else {
            $baseCurrencyRate = (float) $websiteInfo->base_currency_rate;
            if ($baseCurrencyRate <= 0) {
                return redirect()->back()
                    ->with('warning', __('Invalid base currency conversion rate.'))
                    ->withInput($request->all());
            }

            $amount = round(($price / $baseCurrencyRate) * $usdToUahRate, 2);
        }

        $productName = [$title];
        $productCount = [1];
        $productPrice = [$amount];

        $signatureString = $merchantAccount . ';' . $merchantDomainName . ';' . $orderReference . ';' . $orderDate . ';' . $amount . ';' . $currency . ';';
        foreach ($productName as $name) {
            $signatureString .= $name . ';';
        }
        foreach ($productCount as $count) {
            $signatureString .= $count . ';';
        }
        foreach ($productPrice as $p) {
            $signatureString .= $p . ';';
        }
        $signatureString = rtrim($signatureString, ';');

        $merchantSignature = hash_hmac('md5', $signatureString, $apiInfo['secret_key']);

        $val['merchantAccount'] = $merchantAccount;
        $val['merchantDomainName'] = $merchantDomainName;
        $val['merchantTransactionSecureType'] = 'AUTO';
        $val['merchantSignature'] = $merchantSignature;
        $val['orderReference'] = $orderReference;
        $val['orderDate'] = $orderDate;
        $val['amount'] = $amount;
        $val['currency'] = $currency;
        $val['productName[]'] = $productName[0];
        $val['productCount[]'] = $productCount[0];
        $val['productPrice[]'] = $productPrice[0];
        $val['serviceUrl'] = route('membership.wayforpay.notify');
        $val['returnUrl'] = route('success.page');
        $val['clientEmail'] = Auth::guard('vendor')->user()->email;

        if (Auth::guard('vendor')->user()->phone) {
            $val['clientPhone'] = Auth::guard('vendor')->user()->phone;
        }

        $data['val'] = $val;
        $data['method'] = 'post';

        // This is the browser Purchase flow. The API endpoint accepts JSON
        // CREATE_INVOICE requests and cannot process this HTML form payload.
        $data['url'] = 'https://secure.wayforpay.com/pay';

        $cacheData = [
            'request' => $request->all(),
            'vendor_id' => Auth::guard('vendor')->id(),
            'paymentFor' => Session::get('paymentFor'),
            'claim_redeem' => $request->filled(['claim', 't']) ? $request->only(['claim', 't']) : null,
        ];
        Cache::put('wayforpay_' . $orderReference, $cacheData, now()->addDays(1));

        return view('frontend.payment.wayforpay', compact('data'));
    }

    private static function fetchUsdToUahRate(array $apiInfo): ?float
    {
        $orderDate = time();
        $signatureString = $apiInfo['merchant_account'] . ';' . $orderDate;
        $merchantSignature = hash_hmac('md5', $signatureString, $apiInfo['secret_key']);

        try {
            $response = Http::timeout(10)
                ->acceptJson()
                ->post('https://api.wayforpay.com/api', [
                    'apiVersion' => '1',
                    'transactionType' => 'CURRENCY_RATES',
                    'merchantAccount' => $apiInfo['merchant_account'],
                    'orderDate' => $orderDate,
                    'merchantSignature' => $merchantSignature,
                    'currency' => 'USD',
                ]);
        } catch (\Throwable $exception) {
            return null;
        }

        if (!$response->successful()) {
            return null;
        }

        $payload = $response->json();
        $reasonCode = (string) ($payload['reasonCode'] ?? $payload['REASONCODE'] ?? '');
        $rate = $payload['rates']['USD'] ?? $payload['RATES']['USD'] ?? null;

        if ($reasonCode !== '1100' || !is_numeric($rate) || (float) $rate <= 0) {
            return null;
        }

        return (float) $rate;
    }

    public function notify(Request $request)
    {
        $wayforpay = OnlineGateway::where('keyword', 'wayforpay')->first();
        $wayforpayInfo = json_decode($wayforpay->information, true);
        $apiInfo = $wayforpayInfo['api'];

        $input = $request->all();

        $signatureValid = false;
        if (isset($input['merchantSignature'])) {
            $merchantSignature = $input['merchantSignature'];
            $signatureString = $input['merchantAccount'] . ';' . $input['orderReference'] . ';' . $input['amount'] . ';' . $input['currency'] . ';' . $input['authCode'] . ';' . $input['cardPan'] . ';' . $input['transactionStatus'] . ';' . $input['reasonCode'];
            $newSignature = hash_hmac('md5', $signatureString, $apiInfo['secret_key']);
            $signatureValid = ($newSignature == $merchantSignature);
        }

        $orderRef = $input['orderReference'] ?? '';

        if (
            ($input['transactionStatus'] ?? '') == 'Approved' &&
            $signatureValid
        ) {
            $cachedData = Cache::get('wayforpay_' . $orderRef);

            if ($cachedData) {
                $requestData = $cachedData['request'];
                $paymentFor = $cachedData['paymentFor'];

                $bs = Basic::first();
                $package = Package::find($requestData['package_id']);
                $transaction_id = VendorPermissionHelper::uniqidReal(8);
                $transaction_details = json_encode($input);

                if ($paymentFor == "membership") {
                    $amount = $requestData['price'];
                    $password = $requestData['password'];
                    $checkout = new VendorCheckoutController();

                    $vendor = $checkout->store($requestData, $transaction_id, $transaction_details, $amount, $bs, $password);

                    $lastMemb = $vendor->memberships()->orderBy('id', 'DESC')->first();

                    $activation = Carbon::parse($lastMemb->start_date);
                    $expire = Carbon::parse($lastMemb->expire_date);
                    $file_name = $this->makeInvoice($requestData, "membership", $vendor, $password, $amount, "WayforPay", $requestData['phone'] ?? '', $bs->base_currency_symbol_position, $bs->base_currency_symbol, $bs->base_currency_text, $transaction_id, $package->title, $lastMemb);

                    $lastMemb->update(['invoice' => $file_name]);

                    $mailer = new MegaMailer();
                    $data = [
                        'toMail' => $vendor->email,
                        'toName' => $vendor->fname,
                        'username' => $vendor->username,
                        'package_title' => $package->title,
                        'package_price' => ($bs->base_currency_text_position == 'left' ? $bs->base_currency_text . ' ' : '') . $package->price . ($bs->base_currency_text_position == 'right' ? ' ' . $bs->base_currency_text : ''),
                        'discount' => ($bs->base_currency_text_position == 'left' ? $bs->base_currency_text . ' ' : '') . $lastMemb->discount . ($bs->base_currency_text_position == 'right' ? ' ' . $bs->base_currency_text : ''),
                        'total' => ($bs->base_currency_text_position == 'left' ? $bs->base_currency_text . ' ' : '') . $lastMemb->price . ($bs->base_currency_text_position == 'right' ? ' ' . $bs->base_currency_text : ''),
                        'activation_date' => $activation->toFormattedDateString(),
                        'expire_date' => Carbon::parse($expire->toFormattedDateString())->format('Y') == '9999' ? 'Lifetime' : $expire->toFormattedDateString(),
                        'membership_invoice' => $file_name,
                        'website_title' => $bs->website_title,
                        'templateType' => 'package_purchase',
                        'type' => 'registrationWithPremiumPackage'
                    ];
                    $mailer->mailFromAdmin($data);

                    $ctx = $cachedData['claim_redeem'] ?? null;
                    $vendorId = $cachedData['vendor_id'];
                    if ($ctx && $vendorId) {
                        app(ClaimAttachService::class)->attachFromSession((int)$vendorId, $ctx);
                    }

                    Cache::forget('wayforpay_' . $orderRef);
                } elseif ($paymentFor == "extend") {
                    $amount = $requestData['price'];
                    $password = uniqid('qrcode');
                    $checkout = new VendorCheckoutController();
                    $vendor = $checkout->store($requestData, $transaction_id, $transaction_details, $amount, $bs, $password);

                    $lastMemb = Membership::where('vendor_id', $vendor->id)->orderBy('id', 'DESC')->first();
                    $activation = Carbon::parse($lastMemb->start_date);
                    $expire = Carbon::parse($lastMemb->expire_date);

                    $file_name = $this->makeInvoice($requestData, "extend", $vendor, $password, $amount, $requestData["payment_method"], $vendor->phone, $bs->base_currency_symbol_position, $bs->base_currency_symbol, $bs->base_currency_text, $transaction_id, $package->title, $lastMemb);

                    $lastMemb->update(['invoice' => $file_name]);

                    $mailer = new MegaMailer();
                    $data = [
                        'toMail' => $vendor->email,
                        'toName' => $vendor->fname,
                        'username' => $vendor->username,
                        'package_title' => $package->title,
                        'package_price' => ($bs->base_currency_text_position == 'left' ? $bs->base_currency_text . ' ' : '') . $package->price . ($bs->base_currency_text_position == 'right' ? ' ' . $bs->base_currency_text : ''),
                        'activation_date' => $activation->toFormattedDateString(),
                        'expire_date' => Carbon::parse($expire->toFormattedDateString())->format('Y') == '9999' ? 'Lifetime' : $expire->toFormattedDateString(),
                        'membership_invoice' => $file_name,
                        'website_title' => $bs->website_title,
                        'templateType' => 'package_purchase',
                        'type' => 'membershipExtend'
                    ];
                    $mailer->mailFromAdmin($data);

                    $ctx = $cachedData['claim_redeem'] ?? null;
                    $vendorId = $cachedData['vendor_id'];
                    if ($ctx && $vendorId) {
                        app(ClaimAttachService::class)->attachFromSession((int)$vendorId, $ctx);
                    }

                    Cache::forget('wayforpay_' . $orderRef);
                }

                echo json_encode([
                    'orderReference' => $orderRef,
                    'status' => 'accept',
                    'time' => time(),
                    'signature' => hash_hmac('md5', $orderRef . ';accept;' . time(), $apiInfo['secret_key'])
                ]);
                return;
            }
        }

        echo json_encode([
            'orderReference' => $orderRef,
            'status' => 'accept',
            'time' => time(),
            'signature' => hash_hmac('md5', ($orderRef) . ';accept;' . time(), $apiInfo['secret_key'])
        ]);
        return;
    }
}
