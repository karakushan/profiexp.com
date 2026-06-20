<?php

namespace App\Http\Controllers\Admin\HomePage;

use App\Http\Controllers\Controller;
use App\Models\Language;
use App\Models\HomePage\LocationSection;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;

class LocationSectionController extends Controller
{
    public function index(Request $request)
    {
        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['language'] = $language;

        $information['data'] = $language->locationSection()->first();

        $information['langs'] = Language::all();

        return view('admin.home-page.location-section', $information);
    }

    public function update(Request $request)
    {
        $language = Language::query()->where('code', '=', $request->language)->first();

        LocationSection::query()->updateOrCreate(
            ['language_id' => $language->id],
            [
                'title' => $request->title
            ]
        );

        Session::flash('success', __('Location section updated successfully') . '!');

        return redirect()->back();
    }
}
