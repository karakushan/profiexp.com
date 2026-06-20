<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Helpers\BasicMailer;
use App\Models\BasicSettings\Basic;
use App\Models\BasicSettings\MailTemplate;
use App\Models\FcmToken;
use App\Models\Shop\Product;
use App\Models\Shop\ProductOrder;
use App\Models\Shop\ProductPurchaseItem;
use App\Models\Shop\ShippingCharge;
use App\Models\Vendor;
use App\Services\FirebaseService;
use App\Services\VendorNotificationService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use PDF;

class ProductPurchaseController extends Controller
{
  private const LOW_STOCK_THRESHOLD = 5;

  public function index(Request $request)
  {
    $rules = [
      'paymentMethod' => 'required',
      'paymentStatus' => 'required',
      'gatewayType' => 'required',

      'discount' => 'required',
      'checkbox' => 'required',

      'billing_name' => 'required',
      'billing_email' => 'required|email:rfc,dns',
      'billing_phone' => 'required',
      'billing_city' => 'required',
      'billing_country' => 'required',
      'billing_address' => 'required',
      'billing_address' => 'required',
      'cart' => 'required',

      'shipping_method' => 'required',

      'shipping_name' => 'required_if:checkbox,1',
      'shipping_phone' => 'required_if:checkbox,1',
      'shipping_email' => 'required_if:checkbox,1|email:rfc,dns',
      'shipping_city' => 'required_if:checkbox,1',
      'shipping_country' => 'required_if:checkbox,1',
      'shipping_address' => 'required_if:checkbox,1',
      'identity_number' => request()->input('gateway') == 'iyzico' ? 'required' : '',
      'zip_code' => request()->input('gateway') == 'iyzico' ? 'required' : ''
    ];
    $messages = [
      'billing_name.required' => 'The first name field is required.',
      'billing_email.required' => 'The email field is required.',
      'billing_phone.required' => 'The phone number field is required.',
      'billing_address.required' => 'The address field is required.',
      'billing_city.required' => 'The city field is required.',
      'billing_country.required' => 'The country field is required.',
      'shipping_name.required_if' => 'The first name field is required.',
      'shipping_email.required_if' => 'The email field is required.',
      'shipping_phone.required_if' => 'The phone number field is required.',
      'shipping_address.required_if' => 'The address field is required.',
      'shipping_city.required_if' => 'The city field is required.',
      'shipping_country.required_if' => 'The country field is required.'
    ];

    $validator = Validator::make($request->all(), $rules, $messages);
    if ($validator->fails()) {
      return response()->json([
        'success' => false,
        'errors' => $validator->errors()
      ], 422);
    }

    //offline gateway
    if ($request['gatewayType'] == 'offline' && $request->hasFile('attachment')) {
      $filename = time() . '.' . $request->file('attachment')->getClientOriginalExtension();
      $request->file('attachment')->move(public_path('assets/file/attachments/product/'), $filename);
    }
    $cart = $request->cart;
    $calculatedData = $this->calculation($request, $cart);
    $currencyInfo = $this->getCurrencyInfo();

    $order_data = [
      'billing_name' => $request['billing_name'],
      'billing_email' => $request['billing_email'],
      'billing_phone' => $request['billing_phone'],
      'billing_city' => $request['billing_city'],
      'billing_state' => $request['billing_state'] ?? "",
      'billing_country' => $request['billing_country'],
      'billing_address' => $request['billing_address'],

      'shipping_name' => $request->checkbox == 1 ? $request['shipping_name'] : $request['billing_name'],
      'shipping_email' => $request->checkbox == 1 ? $request['shipping_email'] : $request['billing_email'],
      'shipping_phone' => $request->checkbox == 1 ? $request['shipping_phone'] : $request['billing_phone'],
      'shipping_city' => $request->checkbox == 1 ? $request['shipping_city'] : $request['billing_city'],
      'shipping_state' => $request->checkbox == 1 ? $request['shipping_state'] : $request['billing_state'],
      'shipping_country' => $request->checkbox == 1 ? $request['shipping_country'] : $request['billing_country'],
      'shipping_address' => $request->checkbox == 1 ? $request['shipping_address'] : $request['billing_address'],

      'total' => $calculatedData['total'],
      'discount' => $calculatedData['discount'],
      'productShippingChargeId' => $request->exists('shipping_method') ? $request['shipping_method'] : null,
      'shippingCharge' => $calculatedData['shippingCharge'],
      'tax' => $calculatedData['tax'],
      'total_commission' => $calculatedData['totalCommissionAmount'],
      'grandTotal' => $calculatedData['grandTotal'],
      'currencyText' => $currencyInfo->base_currency_text,
      'currencyTextPosition' => $currencyInfo->base_currency_text_position,
      'currencySymbol' => $currencyInfo->base_currency_symbol,
      'currencySymbolPosition' => $currencyInfo->base_currency_symbol_position,
      'paymentMethod' => $request->paymentMethod,
      'gatewayType' => $request->gatewayType,
      'paymentStatus' =>  $request->paymentStatus,
      'orderStatus' => 'pending',
      'fcm_token' => $request->fcm_token,
      'admin_amount_with_commission' => $calculatedData['adminCommission'],
      'vendor_net_amounts' => $calculatedData['vendorAmounts'], // this is an array
      'per_vendor_discount_and_commission' => $calculatedData['vendorDetails'],
    ];

    $orderInfo = $this->storeData($cart, $order_data);
    $this->updateStockList($cart, $orderInfo);
    $invoice = $this->generateInvoice($orderInfo, $cart);
    $orderInfo->update(['invoice' => $invoice]);
    $this->prepareMail($orderInfo);
    $this->notifyVendorsForOrder($orderInfo);

    //send notification
    $app_firebase_json_file = DB::table('basic_settings')
      ->where('uniqid', 12345)
      ->value('app_firebase_json_file');

    if (!empty($orderInfo->fcm_token) && !is_null($app_firebase_json_file)) {
      $title = __('Product Purchase Complete');
      $subtitle = "Your current payment status " . $orderInfo->payment_status;
      FcmToken::create([
        'token' => $orderInfo->fcm_token,
        'user_id' => Auth::guard('sanctum')->check() == true ? Auth::guard('sanctum')->user()->id : null,
        'platform' => 'web',
        'message_title' => $title,
        'message_description' => $subtitle,
        'booking_id' => $orderInfo->id,
      ]);
      FirebaseService::send($orderInfo->fcm_token, $orderInfo->id, $title, $subtitle);
    }

    return response()->json([
      'success' => true,
      'order_number' => $orderInfo->order_number,
      'message' => __('Order Compelete Successfully')
    ], 200);
  }

