<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\ApiHelper\HelperController;
use App\Http\Controllers\Controller;
use App\Models\BasicSettings\Basic;
use App\Models\BasicSettings\PageHeading;
use App\Models\Form;
use App\Models\FormInput;
use App\Models\PaymentGateway\OfflineGateway;
use App\Models\PaymentGateway\OnlineGateway;
use App\Models\Shop\Coupon;
use App\Models\Shop\Product;
use App\Models\Shop\ProductCategory;
use App\Models\Shop\ProductContent;
use App\Models\Shop\ProductReview;
use App\Models\Vendor;
use App\Services\VendorNotificationService;
use App\Services\ReviewService;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator; 

class ProductController extends Controller
{
    public function index(Request $request)
    {
        $language = HelperController::getLanguage($request);
        $data['page_title'] = PageHeading::where('language_id', $language->id)->pluck('products_page_title')->first();

        $basic_settings = Basic::query()->select('breadcrumb')->first();
        $basic_settings['breadcrumb'] = asset('assets/img/' . $basic_settings->breadcrumb);

        $information['categories'] = $language->productCategory()
            ->where('status', 1)
            ->orderBy('serial_number', 'asc')
            ->get();

        $product_name = $category = $rating = $min = $max = $sort = null;

        if ($request->filled('product_name')) {
            $product_name = $request['product_name'];
        }
        if ($request->filled('category')) {
            $category = $request['category'];
        }
        if ($request->filled('rating')) {
            $rating = floatval($request['rating']);
        }
        if ($request->filled('min') && $request->filled('max')) {
            $min = $request['min'];
            $max = $request['max'];
        }
        if ($request->filled('sort')) {
            $sort = $request['sort'];
        }

        $information['products'] = Product::join('product_contents', 'products.id', '=', 'product_contents.product_id')
            ->where('products.status', '=', 'show')
            ->where(function ($query) {
                $query->where('products.placement_type', '!=', 2)
                    ->orWhereNull('products.placement_type');
            })
            ->where('product_contents.language_id', '=', $language->id)
            ->when($product_name, function ($query, $product_name) {
                return $query->where('product_contents.title', 'like', '%' . $product_name . '%');
            })
            ->when($category, function ($query, $category) {
                $categoryId = ProductCategory::query()->where('slug', '=', $category)->pluck('id')->first();
                return $query->where('product_contents.product_category_id', '=', $categoryId);
            })
            ->when($rating, function ($query, $rating) {
                return $query->where('products.average_rating', '>=', $rating);
            })
            ->when(($min && $max), function ($query) use ($min, $max) {
                return $query->where('products.current_price', '>=', $min)->where('products.current_price', '<=', $max);
            })
            ->select('products.id', 'products.featured_image', 'products.average_rating', 'product_contents.title', 'product_contents.slug', 'products.current_price', 'products.previous_price', 'products.product_type', 'products.stock')
            ->when($sort, function ($query, $sort) {
                if ($sort == 'newest') {
                    return $query->orderBy('products.created_at', 'desc');
                } else if ($sort == 'old') {
                    return $query->orderBy('products.created_at', 'asc');
                } else if ($sort == 'high-to-low') {
                    return $query->orderBy('products.current_price', 'desc');
                } else if ($sort == 'low-to-high') {
                    return $query->orderBy('products.current_price', 'asc');
                }
            }, function ($query) {
                return $query->orderByDesc('products.created_at');
            })
            ->paginate(9);

        $information['products']->getCollection()->transform(function ($product) {
            $product->featured_image = asset('assets/img/products/featured-images/' . $product->featured_image);
            return $product;
        });


        $information['total_products'] = Product::join('product_contents', 'products.id', '=', 'product_contents.product_id')
            ->where('products.status', '=', 'show')
            ->where(function ($query) {
                $query->where('products.placement_type', '!=', 2)
                    ->orWhereNull('products.placement_type');
            })
            ->where('product_contents.language_id', '=', $language->id)
            ->when($product_name, function ($query, $product_name) {
                return $query->where('product_contents.title', 'like', '%' . $product_name . '%');
            })
            ->when($category, function ($query, $category) {
                $categoryId = ProductCategory::query()->where('slug', '=', $category)->pluck('id')->first();

                return $query->where('product_contents.product_category_id', '=', $categoryId);
            })
            ->when($rating, function ($query, $rating) {
                return $query->where('products.average_rating', '>=', $rating);
            })
            ->when(($min && $max), function ($query) use ($min, $max) {
                return $query->where('products.current_price', '>=', $min)->where('products.current_price', '<=', $max);
            })
            ->select('products.id', 'products.featured_image', 'products.average_rating', 'product_contents.title', 'product_contents.slug', 'products.current_price', 'products.previous_price')
            ->when($sort, function ($query, $sort) {
                if ($sort == 'newest') {
                    return $query->orderBy('products.created_at', 'desc');
                } else if ($sort == 'old') {
                    return $query->orderBy('products.created_at', 'asc');
                } else if ($sort == 'high-to-low') {
                    return $query->orderBy('products.current_price', 'desc');
                } else if ($sort == 'low-to-high') {
                    return $query->orderBy('products.current_price', 'asc');
                }
            }, function ($query) {
                return $query->orderByDesc('products.created_at');
            })->get()->count();

        $information['currencyInfo'] = $this->getCurrencyInfo();

        $information['min'] = Product::where('status', 'show')->min('current_price');
        $information['max'] = Product::where('status', 'show')->max('current_price');

        return response()->json([
            'success' => false,
            'data' => $information
        ]);
    }

