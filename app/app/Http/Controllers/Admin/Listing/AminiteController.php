<?php

namespace App\Http\Controllers\Admin\Listing;

use App\Http\Controllers\Controller;
use App\Models\Aminite;
use App\Models\AminiteContent;
use App\Models\Language;
use App\Models\Listing\ListingContent;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;

class AminiteController extends Controller
{
    public function index(Request $request)
    {
        $information['aminites'] = Aminite::with('contents.language')
            ->orderByDesc('id')
            ->paginate(20);

        $information['langs'] = Language::all();

        return view('admin.amenitie.index', $information);
    }

    public function store(Request $request)
    {
        $langs = Language::all();
        $defaultLang = Language::where('is_default', 1)->first() ?? Language::first();

        $rules = [
            'icon' => 'required',
        ];

        foreach ($langs as $lang) {
            $rules[$lang->code . '_title'] = ($lang->code === $defaultLang->code ? 'required|max:255' : 'nullable|max:255');
        }

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()
            ], 400);
        }

        $aminite = Aminite::create($request->only('icon'));

        foreach ($langs as $lang) {
            $title = $request->{$lang->code . '_title'};
            if (empty($title)) {
                continue;
            }

            AminiteContent::create([
                'aminite_id' => $aminite->id,
                'language_id' => $lang->id,
                'title' => $title,
            ]);
        }

        Session::flash('success', __('Aminite stored successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }

    public function update(Request $request)
    {
        $langs = Language::all();
        $defaultLang = Language::where('is_default', 1)->first() ?? Language::first();

        $rules = [
            'icon' => 'required',
        ];

        foreach ($langs as $lang) {
            $rules[$lang->code . '_title'] = ($lang->code === $defaultLang->code ? 'required|max:255' : 'nullable|max:255');
        }

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()
            ], 400);
        }

        $aminite = Aminite::findOrFail($request->id);

        $aminite->update($request->only('icon'));

        foreach ($langs as $lang) {
            $title = $request->{$lang->code . '_title'};
            if (empty($title)) {
                continue;
            }

            AminiteContent::updateOrCreate(
                [
                    'aminite_id' => $aminite->id,
                    'language_id' => $lang->id,
                ],
                [
                    'title' => $title,
                ]
            );
        }

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
        }

        $aminite = Aminite::findOrFail($id);
        $aminite->delete();

        return redirect()->back()->with('success', __('Aminite deleted successfully') . '!');
    }

    public function bulkDestroy(Request $request)
    {
        $ids = $request['ids'];

        $listing = ListingContent::select('aminities')->get();
        $data = json_decode($listing, true);
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
            }
            $aminite = Aminite::find($id);
            if ($aminite) {
                $aminite->delete();
            }
        }

        if ($errorOccurred) {
            Session::flash('warning', __('First delete all the listing of these Amenities') . '!');
        } else {
            Session::flash('success', __('Selected Informations deleted successfully') . '!');
        }

        return Response::json(['status' => 'success'], 200);
    }
}