  public function calculation(Request $request, $products)
  {
    $total = 0.00;
    $discountableSubtotal = 0.00;
    $physicalSubtotal = 0.00;
    $digitalSubtotal = 0.00;
    $adminCommission = 0.00;
    $totalCommission = 0.00;
    $vendorAmounts = [];
    $itemDetails = [];

    $vendorDiscounts = [];
    $vendorCommissions = [];
    $vendorOriginalSubtotals = [];
    $vendorDiscountedSubtotals = [];

    // 1. Calculate the initial totals and categorize items.
    foreach ($products as $key => $item) {
      $lineTotal = floatval($item['price']);
      $productType = $item['type'] ?? 'physical';
      $vendorId = $item['vendor_id'] ?? null;

      $total += $lineTotal;

      // Store the details for each item line for later calculation
      $itemDetails[$key] = [
        'vendor_id' => $vendorId,
        'product_type' => $productType,
        'original_total' => $lineTotal,
        'discounted_total' => 0.00,
      ];

      // Categorize the item for discount and shipping logic
      if ($productType === 'digital') {
        $digitalSubtotal += $lineTotal;
        $discountableSubtotal += $lineTotal;
      } else {
        $physicalSubtotal += $lineTotal;
        $discountableSubtotal += $lineTotal;
      }

      // Track per vendor original cart total
      if (!is_null($vendorId)) {
        $vendorOriginalSubtotals[$vendorId] = ($vendorOriginalSubtotals[$vendorId] ?? 0) + $lineTotal;
      }
    }

    // 2. Handle Discount
    $discount = 0.00;
    if ($request->discount > 0 && $discountableSubtotal > 0) {

      $discountVal = $request->discount;
      $discount = floatval($discountVal);

      // Distribute the discount proportionally across all discountable item lines
      foreach ($itemDetails as $key => &$detail) {
        $lineDiscountShare = ($detail['original_total'] / $discountableSubtotal) * $discount;
        $detail['discounted_total'] = $detail['original_total'] - $lineDiscountShare;

        // Track discount share per vendor (if vendor exists)
        $vendorId = $detail['vendor_id'];
        if (!is_null($vendorId)) {
          $vendorDiscounts[$vendorId] = ($vendorDiscounts[$vendorId] ?? 0) + $lineDiscountShare;
        }
      }
      unset($detail);
    } else {
      // If no discount, discounted total is the same as original
      foreach ($itemDetails as $key => &$detail) {
        $detail['discounted_total'] = $detail['original_total'];
      }
      unset($detail);
    }

    // Recalculate the new subtotals after discount
    $subtotal = array_sum(array_column($itemDetails, 'discounted_total'));
    $physicalDiscounted = 0;
    $digitalDiscounted = 0;

    foreach ($itemDetails as $detail) {
      if ($detail['product_type'] == 'digital') {
        $digitalDiscounted += $detail['discounted_total'];
      } else {
        $physicalDiscounted += $detail['discounted_total'];
      }
    }

    // 3. Handle Shipping only for physical products
    $shippingCharge = 0.00;

    if ($physicalSubtotal > 0 && $request->exists('shipping_method') && !is_null($request->input('shipping_method'))) {
      $shippingChargeModel = ShippingCharge::find($request->input('shipping_method'));
      if ($shippingChargeModel) {
        $shippingCharge = floatval($shippingChargeModel->shipping_charge);
      }
    }

    // 4. Handle Tax
    $taxData = Basic::select('product_tax_amount', 'commission_amount')->first();
    $taxRate = floatval($taxData->product_tax_amount ?? 0);
    $commissionRate = floatval($taxData->commission_amount ?? 0);

    $taxableAmount = $subtotal + $shippingCharge;
    $calculatedTax = round($taxableAmount * ($taxRate / 100));

    // 5. Calculate Grand Total
    $grandTotal = $subtotal + $shippingCharge + $calculatedTax;

    // 6. Calculate Commission and Vendor Payouts
    foreach ($itemDetails as $key => $detail) {
      $lineFinalPrice = $detail['discounted_total'];
      $vendorId = $detail['vendor_id'];

      // Track per vendor discounted subtotal (after discount)
      if (!is_null($vendorId)) {
        $vendorDiscountedSubtotals[$vendorId] = ($vendorDiscountedSubtotals[$vendorId] ?? 0) + $lineFinalPrice;
      }

      if (is_null($vendorId)) {
        $adminCommission += $lineFinalPrice;
      } else {
        $commission = $lineFinalPrice * ($commissionRate / 100);
        $vendorAmount = $lineFinalPrice - $commission;

        $adminCommission += $commission;
        $totalCommission += $commission;

        $vendorAmounts[$vendorId] = ($vendorAmounts[$vendorId] ?? 0) + $vendorAmount;
        $vendorCommissions[$vendorId] = ($vendorCommissions[$vendorId] ?? 0) + $commission;
      }
    }

    // Build detailed vendor breakdown
    $vendorDetails = [];
    foreach ($vendorAmounts as $vendorId => $payout) {
      $cartTotal = $vendorOriginalSubtotals[$vendorId] ?? 0.00;
      $discountedSubtotal = $vendorDiscountedSubtotals[$vendorId] ?? 0.00;
      $totalAfterSubtract = $discountedSubtotal - ($vendorCommissions[$vendorId] ?? 0.00);

      // Calculate tax share for this vendor
      $vendorTaxShare = 0.00;
      if ($subtotal > 0) {
        $vendorTaxShare = round(($discountedSubtotal / $subtotal) * $calculatedTax, 2);
      }

      $vendorDetails[$vendorId] = [
        'cart_total' => $cartTotal,
        'discount_share' => $vendorDiscounts[$vendorId] ?? 0.00,
        'commission' => $vendorCommissions[$vendorId] ?? 0.00,
        'net_total_after_subtract' => $totalAfterSubtract,
        'tax_share' => $vendorTaxShare,
      ];
    }

    $calculatedData = array(
      'total' => $total,
      'discount' => $discount,
      'subtotal' => $subtotal,
      'physical_discounted' => $physicalDiscounted,
      'digital_discounted' => $digitalDiscounted,
      'shippingCharge' => $shippingCharge,
      'tax' => $calculatedTax,
      'grandTotal' => $grandTotal,
      'adminCommission' => $adminCommission,
      'vendorAmounts' => $vendorAmounts,
      'vendorDetails' => $vendorDetails,
      'totalCommissionAmount' => $totalCommission,
    );

    return $calculatedData;
  }

