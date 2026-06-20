<?php

namespace App\Http\Controllers\Api\VendorApi\Shop;

use App\Http\Controllers\Controller;
use App\Http\Helpers\UploadFile;
use App\Http\Helpers\VendorPermissionHelper;
use App\Http\Requests\Shop\ProductStoreRequest;
use App\Http\Requests\Shop\ProductUpdateRequest;
use App\Models\Language;
use App\Models\Listing\Listing;
use App\Models\Shop\Product;
use App\Models\Shop\ProductCategory;
use App\Models\Shop\ProductContent;
use App\Models\Shop\ProductPurchaseItem;
use App\Models\Shop\ProductOrder;
use App\Models\Vendor;
use App\Rules\ImageMimeTypeRule;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Mews\Purifier\Facades\Purifier;

class ProductController extends Controller
{
  // GET /api/vendor/shop/products?language=en&search=&category=
  public function index(Request $request)
  {
    $vendor = $request->user();
    $currencyInfo = $this->getCurrencyInfo();

    $language = $request->filled('language')
      ? Language::where('code', $request->language)->first() ?? Language::where('is_default', 1)->first()
      : Language::where('is_default', 1)->first();

    $query = Product::where('vendor_id', $vendor->id)
      ->join('product_contents', 'products.id', '=', 'product_contents.product_id')
      ->leftJoin('product_categories', 'product_categories.id', '=', 'product_contents.product_category_id')
      ->where('product_contents.language_id', $language->id)
      ->when($request->filled('search'), function ($q) use ($request) {
        $q->where('product_contents.title', 'like', '%' . $request->search . '%');
      })
      ->when($request->filled('category'), function ($q) use ($request) {
        $q->where('product_categories.slug', $request->category);
      })
      ->select(
        'products.id',
        'products.product_type',
        'products.status',
        'products.featured_image',
        'products.current_price',
        'products.listing_id',
        'products.is_featured',
        'products.placement_type',
        'product_contents.title',
        'product_categories.name as category_name'
      )
      ->orderByDesc('products.id')
      ->paginate(10);

    $categories = Language::where('code', $language->code)->first()
      ?->productCategory()->where('status', 1)->get(['id', 'name', 'slug'])
      ?? [];

    return response()->json([
      'status' => 'success',
      'data'   => [
        'products'   => $query,
        'categories' => $categories,
        'languages'  => Language::all(['id', 'name', 'code']),
        'currency'   => $this->currencyPayload($currencyInfo),
      ],
    ]);
  }

  // GET /api/vendor/shop/products/create?type=physical|digital
  public function create(Request $request)
  {
    $vendor = $request->user();
    $type   = $request->input('type', 'physical');
    $currencyInfo = $this->getCurrencyInfo();

    $package = VendorPermissionHelper::currentPackagePermission($vendor->id);
    $sliderImageLimit = $package ? (int)($package->number_of_images_per_products ?? 0) : 0;

    $languages = Language::all();
    $languages->map(function ($lang) {
      $lang['categories'] = $lang->productCategory()->where('status', 1)->orderByDesc('id')->get();
    });

    $defaultLang = Language::where('is_default', 1)->first();
    $listings = Listing::with(['listing_content' => fn($q) => $q->where('language_id', $defaultLang->id)])
      ->where('status', 1)
      ->where('vendor_id', $vendor->id)
      ->select('id')
      ->get();

    return response()->json([
      'status' => 'success',
      'data'   => [
        'product_type'       => $type,
        'slider_image_limit' => $sliderImageLimit,
        'languages'          => $languages,
        'listings'           => $listings,
        'currency'           => $this->currencyPayload($currencyInfo),
      ],
    ]);
  }

  // GET /api/vendor/shop/products/{id}/edit
  public function edit(Request $request, $id)
  {
    $vendor  = $request->user();
    $currencyInfo = $this->getCurrencyInfo();
    $product = Product::where('vendor_id', $vendor->id)->findOrFail($id);

    $package = VendorPermissionHelper::currentPackagePermission($vendor->id);
    $totalSlider = is_array(json_decode($product->slider_images, true))
      ? count(json_decode($product->slider_images, true))
      : 0;
    $remainingSlider = $package
      ? max(0, (int)$package->number_of_images_per_products - $totalSlider)
      : 0;

    $defaultLang = Language::where('is_default', 1)->first();
    $languages = Language::all();
    $languages->map(function ($lang) use ($product) {
      $lang['product_data']      = $lang->productContent()->where('product_id', $product->id)->first();
      $lang['listing_contents']  = $lang->listingContent()->where('listing_id', $product->listing_id)->first();
      $lang['categories']        = $lang->productCategory()->where('status', 1)->orderByDesc('id')->get();
    });

    $listings = Listing::with(['listing_content' => fn($q) => $q->where('language_id', $defaultLang->id)])
      ->where('status', 1)
      ->where('vendor_id', $vendor->id)
      ->select('id')
      ->get();

    return response()->json([
      'status' => 'success',
      'data'   => [
        'product'          => $product,
        'remaining_slider' => $remainingSlider,
        'languages'        => $languages,
        'listings'         => $listings,
        'currency'         => $this->currencyPayload($currencyInfo),
      ],
    ]);
  }

