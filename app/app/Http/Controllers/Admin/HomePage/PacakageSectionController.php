<?php

namespace App\Http\Controllers\Admin\Homepage;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Language;
use DB;
use Illuminate\Support\Facades\Session;
use App\Models\HomePage\PackageSection;

class PacakageSectionController extends Controller
{
    public function index(Request $request)
    {
        $information['info'] = DB::table('basic_settings')->select('category_section_background')->first();

        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['language'] = $language;

        $information['data'] = PackageSection::where('language_id', $language->id)->first();

        $information['langs'] = Language::all();

        return view('admin.home-page.package-section', $information);
    }

    public function update(Request $request)
    {
        $language = Language::query()->where('code', '=', $request->language)->first();

        PackageSection::query()->updateOrCreate(
            ['language_id' => $language->id],
            [
                'title' => $request->title
            ]
        );

        Session::flash('success', __('Package section updated successfully') . '!');

        return redirect()->back();
    }
}
