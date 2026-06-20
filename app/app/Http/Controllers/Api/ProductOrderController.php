<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\ApiHelper\HelperController;
use App\Http\Controllers\Controller;
use App\Models\BasicSettings\PageHeading;
use App\Models\Shop\Product;
use App\Models\Shop\ProductOrder;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class ProductOrderController extends Controller
{
    public function product_order(Request $request)
    {
        // Authenticate customer
        $user = Auth::guard('sanctum')->user();
        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthenticated.'
            ], 401);
        }

        $language = HelperController::getLanguage($request);

        $data['page_title'] = PageHeading::where('language_id', $language->id)
            ->pluck('orders_page_title')
            ->first();

        $orders = ProductOrder::where('user_id', $user->id)
            ->orderBy('id', 'desc')
            ->paginate(10);

        $orders->getCollection()->transform(function ($order) {
            $order->invoice = $order->invoice
                ? asset('assets/file/invoices/product/' . $order->invoice)
                : asset('assets/img/noimage.jpg');
            return $order;
        });

        $data['orders'] = $orders;

        return response()->json([
            'success' => true,
            'data'    => $data,
        ]);
    }
    //details
    public function product_order_details(Request $request)
    {
        // Authenticate customer
        $user = Auth::guard('sanctum')->user();
        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthenticated.'
            ], 401);
        }

        $language = HelperController::getLanguage($request);

        $order = ProductOrder::with('item')->where([['user_id', $user->id], ['id', $request->order_id]])
            ->orderBy('id', 'desc')
            ->first();

        if (!$order) {
            return response()->json([
                'success' => false,
                'message' => 'Order not found'
            ]);
        }
        if (!empty($order->item)) {
            $items = $order->item->map(function ($pro) use ($language) {
                $product = Product::join('product_contents', 'products.id', 'product_contents.product_id')
                    ->where('product_contents.language_id', '=', $language->id)
                    ->where('products.id', $pro->product_id)
                    ->first();
                $pro->slug = $product->slug ?? "not-found";
                return $pro;
            });
        }

        $order->invoice = asset('assets/file/invoices/product/' . $order->invoice);

        $data['order'] = $order;

        return response()->json([
            'success' => true,
            'data'    => $data,
        ]);
    }
}
