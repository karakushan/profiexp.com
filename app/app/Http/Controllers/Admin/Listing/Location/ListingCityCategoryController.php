<?php

namespace App\Http\Controllers\Admin\Listing\Location;

use App\Http\Controllers\Controller;
use App\Models\Language;
use App\Models\ListingCategory;
use App\Models\Location\City;
use App\Models\Location\Country;
use App\Models\Location\ListingCityCategory;
use App\Models\Location\ListingCityCategoryContent;
use App\Models\Location\State;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class ListingCityCategoryController extends Controller
{
    public function index(Request $request)
    {
        $language = Language::where('code', $request->language)->firstOrFail();

        $information['language'] = $language;
        $information['langs'] = Language::all();
        $information['countries'] = Country::forLanguage($language->id)
            ->with(['contents' => fn($q) => $q->where('language_id', $language->id)])
            ->orderByDesc('id')->get();
        $information['states'] = State::forLanguage($language->id)
            ->with(['contents' => fn($q) => $q->where('language_id', $language->id)])
            ->orderBy('id')->get();
        $information['cities'] = City::forLanguage($language->id)
            ->with(['contents' => fn($q) => $q->where('language_id', $language->id)])
            ->orderBy('id')->get();
        $information['cityCategoryCities'] = $information['cities']->map(fn($city) => [
            'id' => $city->id,
            'country_id' => $city->country_id,
            'state_id' => $city->state_id,
            'name' => $city->getName($language->id),
        ])->values();
        $information['categories'] = ListingCategory::active()
            ->with(['contents' => fn($q) => $q->where('language_id', $language->id)])
            ->orderBy('serial_number')->get();
        $information['items'] = ListingCityCategory::with(['contents.language', 'city.contents', 'city.country.contents', 'city.state.contents', 'category.contents'])
            ->orderByDesc('id')->get();

        return view('admin.listing.location.city-category.index', $information);
    }

    public function store(Request $request)
    {
        $langs = Language::all();
        $validator = Validator::make($request->all(), [
            'city_id' => ['required', 'exists:cities,id'],
            'listing_category_id' => ['required', 'exists:listing_categories,id'],
        ]);

        if ($validator->fails()) {
            return Response::json(['errors' => $validator->getMessageBag()], 400);
        }

        if (ListingCityCategory::where('city_id', $request->city_id)
            ->where('listing_category_id', $request->listing_category_id)->exists()) {
            return Response::json(['errors' => ['listing_category_id' => [__('This city and category combination already exists.')]]], 400);
        }

        $item = DB::transaction(function () use ($request, $langs) {
            $item = ListingCityCategory::create([
                'city_id' => $request->city_id,
                'listing_category_id' => $request->listing_category_id,
            ]);

            $this->saveContents($item, $request, $langs);

            return $item;
        });

        Session::flash('success', __('City category stored successfully') . '!');
        return Response::json(['status' => 'success', 'id' => $item->id]);
    }

    public function update(Request $request)
    {
        $langs = Language::all();
        $item = ListingCityCategory::findOrFail($request->id);
        $validator = Validator::make($request->all(), [
            'city_id' => ['required', 'exists:cities,id'],
            'listing_category_id' => [
                'required', 'exists:listing_categories,id',
                Rule::unique('listing_city_categories')->where(fn($q) => $q
                    ->where('city_id', $request->city_id)
                    ->where('listing_category_id', $request->listing_category_id)
                    ->where('id', '!=', $item->id)),
            ],
        ]);

        if ($validator->fails()) {
            return Response::json(['errors' => $validator->getMessageBag()], 400);
        }

        DB::transaction(function () use ($item, $request, $langs) {
            $item->update([
                'city_id' => $request->city_id,
                'listing_category_id' => $request->listing_category_id,
            ]);
            $this->saveContents($item, $request, $langs);
        });

        Session::flash('success', __('City category updated successfully') . '!');
        return Response::json(['status' => 'success']);
    }

    public function destroy($id)
    {
        ListingCityCategory::findOrFail($id)->delete();
        return redirect()->back()->with('success', __('City category deleted successfully') . '!');
    }

    public function bulkDestroy(Request $request)
    {
        ListingCityCategory::whereIn('id', (array) $request->ids)->delete();
        Session::flash('success', __('Selected city categories deleted successfully') . '!');
        return Response::json(['status' => 'success']);
    }

    private function saveContents(ListingCityCategory $item, Request $request, $langs): void
    {
        $item->load(['city', 'category']);
        $defaultLanguage = $langs->firstWhere('is_default', 1) ?? $langs->first();
        $defaultLanguageId = $defaultLanguage?->id;

        foreach ($langs as $lang) {
            $cityName = $item->city->getName($lang->id);
            $categoryName = $item->category->getName($lang->id);
            $requestedName = trim((string) $request->input($lang->code . '_name'));
            $generatedName = blank($cityName) || blank($categoryName)
                ? ''
                : trim($cityName . ' — ' . $categoryName);
            $name = $requestedName ?: $generatedName;
            $metaTitle = $request->input($lang->code . '_meta_title');
            $metaDescription = $request->input($lang->code . '_meta_description');
            $seoText = $request->input($lang->code . '_seo_text');

            if (blank($name) && blank($metaTitle) && blank($metaDescription) && blank($seoText)) {
                continue;
            }

            $name = $name ?: trim($item->city->getName($defaultLanguageId) . ' — ' . $item->category->getName($defaultLanguageId));
            $requestedSlug = $request->input($lang->code . '_slug');
            $content = $item->contents()->where('language_id', $lang->id)->first();
            $slug = $this->uniqueSlug(
                createSlug($requestedSlug ?: $name ?: 'city-category-' . $item->id . '-' . $lang->code),
                $lang->id,
                $content?->id
            );

            $item->contents()->updateOrCreate(
                ['language_id' => $lang->id],
                [
                    'name' => $name,
                    'slug' => $slug,
                    'meta_title' => $metaTitle,
                    'meta_description' => $metaDescription,
                    'seo_text' => $seoText,
                ]
            );
        }
    }

    private function uniqueSlug(string $base, int $languageId, ?int $ignoreId = null): string
    {
        $base = $base !== '' ? $base : 'city-category';
        $slug = $base;
        $suffix = 2;

        while (ListingCityCategoryContent::where('language_id', $languageId)
            ->where('slug', $slug)
            ->when($ignoreId, fn($q) => $q->where('id', '!=', $ignoreId))
            ->exists()) {
            $slug = $base . '-' . $suffix++;
        }

        return $slug;
    }
}
