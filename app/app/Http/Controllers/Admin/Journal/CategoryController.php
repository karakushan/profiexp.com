<?php

namespace App\Http\Controllers\Admin\Journal;

use App\Http\Controllers\Controller;
use App\Models\Journal\BlogCategory;
use App\Models\Journal\BlogCategoryContent;
use App\Models\Language;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;

class CategoryController extends Controller
{
    public function index(Request $request)
    {
        $information['langs'] = Language::all();

        // AdminLocale stores the selected admin locale as `admin_{code}`.
        // Category contents use the public language code, so normalize it
        // before selecting the title shown in the table.
        $adminLangCode = str_replace(
            'admin_',
            '',
            (string) (Auth::guard('admin')->user()->lang_code ?? '')
        );
        $adminLang = Language::where('code', $adminLangCode)->first();
        $defaultLang = Language::where('is_default', 1)->first() ?? Language::first();
        $information['adminLanguageId'] = $adminLang?->id;
        $information['defaultLanguageId'] = $defaultLang?->id;

        $information['categories'] = BlogCategory::with('contents.language')
            ->orderByDesc('id')
            ->paginate(10);

        $information['activeLanguageCode'] = $adminLang?->code ?? $defaultLang?->code;

        return view('admin.journal.category.index', $information);
    }

    public function store(Request $request)
    {
        $langs = Language::all();
        $defaultLang = Language::where('is_default', 1)->first() ?? Language::first();

        $rules = [
            'status' => 'required|numeric',
            'serial_number' => 'required|numeric',
        ];

        foreach ($langs as $lang) {
            $rules[$lang->code . '_name'] = ($lang->code === $defaultLang->code ? 'required|max:255' : 'nullable|max:255');
        }

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()
            ], 400);
        }

        $category = BlogCategory::create($request->only(['status', 'serial_number']));

        foreach ($langs as $lang) {
            $name = $request->{$lang->code . '_name'};
            if (empty($name)) {
                continue;
            }

            BlogCategoryContent::create([
                'blog_category_id' => $category->id,
                'language_id' => $lang->id,
                'name' => $name,
                'slug' => createSlug($name),
            ]);
        }

        Session::flash('success', __('New blog category added successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }

    public function update(Request $request)
    {
        $langs = Language::all();
        $activeLanguageCode = $request->input('language');
        if (! $langs->contains('code', $activeLanguageCode)) {
            $activeLanguageCode = Language::where('is_default', 1)->value('code') ?? Language::value('code');
        }

        $rules = [
            'status' => 'required|numeric',
            'serial_number' => 'required|numeric',
        ];

        foreach ($langs as $lang) {
            $rules[$lang->code . '_name'] = ($lang->code === $activeLanguageCode ? 'required|max:255' : 'nullable|max:255');
        }

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()
            ], 400);
        }

        $category = BlogCategory::findOrFail($request->id);
        $category->update($request->only(['status', 'serial_number']));

        foreach ($langs as $lang) {
            $name = $request->input($lang->code . '_name');
            if (empty($name)) {
                continue;
            }

            $content = [
                'name' => $name,
                'slug' => createSlug($name),
            ];

            foreach (['meta_title', 'meta_description', 'seo_text'] as $field) {
                $input = $lang->code . '_' . $field;
                if ($request->has($input)) {
                    $content[$field] = $request->input($input);
                }
            }

            BlogCategoryContent::updateOrCreate(
                [
                    'blog_category_id' => $category->id,
                    'language_id' => $lang->id,
                ],
                $content
            );
        }

        Session::flash('success', __('Blog category updated successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }

    public function destroy($id)
    {
        $category = BlogCategory::findOrFail($id);
        $blogInformations = $category->blogInfo()->get();

        if (count($blogInformations) > 0) {
            return redirect()->back()->with('warning', __('First delete all the blog of this category') . '!');
        }

        $category->delete();

        return redirect()->back()->with('success', __('Blog category deleted successfully') . '!');
    }

    public function bulkDestroy(Request $request)
    {
        $ids = $request->ids;

        foreach ($ids as $id) {
            $category = BlogCategory::find($id);
            if (!$category) {
                continue;
            }

            $blogInformations = $category->blogInfo()->get();

            if (count($blogInformations) > 0) {
                continue;
            }

            $category->delete();
        }

        Session::flash('success', __('Blog categories deleted successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }
}
