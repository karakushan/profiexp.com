<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\ApiHelper\HelperController;
use App\Http\Controllers\Controller;
use App\Models\BasicSettings\Basic;
use App\Models\Language;
use App\Models\Listing\ListingContent;
use App\Models\ListingCategory;
use App\Models\MobileInterfaceSetting;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\PaymentGateway\OnlineGateway;
use App\Models\Shop\ShippingCharge;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;

class HomeController extends Controller
{
    public function index(Request $request)
    {
        $language = HelperController::getLanguage($request);
        $information['categories'] = ListingCategory::withCount('listing_contents')
            ->has('listing_contents')
            ->where([
                ['language_id', $language->id],
                ['status', 1]
            ])
            ->orderBy('listing_contents_count', 'desc')
            ->take(10)
            ->get()
            ->map(function ($category) {
                $imagePath = $category->mobile_image
                    ? public_path('assets/img/listing/category/' . $category->mobile_image)
                    : null;

                $category->mobile_image = ($category->mobile_image && file_exists($imagePath))
                    ? asset('assets/img/listing/category/' . $category->mobile_image)
                    : asset('assets/img/noimage.jpg');

                return $category;
            });

        $information['listing_contents'] = ListingContent::join('listings', 'listings.id', '=', 'listing_contents.listing_id')
            ->Join('feature_orders', 'listings.id', '=', 'feature_orders.listing_id')
            ->join('listing_categories', 'listing_categories.id', '=', 'listing_contents.category_id')
            ->where('listing_contents.language_id', $language->id)
            ->where('feature_orders.order_status', '=', 'completed')
            ->where([
                ['listings.status', '=', '1'],
                ['listings.visibility', '=', '1']
            ])
            ->when('listings.vendor_id' != "0", function ($query) {
                return $query->leftJoin('memberships', 'listings.vendor_id', '=', 'memberships.vendor_id')
                    ->where(function ($query) {
                        $query->where([
                            ['memberships.status', '=', 1],
                            ['memberships.start_date', '<=', now()->format('Y-m-d')],
                            ['memberships.expire_date', '>=', now()->format('Y-m-d')],
                        ])->orWhere('listings.vendor_id', '=', 0);
                    });
            })
            ->when('listings.vendor_id' != "0", function ($query) {
                return $query->leftJoin('vendors', 'listings.vendor_id', '=', 'vendors.id')
                    ->where(function ($query) {
                        $query->where([
                            ['vendors.status', '=', 1],
                        ])->orWhere('listings.vendor_id', '=', 0);
                    });
            })
            ->whereDate('feature_orders.end_date', '>=', Carbon::now()->format('Y-m-d'))
            ->select(
                'listings.*',
                'listing_contents.title',
                'listing_contents.slug',
                'listing_contents.category_id',
                'listing_contents.city_id',
                'listing_contents.state_id',
                'listing_contents.country_id',
                'listing_contents.description',
                'listing_contents.address',
                'listing_categories.name as category_name',
                'listing_categories.icon as icon',
                'listing_categories.slug as category_slug',
                'feature_orders.listing_id as feature_order_listing_id',
            )

            ->inRandomOrder()
            ->limit(10)
            ->get()
            ->map(function ($list) use ($language) {
                return HelperController::formatListForApi($list, $language->id);
            });

        $information['seoInfo'] = $language->seoInfo()->select('meta_keyword_home', 'meta_description_home')->first();
        $information['section_titles'] = MobileInterfaceSetting::where('language_id', $language->id)
            ->select('category_listing_section_title', 'featured_listing_section_title')->first();

        $banner = MobileInterfaceSetting::where('language_id', $language->id)
            ->select('banner_background_image', 'banner_image', 'banner_title', 'banner_button_text', 'banner_button_url')->first();
        if (!empty($banner->banner_background_image)) {
            $banner->banner_background_image = asset('assets/img/mobile-interface/' . $banner->banner_background_image);
        }
        if (!empty($banner->banner_image)) {
            $banner->banner_image = asset('assets/img/mobile-interface/' . $banner->banner_image);
        }
        $information['banner_section'] = $banner;

        return response()->json([
            'success' => true,
            'data' => $information
        ]);
    }

