<?php

namespace App\Http\Controllers\Vendor;

use App;
use App\Http\Controllers\Controller;
use App\Models\Language;
use Illuminate\Http\Request;
use App\Models\Listing\ListingMessage;
use App\Models\Listing\ProductMessage;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;

class MessageController extends Controller
{
    public function index(Request $request)
    {
        $information['langs'] = Language::all();

        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['language'] = $language;

        $vendor_id = Auth::guard('vendor')->user()->id;
        $permissions = listingMessagePermission($vendor_id);
        if ($permissions) {
            $information['messages'] = ListingMessage::where('vendor_id', Auth::guard('vendor')->user()->id)
                ->orderBy('id', 'desc')
                ->paginate(10);
            return view('vendors.message.listing', $information);
        } else {
            Session::flash('warning', "Your Listing message Permission is not granted.");
            Session::flash('success', __('Faviconupdatedsuccessfully') . '!');
            return redirect()->route('vendor.dashboard');
        }
    }
    public function delete(Request $request)
    {
        $message = ListingMessage::findOrFail($request->message_id);

        $message->delete();
        Session::flash('success', 'Message deleted successfully!');
        Session::flash('success', __('Faviconupdatedsuccessfully') . '!');
        return redirect()->back();
    }
    public function bulkDelete(Request $request)
    {
        $ids = $request->ids;

        foreach ($ids as $id) {
            $message = ListingMessage::findOrFail($id);

            $message->delete();
        }

        Session::flash('success', 'Message deleted successfully!');
        Session::flash('success', __('Faviconupdatedsuccessfully') . '!');

        return response()->json(['status' => 'success'], 200);
    }

    public function productIndex(Request $request)
    {
        $information['langs'] = Language::all();

        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['language'] = $language;
        $vendor_id = Auth::guard('vendor')->user()->id;
        $permissions = productMessagePermission($vendor_id);

        if ($permissions) {

            $information['messages'] = ProductMessage::with(['product.content' => function ($query) use ($language) {
                $query->where('language_id', $language->id);
            }])
                ->where('vendor_id', $vendor_id)
                ->orderBy('id', 'desc')
                ->paginate(10);

            return view('vendors.message.product', $information);
        } else {
            Session::flash('warning', "Your Product message Permission is not granted.");
            return redirect()->route('vendor.dashboard');
        }
    }

    public function productDelete(Request $request)
    {
        try {
            $message = ProductMessage::where('vendor_id', Auth::guard('vendor')->id())
                ->findOrFail($request->message_id);


            // Delete associated ZIP file if present
            if (!empty($message->message)) {
                $data = json_decode($message->message, true);
                if (!empty($data) && is_array($data)) {
                    foreach ($data as $field) {
                        if (isset($field['type']) && $field['type'] == 8 && isset($field['value'])) {
                            $localPath = public_path('./assets/file/zip-files/' . $field['value']);
                            if (file_exists($localPath)) {
                                @unlink($localPath);
                            }
                        }
                    }
                }
            }

            $message->delete();
            Session::flash('success', __('Message deleted successfully!'));
        } catch (\Exception $e) {
            Session::flash('error', __('Could not delete message.'));
        }
        return redirect()->back();
    }


    // Bulk Delete
    public function productBulkDelete(Request $request)
    {
        $ids = (array) $request->ids;
        $vendorId = Auth::guard('vendor')->id();
        $deletedCount = 0;

        foreach ($ids as $id) {
            $message = ProductMessage::where('vendor_id', $vendorId)->find($id);
            if ($message) {
                // Delete associated ZIP files
                if (!empty($message->message)) {
                    $data = json_decode($message->message, true);
                    if (!empty($data) && is_array($data)) {
                        foreach ($data as $field) {
                            if (isset($field['type']) && $field['type'] == 8 && isset($field['value'])) {
                                $localPath = public_path('./assets/file/zip-files/' . $field['value']);
                                if (file_exists($localPath)) {
                                    @unlink($localPath);
                                }
                            }
                        }
                    }
                }
                $message->delete();
                $deletedCount++;
            }
        }

        $msg = $deletedCount > 0
            ? __('Message deleted successfully!')
            : __('No messages found or deleted!');
        Session::flash('success', $msg);

        return response()->json(['status' => 'success', 'deleted' => $deletedCount], 200);
    }

    public function showMessageDetails($id)
    {

        $vendor_id = Auth::guard('vendor')->user()->id;

        $message = ProductMessage::where('vendor_id', $vendor_id)
            ->findOrFail($id);

        $applange = App::getLocale();
        $langPart = explode('_', $applange);
        $language = Language::query()->where('code', '=', $langPart[1])->firstOrFail();

        return view('vendors.message.details', compact('message', 'language'));
    }
}
