<?php

namespace App\Http\Controllers\Vendor\Shop;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Exports\ProductOrdersExport;
use App\Http\Helpers\BasicMailer;
use App\Models\BasicSettings\Basic;
use App\Models\PaymentGateway\OfflineGateway;
use App\Models\PaymentGateway\OnlineGateway;
use App\Models\Shop\ProductOrder;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;
use Maatwebsite\Excel\Facades\Excel;
use PDF;

class OrderController extends Controller
{
    public function orders(Request $request)
    {
        $orderNumber = $paymentStatus = $orderStatus = null;
        $vendorId = Auth::guard('vendor')->user()->id;

        if ($request->filled('order_no')) {
            $orderNumber = $request['order_no'];
        }
        if ($request->filled('payment_status')) {
            $paymentStatus = $request['payment_status'];
        }
        if ($request->filled('order_status')) {
            $orderStatus = $request['order_status'];
        }
        // Fix: Query orders that have at least one item belonging to the vendor
        $orders = ProductOrder::query()
            ->join('product_purchase_items', 'product_orders.id', '=', 'product_purchase_items.product_order_id')
            ->where('product_purchase_items.vendor_id', $vendorId)
            ->when($orderNumber, function ($query, $orderNumber) {
                return $query->where('product_orders.order_number', 'like', '%' . $orderNumber . '%');
            })
            ->when($paymentStatus, function ($query, $paymentStatus) {
                return $query->where('product_orders.payment_status', '=', $paymentStatus);
            })
            ->when($orderStatus, function ($query, $orderStatus) {
                return $query->where('product_orders.order_status', '=', $orderStatus);
            })
            ->select('product_orders.*')  
            ->distinct()  
            ->orderByDesc('product_orders.id')
            ->paginate(10);

        // Append query params for pagination
        $orders->appends($request->all());


        return view('vendors.shop.order.index', compact('orders'));
    }


    public function show($id)
    {
        $vendorId = Auth::guard('vendor')->user()->id;
        $order = ProductOrder::findOrFail($id);

        $information['details'] = $order;
        $information['tax'] = Basic::select('product_tax_amount')->first();

        // Fetch ONLY vendor's items
        $vendorItems = $order->item()->where('vendor_id', $vendorId)->get();

        // Attach product details 
        $vendorItems->map(function ($item) {
            $product = $item->productInfo()->first();

            $item['featured_image'] = $product->featured_image;
            $item['current_price'] = $product->current_price;
            $item['product_type'] = $product->product_type;
            return $item;
        });

        $vendorCartTotal = 0.00;
        $totalVendorDiscount = 0.00;
        $totalVendorCommission = 0.00;
        $vendorDiscount = 0.00;  
        $vendorCommission = 0.00;  
        $vendorTax = 0.00;  
        $vendorNetTotal = 0.00;  

        if ($order) {
            $perVendorDetails = $order->per_vendor_discount_and_commission
                ? json_decode($order->per_vendor_discount_and_commission, true)
                : [];
           
            // Access by vendorId key 
            $vendorData = $perVendorDetails[$vendorId] ?? [];
            $cartTotal = $vendorData['cart_total'] ?? 0.00;
            $vendorDiscount = $vendorData['discount_share'] ?? 0.00;
            $vendorCommission = $vendorData['commission'] ?? 0.00;
            $totalTax = $vendorData['tax_share'] ?? 0.00;
            $netTotal = $vendorData['net_total_after_subtract'] ?? 0.00;

            // Set totals
            $vendorCartTotal = $cartTotal;
            $totalVendorDiscount = $vendorDiscount;
            $totalVendorCommission = $vendorCommission;
            $vendorTax = $totalTax;
            $vendorNetTotal = $netTotal;
        }

        $information['items'] = $vendorItems;
        $information['vendorCartTotal'] = $vendorCartTotal;
        $information['totalVendorDiscount'] = $totalVendorDiscount;
        $information['totalVendorCommission'] = $totalVendorCommission;
        $information['vendorTax'] = $vendorTax;
        $information['vendorNetTotal'] = $vendorNetTotal; 

        return view('vendors.shop.order.details', $information);
    }


    public function destroy($id)
    {
        $order = ProductOrder::find($id);

        // delete the attachment
        @unlink(public_path('assets/file/attachments/product/') . $order->attachment);

        // delete the invoice
        @unlink(public_path('assets/file/invoices/product/') . $order->invoice);

        // delete purchase infos of this order
        $items = $order->item()->get();

        if (count($items) > 0) {
            foreach ($items as $item) {
                $item->delete();
            }
        }

        $order->delete();

        return redirect()->back()->with('success', __('Order deleted successfully') . '!');
    }

    public function bulkDestroy(Request $request)
    {
        $ids = $request->ids;

        foreach ($ids as $id) {
            $order = ProductOrder::find($id);

            // delete the attachment
            @unlink(public_path('assets/file/attachments/product/') . $order->attachment);

            // delete the invoice
            @unlink(public_path('assets/file/invoices/product/') . $order->invoice);

            // delete purchase infos of this order
            $items = $order->item()->get();

            if (count($items) > 0) {
                foreach ($items as $item) {
                    $item->delete();
                }
            }

            $order->delete();
        }

        Session::flash('success', __('Orders deleted successfully') . '!');

        return response()->json(['status' => 'success'], 200);
    }
}
