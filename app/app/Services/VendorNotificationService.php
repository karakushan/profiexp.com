<?php

namespace App\Services;

use App\Models\VendorDevice;
use App\Models\VendorNotification;
use App\Services\FirebaseService;
use Illuminate\Support\Facades\Log;

class VendorNotificationService
{
    public static function send($vendor, $type, $title, $message, array $data = [])
    {
        if (empty($vendor) || empty($vendor->id)) {
            return null;
        }

        try {
            $data = self::normalizeData($data);

            $notification = VendorNotification::create([
                'vendor_id' => $vendor->id,
                'type' => $type,
                'title' => $title,
                'message' => $message,
                'data' => $data,
                'is_read' => false,
            ]);

            $payload = array_merge($data, [
                'type' => (string) $type,
                'notification_id' => (string) $notification->id,
                'vendor_id' => (string) $vendor->id,
            ]);

            $devices = VendorDevice::query()
                ->where('vendor_id', $vendor->id)
                ->whereNotNull('fcm_token')
                ->distinct()
                ->get(['fcm_token']);

            foreach ($devices as $device) {
                FirebaseService::sendToToken(
                    $title,
                    $message,
                    $device->fcm_token,
                    $payload
                );
            }

            return $notification;
        } catch (\Throwable $e) {
            Log::error('Failed to store vendor notification.', [
                'vendor_id' => $vendor->id ?? null,
                'type' => $type,
                'title' => $title,
                'data' => $data,
                'error' => $e->getMessage(),
            ]);

            return null;
        }
    }

    private static function normalizeData(array $data): array
    {
        $normalized = [];

        foreach ($data as $key => $value) {
            if ($value === null) {
                continue;
            }

            if (is_bool($value)) {
                $normalized[$key] = $value ? '1' : '0';
                continue;
            }

            if (is_scalar($value)) {
                $normalized[$key] = (string) $value;
                continue;
            }

            $json = json_encode($value);
            if ($json !== false) {
                $normalized[$key] = $json;
            }
        }

        return $normalized;
    }
}
