<?php

namespace App\Http\Controllers\Api\VendorApi;

use App\Http\Controllers\Controller;
use App\Models\VendorNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class VendorNotificationController extends Controller
{
        private function authVendor(Request $request)
    {
        return $request->user('sanctum') ?? Auth::guard('vendor')->user();
    }

    public function index(Request $request)
    {
        $vendor = $this->authVendor($request);

        if (!$vendor) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized'
            ], 401);
        }

        $perPage = (int) $request->input('per_page', 15);
        $perPage = $perPage > 0 ? min($perPage, 50) : 15;

        $notifications = VendorNotification::query()
            ->where('vendor_id', $vendor->id)
            ->latest()
            ->paginate($perPage);

        return response()->json([
            'success' => true,
            'data' => $notifications,
            'meta' => [
                'unread_count' => VendorNotification::where('vendor_id', $vendor->id)
                    ->where('is_read', false)
                    ->count(),
            ]
        ]);
    }

    public function markAsRead(Request $request, $id)
    {
        $vendor = $this->authVendor($request);

        if (!$vendor) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized'
            ], 401);
        }

        $notification = VendorNotification::query()
            ->where('vendor_id', $vendor->id)
            ->findOrFail($id);

        if (!$notification->is_read) {
            $notification->update([
                'is_read' => true,
                'read_at' => now(),
            ]);
        }

        return response()->json([
            'success' => true,
            'message' => 'Notification marked as read',
            'data' => $notification->fresh()
        ]);
    }

    public function destroy(Request $request, $id)
    {
        $vendor = $this->authVendor($request);

        if (!$vendor) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized'
            ], 401);
        }

        $notification = VendorNotification::query()
            ->where('vendor_id', $vendor->id)
            ->findOrFail($id);

        $notification->delete();

        return response()->json([
            'success' => true,
            'message' => 'Notification deleted successfully'
        ]);
    }
}
