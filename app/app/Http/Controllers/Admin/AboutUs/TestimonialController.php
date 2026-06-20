<?php

namespace App\Http\Controllers\Admin\AboutUs;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Helpers\UploadFile;
use App\Http\Requests\Testimonial\AboutusStoreRequest;
use App\Http\Requests\Testimonial\AboutusUpdateRequest;
use App\Models\HomePage\Testimony\Testimonial;
use App\Models\HomePage\Testimony\TestimonialSection;
use App\Models\Language;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;


class TestimonialController extends Controller
{
    public function index(Request $request)
    {
        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['language'] = $language;

        $information['data'] = $language->testimonialSection()->first();

        $information['themeInfo'] = DB::table('basic_settings')->select('theme_version', 'testimonial_section_image')->first();

        $information['testimonials'] = $language->testimonial()->orderByDesc('id')->get();

        $information['langs'] = Language::all();

        return view('admin.about-us.testimonial-section.index', $information);
    }

    public function updateSectionBackground(Request $request)
    {

        $request->validate([
            'testimonial_section_image' => 'required'
        ]);

        if ($request->hasFile('testimonial_section_image')) {
            $imgName = UploadFile::store(public_path('assets/img/'), $request->file('testimonial_section_image'));
        }

        DB::table('basic_settings')->updateOrInsert(
            ['uniqid' => 12345],
            ['testimonial_section_image' =>  $imgName]
        );
        Session::flash('success', __('Testimonial section Background Image updated successfully') . '!');

        return redirect()->back();
    }
    public function updateSectionInfo(Request $request)
    {
        $language = Language::query()->where('code', '=', $request->language)->first();

        $testimonialSection = TestimonialSection::where('language_id', $language->id)->first();

        if ($testimonialSection) {
            $testimonialSection->update(
                [
                    'subtitle' => $request->subtitle,
                    'title' => $request->title,
                    'clients' => $request->clients,
                ]
            );
        } else {
            TestimonialSection::create(
                [
                    'language_id' => $language->id,
                    'subtitle' => $request->subtitle,
                    'title' => $request->title,
                    'clients' => $request->clients,
                ]
            );
        }

        Session::flash('success', __('Testimonial section updated successfully') . '!');

        return redirect()->back();
    }

    public function storeTestimonial(AboutusStoreRequest $request)
    {
        // store image in storage
        $imgName = UploadFile::store(public_path('assets/img/clients/'), $request->file('image'));
        Testimonial::query()->create($request->except('language', 'image') + [
            'image' => $request->hasFile('image') ? $imgName : NULL
        ]);

        Session::flash('success', __('New testimonial added successfully') . '!');

        return response()->json(['status' => 'success'], 200);
    }

    public function updateTestimonial(AboutusUpdateRequest $request)
    {
        $testimonial = Testimonial::query()->find($request->id);

        if ($request->hasFile('image')) {
            $newImage = $request->file('image');
            $oldImage = $testimonial->image;
            $imgName = UploadFile::update(public_path('assets/img/clients/'), $newImage, $oldImage);
        }

        $testimonial->update($request->except('language', 'image') + [
            'image' => $request->hasFile('image') ? $imgName : $testimonial->image
        ]);

        Session::flash('success', __('Testimonial updated successfully') . '!');

        return response()->json(['status' => 'success'], 200);
    }

    public function destroyTestimonial($id)
    {
        $testimonial = Testimonial::query()->find($id);

        @unlink(public_path('assets/img/clients/') . $testimonial->image);

        $testimonial->delete();

        return redirect()->back()->with('success', __('Testimonial deleted successfully') . '!');
    }

    public function bulkDestroyTestimonial(Request $request)
    {
        $ids = $request['ids'];

        foreach ($ids as $id) {
            $testimonial = Testimonial::query()->find($id);

            @unlink(public_path('assets/img/clients/') . $testimonial->image);

            $testimonial->delete();
        }

        Session::flash('success', __('Testimonials deleted successfully') . '!');

        return response()->json(['status' => 'success'], 200);
    }
}