  public function storeData($productList, $arrData)
  {
    $orderInfo = ProductOrder::query()->create([
      'user_id' => Auth::guard('sanctum')->check() == true ? Auth::guard('sanctum')->user()->id : null,
      'order_number' => uniqid(),
      'billing_name' => $arrData['billing_name'],
      'billing_phone' => $arrData['billing_phone'],
      'billing_email' => $arrData['billing_email'],
      'billing_address' => $arrData['billing_address'],
      'billing_city' => $arrData['billing_city'],
      'billing_state' => $arrData['billing_state'],
      'billing_country' => $arrData['billing_country'],
      'shipping_name' => $arrData['shipping_name'],
      'shipping_email' => $arrData['shipping_email'],
      'shipping_phone' => $arrData['shipping_phone'],
      'shipping_address' => $arrData['shipping_address'],
      'shipping_city' => $arrData['shipping_city'],
      'shipping_state' => $arrData['shipping_state'],
      'shipping_country' => $arrData['shipping_country'],
      'total' => $arrData['total'],
      'discount' => $arrData['discount'],
      'product_shipping_charge_id' => $arrData['productShippingChargeId'],
      'shipping_cost' => $arrData['shippingCharge'],
      'tax' => $arrData['tax'],
      'total_commission' => $arrData['total_commission'],
      'admin_amount_with_commission' => $arrData['admin_amount_with_commission'],
      'grand_total' => $arrData['grandTotal'],
      'vendor_net_amount' => json_encode($arrData['vendor_net_amounts']) ?? null,
      'per_vendor_discount_and_commission' => json_encode($arrData['per_vendor_discount_and_commission']) ?? null,
      'currency_text' => $arrData['currencyText'],
      'currency_text_position' => $arrData['currencyTextPosition'],
      'currency_symbol' => $arrData['currencySymbol'],
      'currency_symbol_position' => $arrData['currencySymbolPosition'],
      'payment_method' => $arrData['paymentMethod'],
      'gateway_type' => $arrData['gatewayType'],
      'payment_status' => $arrData['paymentStatus'],
      'order_status' => $arrData['orderStatus'],
      'attachment' => array_key_exists('attachment', $arrData) ? $arrData['attachment'] : null,
      'conversation_id' => array_key_exists('conversation_id', $arrData) ? $arrData['conversation_id'] : null,
      'fcm_token' => array_key_exists('fcm_token', $arrData) ? $arrData['fcm_token'] : null,
    ]);

    // Update vendor amounts
    if (isset($arrData['vendor_net_amounts']) && is_array($arrData['vendor_net_amounts'])) {
      foreach ($arrData['vendor_net_amounts'] as $vendorId => $amount) {
        $vendor = Vendor::find($vendorId);
        if ($vendor) {
          // Increment the vendor's amount
          $vendor->increment('amount', $amount);
        }
      }
    }

    foreach ($productList as $key => $item) {
      ProductPurchaseItem::create([
        'product_order_id' => $orderInfo->id,
        'product_id' => $key,
        'title' => $item['title'],
        'quantity' => intval($item['quantity']),
        'vendor_id' => isset($item['vendor_id']) ? $item['vendor_id'] : null,
      ]);
    }


    return $orderInfo;
  }