    public function show($slug, Request $request)
    {
        $product = ProductContent::where('slug', $slug)->first();
        if (is_null($product)) {
            return response()->json([
                'success' => false,
                'message' => __('Product Not found!')
            ]);
        }
        $language = HelperController::getLanguage($request);
        $productId = $product->product_id;

        $basic_settings = Basic::query()->select('breadcrumb')->first();
        $basic_settings['breadcrumb'] = asset('assets/img/' . $basic_settings->breadcrumb);


        $information['currencyInfo'] = $this->getCurrencyInfo();


        $details = Product::join('product_contents', 'products.id', '=', 'product_contents.product_id')
            ->leftJoin('product_categories', 'product_categories.id', '=', 'product_contents.product_category_id')
            ->where('product_contents.language_id', '=', $language->id)
            ->where('products.id', '=', $productId)
            ->select('products.id', 'products.slider_images', 'product_contents.title', 'product_contents.slug', 'products.average_rating', 'products.current_price', 'products.previous_price', 'product_contents.summary', 'product_contents.content', 'product_categories.name as categoryName', 'product_categories.slug as categorySlug', 'product_categories.id as categoryId', 'product_contents.meta_keywords', 'product_contents.meta_description', 'products.vendor_id')
            ->firstOrFail();

        if (!empty($details->slider_images)) {
            $sliders = collect(json_decode($details->slider_images));
            $sliders = $sliders->map(function ($item) {
                $item = asset('/assets/img/products/slider-images/' . $item);
                return $item;
            });
            $details->slider_images = $sliders;
        }

        $information['details'] = $details;

        $reviews = ProductReview::query()->where('product_id', '=', $productId)
            ->where('status', 'approved')
            ->orderByDesc('id')->get();

        $reviews = $reviews->map(function ($review) use ($language) {
            $user = $review->userInfo()->select('id', 'name', 'username', 'image')->first();
            ReviewService::setDisplayText($review, $language->id);

            return [
                'id'         => $review->id,
                'rating'     => $review->rating,
                'review'     => $review->comment,
                'created_at' => $review->created_at->toDateTimeString(),
                'updated_at' => $review->updated_at->toDateTimeString(),
                'user'       => [
                    'name'     => $user->name ?? null,
                    'username' => $user->username ?? null,
                    'image'    => $user?->image ? asset('assets/img/users/' . $user->image) : null,
                ],
            ];
        });

        $information['reviews'] = $reviews;

        $information['related_products'] = Product::join('product_contents', 'products.id', '=', 'product_contents.product_id')
            ->where('products.status', '=', 'show')
            ->where('product_contents.language_id', '=', $language->id)
            ->where('product_contents.product_category_id', '=', $details->categoryId)
            ->where('products.id', '!=', $details->id)
            ->select('products.id', 'products.featured_image', 'products.average_rating', 'product_contents.title', 'product_contents.slug', 'products.current_price', 'products.previous_price', 'products.product_type', 'products.stock')
            ->orderByDesc('products.created_at')
            ->get()->map(function ($item) {
                $item->featured_image = asset('assets/img/products/featured-images/' . $item->featured_image);
                return $item;
            });


        $productPlacementType = Product::where('id', $productId)->select('placement_type')->first();

        $information['placement_type'] = $productPlacementType->placement_type;

        if ($productPlacementType->placement_type == '2') {
            $form = Form::query()->where([
                ['vendor_id', $details->vendor_id],
                ['type', 'quote_request'],
                ['language_id', $language->id]
            ])->first();

            if ($form) {
                $information['inputFields'] = FormInput::query()->where('form_id', $form->id)->orderBy('order_no', 'asc')->get();
            } else {
                $information['inputFields'] = [];
            }
        }
        return response()->json([
            'success' => false,
            'data' => $information
        ]);
    }

