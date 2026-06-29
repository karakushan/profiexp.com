<?php

namespace App\Http\Controllers\Admin\Listing\Location;

use App\Http\Controllers\Controller;
use App\Models\Language;
use App\Models\Listing\ListingContent;
use App\Models\Location\City;
use App\Models\Location\Country;
use App\Models\Location\CountryContent;
use App\Models\Location\State;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class CountryController extends Controller
{
    public function index(Request $request)
    {
        $language = Language::where('code', $request->language)->firstOrFail();
        $information['countries'] = Country::forLanguage($language->id)
            ->with(['contents' => fn($q) => $q->where('language_id', $language->id)])
            ->orderByDesc('id')
            ->get();
        $information['langs'] = Language::all();
        $information['language'] = $language;

        return view('admin.listing.location.country.index', $information);
    }

    public function store(Request $request)
    {
        $langs = Language::all();
        $defaultLang = Language::where('is_default', 1)->first() ?? Language::first();

        $rules = [];
        foreach ($langs as $lang) {
            $rules[$lang->code . '_name'] = ($lang->code === $defaultLang->code ? 'required|max:255' : 'nullable|max:255');
        }

        $messages = [
            $defaultLang->code . '_name.required' => __('The name field is required for default language.'),
        ];

        $validator = Validator::make($request->all(), $rules, $messages);

        if ($validator->fails()) {
            return Response::json(['errors' => $validator->getMessageBag()], 400);
        }

        $country = Country::create();

        foreach ($langs as $lang) {
            $name = $request->{$lang->code . '_name'};
            if (empty($name)) continue;

            CountryContent::create([
                'country_id' => $country->id,
                'language_id' => $lang->id,
                'name' => $name,
            ]);
        }

        Session::flash('success', __('Country stored successfully') . '!');
        return Response::json(['status' => 'success'], 200);
    }

    public function update(Request $request)
    {
        $langs = Language::all();
        $defaultLang = Language::where('is_default', 1)->first() ?? Language::first();

        $rules = [];
        foreach ($langs as $lang) {
            $rules[$lang->code . '_name'] = ($lang->code === $defaultLang->code ? 'required|max:255' : 'nullable|max:255');
        }

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return Response::json(['errors' => $validator->getMessageBag()], 400);
        }

        $country = Country::findOrFail($request->id);

        foreach ($langs as $lang) {
            $name = $request->{$lang->code . '_name'};
            if (empty($name)) continue;

            CountryContent::updateOrCreate(
                ['country_id' => $country->id, 'language_id' => $lang->id],
                ['name' => $name]
            );
        }

        Session::flash('success', __('Country updated successfully') . '!');
        return Response::json(['status' => 'success'], 200);
    }

    public function destroy($id)
    {
        $country = Country::findOrFail($id);

        if (City::where('country_id', $id)->exists()) {
            return redirect()->back()->with('warning', __('First delete all the city of this Country') . '!');
        }

        if (State::where('country_id', $id)->exists()) {
            return redirect()->back()->with('warning', __('First delete all the State of this Country') . '!');
        }

        if (ListingContent::where('country_id', $id)->exists()) {
            return redirect()->back()->with('warning', __('First delete all the listing of this Country') . '!');
        }

        $country->contents()->delete();
        $country->delete();

        return redirect()->back()->with('success', __('Country deleted successfully') . '!');
    }

    public function bulkDestroy(Request $request)
    {
        $ids = $request['ids'];
        $errorMessages = [];

        foreach ($ids as $id) {
            $country = Country::find($id);
            if (!$country) continue;

            if (City::where('country_id', $id)->exists()) {
                $errorMessages[] = __('First delete all cities of country') . ' #' . $id;
                continue;
            }

            if (State::where('country_id', $id)->exists()) {
                $errorMessages[] = __('First delete all states of country') . ' #' . $id;
                continue;
            }

            if (ListingContent::where('country_id', $id)->exists()) {
                $errorMessages[] = __('First delete all listings of country') . ' #' . $id;
                continue;
            }

            $country->contents()->delete();
            $country->delete();
        }

        if (!empty($errorMessages)) {
            Session::flash('warning', implode(' | ', $errorMessages));
        } else {
            Session::flash('success', __('Selected countries deleted successfully') . '!');
        }

        return Response::json(['status' => 'success'], 200);
    }
}
