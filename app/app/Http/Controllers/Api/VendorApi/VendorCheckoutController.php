<?php

namespace App\Http\Controllers\Api\VendorApi;

use App\Http\Controllers\Controller;
use App\Http\Helpers\VendorPermissionHelper;
use App\Models\BasicSettings\Basic;
use App\Models\Membership;
use App\Models\Package;
use App\Models\PaymentGateway\OfflineGateway;
use App\Models\PaymentGateway\OnlineGateway;
use App\Services\VendorNotificationService;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\Validator;

class VendorCheckoutController extends Controller
{
    private const SUPPORTED_MOBILE_GATEWAYS = [
        'paypal',
        'flutterwave',
        'phonepe',
        'mollie',
        'xendit',
        'midtrans',
        'paystack',
        'paytabs',
        'toyyibpay',
        'monnify',
        'authorize.net',
        'mercadopago',
        'myfatoorah',
        'now_payments',
        'stripe',
        'razorpay',
    ];

    public function gatewayKeys()
    {
        return response()->json([
            'stripe_key' => $this->gatewayCredentials('stripe'),
            'stripe_secret_key' => $this->gatewaySecretKey('stripe'),
            'razorpay_key' => $this->gatewayCredentials('razorpay'),
            'razorpay_secret_key' => $this->gatewaySecretKey('razorpay'),
        ]);
    }

    /**
     * POST /api/vendor/buy-plan/checkout/{package_id}
     *
     * Processes a membership checkout for the authenticated vendor.
     * - Free plan   → creates membership (status 1)
     * - Offline GW  → creates pending membership (status 0), optional receipt upload
     * - Online GW   → returns gateway keyword for client-side payment handling
     */
    public function checkout(Request $request, $package_id)
    {
        $vendor    = $request->user();
        $vendor_id = $vendor->id;

        $abs = Basic::first();
        Config::set('app.timezone', $abs->timezone);

        $package = Package::find($package_id);
        if (!$package) {
            return response()->json(['error' => __('Package not found')], 404);
        }

        // ── Validation ──
        $price = (float) $request->input('price', 0);
        $rules = [
            'price'          => 'required|numeric|min:0',
            'start_date'     => 'required|date',
            'expire_date'    => 'required',
            'payment_method' => $price != 0 ? 'required|string' : 'nullable|string',
        ];

        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // ── Guard: pending membership ──
        if (VendorPermissionHelper::hasPendingMembership($vendor_id)) {
            return response()->json([
                'error' => __('You already have a Pending Membership Request') . '!',
            ], 422);
        }

        // ── Guard: max 2 queued packages ──
        $packageCount = Membership::query()
            ->where('vendor_id', $vendor_id)
            ->where('expire_date', '>=', Carbon::now()->toDateString())
            ->whereYear('start_date', '<>', '9999')
            ->where('status', '<>', 2)
            ->count();

        if ($packageCount >= 2) {
            return response()->json([
                'error' => __('You have another package to activate after the current package expires. You cannot purchase / extend any package, until the next package is activated') . '!',
            ], 422);
        }

        $payment_method   = $request->input('payment_method', '-');
        $offline_gateways = OfflineGateway::where('status', 1)->pluck('name')->toArray();

        // ── Free plan ──
        if ($price == 0) {
            $transaction_id = VendorPermissionHelper::uniqidReal(8);
            $membership = $this->storeMembership(
                $request, $vendor_id, $package, $abs,
                $transaction_id, 'Free', 1, null
            );
            $this->notifyMembershipStatus($vendor, $membership, $package, 'vendor_package_activated', 'Package activated', 'Your package "' . $package->title . '" has been activated successfully.');
            return response()->json([
                'message'    => __('Membership purchased successfully!'),
                'membership' => $membership,
            ], 200);
        }

        // ── Offline gateway ──
        if (in_array($payment_method, $offline_gateways)) {
            $receipt_name = null;
            $gateway = OfflineGateway::where('name', $payment_method)->first();

            if ($gateway && $gateway->has_attachment == 1) {
                if (!$request->hasFile('receipt')) {
                    return response()->json(['error' => __('The receipt field is required.')], 422);
                }
                $filename  = time() . '.' . $request->file('receipt')->getClientOriginalExtension();
                $directory = public_path('assets/front/img/membership/receipt');
                @mkdir($directory, 0777, true);
                $request->file('receipt')->move($directory, $filename);
                $receipt_name = $filename;
            }

            $transaction_id = VendorPermissionHelper::uniqidReal(8);
            $membership = $this->storeMembership(
                $request, $vendor_id, $package, $abs,
                $transaction_id, 'offline', 0, $receipt_name
            );
            $this->notifyMembershipStatus($vendor, $membership, $package, 'vendor_package_request_submitted', 'Package request received', 'Your package purchase request for "' . $package->title . '" has been submitted.');
            return response()->json([
                'message'    => __('Membership request submitted! Waiting for admin approval.'),
                'membership' => $membership,
            ], 200);
        }

        // ── Online gateway — return keyword for client-side handling ──
        $onlineGateway = OnlineGateway::where('name', $payment_method)
            ->where('mobile_status', 1)
            ->whereIn('keyword', self::SUPPORTED_MOBILE_GATEWAYS)
            ->first();

        if ($onlineGateway) {
            return response()->json([
                'payment_required' => true,
                'gateway'          => $onlineGateway->keyword,
                'gateway_name'     => $onlineGateway->name,
                'amount'           => $price,
            ], 200);
        }

        return response()->json(['error' => __('Invalid payment method.')], 422);
    }