  public function generateInvoice($orderInfo, $productList)
  {
    $fileName = $orderInfo->order_number . '.pdf';

    $data['orderInfo'] = $orderInfo;
    $data['productList'] = $productList;

    $directory = public_path('assets/file/invoices/product/');
    @mkdir($directory, 0775, true);

    $fileLocated = $directory . $fileName;

    $data['taxData'] = Basic::select('product_tax_amount')->first();

    PDF::loadView('frontend.shop.invoice', $data)->save($fileLocated);

    return $fileName;
  }

  public function prepareMail($orderInfo)
  {
    // get the mail template info from db
    $mailTemplate = MailTemplate::query()->where('mail_type', '=', 'product_order')->first();
    $mailData['subject'] = $mailTemplate->mail_subject;
    $mailBody = $mailTemplate->mail_body;

    // get the website title info from db
    $info = Basic::select('website_title')->first();

    $customerName = $orderInfo->billing_first_name . ' ' . $orderInfo->billing_last_name;
    $orderNumber = $orderInfo->order_number;
    $websiteTitle = $info->website_title;

    if (Auth::guard('web')->check() == true) {
      $orderLink = '<p>Order Details: <a href=' . url("user/order/details/" . $orderInfo->id) . '>Click Here</a></p>';
    } else {
      $orderLink = '';
    }

    // replacing with actual data
    $mailBody = str_replace('{customer_name}', $customerName, $mailBody);
    $mailBody = str_replace('{order_number}', $orderNumber, $mailBody);
    $mailBody = str_replace('{website_title}', $websiteTitle, $mailBody);
    $mailBody = str_replace('{order_link}', $orderLink, $mailBody);

    $mailData['body'] = $mailBody;

    $mailData['recipient'] = $orderInfo->billing_email;

    $mailData['invoice'] = public_path('assets/file/invoices/product/') . $orderInfo->invoice;

    BasicMailer::sendMail($mailData);

    return;
  }

