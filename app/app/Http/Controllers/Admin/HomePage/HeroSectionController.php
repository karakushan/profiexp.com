<?php

namespace App\Http\Controllers\Admin\Homepage;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Helpers\UploadFile;
use App\Models\HomePage\HeroSection;
use App\Models\Language;
use App\Rules\ImageMimeTypeRule;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class HeroSectionController extends Controller
{
    public function heroSection(Request $request)
    {
        $information['info'] = DB::table('basic_settings')->select('hero_section_background_img')->first();

        $language = Language::query()->where(
            'code',
            '=',
            $request->language
        )->firstOrFail();
        $information['language'] = $language;
        $information['langs'] = Language::all();

        $information['data'] = $language->heroSection()->first();
        return view('admin.home-page.hero-section.index', $information);
    }

    public function store(Request $request)
    {
        $data = DB::table('basic_settings')->select('hero_section_background_img')->first();
        $rules = [];

        if (empty($data->hero_section_background_img)) {
            $rules['hero_section_background_img'] = 'required';
        }
        if ($request->hasFile('hero_section_background_img')) {
            $rules['hero_section_background_img'] = new ImageMimeTypeRule();
        }

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator->errors());
        }

        if ($request->hasFile('hero_section_background_img')) {
            $newImage = $request->file('hero_section_background_img');
            $oldImage = $data->hero_section_background_img;

            $imgName = UploadFile::update(public_path('assets/img/hero-section/'), $newImage, $oldImage);

            // finally, store the image into db
            DB::table('basic_settings')->updateOrInsert(
                ['uniqid' => 12345],
                ['hero_section_background_img' => $imgName],
            );

            $request->session()->flash('success', 'Image updated successfully!');
        }

        return redirect()->back();
    }


    public function update(Request $request)
    {
        $language = Language::query()->where('code', '=', $request->language)->first();

        HeroSection::query()->updateOrCreate(
            ['language_id' => $language->id],
            [
                'title' => $request->title,
                'text' => $request->text,
            ]
        );

        $request->session()->flash('success', 'Hero section updated successfully!');

        return redirect()->back();
    }
}
