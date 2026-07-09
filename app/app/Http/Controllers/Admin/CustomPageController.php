<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\Page\StoreRequest;
use App\Http\Requests\Page\UpdateRequest;
use App\Models\CustomPage\Page;
use App\Models\CustomPage\PageContent;
use App\Models\Language;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Mews\Purifier\Facades\Purifier;

class CustomPageController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        // first, get the language info from db
        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['language'] = $language;

        // then, get the custom pages of that language from db
        $information['pages'] = Page::query()->join('page_contents', 'pages.id', '=', 'page_contents.page_id')
            ->where('page_contents.language_id', '=', $language->id)
            ->orderByDesc('pages.id')
            ->get();

        // also, get all the languages from db
        $information['langs'] = Language::all();

        return view('admin.custom-page.index', $information);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        // get all the languages from db
        $information['languages'] = Language::all();

        return view('admin.custom-page.create', $information);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreRequest $request)
    {
        $page = new Page();

        $page->status = $request->status;
        $page->save();

        $languages = Language::all();

        foreach ($languages as $language) {
            $pageContent = new PageContent();
            $pageContent->language_id = $language->id;
            $pageContent->page_id = $page->id;
            $pageContent->title = $request[$language->code . '_title'];
            $pageContent->slug = createSlug($request[$language->code . '_title']);
            $pageContent->content = Purifier::clean($request[$language->code . '_content'], 'youtube');
            $pageContent->meta_keywords = $request[$language->code . '_meta_keywords'];
            $pageContent->meta_description = $request[$language->code . '_meta_description'];
            $pageContent->save();
        }
        Session::flash('success', __('New page added successfully') . '!');

        return response()->json(['status' => 'success'], 200);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id, Request $request)
    {
        $information['page'] = Page::query()->findOrFail($id);

        $information['languages'] = Language::all();

        if ($request->has('language')) {
            $information['currentLanguage'] = Language::where('code', $request->language)->firstOrFail();
        } else {
            $information['currentLanguage'] = Language::where('is_default', 1)->first();
        }

        return view('admin.custom-page.edit', $information);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateRequest $request, $id)
    {
        $page = Page::query()->findOrFail($id);

        $page->update([
            'status' => $request->status
        ]);

        foreach (Language::all() as $language) {
            if (!$this->hasTranslationInput($request, $language->code)) {
                continue;
            }

            $pageContent = PageContent::query()->firstOrNew([
                'page_id' => $id,
                'language_id' => $language->id
            ]);

            $slug = $request[$language->code . '_slug'];
            if (empty($slug)) {
                $slug = createSlug($request[$language->code . '_title']);
            } else {
                $slug = createSlug($slug);
            }

            $pageContent->fill([
                'title' => $request[$language->code . '_title'],
                'slug' => $slug,
                'content' => Purifier::clean($request[$language->code . '_content'], 'youtube'),
                'meta_keywords' => $request[$language->code . '_meta_keywords'],
                'meta_description' => $request[$language->code . '_meta_description']
            ])->save();
        }

        Session::flash('success', __('Page updated successfully') . '!');

        return response()->json(['status' => 'success'], 200);
    }

    private function hasTranslationInput(Request $request, string $code): bool
    {
        $fields = [
            $code . '_title',
            $code . '_slug',
            $code . '_content',
            $code . '_meta_keywords',
            $code . '_meta_description',
        ];

        foreach ($fields as $field) {
            if (trim((string) $request->input($field, '')) !== '') {
                return true;
            }
        }

        return false;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $page = Page::query()->findOrFail($id);

        $pageContents = $page->content()->get();

        foreach ($pageContents as $pageContent) {
            $pageContent->delete();
        }

        $page->delete();

        return redirect()->back()->with('success', __('Page deleted successfully') . '!');
    }

    /**
     * Remove the selected or all resources from storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function bulkDestroy(Request $request)
    {
        $ids = $request->ids;

        foreach ($ids as $id) {
            $page = Page::query()->findOrFail($id);

            $pageContents = $page->content()->get();

            foreach ($pageContents as $pageContent) {
                $pageContent->delete();
            }

            $page->delete();
        }

        Session::flash('success', __('Pages deleted successfully') . '!');
        

        return response()->json(['status' => 'success'], 200);
    }
}
