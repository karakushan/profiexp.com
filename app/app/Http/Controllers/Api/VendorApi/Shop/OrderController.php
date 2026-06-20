<?php

namespace App\Http\Controllers\Api\VendorApi\Shop;

use App\Http\Controllers\Controller;
use App\Models\BasicSettings\Basic;
use App\Models\Shop\ProductOrder;
use App\Models\Shop\ProductPurchaseItem;
use Illuminate\Http\Request;

class OrderController extends Controller
{
  // GET /api/vendor/shop/orders?page=1&order_no=&payment_status=&order_status=
  public function index(Request $request)
  {
    $vendor = $request->user();

    $orders = ProductOrder::query()
      ->join('product_purchase_items', 'product_orders.id', '=', 'product_purchase_items.product_order_id')
      ->where('product_purchase_items.vendor_id', $vendor->id)
      ->when($request->filled('order_no'), function ($q) use ($request) {
        $q->where('product_orders.order_number', 'like', '%' . $request->order_no . '%');
      })
      ->when($request->filled('payment_status'), function ($q) use ($request) {
        $q->where('product_orders.payment_status', $request->payment_status);
      })
      ->when($request->filled('order_status'), function ($q) use ($request) {
        $q->where('product_orders.order_status', $request->order_status);
      })
      ->select('product_orders.*')
      ->distinct()
      ->orderByDesc('product_orders.id')
      ->paginate(10);

    return response()->json(['status' => 'success', 'data' => ['orders' => $orders]]);
  }

  // GET /api/vendor/shop/orders/{id}
  public function show(Request $request, $id)
  {
    $vendor = $request->user();
    $order  = ProductOrder::with('shippingMethod')->findOrFail($id);
    $tax    = Basic::value('product_tax_amount');

    $vendorItems = $order->item()
      ->where('vendor_id', $vendor->id)
      ->get()
      ->map(function ($item) {
        $product = $item->productInfo()->first();
        $item['featured_image'] = $product
          ? asset('assets/img/products/featured-images/' . $product->featured_image)
          : null;
        $item['current_price'] = $product?->current_price;
        $item['product_type']  = $product?->product_type;
        // Slider images
        $rawSlider = $product?->slider_images;
        $sliderArr = [];
        if ($rawSlider) {
          $decoded = json_decode($rawSlider, true);
          if (is_array($decoded)) {
            $sliderArr = array_map(
              fn($f) => asset('assets/img/products/slider-images/' . $f),
              $decoded
            );
          }
        }
        $item['slider_images'] = $sliderArr;
        return $item;
      });

    $perVendorDetails = $order->per_vendor_discount_and_commission
      ? json_decode($order->per_vendor_discount_and_commission, true)
      : [];
    $vendorData = $perVendorDetails[$vendor->id] ?? [];

    return response()->json([
      'status' => 'success',
      'data'   => [
        'order'         => $order,
        'items'         => $vendorItems,
        'shipping_type' => $order->shippingMethod?->title ?? 'N/A',
        'tax'           => $tax,
        'cart_total'    => $vendorData['cart_total']              ?? 0,
        'discount'      => $vendorData['discount_share']          ?? 0,
        'commission'    => $vendorData['commission']              ?? 0,
        'tax_share'     => $vendorData['tax_share']               ?? 0,
        'net_total'     => $vendorData['net_total_after_subtract'] ?? 0,
      ],
    ]);
  }

  // POST /api/vendor/shop/orders/{id}/delete
  public function destroy(Request $request, $id)
  {
    $order = ProductOrder::findOrFail($id);
    $this->_deleteOrder($order);
    return response()->json(['status' => 'success', 'message' => 'Order deleted successfully.']);
  }

  // POST /api/vendor/shop/orders/bulk-delete
  public function bulkDestroy(Request $request)
  {
    $request->validate(['ids' => 'required|array']);
    foreach ($request->ids as $id) {
      $order = ProductOrder::find($id);
      if ($order) {
        $this->_deleteOrder($order);
      }
    }
    return response()->json(['status' => 'success', 'message' => 'Orders deleted successfully.']);
  }

  private function _deleteOrder(ProductOrder $order): void
  {
    @unlink(public_path('assets/file/attachments/product/') . $order->attachment);
    @unlink(public_path('assets/file/invoices/product/') . $order->invoice);
    $order->item()->delete();
    $order->delete();
  }
}
