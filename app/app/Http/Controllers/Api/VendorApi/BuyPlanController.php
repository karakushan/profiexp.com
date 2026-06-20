<?php

namespace App\Http\Controllers\Api\VendorApi;

use App\Http\Controllers\Controller;
use App\Http\Helpers\VendorPermissionHelper;
use App\Models\BasicSettings\Basic;
use App\Models\Membership;
use App\Models\Package;
use App\Models\PaymentGateway\OfflineGateway;
use App\Models\PaymentGateway\OnlineGateway;
use Carbon\Carbon;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;

class BuyPlanController extends Controller
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
    ];

    // GET /api/vendor/buy-plan
    public function index(Request $request)
    {
        $vendor_id = $request->user()->id;

        $abs = Basic::first();
        Config::set('app.timezone', $abs->timezone);

        $packages = Package::where('status', '1')->get();

        $nextPackageCount = Membership::query()->where([
            ['vendor_id', $vendor_id],
            ['expire_date', '>=', Carbon::now()->toDateString()]
        ])->whereYear('start_date', '<>', '9999')->where('status', '<>', 2)->count();

        $current_membership = Membership::query()->where([
            ['vendor_id', $vendor_id],
            ['start_date', '<=', Carbon::now()->toDateString()],
            ['expire_date', '>=', Carbon::now()->toDateString()]
        ])->where('status', 1)->whereYear('start_date', '<>', '9999')->first();

        $next_membership = null;
        if ($current_membership) {
            $countCurrMem = Membership::query()->where([
                ['vendor_id', $vendor_id],
                ['start_date', '<=', Carbon::now()->toDateString()],
                ['expire_date', '>=', Carbon::now()->toDateString()]
            ])->where('status', 1)->whereYear('start_date', '<>', '9999')->count();

            if ($countCurrMem > 1) {
                $next_membership = Membership::query()->where([
                    ['vendor_id', $vendor_id],
                    ['start_date', '<=', Carbon::now()->toDateString()],
                    ['expire_date', '>=', Carbon::now()->toDateString()]
                ])->where('status', '<>', 2)->whereYear('start_date', '<>', '9999')->orderBy('id', 'DESC')->first();
            } else {
                $next_membership = Membership::query()->where([
                    ['vendor_id', $vendor_id],
                    ['start_date', '>', $current_membership->expire_date]
                ])->whereYear('start_date', '<>', '9999')->where('status', '<>', 2)->first();
            }
        }

        return response()->json([
            'packages'           => $packages,
            'current_membership' => $current_membership,
            'current_package'    => $current_membership ? Package::find($current_membership->package_id) : null,
            'next_membership'    => $next_membership,
            'next_package'       => $next_membership ? Package::find($next_membership->package_id) : null,
            'package_count'      => $nextPackageCount,
            'currency'           => [
                'base_currency_text'            => $abs->base_currency_text,
                'base_currency_rate'            => $abs->base_currency_rate,
                'base_currency_symbol'          => $abs->base_currency_symbol,
                'base_currency_symbol_position' => $abs->base_currency_symbol_position,
            ],
        ], 200);
    }

    // GET /api/vendor/buy-plan/checkout/{package_id}
    public function checkout(Request $request, $package_id)
    {
        $vendor_id = $request->user()->id;

        $abs = Basic::first();
        Config::set('app.timezone', $abs->timezone);

        $package = Package::find($package_id);
        if (!$package) {
            return response()->json(['error' => __('Package not found')], 404);
        }

        $packageCount = Membership::query()->where([
            ['vendor_id', $vendor_id],
            ['expire_date', '>=', Carbon::now()->toDateString()]
        ])->whereYear('start_date', '<>', '9999')->where('status', '<>', 2)->count();

        $hasPendingMemb = VendorPermissionHelper::hasPendingMembership($vendor_id);

        if ($hasPendingMemb) {
            return response()->json(['error' => __('You already have a Pending Membership Request') . '!'], 422);
        }
        if ($packageCount >= 2) {
            return response()->json(['error' => __('You have another package to activate after the current package expires. You cannot purchase / extend any package, until the next package is activated') . '!'], 422);
        }

        $online  = OnlineGateway::where('mobile_status', 1)
            ->whereIn('keyword', self::SUPPORTED_MOBILE_GATEWAYS)
            ->get();
        $offline = OfflineGateway::where('status', 1)->orderBy('serial_number', 'asc')->get();

        $membership = Membership::query()->where([
            ['vendor_id', $vendor_id],
            ['expire_date', '>=', Carbon::now()->format('Y-m-d')]
        ])->where('status', '<>', 2)->whereYear('start_date', '<>', '9999')
            ->latest()
            ->first();

        $previousPackage = $membership ? Package::find($membership->package_id) : null;

        $stripe = OnlineGateway::where('keyword', 'stripe')->first();
        $stripeInfo = $stripe
            ? (json_decode($stripe->mobile_information, true) ?: json_decode($stripe->information, true))
            : null;
        $stripe_key  = $stripeInfo['key'] ?? null;

        $pgwBaseUrl = rtrim($request->root(), '/') . '/pgw';

        return response()->json([
            'package'          => $package,
            'online_gateways'  => $online,
            'offline_gateways' => $offline,
            'current_membership' => $membership,
            'previous_package' => $previousPackage,
            'stripe_key'       => $stripe_key,
            'currency'         => [
                'base_currency_text'            => $abs->base_currency_text,
                'base_currency_rate'            => $abs->base_currency_rate,
                'base_currency_symbol'          => $abs->base_currency_symbol,
                'base_currency_symbol_position' => $abs->base_currency_symbol_position,
            ],
            'pgw_base_url'     => $pgwBaseUrl,
        ], 200);
    }
}
