<?php

namespace App\Http\Controllers\Vendor\Shop;

use App\Http\Controllers\Controller;
use App\Http\Requests\Shop\CouponStoreRequest;
use App\Http\Requests\Shop\CouponUpdateRequest;
use App\Models\Shop\Coupon;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;

class CouponController extends Controller
{
    public function index()
    {
        $vendorId = Auth::guard('vendor')->user()->id;
        // get the coupons from db
        $information['coupons'] = Coupon::where('vendor_id', $vendorId)->orderByDesc('id')->get();

        // also, get the currency information from db
        $information['currencyInfo'] = $this->getCurrencyInfo();

        return view('vendors.shop.coupon.index', $information);
    }

    public function store(CouponStoreRequest $request)
    {
        $startDate = Carbon::parse($request->start_date);
        $endDate = Carbon::parse($request->end_date);

        Coupon::create($request->except('start_date', 'end_date') + [
            'start_date' => date_format($startDate, 'Y-m-d'),
            'end_date' => date_format($endDate, 'Y-m-d'),
            'vendor_id' => Auth::guard('vendor')->user()->id,
        ]);

        Session::flash('success', __('New coupon added successfully') . '!');

        return response()->json(['status' => 'success'], 200);
    }

    public function update(CouponUpdateRequest $request)
    {
        $startDate = Carbon::parse($request->start_date);
        $endDate = Carbon::parse($request->end_date);

        Coupon::find($request->id)->update($request->except('start_date', 'end_date') + [
            'start_date' => date_format($startDate, 'Y-m-d'),
            'end_date' => date_format($endDate, 'Y-m-d'),
            'vendor_id' => Auth::guard('vendor')->user()->id,
        ]);

        Session::flash('success', __('Coupon updated successfully') . '!');

        return response()->json(['status' => 'success'], 200);
    }

    public function destroy($id)
    {
        Coupon::find($id)->delete();

        return redirect()->back()->with('success', __('Coupon deleted successfully') . '!');
    }
}
