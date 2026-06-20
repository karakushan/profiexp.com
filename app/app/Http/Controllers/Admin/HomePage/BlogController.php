<?php

namespace App\Http\Controllers\Admin\HomePage;


use App\Http\Controllers\Controller;
use App\Models\HomePage\BlogSection;
use App\Models\Language;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;

class BlogController extends Controller
{
    public function index(Request $request)
    {
        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['language'] = $language;

        $information['data'] = $language->blogSection()->first();

        $information['langs'] = Language::all();

        return view('admin.home-page.blog-section', $information);
    }

    public function update(Request $request)
    {
        $rules = [
            'title' => 'required',
            'button_text' => 'required',
        ];

        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator->errors());
        }
        $language = Language::query()->where('code', '=', $request->language)->first();

        BlogSection::query()->updateOrCreate(
            ['language_id' => $language->id],
            [
                'button_text' => $request->button_text,
                'title' => $request->title
            ]
        );

        Session::flash('success', __('Blog section updated successfully') . '!');

        return redirect()->back();
    }
}
