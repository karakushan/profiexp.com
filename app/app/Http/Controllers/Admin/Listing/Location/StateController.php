<?php

namespace App\Http\Controllers\Admin\Listing\Location;

use App\Http\Controllers\Controller;
use App\Models\Language;
use App\Models\Listing\ListingContent;
use App\Models\Location\City;
use App\Models\Location\Country;
use App\Models\Location\CountryContent;
use App\Models\Location\State;
use App\Models\Location\StateContent;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class StateController extends Controller
{
    public function index(Request $request)
    {
        $language = Language::where('code', $request->language)->firstOrFail();

        $information['countries'] = Country::forLanguage($language->id)
            ->with(['contents' => fn($q) => $q->where('language_id', $language->id)])
            ->orderByDesc('id')
            ->get();

        $information['states'] = State::forLanguage($language->id)
            ->with([
                'contents' => fn($q) => $q->where('language_id', $language->id),
                'country.contents' => fn($q) => $q->where('language_id', $language->id),
            ])
            ->orderByDesc('id')
            ->get();

        $information['langs'] = Language::all();
        $information['language'] = $language;

        return view('admin.listing.location.state.index', $information);
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

    public function store(Request $request)
    {
        $langs = Language::all();
        $defaultLang = Language::where('is_default', 1)->first() ?? Language::first();

        $rules = [];
        foreach ($langs as $lang) {
            $rules[$lang->code . '_name'] = ($lang->code === $defaultLang->code ? 'required|max:255' : 'nullable|max:255');
        }

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->getMessageBag()], 400);
        }

        $state = State::create(['country_id' => $request->country_id]);

        foreach ($langs as $lang) {
            $name = $request->{$lang->code . '_name'};
            if (empty($name)) continue;

            StateContent::create([
                'state_id' => $state->id,
                'language_id' => $lang->id,
                'name' => $name,
            ]);
        }

        Session::flash('success', __('State stored successfully') . '!');
        return response()->json(['status' => 'success'], 200);
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

        $state = State::findOrFail($request->id);
        $state->update(['country_id' => $request->country_id]);

        foreach ($langs as $lang) {
            $name = $request->{$lang->code . '_name'};
            if (empty($name)) continue;

            StateContent::updateOrCreate(
                ['state_id' => $state->id, 'language_id' => $lang->id],
                ['name' => $name]
            );
        }

        Session::flash('success', __('State updated successfully') . '!');
        return Response::json(['status' => 'success'], 200);
    }

    public function destroy($id)
    {
        $State = State::findOrFail($id);

        if (City::where('state_id', $id)->exists()) {
            return redirect()->back()->with('warning', __('First delete all the city of this State') . '!');
        }

        if (ListingContent::where('state_id', $id)->exists()) {
            return redirect()->back()->with('warning', __('First delete all the listing of this State') . '!');
        }

        $State->contents()->delete();
        $State->delete();

        return redirect()->back()->with('success', __('State deleted successfully') . '!');
    }

    public function bulkDestroy(Request $request)
    {
        $ids = $request['ids'];

        foreach ($ids as $id) {
            $State = State::find($id);
            if (!$State) continue;

            if (City::where('state_id', $id)->exists()) continue;
            if (ListingContent::where('state_id', $id)->exists()) continue;

            $State->contents()->delete();
            $State->delete();
        }

        Session::flash('success', __('Selected states deleted successfully') . '!');
        return Response::json(['status' => 'success'], 200);
    }
}