    /* *****************************
     * basic data
    * *****************************/
    public function getBasic(Request $request)
    {

        $basicData = DB::table('basic_settings')
            ->select('app_logo', 'app_fav', 'base_currency_text', 'base_currency_rate', 'base_currency_symbol', 'base_currency_symbol_position', 'equipment_tax_amount as equipment_tax', 'product_tax_amount as product_tax',  'app_primary_color', 'app_breadcrumb_overlay_opacity', 'app_breadcrumb_color', 'app_google_map_status', 'radius as google_map_radius', 'google_map_api_key')
            ->first();

        $basicData->app_logo = asset('assets/img/mobile-interface/' . $basicData->app_logo);
        $basicData->app_fav = asset('assets/img/mobile-interface/' . $basicData->app_fav);

        $data['basic_data'] = $basicData;
        $data['languages'] = Language::all();


        return response()->json([
            'success' => true,
            'data' => $data
        ]);
    }
    public function getPayment(Request $request)
    {
        $basicData = DB::table('basic_settings')
            ->select('base_currency_text', 'base_currency_rate', 'base_currency_symbol', 'base_currency_symbol_position', 'equipment_tax_amount as equipment_tax', 'product_tax_amount as product_tax')
            ->first();
        $data['basic_data'] = $basicData;

        $data['online_gateways'] = DB::table('online_gateways')
            ->where('mobile_status', 1)
            ->whereIn('keyword', [
                'phonepe',
                'mercadopago',
                'myfatoorah',
                'midtrans',
                'authorize.net',
                'toyyibpay',
                'xendit',
                'mollie',
                'paystack',
                'flutterwave',
                'stripe',
                'paypal',
                'razorpay',
                'monnify',
                'now_payments',
                'yoco',
                'iyzico',
                'instamojo',
                'paytabs',
                'perfect_money',
                'paytm'
            ])
            ->select('id', 'name', 'keyword')
            ->get();

        $data['offline_gateways'] = DB::table('offline_gateways')
            ->where('status', 1)
            ->orderBy('serial_number', 'asc')
            ->select('id', 'name', 'short_description', 'instructions', 'has_attachment')
            ->get();
        $language = HelperController::getLanguage($request);

        $data['shipping_methods'] = ShippingCharge::query()
            ->where('language_id', $language->id)
            ->orderBy('serial_number', 'desc')
            ->get();

        $stripe = OnlineGateway::where('keyword', 'stripe')->first();
        $stripeInfo = $stripe ? json_decode($stripe->mobile_information, true) : null;
        $data['stripe_public_key'] = $stripeInfo['key'] ?? null;
        $data['stripe_secret_key'] = $stripeInfo['secret'] ?? null;

        $razorpay = OnlineGateway::where('keyword', 'razorpay')->first();
        $data['razorpayInfo'] = $razorpay ? json_decode($razorpay->mobile_information, true) : null;

        $razorpay = OnlineGateway::where('keyword', 'paytabs')->first();
        $data['paytabsInfo'] = $razorpay ? json_decode($razorpay->mobile_information, true) : null;

        return response()->json([
            'success' => true,
            'data' => $data
        ]);
    }
    public function getCategories(Request $request)
    {
        $language = HelperController::getLanguage($request);

        if ($request->filled('name')) {
            $name = $request->name;
        } else {
            $name = null;
        }

        $categories = ListingCategory::where('language_id', $language->id)
            ->where('status', 1)
            ->when($name, function ($query) use ($name) {
                return $query->where('name', 'like', '%' . $name . '%');
            })
            ->orderBy('serial_number', 'asc')
            ->paginate(10);

        // Transform only the items, not the whole paginator
        $categories->getCollection()->transform(function ($category) {
            $category->mobile_image = $category->mobile_image
                ? asset('assets/img/listing/category/' . $category->mobile_image)
                : asset('assets/img/noimage.jpg');
            return $category;
        });

        return response()->json([
            'success' => true,
            'data'    => [
                'categories' => $categories
            ]
        ]);
    }

