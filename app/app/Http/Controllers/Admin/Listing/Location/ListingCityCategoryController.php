<?php

namespace App\Http\Controllers\Admin\Listing\Location;

use App\Http\Controllers\Controller;
use App\Models\Language;
use App\Models\ListingCategory;
use App\Models\Location\City;
use App\Models\Location\Country;
use App\Models\Location\ListingCityCategory;
use App\Models\Location\State;
use App\Services\ListingCityCategoryContentService;
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
        $categories = ListingCategory::active()
            ->with(['contents' => fn($q) => $q->where('language_id', $language->id)])
            ->orderBy('serial_number')->get();
        $information['categoryOptions'] = $this->flattenCategoryOptions($categories, $language->id);
        $information['items'] = ListingCityCategory::with(['contents.language', 'city.contents', 'city.country.contents', 'city.state.contents', 'category.contents'])
            ->orderByDesc('id')->get();

        return view('admin.listing.location.city-category.index', $information);
    }

    private function flattenCategoryOptions($categories, int $languageId, ?int $parentId = null, int $level = 0): array
    {
        $options = [];

        foreach ($categories->where('parent_id', $parentId)->sortBy('serial_number') as $category) {
            $content = $category->contents->firstWhere('language_id', $languageId);
            $options[] = [
                'id' => $category->id,
                'name' => $content?->name ?: $category->name,
                'level' => $level,
            ];
            $options = array_merge(
                $options,
                $this->flattenCategoryOptions($categories, $languageId, $category->id, $level + 1)
            );
        }

        return $options;
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
        app(ListingCityCategoryContentService::class)->saveFromRequest($item, $request, collect($langs));
    }
}
