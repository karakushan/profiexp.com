<?php

namespace App\Http\Controllers\Admin\FeaturedListing;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\FeaturedListingCharge;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Session;

class ChargeController extends Controller
{
    public function index(Request $request)
    {

        $information['charges'] = FeaturedListingCharge::all();

        return view('admin.featured-listing.charge.index', $information); 
    }
    public function store(Request $request)
    {
        $rules = [
            'price' => 'required',
            'days' => 'required',
        ];

        $message = [
            'price.required' => 'The price field is required.',
            'days.required' => 'The days field is required.'
        ];

        $validator = Validator::make($request->all(), $rules, $message);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()
            ], 400);
        }
        FeaturedListingCharge::query()->create($request->except('language'));

        Session::flash('success', __('Charge stored successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }
    public function update(Request $request)
    {
        $rules = [
            'price' => 'required',
            'days' => 'required',
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return Response::json([
                'errors' => $validator->getMessageBag()
            ], 400);
        }

        $chargeInfo = FeaturedListingCharge::query()->find($request->id);

        $chargeInfo->update([
            'price' => $request->price,
            'days' => $request->days,
        ]);

        Session::flash('success', __('Charge updated successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }
    public function destroy($id)
    {

        $charge = FeaturedListingCharge::query()->find($id);

        $charge->delete();

        return redirect()->back()->with('success', __('Charge deleted successfully') . '!');
    }
    public function bulkDestroy(Request $request)
    {
        $ids = $request['ids'];

        foreach ($ids as $id) {
            $charge = FeaturedListingCharge::query()->find($id);

            $charge->delete();
        }

        Session::flash('success', __('Selected Informations deleted successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }
}
