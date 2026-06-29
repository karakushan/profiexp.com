<?php

namespace App\Http\Controllers\Admin\Listing\Location;

use App\Http\Controllers\Controller;
use App\Models\Language;
use App\Models\Listing\ListingContent;
use App\Models\Location\City;
use App\Models\Location\CityContent;
use App\Models\Location\Country;
use App\Models\Location\State;
use App\Rules\ImageMimeTypeRule;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Illuminate\Validation\Rule;

class CityController extends Controller
{
    public function index(Request $request)
    {
        $language = Language::where('code', $request->language)->firstOrFail();

        $information['countries'] = Country::forLanguage($language->id)
            ->with(['contents' => fn($q) => $q->where('language_id', $language->id)])
            ->orderByDesc('id')
            ->get();

        $information['stateCount'] = State::forLanguage($language->id)->count();

        $information['cities'] = City::forLanguage($language->id)
            ->with([
                'contents' => fn($q) => $q->where('language_id', $language->id),
                'country.contents' => fn($q) => $q->where('language_id', $language->id),
                'state.contents' => fn($q) => $q->where('language_id', $language->id),
            ])
            ->orderByDesc('id')
            ->get();

        $information['states'] = State::forLanguage($language->id)
            ->with(['contents' => fn($q) => $q->where('language_id', $language->id)])
            ->get();

        $information['langs'] = Language::all();
        $information['language'] = $language;

        return view('admin.listing.location.city.index', $information);
    }

    public function getCountry($language_id)
    {
        $countries = Country::forLanguage($language_id)
            ->with(['contents' => fn($q) => $q->where('language_id', $language_id)])
            ->get()
            ->map(fn($c) => ['id' => $c->id, 'name' => $c->getName($language_id)]);

        $states = State::forLanguage($language_id)
            ->with(['contents' => fn($q) => $q->where('language_id', $language_id)])
            ->get()
            ->map(fn($s) => ['id' => $s->id, 'name' => $s->getName($language_id)]);

        return response()->json([
            'status' => 'success',
            'countries' => $countries,
            'states' => $states,
        ], 200);
    }

    public function getState($country)
    {
        $language = request('language_id') ? Language::find(request('language_id')) : null;

        $states = State::where('country_id', $country)->get()->map(function ($s) use ($language) {
            return [
                'id' => $s->id,
                'name' => $language ? $s->getName($language->id) : ($s->contents()->first()?->name ?? ''),
            ];
        });

        return response()->json(['status' => 'success', 'states' => $states], 200);
    }

    public function store(Request $request)
    {
        $langs = Language::all();
        $defaultLang = Language::where('is_default', 1)->first() ?? Language::first();

        $rules = [
            'country_id' => 'required',
            'feature_image' => ['sometimes', new ImageMimeTypeRule()],
        ];

        foreach ($langs as $lang) {
            $rules[$lang->code . '_name'] = ($lang->code === $defaultLang->code ? 'required|max:255' : 'nullable|max:255');
        }

        $stateExists = State::where('country_id', $request->country_id)->exists();
        if ($stateExists) {
            $rules['state_id'] = 'required';
        }

        $messages = [
            'country_id.required' => __('The country field is required.'),
            'state_id.required' => __('The state field is required.'),
        ];

        $validator = Validator::make($request->all(), $rules, $messages);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->getMessageBag()], 400);
        }

        if ($request->feature_image) {
            $featuredImgName = time() . '.' . $request->feature_image->getClientOriginalExtension();
            $featuredDir = public_path('assets/img/location/city/');
            if (!file_exists($featuredDir)) {
                @mkdir($featuredDir, 0777, true);
            }
            copy($request->feature_image, $featuredDir . $featuredImgName);
        } else {
            $featuredImgName = null;
        }

        $city = City::create([
            'country_id' => $request->country_id,
            'state_id' => $request->state_id,
            'feature_image' => $featuredImgName,
        ]);

        foreach ($langs as $lang) {
            $name = $request->{$lang->code . '_name'};
            if (empty($name)) continue;

            CityContent::create([
                'city_id' => $city->id,
                'language_id' => $lang->id,
                'name' => $name,
                'slug' => Str::slug($name),
            ]);
        }

        Session::flash('success', __('City stored successfully') . '!');
        return response()->json(['status' => 'success'], 200);
    }

    public function update(Request $request)
    {
        $langs = Language::all();
        $defaultLang = Language::where('is_default', 1)->first() ?? Language::first();

        $rules = [
            'country_id' => 'required',
        ];

        foreach ($langs as $lang) {
            $rules[$lang->code . '_name'] = ($lang->code === $defaultLang->code ? 'required|max:255' : 'nullable|max:255');
        }

        $stateExists = State::where('country_id', $request->country_id)->exists();
        if ($stateExists) {
            $rules['state_id'] = 'required';
        }

        if ($request->hasFile('image')) {
            $rules['image'] = [new ImageMimeTypeRule()];
        }

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return Response::json(['errors' => $validator->getMessageBag()], 400);
        }

        $city = City::findOrFail($request->id);

        $updateData = ['country_id' => $request->country_id];

        if ($request->hasFile('image')) {
            @unlink(public_path('assets/img/location/city/') . $city->feature_image);
            $img = $request->file('image');
            $filename = uniqid() . '.jpg';
            $directory = public_path('assets/img/location/city/');
            @mkdir($directory, 0775, true);
            $img->move($directory, $filename);
            $updateData['feature_image'] = $filename;
        }

        $statesCount = State::where('country_id', $request->country_id)->count();
        $updateData['state_id'] = $statesCount > 0 ? $request->state_id : null;

        $city->update($updateData);

        foreach ($langs as $lang) {
            $name = $request->{$lang->code . '_name'};
            if (empty($name)) continue;

            CityContent::updateOrCreate(
                ['city_id' => $city->id, 'language_id' => $lang->id],
                ['name' => $name, 'slug' => Str::slug($name)]
            );
        }

        Session::flash('success', __('City updated successfully') . '!');
        return Response::json(['status' => 'success'], 200);
    }

    public function ImageRemove(Request $request)
    {
        $city = City::findOrFail($request->fileid);
        $city->feature_image = null;
        $city->save();

        Session::flash('success', __('Image deleted successfully') . '!');
        return Response::json(['status' => 'success'], 200);
    }

    public function destroy($id)
    {
        $City = City::findOrFail($id);

        if (ListingContent::where('city_id', $id)->exists()) {
            return redirect()->back()->with('warning', __('First delete all the listing of this City') . '!');
        }

        $City->contents()->delete();
        $City->delete();

        return redirect()->back()->with('success', __('City deleted successfully') . '!');
    }

    public function bulkDestroy(Request $request)
    {
        $ids = $request['ids'];

        foreach ($ids as $id) {
            $City = City::find($id);
            if (!$City) continue;
            if (ListingContent::where('city_id', $id)->exists()) continue;

            $City->contents()->delete();
            $City->delete();
        }

        Session::flash('success', __('Selected cities deleted successfully') . '!');
        return Response::json(['status' => 'success'], 200);
    }
}
