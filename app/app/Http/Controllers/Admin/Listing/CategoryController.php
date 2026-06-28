<?php

namespace App\Http\Controllers\Admin\Listing;

use App\Http\Controllers\Controller;
use App\Http\Helpers\UploadFile;
use App\Models\Language;
use App\Models\ListingCategory;
use App\Models\ListingCategoryContent;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;

class CategoryController extends Controller
{
    public function index(Request $request)
    {
        $information['language'] = $this->getAdminLanguage();

        $information['rootCategories'] = ListingCategory::root()
            ->with(['allChildren', 'contents.language'])
            ->orderByDesc('id')
            ->paginate(10);

        $information['langs'] = Language::all();
        $information['adminLanguageId'] = $this->getAdminLanguageId();

        return view('admin.listing.category.index', $information);
    }

    public function store(Request $request)
    {
        $langs = Language::all();
        $defaultLang = Language::where('is_default', 1)->first() ?? Language::first();

        $rules = [
            'icon' => 'required',
            'parent_id' => 'nullable|exists:listing_categories,id',
            'status' => 'required|numeric',
            'serial_number' => 'required|numeric',
            'mobile_image' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg,webp|max:2048',
        ];

        foreach ($langs as $lang) {
            $rules[$lang->code . '_name'] = ($lang->code === $defaultLang->code ? 'required|max:255' : 'nullable|max:255');
            $rules[$lang->code . '_meta_title'] = 'nullable|string|max:255';
            $rules[$lang->code . '_meta_description'] = 'nullable|string';
            $rules[$lang->code . '_seo_text'] = 'nullable|string';
        }

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()
            ], 400);
        }

        $in = $request->only(['parent_id', 'icon', 'serial_number', 'status']);

        if ($request->hasFile('mobile_image')) {
            $in['mobile_image'] = UploadFile::store(
                public_path('assets/img/listing/category/'),
                $request->file('mobile_image')
            );
        }

        $category = ListingCategory::create($in);

        foreach ($langs as $lang) {
            $name = $request->{$lang->code . '_name'};
            if (empty($name)) {
                continue;
            }

            ListingCategoryContent::create([
                'listing_category_id' => $category->id,
                'language_id' => $lang->id,
                'name' => $name,
                'slug' => createSlug($name),
                'meta_title' => $request->{$lang->code . '_meta_title'},
                'meta_description' => $request->{$lang->code . '_meta_description'},
                'seo_text' => $request->{$lang->code . '_seo_text'},
            ]);
        }

        Session::flash('success', __('New Listing category added successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }

    public function update(Request $request)
    {
        $langs = Language::all();
        $defaultLang = Language::where('is_default', 1)->first() ?? Language::first();

        $rules = [
            'icon' => 'required',
            'parent_id' => 'nullable|exists:listing_categories,id',
            'status' => 'required|numeric',
            'serial_number' => 'required|numeric',
        ];

        foreach ($langs as $lang) {
            $rules[$lang->code . '_name'] = ($lang->code === $defaultLang->code ? 'required|max:255' : 'nullable|max:255');
            $rules[$lang->code . '_meta_title'] = 'nullable|string|max:255';
            $rules[$lang->code . '_meta_description'] = 'nullable|string';
            $rules[$lang->code . '_seo_text'] = 'nullable|string';
        }

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()
            ], 400);
        }

        $category = ListingCategory::findOrFail($request->id);

        $in = $request->only(['parent_id', 'icon', 'serial_number', 'status']);

        if ($request->hasFile('mobile_image')) {
            $newImage = $request->file('mobile_image');
            $oldImage = $category->mobile_image;
            $in['mobile_image'] = UploadFile::update(
                public_path('assets/img/listing/category/'),
                $newImage,
                $oldImage
            );
        }

        $category->update($in);

        foreach ($langs as $lang) {
            $name = $request->{$lang->code . '_name'};
            if (empty($name)) {
                continue;
            }

            ListingCategoryContent::updateOrCreate(
                [
                    'listing_category_id' => $category->id,
                    'language_id' => $lang->id,
                ],
                [
                    'name' => $name,
                    'slug' => createSlug($name),
                    'meta_title' => $request->{$lang->code . '_meta_title'},
                    'meta_description' => $request->{$lang->code . '_meta_description'},
                    'seo_text' => $request->{$lang->code . '_seo_text'},
                ]
            );
        }

        Session::flash('success', __('Listing category updated successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }

    public function destroy($id)
    {
        $category = ListingCategory::findOrFail($id);

        if ($category->children()->count() > 0) {
            return redirect()->back()->with('warning', __('First delete all subcategories of this category') . '!');
        }

        $listingContents = $category->listing_contents()->get();

        if (count($listingContents) > 0) {
            return redirect()->back()->with('warning', __('First delete all the listing of this category') . '!');
        }

        @unlink(public_path('assets/img/listing/category/') . $category->mobile_image);
        $category->delete();

        return redirect()->back()->with('success', __('Category deleted successfully') . '!');
    }

    public function bulkDestroy(Request $request)
    {
        $ids = $request->ids;

        foreach ($ids as $id) {
            $category = ListingCategory::find($id);
            if (!$category) {
                continue;
            }

            if ($category->children()->count() > 0) {
                continue;
            }

            $listingContents = $category->listing_contents()->get();

            if (count($listingContents) > 0) {
                continue;
            }

            @unlink(public_path('assets/img/listing/category/') . $category->mobile_image);
            $category->delete();
        }

        Session::flash('success', __('Listing categories deleted successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }

    private function getAdminLanguage(): Language
    {
        $adminLangCode = Auth::guard('admin')->user()->lang_code ?? null;

        if ($adminLangCode) {
            $lang = Language::where('code', $adminLangCode)->first();
            if ($lang) {
                return $lang;
            }
        }

        return Language::where('is_default', 1)->first() ?? Language::first();
    }

    private function getAdminLanguageId(): int
    {
        return $this->getAdminLanguage()->id;
    }
}