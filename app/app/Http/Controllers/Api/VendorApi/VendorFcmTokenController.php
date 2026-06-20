<?php

namespace App\Http\Controllers\Api\VendorApi;

use App\Http\Controllers\Controller;
use App\Models\VendorDevice;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class VendorFcmTokenController extends Controller
{
        private function authVendor(Request $request)
    {
        return $request->user('sanctum') ?? Auth::guard('vendor')->user();
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'fcm_token' => 'required|string',
            'device_type' => 'nullable|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'validation_error',
                'errors' => $validator->errors()
            ], 422);
        }

        $vendor = $this->authVendor($request);

        if (!$vendor) {
            return response()->json([
                'status' => 'error',
                'message' => 'Unauthorized'
            ], 401);
        }

        VendorDevice::updateOrCreate(
            ['fcm_token' => $request->fcm_token],
            [
                'vendor_id' => $vendor->id,
                'device_type' => $request->device_type ?? 'android',
                'last_seen_at' => now(),
            ]
        );

        return response()->json([
            'status' => 'success',
            'message' => 'Vendor FCM token saved'
        ]);
    }
}
