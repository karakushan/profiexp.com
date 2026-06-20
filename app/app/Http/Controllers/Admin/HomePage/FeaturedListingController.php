<?php

namespace App\Http\Controllers\Admin\HomePage;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Language;
use DB;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;
use App\Models\HomePage\ListingSection;

class FeaturedListingController extends Controller
{
    public function index(Request $request)
    {
        $information['info'] = DB::table('basic_settings')->select('category_section_background')->first();

        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['language'] = $language;

        $information['data'] = ListingSection::where('language_id', $language->id)->first();

        $information['langs'] = Language::all();

        return view('admin.home-page.featured-listing-section', $information);
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

        ListingSection::query()->updateOrCreate(
            ['language_id' => $language->id],
            [
                'subtitle' => $request->subtitle,
                'title' => $request->title,
                'text' => clean($request->text),
                'button_text' => $request->button_text
            ]
        );
        Session::flash('success', __('Listing section updated successfully') . '!');

        return redirect()->back();
    }
}
