<?php

namespace App\Http\Controllers\Admin\Listing;

use App\Http\Controllers\Controller;
use App\Models\Language;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Validator;
use App\Models\Aminite;
use App\Models\Listing\ListingContent;
use Illuminate\Support\Facades\Session;
use Illuminate\Validation\Rule;

class AminiteController extends Controller
{
    public function index(Request $request)
    {
        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['aminites'] = $language->aminiteInfo()->orderByDesc('id')->get();
        $information['langs'] = Language::all();

        return view('admin.amenitie.index', $information);
    }

    public function store(Request $request)
    {
        $rules = [
            'language_id' => 'required',
            'icon' => 'required',
            'title' => [
                'required',
                Rule::unique('aminites')->where(function ($query) use ($request) {
                    return $query->where('language_id', $request->input('language_id'));
                }),
                'max:255',
            ],
        ];

        $message = [
            'language_id.required' => __('The language field is required.')
        ];

        $validator = Validator::make($request->all(), $rules, $message);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()
            ], 400);
        }
        Aminite::query()->create($request->except('language'));

        Session::flash('success', __('Aminite stored successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }

    public function update(Request $request)
    {
        $rules = [
            'title' => [
                'required',
                Rule::unique('aminites')->where(function ($query) use ($request) {
                    return $query->where('language_id', $request->input('language_id'));
                })->ignore($request->id, 'id'),
                'max:255',
            ],
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()
            ], 400);
        }

        $aminiteInfo = Aminite::query()->find($request->id);

        $aminiteInfo->update($request->except('language'));

        Session::flash('success', __('Aminite updated successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }

    public function destroy($id)
    {

        $listing = ListingContent::select('aminities')->get();
        $data = json_decode($listing, true);
        $found = false;

        foreach ($data as $item) {

            $aminities = json_decode($item['aminities']);

            if (in_array($id, $aminities)) {
                $found = true;
                break;
            }
        }
        if ($found) {
            return redirect()->back()->with('warning', __('First delete all the listing of this Amenitie') . '!');
        } else {
            $aminiteInfo = Aminite::query()->find($id);
            $aminiteInfo->delete();
            return redirect()->back()->with('success', __('Aminite deleted successfully') . '!');
        }
    }

    public function bulkDestroy(Request $request)
    {
        $ids = $request['ids'];

        $listing = ListingContent::select('aminities')->get();
        $data = json_decode($listing, true);
        $found = false;
        $errorOccurred = false;

        foreach ($ids as $id) {
            $found = false;

            foreach ($data as $item) {

                $aminities = json_decode($item['aminities']);
                if (in_array($id, $aminities)) {
                    $found = true;
                    break;
                }
            }
            if ($found) {
                $errorOccurred = true;
                break;
            } else {
                $aminiteInfo = Aminite::query()->find($id);
                $aminiteInfo->delete();
            }
        }
        if ($errorOccurred == true) {
            Session::flash('warning', __('First delete all the listing of these Amenities') . '!');
        } else {
            Session::flash('success', __('Selected Informations deleted successfully') . '!');
        }
        return Response::json(['status' => 'success'], 200);
    }
}