    public function storeReview(Request $request, $id)
    {
        $rule = ['rating' => 'required'];

        $validator = Validator::make($request->all(), $rule);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        $productPurchased = false;

        // get the authenticate user
        $user = Auth::guard('sanctum')->user();
        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => __('You have to Login First!')
            ], 422);
        }

        // then, get the purchases of that user
        $orders = $user->productOrder()->where('payment_status', 'completed')->get();

        if (count($orders) > 0) {
            foreach ($orders as $order) {
                // then, get the purchased items of each order
                $items = $order->item()->get();

                foreach ($items as $item) {
                    // check whether selected product has bought or not
                    if ($item->product_id == $id) {
                        $productPurchased = true;
                        break 2;
                    }
                }
            }

            if ($productPurchased == true) {
                $review = ProductReview::updateOrCreate(
                    ['user_id' => $user->id, 'product_id' => $id],
                    [
                        'comment' => $request->comment,
                        'rating' => $request->rating,
                        'status' => 'pending',
                        'language_id' => ReviewService::languageId($request->header('Accept-Language')),
                    ]
                );
                if ($review->wasRecentlyCreated) {
                    $product = Product::find($id);
                    $vendor = !empty($product?->vendor_id) ? Vendor::find($product->vendor_id) : null;

                    VendorNotificationService::send(
                        $vendor,
                        'vendor_product_review_received',
                        'New product review',
                        'You received a new review on one of your products.',
                        [
                            'product_id' => $id,
                            'review_id' => $review->id,
                        ]
                    );
                }

                ReviewService::recalculate(ReviewService::TYPE_PRODUCT, (int) $id);

                return response()->json([
                    'success' => true,
                    'message' =>  __('Your review submitted and is awaiting moderation')
                ], 200);
            } else {
                return response()->json([
                    'success' => false,
                    'message' => __('You have not bought this product yet!')
                ], 422);
            }
        } else {
            return response()->json([
                'success' => false,
                'message' => __('You have not bought anything yet!')
            ], 422);
        }

        return redirect()->back();
    }

    public function addToCart(Request $request)
    {
        $rules = [
            'product_id' => 'required',
            'quantity' => 'required',
            'cart' => 'nullable'
        ];
        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        $productCart = $request->cart ?? [];

        $language = HelperController::getLanguage($request);
        $id = $request->product_id;
        $quantity = $request->quantity;

        // get the information of selected product
        $productInfo = ProductContent::with('product')
            ->where('language_id', $language->id)
            ->where('product_id', $id)
            ->first();

        if (!$productInfo) {
            return response()->json([
                'success' => false,
                'message' => 'product not found.'
            ], 404);
        }

        // check whether the selected product has enough stock or not
        if ($productInfo->product->product_type == 'physical') {
            if (empty($productCart) || !isset($productCart[$id])) {
                // product cart is empty or, product is not exist in that cart
                if ($productInfo->product->stock < $quantity) {
                    return response()->json([
                        'success' => false,
                        'message' => 'Sorry, product out of stock!',
                    ], 400);
                }
            } else {
                // product cart is not empty and, product is exist in that cart
                if ($productInfo->product->stock < $productCart[$id]['quantity'] + $quantity) {

                    $cartInfo = $this->cart_total_cart_quantity($productCart);
                    return response()->json([
                        'success' => false,
                        'message' => 'Sorry, product out of stock!',
                    ], 400);
                }
            }
        }

        // add product in the cart if product has enough stock
        if (empty($productCart)) {
            // first case, cart is totally empty
            $productCart = [
                $id => [
                    'type' => $productInfo->product->product_type,
                    'image' => $productInfo->product->featured_image,
                    'title' => $productInfo->title,
                    'slug' => $productInfo->slug,
                    'quantity' => $quantity,
                    'price' => $productInfo->product->current_price * $quantity,
                    'vendor_id' => $productInfo->product->vendor_id
                ]
            ];
        } else if (!empty($productCart) && !isset($productCart[$id])) {
            // second case, cart is not empty but product is not exist in this cart
            $productCart[$id] = [
                'type' => $productInfo->product->product_type,
                'image' => $productInfo->product->featured_image,
                'title' => $productInfo->title,
                'slug' => $productInfo->slug,
                'quantity' => $quantity,
                'price' => $productInfo->product->current_price * $quantity,
                'vendor_id' => $productInfo->product->vendor_id
            ];
        } else if (!empty($productCart) && isset($productCart[$id])) {
            // third case, cart is not empty and product is also exist in this cart
            $productCart[$id]['quantity'] += intval($quantity);
            $productCart[$id]['price'] += $productInfo->product->current_price * intval($quantity);
        }


        if (count($productCart) > 0) {
            foreach ($productCart as $key => $cart) {
                $productCart[$key]['image'] = asset('assets/img/products/featured-images/' . $cart['image']);
            }
        }

        $cartInfo = $this->cart_total_cart_quantity($productCart);
        return response()->json([
            'success' => true,
            'message' => 'Product Added into the cart',
            'cart' => $productCart,
            'cartTotal' => $cartInfo['cartTotal'],
            'numOfProducts' => $cartInfo['numOfProducts'],
            'qtyTotal' => $cartInfo['qtyTotal']
        ], 200);
    }

    public function removeProductCart(Request $request)
    {
        $rules = [
            'product_id' => 'required',
            'quantity' => 'required',
            'cart' => 'required'
        ];
        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        $id = $request->product_id;
        $productList = $request->cart;
        $language = HelperController::getLanguage($request);
        $productInfo = ProductContent::with('product')
            ->where('language_id', $language->id)
            ->where('product_id', $id)
            ->first();

        if (!$productInfo) {
            return response()->json([
                'success' => false,
                'message' => 'product not found.'
            ], 404);
        }

        if (array_key_exists($id, $productList)) {
            unset($productList[$id]);
        }

        $cartInfo = $this->cart_total_cart_quantity($productList);
        return response()->json([
            'success' => __('Product removed successfully'),
            'cart' => $productList,
            'cartTotal' => $cartInfo['cartTotal'],
            'numOfProducts' => $cartInfo['numOfProducts'],
            'qtyTotal' => $cartInfo['qtyTotal'],
        ], 200);
    }

    public function cart_total_cart_quantity(array $items)
    {
        $cartTotal = 0;
        $totalQuantity = 0;
        if (count($items) > 0) {
            foreach ($items as $key => $product) {
                $cartTotal += $product['price'];
                $totalQuantity += $product['quantity'];
            }
        }
        return [
            'cartTotal' => $cartTotal,
            'numOfProducts' => count($items),
            'qtyTotal' => $totalQuantity,
        ];
    }

    public function updateCart2(Request $request)
    {

        $rules = [
            'product_id' => 'required',
            'quantity' => 'required',
            'cart' => 'required'
        ];

        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        $productId = $request->product_id;
        $newQuantity = $request->quantity;
        $productList = $request->cart;
        $productInfo = Product::where('id', $productId)->first();

        if (!$productInfo) {
            return response()->json([
                'success' => false,
                'message' => 'product not found.'
            ], 404);
        }

        if (($productInfo->product_type == 'physical') && ($productInfo->stock < $newQuantity)) {
            return response()->json([
                'success' => false,
                'message' => 'Sorry, product out of stock!'
            ], 400);
        }



        if ($newQuantity < 1) {
            unset($productList[$productId]);
        } else {

            $unitPrice = $productInfo->current_price;
            $qty =  $productList[$productId]['quantity'] + $newQuantity;

            $productList[$productId]['type'] = $productList[$productId]['type'];
            $productList[$productId]['image'] = $productList[$productId]['image'];
            $productList[$productId]['title'] = $productList[$productId]['title'];
            $productList[$productId]['slug'] = $productList[$productId]['slug'];
            $productList[$productId]['quantity'] = $qty;
            $productList[$productId]['price'] = $unitPrice * $qty;
            $productList[$productId]['vendor_id'] = $productInfo->vendor_id;
        }

        $cartInfo = $this->cart_total_cart_quantity($productList);

        return response()->json([
            'success' => true,
            'cart' => $productList,
            'cartTotal' => $cartInfo['cartTotal'],
            'numOfProducts' => $cartInfo['numOfProducts'],
            'qtyTotal' => $cartInfo['qtyTotal'],
        ], 200);
    }

    public function updateCart(Request $request)
    {
        $rules = [
            'data' => 'required | array',
            'cart' => 'required | array'
        ];

        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        // get data from ajax request
        $data = $request->data;
        $productList = $request->cart;

        for ($i = 0; $i < sizeof($data['id']); $i++) {
            $productId = intval($data['id'][$i]);

            // get the information of product
            $productInfo = Product::where('id', $productId)->first();

            $newQuantity = intval($data['quantity'][$i]);
            $unitPrice = floatval($data['unitPrice'][$i]);

            // first, check whether the selected product has enough stock or not
            if (($productInfo->product_type == 'physical') && ($productInfo->stock < $newQuantity)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Sorry, product out of stock!'
                ], 400);
            }

            // second, if product is not out of stock then update product in cart
            if ($newQuantity < 1) {
                unset($productList[$productId]);
            } else {
                $productList[$productId]['type'] = $productList[$productId]['type'];
                $productList[$productId]['image'] = $productList[$productId]['image'];
                $productList[$productId]['title'] = $productList[$productId]['title'];
                $productList[$productId]['slug'] = $productList[$productId]['slug'];
                $productList[$productId]['quantity'] = $newQuantity;
                $productList[$productId]['price'] = $unitPrice * $newQuantity;
                $productList[$productId]['vendor_id'] = $productInfo->vendor_id;

                $imageName = $productList[$productId]['image'];
                $productList[$productId]['image_url'] = $imageName
                    ? asset('assets/img/products/featured-images/' . $imageName)
                    : asset('assets/img/default-product.jpg');
            }
        }

        $cartInfo = $this->cart_total_cart_quantity($productList);
        return response()->json([
            'success' => true,
            'cart' => $productList,
            'cartTotal' => $cartInfo['cartTotal'],
            'numOfProducts' => $cartInfo['numOfProducts'],
            'qtyTotal' => $cartInfo['qtyTotal'],
        ], 200);
    }

    public function checkout(Request $request)
    {


        $tax = Basic::select('product_tax_amount')->first();
        $information['tax'] = $tax->product_tax_amount;
        $information['onlineGateways'] = OnlineGateway::where('status', 1)->get();
        $information['offline_gateways'] = OfflineGateway::where('status', 1)->orderBy('serial_number', 'asc')->get();

        $stripe = OnlineGateway::where('keyword', 'stripe')->first();
        $stripe_info = json_decode($stripe->information, true);
        $information['stripe_key'] = $stripe_info['key'];
        $authorizenet = OnlineGateway::query()->whereKeyword('authorize.net')->first();
        $anetInfo = json_decode($authorizenet->information);
        $information['currencyInfo'] = $this->getCurrencyInfo();

        if ($anetInfo->sandbox_check == 1) {
            $information['anetSource'] = 'https://jstest.authorize.net/v1/Accept.js';
        } else {
            $information['anetSource'] = 'https://js.authorize.net/v1/Accept.js';
        }
        $information['anetClientKey'] = $anetInfo->public_key;
        $information['anetLoginId'] = $anetInfo->login_id;

        return response()->json([
            'success' => true,
            'data' => $information
        ], 200);
    }

    public function applyCoupon(Request $request)
    {

        $rules = [
            'code' => 'required',
            'cart' => 'required',
        ];

        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 422);
        }
        try {
            $coupon = Coupon::where('code', $request->code)->first();
            $startDate = Carbon::parse($coupon->start_date);
            $endDate = Carbon::parse($coupon->end_date);
            $todayDate = Carbon::now();

            // first, check coupon is valid or not
            if ($todayDate->between($startDate, $endDate) == false) {
                return response()->json(
                    [
                        'success' => false,
                        'message' => 'Sorry, coupon has expired!'
                    ],
                    400
                );
            }
            $cartItems = $request->cart;
            $total = 0;
            foreach ($cartItems as $item) {
                $total += $item['price'];
            }

            // second, check for minimum cart total
            if (!empty($coupon->minimum_spend)) {
                $minimumSpend = floatval($coupon->minimum_spend);

                if ($total < $minimumSpend) {
                    $currencyInfo = $this->getCurrencyInfo();
                    $position = $currencyInfo->base_currency_symbol_position;
                    $symbol = $currencyInfo->base_currency_symbol;
                    $spendData = ($position == 'left' ? $symbol : '') . $coupon->minimum_spend . ($position == 'right' ? $symbol : '');

                    return response()->json([
                        'success' => false,
                        'message' => 'You have to purchase at least ' . $spendData . ' of product.'
                    ], 400);
                }
            }

            // check for existence of digital item & send it through response
            $status = $this->isAllDigitalProduct($cartItems);

            if ($coupon->type == 'fixed') {
                return response()->json([
                    'success' => true,
                    'message' => __('Coupon applied successfully.'),
                    'amount' => $coupon->value,
                    'digitalProductStatus' => $status
                ]);
            } else {
                $couponAmount = $total * ($coupon->value / 100);
                return response()->json([
                    'success' => true,
                    'message' =>  __('Coupon applied successfully.'),
                    'amount' => $couponAmount,
                    'digitalProductStatus' => $status
                ]);
            }
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Coupon is not valid!'
            ], 400);
        }
    }

    public function isAllDigitalProduct($cartItems)
    {
        foreach ($cartItems as $item) {
            if ($item['type'] == 'physical') {
                $isAllDigitalProductStaus = false;
                break;
            } else {
                $isAllDigitalProductStaus = true;
            }
        }
        return $isAllDigitalProductStaus;
    }
}
