<?php

namespace App\Http\Controllers\Admin\Listing\Location;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Language;
use App\Models\Listing\ListingContent;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Validator;
use App\Models\Location\Country;
use App\Models\Location\State;
use Illuminate\Validation\Rule;
use App\Models\Location\City;
use App\Rules\ImageMimeTypeRule;
use Illuminate\Support\Facades\Session;

class CityController extends Controller
{
    public function index(Request $request)
    {
        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['countries'] = $language->countryInfo()->orderByDesc('id')->get();
        $information['states'] = $language->stateInfo()->orderByDesc('id')->get();
        $information['stateCount'] = $language->stateInfo()->orderByDesc('id')->count();
        $information['cities'] = $language->cityInfo()->orderByDesc('id')->get();
        $information['langs'] = Language::all();
        $information['language'] = $language;

        return view('admin.listing.location.city.index', $information);
    }
    public function getCountry($language_id)
    {
        $countries = Country::where('language_id', $language_id)->get();
        $states = State::where('language_id', $language_id)->get();

        return response()->json([
            'status' => 'success',
            'countries' => $countries,
            'states' => $states
        ], 200);
    }

    public function getState($country)
    {
        $states = State::where('country_id', $country)->get();
        return response()->json(['status' => 'success', 'states' => $states], 200);
    }

    public function store(Request $request)
    {
        $totalCountry = Country::Where('language_id', $request->m_language_id)->count();
        if ($totalCountry > 0) {
            $country = true;
            $totalState = State::Where('country_id', $request->country_id)->count();
            if ($totalState > 0) {
                $state = true;
            } else {
                $state = false;
            }
        } else {
            $country = false;
            $totalState = State::Where('language_id', $request->m_language_id)->count();
            if ($totalState > 0) {
                $state = true;
            } else {
                $state = false;
            }
        }
        $rules = [
            'm_language_id' => 'required',
            'feature_image' => [
                'sometimes',
                new ImageMimeTypeRule()
            ],
            'name' => [
                'required',
                Rule::unique('cities')->where(function ($query) use ($request) {
                    return $query->where('language_id', $request->input('m_language_id'))
                        ->where('country_id', $request->input('country_id'))
                        ->where('state_id', $request->input('state_id'));
                }),
                'max:255',
            ],
            'country_id' => $country ? 'required' : '',
            'state_id' => $state ? 'required' : '',
        ];

        $messages = [
            'm_language_id.required' => __('The language field is required.'),
            'country_id.required' => __('The country field is required.'),
            'state_id.required' => __('The state field is required.'),
            'feature_image.required' => __('The featured image field is required.'),
            'name.required' => __('The name field is required.')
        ];

        $validator = Validator::make($request->all(), $rules, $messages);

        if ($validator->fails()) {
            return response()->json([
                'errors' => $validator->getMessageBag()
            ], 400);
        }

        if ($request->feature_image) {

            $featuredImgURL = $request->feature_image;
            $featuredImgExt = $featuredImgURL->getClientOriginalExtension();
            $featuredImgName = time() . '.' . $featuredImgExt;
            $featuredDir = public_path('assets/img/location/city/');

            if (!file_exists($featuredDir)) {
                @mkdir($featuredDir, 0777, true);
            }

            copy($featuredImgURL, $featuredDir . $featuredImgName);
        } else {
            $featuredImgName = null;
        }

        $city = new City();

        $city->language_id = $request->m_language_id;
        $city->country_id = $request->country_id;
        $city->state_id = $request->state_id;
        $city->feature_image = $featuredImgName;
        $city->name = $request->name;
        $city->slug = createSlug($request->name);

        $city->save();

        Session::flash('success', __('State stored successfully') . '!');

        return response()->json(['status' => 'success'], 200);
    }

    public function update(Request $request)
    {
        $totalCountry = Country::Where('language_id', $request->language_id)->count();
        if ($totalCountry > 0) {
            $country = true;
        } else {
            $country = false;
        }
        $totalState = State::Where('country_id', $request->country_id)->count();
        if ($totalState > 0) {
            $state = true;
        } else {
            $state = false;
        }

        $rules = [
            'name' => [
                'required',
                'max:255',
                Rule::unique('cities')->ignore($request->id, 'id')->where(function ($query) use ($request) {
                    return $query->where('language_id', $request->input('language_id'))
                        ->where('country_id', $request->input('country_id'))
                        ->where('state_id', $request->input('state_id'));
                }),
            ],

            'country_id' => $country ? 'required' : '',
            'state_id' => $state ? 'required' : '',
        ];
        if ($request->hasFile('image')) {
            $rules['image'] = [
                new ImageMimeTypeRule(),
            ];
        }

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()
            ], 400);
        }

        $city = City::find($request->id);

        $in = $request->all();

        if ($request->hasFile('image')) {
            @unlink(public_path('assets/img/location/city/') . $city->feature_image);
            $img = $request->file('image');
            $filename = uniqid() . '.jpg';
            $directory = public_path('assets/img/location/city/');
            @mkdir($directory, 0775, true);
            $img->move($directory, $filename);
            $in['feature_image'] = $filename;
        }
        $States = State::where('country_id', $request->country_id)->count();
        if ($States < 1) {
            $in['state_id'] = null;
        }
        $in['slug'] = createSlug($request->name);

        $city->update($in);

        Session::flash('success', __('City updated successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }

    public function ImageRemove(Request $request)
    {

        $city = City::Where('id', $request->fileid)->first();


        $city->feature_image = null;

        $city->save();

        Session::flash('success', __('Successfully Delete Image') . '!');

        return Response::json(['status' => 'success'], 200);
    }

    public function destroy($id)
    {
        $City = City::query()->find($id);

        $listing_content = ListingContent::Where('city_id', $id)->get();

        if (count($listing_content) > 0) {
            return redirect()->back()->with('warning', __('First delete all the listing of this City') . '!');
        } else {
            $City->delete();
            return redirect()->back()->with('success', __('City deleted successfully') . '!');
        }
    }

    public function bulkDestroy(Request $request)
    {
        $ids = $request['ids'];

        $errorOccurred = false;
        foreach ($ids as $id) {
            $City = City::query()->find($id);
            $listing_content = ListingContent::Where('city_id', $id)->get();

            if (count($listing_content) > 0) {
                $errorOccurred = true;
                break;
            } else {
                $City->delete();
            }
        }
        if ($errorOccurred == true) {
            Session::flash('warning', __('First delete all the listing of these City') . '!');
        } else {
            Session::flash('success', __('Selected Informations deleted successfully') . '!');
        }
        return Response::json(['status' => 'success'], 200);
    }
}
