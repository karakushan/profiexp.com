<?php

namespace App\Http\Controllers\Api\VendorApi;

use App\Http\Controllers\Controller;
use App\Models\Language;
use App\Models\Listing\ListingMessage;
use App\Models\Listing\ProductMessage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MessageController extends Controller
{
    // GET /api/vendor/messages/listing
    public function index(Request $request)
    {
        $vendor_id = $request->user()->id;

        if (!listingMessagePermission($vendor_id)) {
            return response()->json(['error' => __('Your Listing message Permission is not granted.')], 403);
        }

        $langId = Language::where('is_default', 1)->value('id') ?? 1;

        $messages = DB::table('listing_messages')
            ->leftJoin('listing_contents', function ($join) use ($langId) {
                $join->on('listing_messages.listing_id', '=', 'listing_contents.listing_id')
                    ->where('listing_contents.language_id', '=', $langId);
            })
            ->where('listing_messages.vendor_id', $vendor_id)
            ->select(
                'listing_messages.id',
                'listing_messages.name',
                'listing_messages.email',
                'listing_messages.phone',
                'listing_messages.message',
                'listing_messages.created_at',
                'listing_contents.title as listing_title'
            )
            ->orderBy('listing_messages.id', 'desc')
            ->paginate(10);

        return response()->json(['success' => true, 'data' => $messages], 200);
    }

    // POST /api/vendor/messages/listing/{id}/delete
    public function delete(Request $request, $id)
    {
        $message = ListingMessage::where('vendor_id', $request->user()->id)->find($id);

        if (!$message) {
            return response()->json(['error' => __('Message not found.')], 404);
        }

        $message->delete();

        return response()->json(['success' => true, 'message' => __('Message deleted successfully!')], 200);
    }

    // POST /api/vendor/messages/listing/bulk-delete
    public function bulkDelete(Request $request)
    {
        $ids = (array) $request->ids;
        $vendor_id = $request->user()->id;

        ListingMessage::where('vendor_id', $vendor_id)->whereIn('id', $ids)->delete();

        return response()->json(['success' => true, 'message' => __('Message deleted successfully!')], 200);
    }

    // GET /api/vendor/messages/product
    public function productIndex(Request $request)
    {
        $vendor_id = $request->user()->id;

        if (!productMessagePermission($vendor_id)) {
            return response()->json(['error' => __('Your Product message Permission is not granted.')], 403);
        }

        $langId = Language::where('is_default', 1)->value('id') ?? 1;

        $messages = DB::table('product_messages')
            ->leftJoin('products', 'product_messages.product_id', '=', 'products.id')
            ->leftJoin('product_contents', function ($join) use ($langId) {
                $join->on('product_messages.product_id', '=', 'product_contents.product_id')
                    ->where('product_contents.language_id', '=', $langId);
            })
            ->leftJoin('listing_contents', function ($join) use ($langId) {
                $join->on('products.listing_id', '=', 'listing_contents.listing_id')
                    ->where('listing_contents.language_id', '=', $langId);
            })
            ->where('product_messages.vendor_id', $vendor_id)
            ->select(
                'product_messages.id',
                'product_messages.name',
                'product_messages.email',
                'product_messages.message',
                'product_messages.created_at',
                'product_contents.title as product_title',
                'listing_contents.title as listing_title'
            )
            ->orderBy('product_messages.id', 'desc')
            ->paginate(10);

        return response()->json(['success' => true, 'data' => $messages], 200);
    }

    // GET /api/vendor/messages/product/{id}
    public function showMessageDetails(Request $request, $id)
    {
        $vendor_id = $request->user()->id;
        $langId = Language::where('is_default', 1)->value('id') ?? 1;

        $message = DB::table('product_messages')
            ->leftJoin('products', 'product_messages.product_id', '=', 'products.id')
            ->leftJoin('product_contents', function ($join) use ($langId) {
                $join->on('product_messages.product_id', '=', 'product_contents.product_id')
                    ->where('product_contents.language_id', '=', $langId);
            })
            ->leftJoin('listing_contents', function ($join) use ($langId) {
                $join->on('products.listing_id', '=', 'listing_contents.listing_id')
                    ->where('listing_contents.language_id', '=', $langId);
            })
            ->where('product_messages.vendor_id', $vendor_id)
            ->where('product_messages.id', $id)
            ->select(
                'product_messages.id',
                'product_messages.name',
                'product_messages.email',
                'product_messages.message',
                'product_messages.created_at',
                'product_contents.title as product_title',
                'listing_contents.title as listing_title'
            )
            ->first();

        if (!$message) {
            return response()->json(['error' => __('Message not found.')], 404);
        }

        // Decode message JSON into labelled fields
        $fields  = [];
        $fileUrl = null;

        if (!empty($message->message)) {
            $data = json_decode($message->message, true);
            if (is_array($data)) {
                foreach ($data as $field) {
                    if (isset($field['type']) && $field['type'] == 8) {
                        $fileUrl = !empty($field['value'])
                            ? url('assets/file/zip-files/' . $field['value'])
                            : null;
                    } else {
                        $fields[] = [
                            'label' => $field['label'] ?? '',
                            'value' => (string) ($field['value'] ?? ''),
                        ];
                    }
                }
            }
        }

        return response()->json([
            'success' => true,
            'data'    => [
                'id'            => $message->id,
                'name'          => $message->name,
                'email'         => $message->email,
                'product_title' => $message->product_title ?? '',
                'listing_title' => $message->listing_title ?? '',
                'created_at'    => $message->created_at,
                'fields'        => $fields,
                'file_url'      => $fileUrl,
            ],
        ], 200);
    }

    // POST /api/vendor/messages/product/{id}/delete
    public function productDelete(Request $request, $id)
    {
        $message = ProductMessage::where('vendor_id', $request->user()->id)->find($id);

        if (!$message) {
            return response()->json(['error' => __('Message not found.')], 404);
        }

        $this->deleteZipFiles($message);
        $message->delete();

        return response()->json(['success' => true, 'message' => __('Message deleted successfully!')], 200);
    }

    // POST /api/vendor/messages/product/bulk-delete
    public function productBulkDelete(Request $request)
    {
        $ids = (array) $request->ids;
        $vendor_id = $request->user()->id;

        $messages = ProductMessage::where('vendor_id', $vendor_id)->whereIn('id', $ids)->get();

        foreach ($messages as $message) {
            $this->deleteZipFiles($message);
            $message->delete();
        }

        return response()->json([
            'success' => true,
            'message' => __('Message deleted successfully!'),
            'deleted' => $messages->count(),
        ], 200);
    }

    private function deleteZipFiles($message)
    {
        if (!empty($message->message)) {
            $data = json_decode($message->message, true);
            if (!empty($data) && is_array($data)) {
                foreach ($data as $field) {
                    if (isset($field['type']) && $field['type'] == 8 && isset($field['value'])) {
                        $localPath = public_path('assets/file/zip-files/' . $field['value']);
                        if (file_exists($localPath)) {
                            @unlink($localPath);
                        }
                    }
                }
            }
        }
    }
}