    /**
     * POST /api/vendor/buy-plan/checkout/{package_id}/payment-verifier
     *
     * Verifies the checkout amount and resolves gateway-ready amount/currency
     * using backend currency settings and conversion rules.
     */
    public function paymentVerifier(Request $request, $package_id)
    {
        $package = Package::find($package_id);
        if (!$package) {
            return response()->json(['error' => __('Package not found')], 404);
        }

        $validator = Validator::make($request->all(), [
            'amount'  => 'required|numeric|min:0.01',
            'gateway' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $sourceAmount = (float) $request->input('amount', 0);
        if (abs($sourceAmount - (float) $package->price) > 0.01) {
            return response()->json([
                'error' => __('Invalid payment amount for this package.'),
            ], 422);
        }

        $gatewayInput = strtolower(trim((string) $request->input('gateway')));
        if ($gatewayInput === 'myfatorah') {
            $gatewayInput = 'myfatoorah';
        }
        if ($gatewayInput === 'nowpayments') {
            $gatewayInput = 'now_payments';
        }

        $onlineGateway = OnlineGateway::query()
            ->where('mobile_status', 1)
            ->whereIn('keyword', self::SUPPORTED_MOBILE_GATEWAYS)
            ->where(function ($query) use ($gatewayInput) {
                $query->whereRaw('LOWER(keyword) = ?', [$gatewayInput])
                    ->orWhereRaw('LOWER(name) = ?', [$gatewayInput]);
            })
            ->first();

        if (!$onlineGateway) {
            return response()->json([
                'error' => __('Invalid or inactive online gateway.'),
            ], 422);
        }

        $currencyInfo = Basic::query()
            ->select('base_currency_text', 'base_currency_rate')
            ->first();

        $baseCurrency = strtoupper((string) ($currencyInfo->base_currency_text ?? 'USD'));
        $baseRate = (float) ($currencyInfo->base_currency_rate ?? 1);
        $gatewayKeyword = strtolower((string) $onlineGateway->keyword);

        $verifiedAmount = round($sourceAmount, 2);
        $verifiedCurrency = $baseCurrency;

        switch ($gatewayKeyword) {
            case 'paypal':
                if ($baseCurrency !== 'USD') {
                    if ($baseRate <= 0) {
                        return response()->json([
                            'error' => __('Invalid base currency conversion rate.'),
                        ], 422);
                    }
                    $verifiedAmount = round($sourceAmount / $baseRate, 2);
                }
                $verifiedCurrency = 'USD';
                break;

            case 'paystack':
                if ($baseCurrency !== 'NGN') {
                    return response()->json([
                        'error' => __('Invalid currency for paystack payment.'),
                    ], 422);
                }
                $verifiedAmount = round($sourceAmount, 2);
                $verifiedCurrency = 'NGN';
                break;

            case 'paytabs':
                $allowedCurrencies = ['AED', 'SAR', 'QAR', 'OMR', 'BHD', 'KWD', 'JOD', 'EGP', 'USD', 'EUR', 'GBP', 'MYR'];
                if (!in_array($baseCurrency, $allowedCurrencies, true)) {
                    return response()->json([
                        'error' => __('Invalid currency for paytabs payment.'),
                    ], 422);
                }
                $verifiedAmount = round($sourceAmount, 2);
                break;

            case 'flutterwave':
                $allowedCurrencies = ['BIF', 'CAD', 'CDF', 'CVE', 'EUR', 'GBP', 'GHS', 'GMD', 'GNF', 'KES', 'LRD', 'MWK', 'MZN', 'NGN', 'RWF', 'SLL', 'STD', 'TZS', 'UGX', 'USD', 'XAF', 'XOF', 'ZMK', 'ZMW', 'ZWD'];
                if (!in_array($baseCurrency, $allowedCurrencies, true)) {
                    return response()->json([
                        'error' => __('Invalid currency for flutterwave payment.'),
                    ], 422);
                }
                $verifiedAmount = (float) intval($sourceAmount);
                break;

            case 'razorpay':
                if ($baseCurrency !== 'INR') {
                    return response()->json([
                        'error' => __('Invalid currency for razorpay payment.'),
                    ], 422);
                }
                $verifiedAmount = round($sourceAmount, 2);
                $verifiedCurrency = 'INR';
                break;

            case 'mercadopago':
                $allowedCurrencies = ['ARS', 'BOB', 'BRL', 'CLF', 'CLP', 'COP', 'CRC', 'CUC', 'CUP', 'DOP', 'EUR', 'GTQ', 'HNL', 'MXN', 'NIO', 'PAB', 'PEN', 'PYG', 'USD', 'UYU', 'VEF', 'VES'];
                if (!in_array($baseCurrency, $allowedCurrencies, true)) {
                    return response()->json([
                        'error' => __('Invalid currency for mercadopago payment.'),
                    ], 422);
                }
                $verifiedAmount = (float) intval($sourceAmount);
                break;

            case 'phonepe':
                if ($baseCurrency !== 'INR') {
                    return response()->json([
                        'error' => __('Invalid currency for phonepe payment.'),
                    ], 422);
                }
                $verifiedAmount = round($sourceAmount, 2);
                $verifiedCurrency = 'INR';
                break;

            case 'mollie':
                $allowedCurrencies = ['AED', 'AUD', 'BGN', 'BRL', 'CAD', 'CHF', 'CZK', 'DKK', 'EUR', 'GBP', 'HKD', 'HRK', 'HUF', 'ILS', 'ISK', 'JPY', 'MXN', 'MYR', 'NOK', 'NZD', 'PHP', 'PLN', 'RON', 'RUB', 'SEK', 'SGD', 'THB', 'TWD', 'USD', 'ZAR'];
                if (!in_array($baseCurrency, $allowedCurrencies, true)) {
                    return response()->json([
                        'error' => __('Invalid currency for mollie payment.'),
                    ], 422);
                }
                $verifiedAmount = (float) sprintf('%0.2f', $sourceAmount);
                break;

            case 'stripe':
                if ($baseCurrency !== 'USD') {
                    if ($baseRate <= 0) {
                        return response()->json([
                            'error' => __('Invalid base currency conversion rate.'),
                        ], 422);
                    }
                    $verifiedAmount = round(($sourceAmount / $baseRate), 2);
                }
                $verifiedCurrency = 'USD';
                break;

            case 'authorize.net':
                $allowedCurrencies = ['USD', 'CAD', 'CHF', 'DKK', 'EUR', 'GBP', 'NOK', 'PLN', 'SEK', 'AUD', 'NZD'];
                if (!in_array($baseCurrency, $allowedCurrencies, true)) {
                    return response()->json([
                        'error' => __('Invalid currency for authorize.net payment.'),
                    ], 422);
                }
                $verifiedAmount = (float) sprintf('%0.2f', $sourceAmount);
                break;

            case 'myfatoorah':
                $allowedCurrencies = ['KWD', 'SAR', 'BHD', 'AED', 'QAR', 'OMR', 'JOD'];
                if (!in_array($baseCurrency, $allowedCurrencies, true)) {
                    return response()->json([
                        'error' => __('Invalid currency for myfatoorah payment.'),
                    ], 422);
                }
                $verifiedAmount = (float) intval($sourceAmount);
                break;

            case 'midtrans':
                $allowedCurrencies = ['IDR'];
                if (!in_array($baseCurrency, $allowedCurrencies, true)) {
                    return response()->json([
                        'error' => __('Invalid currency for midtrans payment.'),
                    ], 422);
                }
                $verifiedAmount = (float) round($sourceAmount);
                $verifiedCurrency = 'IDR';
                break;

            case 'toyyibpay':
                $allowedCurrencies = ['RM', 'MYR'];
                if (!in_array($baseCurrency, $allowedCurrencies, true)) {
                    return response()->json([
                        'error' => __('Invalid currency for toyyibpay payment.'),
                    ], 422);
                }
                $verifiedAmount = round($sourceAmount, 2);
                $verifiedCurrency = $baseCurrency === 'RM' ? 'MYR' : $baseCurrency;
                break;

            case 'xendit':
                $allowedCurrencies = ['IDR', 'PHP', 'USD', 'SGD', 'MYR'];
                if (!in_array($baseCurrency, $allowedCurrencies, true)) {
                    return response()->json([
                        'error' => __('Invalid currency for xendit payment.'),
                    ], 422);
                }
                $verifiedAmount = round($sourceAmount, 2);
                break;

            case 'monnify':
                $allowedCurrencies = ['NGN'];
                if (!in_array($baseCurrency, $allowedCurrencies, true)) {
                    return response()->json([
                        'error' => __('Invalid currency for monnify payment.'),
                    ], 422);
                }
                $verifiedAmount = round($sourceAmount, 2);
                $verifiedCurrency = 'NGN';
                break;

            case 'now_payments':
                $allowedCurrencies = ['USD', 'EUR', 'GBP', 'USDT', 'BTC', 'ETH'];
                if (!in_array($baseCurrency, $allowedCurrencies, true)) {
                    return response()->json([
                        'error' => __('Invalid currency for now_payments payment.'),
                    ], 422);
                }
                $verifiedAmount = round($sourceAmount, 2);
                break;

            case 'iyzico':
                $allowedCurrencies = ['TRY'];
                if (!in_array($baseCurrency, $allowedCurrencies, true)) {
                    return response()->json([
                        'error' => __('Invalid currency for iyzico payment.'),
                    ], 422);
                }
                $verifiedAmount = round($sourceAmount, 2);
                $verifiedCurrency = 'TRY';
                break;

            case 'yoco':
                $allowedCurrencies = ['ZAR'];
                if (!in_array($baseCurrency, $allowedCurrencies, true)) {
                    return response()->json([
                        'error' => __('Invalid currency for yoco payment.'),
                    ], 422);
                }
                $verifiedAmount = round($sourceAmount, 2);
                $verifiedCurrency = 'ZAR';
                break;

            default:
                $verifiedAmount = (float) intval($sourceAmount);
                break;
        }

        $verifiedAmountMinor = (int) round($verifiedAmount * 100);
        if ($verifiedAmountMinor <= 0) {
            return response()->json([
                'error' => __('Invalid verified amount for checkout.'),
            ], 422);
        }

        return response()->json([
            'success' => true,
            'data'    => [
                'gateway'               => $gatewayKeyword,
                'gateway_name'          => $onlineGateway->name,
                'source_amount'         => round($sourceAmount, 2),
                'source_currency'       => $baseCurrency,
                'verified_amount'       => $verifiedAmount,
                'verified_currency'     => $verifiedCurrency,
                'verified_amount_minor' => $verifiedAmountMinor,
            ],
        ], 200);
    }

    /**
     * POST /api/vendor/buy-plan/checkout/{package_id}/complete-online
     *
     * Finalizes an online gateway membership purchase after payment is
     * confirmed by mobile PGW scripts (PayPal first).
     */
    public function completeOnlineCheckout(Request $request, $package_id)
    {
        $vendor    = $request->user();
        $vendor_id = $vendor->id;

        $abs = Basic::first();
        Config::set('app.timezone', $abs->timezone);

        $package = Package::find($package_id);
        if (!$package) {
            return response()->json(['error' => __('Package not found')], 404);
        }

        $validator = Validator::make($request->all(), [
            'price'               => 'required|numeric|min:0',
            'start_date'          => 'required|date',
            'expire_date'         => 'required',
            'payment_method'      => 'required|string',
            'transaction_id'      => 'required|string|max:191',
            'transaction_details' => 'nullable',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        if (VendorPermissionHelper::hasPendingMembership($vendor_id)) {
            return response()->json([
                'error' => __('You already have a Pending Membership Request') . '!',
            ], 422);
        }

        $packageCount = Membership::query()
            ->where('vendor_id', $vendor_id)
            ->where('expire_date', '>=', Carbon::now()->toDateString())
            ->whereYear('start_date', '<>', '9999')
            ->where('status', '<>', 2)
            ->count();

        if ($packageCount >= 2) {
            return response()->json([
                'error' => __('You have another package to activate after the current package expires. You cannot purchase / extend any package, until the next package is activated') . '!',
            ], 422);
        }

        $onlineGateway = OnlineGateway::query()
            ->where('name', $request->input('payment_method'))
            ->where('mobile_status', 1)
            ->whereIn('keyword', self::SUPPORTED_MOBILE_GATEWAYS)
            ->first();

        if (!$onlineGateway) {
            return response()->json(['error' => __('Invalid payment method.')], 422);
        }

        $price = (float) $request->input('price', 0);
        if (abs($price - (float) $package->price) > 0.01) {
            return response()->json([
                'error' => __('Invalid payment amount for this package.'),
            ], 422);
        }

        $transactionId = (string) $request->input('transaction_id');
        $alreadyExists = Membership::query()
            ->where('vendor_id', $vendor_id)
            ->where('transaction_id', $transactionId)
            ->exists();

        if ($alreadyExists) {
            return response()->json([
                'error' => __('This transaction has already been processed.'),
            ], 422);
        }

        $details = $request->input('transaction_details');
        if (is_string($details) && $details !== '') {
            $decoded = json_decode($details, true);
            if (json_last_error() === JSON_ERROR_NONE) {
                $details = $decoded;
            }
        }

        if (!is_array($details)) {
            $details = [];
        }

        $details['gateway'] = $onlineGateway->keyword;
        $details['payment_state'] = 'completed';

        $membership = $this->storeMembership(
            $request,
            $vendor_id,
            $package,
            $abs,
            $transactionId,
            $details,
            1,
            null
        );
        $this->notifyMembershipStatus($vendor, $membership, $package, 'vendor_package_activated', 'Package activated', 'Your package "' . $package->title . '" has been activated successfully.');

        return response()->json([
            'message'    => __('Membership purchased successfully!'),
            'membership' => $membership,
        ], 200);
    }

    /**
     * Creates a Membership record.
     * Also handles expiring a lifetime/trial membership when a new one is purchased.
     */
    private function storeMembership(
        Request $request,
        int $vendor_id,
        Package $package,
        $abs,
        string $transaction_id,
        $transaction_details,
        int $status,
        ?string $receipt_name
    ): Membership {
        // Expire lifetime or trial membership immediately when a paid plan replaces it
        $previousMembership = Membership::query()
            ->select('id', 'package_id', 'is_trial')
            ->where('vendor_id', $vendor_id)
            ->where('start_date', '<=', Carbon::now()->toDateString())
            ->where('expire_date', '>=', Carbon::now()->toDateString())
            ->where('status', 1)
            ->orderBy('created_at', 'DESC')
            ->first();

        if ($previousMembership) {
            $previousPackage = Package::select('term')
                ->where('id', $previousMembership->package_id)
                ->first();

            $isOfflineTransaction = is_string($transaction_details)
                ? strtolower($transaction_details) === 'offline'
                : false;

            if (
                ($previousPackage->term === 'lifetime' || $previousMembership->is_trial == 1)
                && !$isOfflineTransaction
            ) {
                Membership::where('id', $previousMembership->id)
                    ->update(['expire_date' => Carbon::parse($request->input('start_date'))]);
            }
        }

        return Membership::create([
            'price'               => $request->input('price', 0),
            'currency'            => $abs->base_currency_text,
            'currency_symbol'     => $abs->base_currency_symbol,
            'payment_method'      => $request->input('payment_method', '-'),
            'transaction_id'      => $transaction_id,
            'status'              => $status,
            'receipt'             => $receipt_name,
            'transaction_details' => json_encode($transaction_details),
            'settings'            => json_encode($abs),
            'package_id'          => $package->id,
            'vendor_id'           => $vendor_id,
            'start_date'          => Carbon::parse($request->input('start_date')),
            'expire_date'         => Carbon::parse($request->input('expire_date')),
            'is_trial'            => 0,
            'trial_days'          => 0,
            'ai_engine'           => $package->ai_engine ?? null,
            'ai_token_limit'      => $package->ai_token_limit ?? 0,
            'ai_image_limit'      => $package->ai_image_limit ?? 0,
        ]);
    }

    private function notifyMembershipStatus($vendor, Membership $membership, Package $package, string $type, string $title, string $message): void
    {
        VendorNotificationService::send(
            $vendor,
            $type,
            $title,
            $message,
            [
                'package_id' => $package->id,
                'membership_id' => $membership->id,
            ]
        );
    }

    private function gatewayCredentials(string $keyword): ?string
    {
        $gateway = OnlineGateway::query()
            ->where('mobile_status', 1)
            ->where('keyword', $keyword)
            ->select('mobile_information')
            ->first();

        if (!$gateway) {
            return null;
        }

        $information = json_decode($gateway->mobile_information, true) ?? [];

        return $information['key'] ?? null;
    }

        private function gatewaySecretKey(string $keyword): ?string
    {
        $gateway = OnlineGateway::query()
            ->where('mobile_status', 1)
            ->where('keyword', $keyword)
            ->select('mobile_information')
            ->first();

        if (!$gateway) {
            return null;
        }

        $information = json_decode($gateway->mobile_information, true) ?? [];

        return $information['secret'] ?? null;
    }
}