  // POST /api/vendor/shop/products
  public function store(Request $request)
  {
    $vendor = $request->user();

    $request->validate([
      'product_type'   => 'required|in:physical,digital',
      'featured_image' => 'required|file|mimes:jpg,jpeg,png,webp|max:4096',
      'current_price'  => 'required|numeric',
      'status'         => 'required|in:show,hide,0,1',
    ]);

    $featuredImgName = UploadFile::store(
      public_path('assets/img/products/featured-images/'),
      $request->file('featured_image')
    );

    $fileName = null;
    if ($request->hasFile('file')) {
      $fileName = UploadFile::store(public_path('assets/file/products/'), $request->file('file'));
    }

    // Handle slider images uploaded as slider_images[] binary files
    $sliderImageNames = [];
    if ($request->hasFile('slider_images')) {
      $sliderDir = public_path('assets/img/products/slider-images/');
      @mkdir($sliderDir, 0775, true);
      foreach ($request->file('slider_images') as $sliderFile) {
        $sliderImageNames[] = UploadFile::store($sliderDir, $sliderFile);
      }
    }

    $product = Product::create(array_merge($request->except('featured_image', 'slider_images', 'file'), [
      'featured_image' => $featuredImgName,
      'slider_images'  => json_encode($sliderImageNames),
      'file'           => $fileName,
      'status'         => $this->normalizeProductStatus($request->input('status')),
      'vendor_id'      => $vendor->id,
    ]));

    $languages = Language::all();
    foreach ($languages as $language) {
      $pc = new ProductContent();
      $pc->language_id        = $language->id;
      $pc->product_id         = $product->id;
      $pc->product_category_id = $request->input($language->code . '_category_id');
      $pc->title              = $request->input($language->code . '_title') ?? '';
      $pc->slug               = createSlug($request->input($language->code . '_title') ?? '');
      $pc->summary            = $request->input($language->code . '_summary') ?? '';
      $pc->content            = Purifier::clean($request->input($language->code . '_content') ?? '', 'youtube');
      $pc->meta_keywords      = $request->input($language->code . '_meta_keywords') ?? '';
      $pc->meta_description   = $request->input($language->code . '_meta_description') ?? '';
      $pc->save();
    }

    return response()->json([
      'status'  => 'success',
      'message' => 'Product created successfully.',
      'data'    => ['product_id' => $product->id],
    ]);
  }

  // POST /api/vendor/shop/products/{id}/update
  public function update(Request $request, $id)
  {
    $vendor  = $request->user();
    $product = Product::where('vendor_id', $vendor->id)->findOrFail($id);

    $request->validate([
      'current_price' => 'required|numeric',
      'status'        => 'required|in:show,hide,0,1',
    ]);

    $featuredImgName = $product->featured_image;
    if ($request->hasFile('featured_image')) {
      $featuredImgName = UploadFile::update(
        public_path('assets/img/products/featured-images/'),
        $request->file('featured_image'),
        $product->featured_image
      );
    }

    // Handle keep_slider_images: JSON string of filenames to retain (removes unlisted existing)
    $sliderImages = json_decode($product->slider_images, true) ?? [];
    if ($request->filled('keep_slider_images')) {
      $keepNames = json_decode($request->input('keep_slider_images'), true) ?? [];
      foreach ($sliderImages as $img) {
        if (!in_array($img, $keepNames)) {
          @unlink(public_path('assets/img/products/slider-images/') . $img);
        }
      }
      $sliderImages = $keepNames;
    }

    // Append newly uploaded slider images (sent as slider_images[] binary files)
    if ($request->hasFile('slider_images')) {
      $sliderDir = public_path('assets/img/products/slider-images/');
      @mkdir($sliderDir, 0775, true);
      foreach ($request->file('slider_images') as $sliderFile) {
        $sliderImages[] = UploadFile::store($sliderDir, $sliderFile);
      }
    }
    $sliderImages = json_encode($sliderImages);

    $fileName = $product->file;
    if ($request->hasFile('file')) {
      $fileName = UploadFile::update(
        public_path('assets/file/products/'),
        $request->file('file'),
        $product->file
      );
    }

    if ($product->product_type === 'digital' && $request->input('input_type') === 'link' && !empty($product->file)) {
      @unlink(public_path('assets/file/products/') . $product->file);
      $fileName = null;
    }

    $product->update(array_merge($request->except('featured_image', 'slider_images', 'file'), [
      'featured_image' => $featuredImgName,
      'slider_images'  => $sliderImages,
      'file'           => $fileName,
      'status'         => $this->normalizeProductStatus($request->input('status')),
      'vendor_id'      => $vendor->id,
    ]));

    $languages = Language::all();
    foreach ($languages as $language) {
      $pc = ProductContent::where('product_id', $id)->where('language_id', $language->id)->first()
        ?? new ProductContent();
      $pc->language_id        = $language->id;
      $pc->product_id         = $id;
      $pc->product_category_id = $request->input($language->code . '_category_id');
      $pc->title              = $request->input($language->code . '_title') ?? '';
      $pc->slug               = createSlug($request->input($language->code . '_title') ?? '');
      $pc->summary            = $request->input($language->code . '_summary') ?? '';
      $pc->content            = Purifier::clean($request->input($language->code . '_content') ?? '', 'youtube');
      $pc->meta_keywords      = $request->input($language->code . '_meta_keywords') ?? '';
      $pc->meta_description   = $request->input($language->code . '_meta_description') ?? '';
      $pc->save();
    }

    return response()->json(['status' => 'success', 'message' => 'Product updated successfully.']);
  }