    public function verfiyPayment(Request $request)
    {
        $rules = [
            'amount' => 'required',
            'gateway' => 'required',
        ];

        $validator = Validator::make(request()->all(), $rules);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $amount = $request['amount'];
        $gateway = $request['gateway'];

        //convert payment amount
        $currencyInfo  = Basic::select(
            'base_currency_symbol',
            'base_currency_symbol_position',
            'base_currency_text',
            'base_currency_text_position',
            'base_currency_rate'
        )
            ->firstOrFail();
        $gateway = strtolower($gateway);

        switch ($gateway) {
            case 'paypal':
                if ($currencyInfo->base_currency_text !== 'USD') {
                    $rate = floatval($currencyInfo->base_currency_rate);
                    $convertedTotal = $amount / $rate;
                }
                $paidAmount = $currencyInfo->base_currency_text === 'USD' ? $amount : $convertedTotal;
                break;
            case 'paystack':
                if ($currencyInfo->base_currency_text !== 'NGN') {
                    return response()->json(['status' => 'error', 'message' => 'Invalid currency for paystack payment.'], 422);
                }
                $paidAmount = $amount;
                break;
            case 'flutterwave':
                $allowedCurrencies = array('BIF', 'CAD', 'CDF', 'CVE', 'EUR', 'GBP', 'GHS', 'GMD', 'GNF', 'KES', 'LRD', 'MWK', 'MZN', 'NGN', 'RWF', 'SLL', 'STD', 'TZS', 'UGX', 'USD', 'XAF', 'XOF', 'ZMK', 'ZMW', 'ZWD');
                if (!in_array($currencyInfo->base_currency_text, $allowedCurrencies)) {
                    return response()->json(['status' => 'error', 'message' => 'Invalid currency for flutterwave payment.'], 422);
                }
                $paidAmount = intval($amount);
                break;
            case 'razorpay':
                if ($currencyInfo->base_currency_text !== 'INR') {
                    return response()->json(['status' => 'error', 'message' => 'Invalid currency for razorpay payment.'], 422);
                }
                $paidAmount = $amount;
                break;
            case 'mercadopago':
                $allowedCurrencies = array('ARS', 'BOB', 'BRL', 'CLF', 'CLP', 'COP', 'CRC', 'CUC', 'CUP', 'DOP', 'EUR', 'GTQ', 'HNL', 'MXN', 'NIO', 'PAB', 'PEN', 'PYG', 'USD', 'UYU', 'VEF', 'VES');
                if (!in_array($currencyInfo->base_currency_text, $allowedCurrencies)) {
                    return response()->json(['status' => 'error', 'message' => 'Invalid currency for mercadopago payment.'], 422);
                }
                $paidAmount = intval($amount);
                break;
            case 'mollie':
                $allowedCurrencies = array('AED', 'AUD', 'BGN', 'BRL', 'CAD', 'CHF', 'CZK', 'DKK', 'EUR', 'GBP', 'HKD', 'HRK', 'HUF', 'ILS', 'ISK', 'JPY', 'MXN', 'MYR', 'NOK', 'NZD', 'PHP', 'PLN', 'RON', 'RUB', 'SEK', 'SGD', 'THB', 'TWD', 'USD', 'ZAR');
                if (!in_array($currencyInfo->base_currency_text, $allowedCurrencies)) {
                    return response()->json(['status' => 'error', 'message' => 'Invalid currency for mollie payment.'], 422);
                }
                $paidAmount = sprintf('%0.2f', $amount);
                break;
            case 'stripe':
                if ($currencyInfo->base_currency_text !== 'USD') {
                    $rate = floatval($currencyInfo->base_currency_rate);
                    $convertedTotal = round(($amount / $rate), 2);
                }

                $paidAmount = $currencyInfo->base_currency_text === 'USD' ? $amount : $convertedTotal;
                break;
            case 'authorize.net':
                $allowedCurrencies = array('USD', 'CAD', 'CHF', 'DKK', 'EUR', 'GBP', 'NOK', 'PLN', 'SEK', 'AUD', 'NZD');
                if (!in_array($currencyInfo->base_currency_text, $allowedCurrencies)) {
                    return response()->json(['status' => 'error', 'message' => 'Invalid currency for authorize.net payment.'], 422);
                }
                $paidAmount = sprintf('%0.2f', $amount);
                break;
            case 'phonepe':
                $allowedCurrencies = array('INR');
                if (!in_array($currencyInfo->base_currency_text, $allowedCurrencies)) {
                    return response()->json(['status' => 'error', 'message' => 'Invalid currency for phonepe payment.'], 422);
                }
                $paidAmount = $amount;
                break;
            case 'myfatoorah':
                $allowedCurrencies = array('KWD', 'SAR', 'BHD', 'AED', 'QAR', 'OMR', 'JOD');
                if (!in_array($currencyInfo->base_currency_text, $allowedCurrencies)) {
                    return response()->json(['status' => 'error', 'message' => 'Invalid currency for myfatoorah payment.'], 422);
                }
                $paidAmount = intval($amount);
                break;
            case 'midtrans':
                $allowedCurrencies =  array('IDR');
                if (!in_array($currencyInfo->base_currency_text, $allowedCurrencies)) {
                    return response()->json(['status' => 'error', 'message' => 'Invalid currency for midtrans payment.'], 422);
                }
                $paidAmount = (int)round($amount);
                break;
            case 'toyyibpay':
                $allowedCurrencies =  array('RM');
                if (!in_array($currencyInfo->base_currency_text, $allowedCurrencies)) {
                    return response()->json(['status' => 'error', 'message' => 'Invalid currency for toyyibpay payment.'], 422);
                }
                $paidAmount = $amount;
                break;
            case 'xendit':
                $allowedCurrencies =  array('IDR', 'PHP', 'USD', 'SGD', 'MYR');
                if (!in_array($currencyInfo->base_currency_text, $allowedCurrencies)) {
                    return response()->json(['status' => 'error', 'message' => 'Invalid currency for xendit payment.'], 422);
                }
                $paidAmount = $amount;
                break;
            case 'monnify':
                $allowedCurrencies =  array('NGN');
                if (!in_array($currencyInfo->base_currency_text, $allowedCurrencies)) {
                    return response()->json(['status' => 'error', 'message' => 'Invalid currency for monnify payment.'], 422);
                }
                $paidAmount = $amount;
                break;
            case 'now_payments':
                $allowedCurrencies =  array('USD', 'EUR', 'GBP', 'USDT', 'BTC', 'ETH');
                if (!in_array($currencyInfo->base_currency_text, $allowedCurrencies)) {
                    return response()->json(['status' => 'error', 'message' => 'Invalid currency for now_payments payment.'], 422);
                }
                $paidAmount = $amount;
                break;
            case 'iyzico':
                $allowedCurrencies =  array('TRY');
                if (!in_array($currencyInfo->base_currency_text, $allowedCurrencies)) {
                    return response()->json(['status' => 'error', 'message' => 'Invalid currency for iyzico payment.'], 422);
                }
                $paidAmount = $amount;
                break;
            case 'yoco':
                $allowedCurrencies =  array('ZAR');
                if (!in_array($currencyInfo->base_currency_text, $allowedCurrencies)) {
                    return response()->json(['status' => 'error', 'message' => 'Invalid currency for yoco payment.'], 422);
                }
                $paidAmount = $amount;
                break;
            default:
                $paidAmount = intval($amount);
                break;
        }

        return ['verified_amount' => $paidAmount];
    }
}