  public function complete($type = null)
  {
    $misc = new MiscellaneousController();

    $information['bgImg'] = $misc->getBreadcrumb();

    $information['purchaseType'] = $type;

    return view('frontend.payment.purchase-success', $information);
  }

  public function cancel(Request $request)
  {
    $notification = array('message' => 'Something went wrong', 'alert-type' => 'error');
    return redirect()->route('shop.products')->with($notification);
  }
  public function updateStockList($productList, ProductOrder $orderInfo)
  {
    if (count($productList) > 0) {
      foreach ($productList as $key => $item) {
        $product = Product::query()->find($key);
        if (empty($product) || $product->product_type != 'physical') {
          continue;
        }

        $stock = max(0, ((int) $product->stock) - intval($item['quantity']));
        $product->update(['stock' => $stock]);

        $vendor = !empty($product->vendor_id) ? Vendor::find($product->vendor_id) : null;
        if (empty($vendor)) {
          continue;
        }

        $productTitle = $this->resolveProductTitle($product, $item['title'] ?? 'Product');

        if ($stock <= 0) {
          VendorNotificationService::send(
            $vendor,
            'vendor_product_out_of_stock',
            'Out of stock',
            'Product "' . $productTitle . '" is now out of stock.',
            [
              'order_id' => $orderInfo->id,
              'product_id' => $product->id,
            ]
          );
        } elseif ($stock <= self::LOW_STOCK_THRESHOLD) {
          VendorNotificationService::send(
            $vendor,
            'vendor_product_low_stock',
            'Low stock alert',
            'Product "' . $productTitle . '" stock is running low.',
            [
              'order_id' => $orderInfo->id,
              'product_id' => $product->id,
            ]
          );
        }
      }
    }

    return 0;
  }

  private function notifyVendorsForOrder(ProductOrder $orderInfo): void
  {
    $vendorItems = ProductPurchaseItem::query()
      ->where('product_order_id', $orderInfo->id)
      ->whereNotNull('vendor_id')
      ->get()
      ->groupBy('vendor_id');

    foreach ($vendorItems as $vendorId => $items) {
      $vendor = Vendor::find($vendorId);
      if (empty($vendor)) {
        continue;
      }

      VendorNotificationService::send(
        $vendor,
        'vendor_product_purchased',
        'New order received',
        'Order #' . $orderInfo->order_number . ' includes ' . $items->count() . ' of your product(s). Payment status: ' . $orderInfo->payment_status . '.',
        [
          'order_id' => $orderInfo->id,
        ]
      );
    }
  }

  private function resolveProductTitle(Product $product, string $fallback = 'Product'): string
  {
    $title = $product->content()->value('title');

    if (!empty($title)) {
      return $title;
    }

    return $fallback;
  }
}