  // POST /api/vendor/shop/products/{id}/featured
  public function updateFeaturedStatus(Request $request, $id)
  {
    $vendor  = $request->user();
    $product = Product::where('vendor_id', $vendor->id)->findOrFail($id);
    $request->validate(['is_featured' => 'required|in:yes,no']);

    $product->update(['is_featured' => $request->is_featured]);

    return response()->json(['status' => 'success', 'message' => 'Featured status updated.']);
  }

  // POST /api/vendor/shop/products/{id}/slider-image/remove
  public function detachImage(Request $request, $id)
  {
    $vendor  = $request->user();
    $product = Product::where('vendor_id', $vendor->id)->findOrFail($id);
    $request->validate(['key' => 'required|integer|min:0']);

    $sliderImages = json_decode($product->slider_images, true) ?? [];
    if (count($sliderImages) <= 1) {
      return response()->json(['status' => 'error', 'message' => 'Cannot delete the last slider image.'], 422);
    }

    @unlink(public_path('assets/img/products/slider-images/') . $sliderImages[$request->key]);
    array_splice($sliderImages, $request->key, 1);
    $product->update(['slider_images' => json_encode($sliderImages)]);

    return response()->json(['status' => 'success', 'message' => 'Slider image removed.']);
  }

  // POST /api/vendor/shop/products/{id}/delete
  public function destroy(Request $request, $id)
  {
    $vendor  = $request->user();
    $product = Product::where('vendor_id', $vendor->id)->findOrFail($id);

    $this->_deleteProduct($product);

    return response()->json(['status' => 'success', 'message' => 'Product deleted successfully.']);
  }

  // POST /api/vendor/shop/products/bulk-delete
  public function bulkDestroy(Request $request)
  {
    $vendor = $request->user();
    $request->validate(['ids' => 'required|array']);

    $products = Product::where('vendor_id', $vendor->id)->whereIn('id', $request->ids)->get();
    foreach ($products as $product) {
      $this->_deleteProduct($product);
    }

    return response()->json(['status' => 'success', 'message' => 'Products deleted successfully.']);
  }

  private function currencyPayload($currencyInfo): array
  {
    return [
      'base_currency_text' => (string) ($currencyInfo->base_currency_text ?? ''),
      'base_currency_rate' => (float) ($currencyInfo->base_currency_rate ?? 1),
      'base_currency_symbol' => (string) ($currencyInfo->base_currency_symbol ?? ''),
      'base_currency_symbol_position' => (string) ($currencyInfo->base_currency_symbol_position ?? 'left'),
    ];
  }

  private function normalizeProductStatus($status): string
  {
    $value = strtolower(trim((string) $status));

    return in_array($value, ['1', 'show'], true) ? 'show' : 'hide';
  }

  private function _deleteProduct(Product $product): void
  {
    @unlink(public_path('assets/img/products/featured-images/') . $product->featured_image);

    $sliderImages = json_decode($product->slider_images, true) ?? [];
    foreach ($sliderImages as $img) {
      @unlink(public_path('assets/img/products/slider-images/') . $img);
    }

    @unlink(public_path('assets/file/products/') . $product->file);

    foreach ($product->content()->get() as $pc) {
      $pc->delete();
    }

    foreach ($product->purchase()->get() as $purchaseData) {
      $othersExist = ProductPurchaseItem::where('product_id', '<>', $product->id)
        ->where('product_order_id', $purchaseData->product_order_id)
        ->exists();

      if (!$othersExist) {
        $order = ProductOrder::find($purchaseData->product_order_id);
        if ($order) {
          @unlink(public_path('assets/file/attachments/product/') . $order->receipt);
          @unlink(public_path('assets/file/invoices/product/') . $order->invoice);
          $order->delete();
        }
      }

      $purchaseData->delete();
    }

    foreach ($product->review()->get() as $review) {
      $review->delete();
    }

    $product->delete();
  }
}
