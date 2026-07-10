<?php

namespace App\Http\Controllers\Api\VendorApi\Shop;

use App\Http\Controllers\Controller;
use App\Models\Language;
use App\Models\Shop\ProductCategory;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class CategoryController extends Controller
{
  // GET /api/vendor/shop/categories?language=en
  public function index(Request $request)
  {
    $language = $request->filled('language')
      ? Language::where('code', $request->language)->first() ?? Language::where('is_default', 1)->first()
      : Language::where('is_default', 1)->first();

    $categories = $language->productCategory()->orderByDesc('id')
      ->get(['id', 'language_id', 'name', 'slug', 'status', 'serial_number']);
    $languages = Language::all(['id', 'name', 'code']);

    return response()->json([
      'status' => 'success',
      'data' => ['categories' => $categories, 'languages' => $languages],
    ]);
  }

  // POST /api/vendor/shop/categories
  public function store(Request $request)
  {
    $request->validate([
      'language_id'   => 'required|exists:languages,id',
      'name'          => 'required|unique:product_categories|max:255',
      'status'        => 'required|numeric',
      'serial_number' => 'required|numeric',
    ]);

    ProductCategory::create($request->except('slug') + [
      'slug' => createSlug($request->name),
    ]);

    return response()->json(['status' => 'success', 'message' => 'Category created successfully.']);
  }

  // POST /api/vendor/shop/categories/{id}/update
  public function update(Request $request, $id)
  {
    $request->validate([
      'name'          => ['required', 'max:255', Rule::unique('product_categories', 'name')->ignore($id)],
      'status'        => 'required|numeric',
      'serial_number' => 'required|numeric',
    ]);

    ProductCategory::findOrFail($id)->update($request->except('slug') + [
      'slug' => createSlug($request->name),
    ]);

    return response()->json(['status' => 'success', 'message' => 'Category updated successfully.']);
  }

  // POST /api/vendor/shop/categories/{id}/delete
  public function destroy($id)
  {
    $category = ProductCategory::findOrFail($id);

    if ($category->productContent()->count() > 0) {
      return response()->json([
        'status'  => 'error',
        'message' => 'Please delete all products in this category first.',
      ], 422);
    }

    $category->delete();

    return response()->json(['status' => 'success', 'message' => 'Category deleted successfully.']);
  }

  // POST /api/vendor/shop/categories/bulk-delete
  public function bulkDestroy(Request $request)
  {
    $request->validate(['ids' => 'required|array']);

    foreach ($request->ids as $id) {
      $category = ProductCategory::find($id);
      if ($category && $category->productContent()->count() > 0) {
        return response()->json([
          'status'  => 'error',
          'message' => 'Please delete all products of these categories first.',
        ], 422);
      }
    }

    ProductCategory::whereIn('id', $request->ids)->delete();

    return response()->json(['status' => 'success', 'message' => 'Categories deleted successfully.']);
  }
}
/*
        // first, get the language info from db
        $language = Language::where('code', $request->language)->firstOrFail();
        $information['language'] = $language;

        // then, get the product categories of that language from db
        $information['categories'] = $language->productCategory()->orderByDesc('id')->get();

        // also, get all the languages from db
        $information['langs'] = Language::all();

        return view('vendors.shop.category.index', $information);
    }
    public function store(Request $request)
    {
        $rules = [
            'language_id' => 'required',
            'name' => 'required|unique:product_categories|max:255',
            'status' => 'required|numeric',
            'serial_number' => 'required|numeric'
        ];

        $message = [
            'language_id.required' => 'The language field is required.'
        ];

        $validator = Validator::make($request->all(), $rules, $message);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()
            ], 400);
        }

        ProductCategory::create($request->except('slug') + [
            'slug' => createSlug($request->name)
        ]);

        Session::flash('success', __('New product category added successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }

    public function update(Request $request)
    {
        $rules = [
            'name' => [
                'required',
                'max:255',
                Rule::unique('product_categories', 'name')->ignore($request->id, 'id')
            ],
            'status' => 'required|numeric',
            'serial_number' => 'required|numeric'
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()
            ], 400);
        }

        $category = ProductCategory::find($request->id);

        $category->update($request->except('slug') + [
            'slug' => createSlug($request->name)
        ]);

        Session::flash('success', __('Product category updated successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }

    public function destroy($id)
    {
        $category = ProductCategory::find($id);
        $productContents = $category->productContent()->get();

        if (count($productContents) > 0) {
            return redirect()->back()->with('warning', __('First delete all the products of this category') . '!');
        } else {
            $category->delete();

            return redirect()->back()->with('success', __('Category deleted successfully') . '!');
        }
    }

    public function bulkDestroy(Request $request)
    {
        $ids = $request->ids;

        $errorOccurred = false;

        foreach ($ids as $id) {
            $category = ProductCategory::find($id);
            $productContents = $category->productContent()->get();

            if (count($productContents) > 0) {
                $errorOccurred = true;
                break;
            } else {
                $category->delete();
            }
        }

        if ($errorOccurred == true) {
            Session::flash('warning', __('First delete all the product of these categories') . '!');
        } else {
            Session::flash('success', __('Product categories deleted successfully!') . '!');
        }

        return Response::json(['status' => 'success'], 200);
    }
}
*/
