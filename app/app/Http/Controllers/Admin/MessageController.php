<?php

namespace App\Http\Controllers\Admin;

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
        $information['messages'] = ListingMessage::orderBy('id', 'desc')
            ->paginate(10);
        return view('admin.message.listing', $information);
    }

    public function productIndex(Request $request)
    {
        $information['langs'] = Language::all();

        $language = Language::query()->where('code', '=', $request->language)->firstOrFail();
        $information['language'] = $language;

        $information['messages'] = ProductMessage::with(['product.content' => function ($query) use ($language) {
            $query->where('language_id', $language->id);
        }])
            ->orderBy('id', 'desc')
            ->paginate(10);

        return view('admin.message.product', $information);
    }

    public function delete(Request $request)
    {
        $message = ListingMessage::findOrFail($request->message_id);

        $message->delete();
        Session::flash('success', __('Message deleted successfully') . '!');
        return redirect()->back();
    }

    public function productDelete(Request $request)
    {
        $message = ProductMessage::findOrFail($request->message_id);

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
        Session::flash('success', __('Message deleted successfully') . '!');
        return redirect()->back();
    }

    public function bulkDelete(Request $request)
    {
        $ids = $request->ids;

        foreach ($ids as $id) {
            $message = ListingMessage::findOrFail($id);

            $message->delete();
        }

        Session::flash('success', __('Message deleted successfully') . '!');

        return response()->json(['status' => 'success'], 200);
    }

    public function productBulkDelete(Request $request)
    {
        $ids = (array) $request->ids;
        $deletedCount = 0;
        foreach ($ids as $id) {
            $message = ProductMessage::findOrFail($id);
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

        Session::flash('success', __('Message deleted successfully') . '!');
        return response()->json(['status' => 'success'], 200);
    }

    public function showMessageDetails($id)
    {

        $message = ProductMessage::findOrFail($id);
        $applange = App::getLocale();
        $langPart = explode('_', $applange);
        $language = Language::query()->where('code', '=', $langPart[1])->firstOrFail();

        return view('admin.message.details', compact('message', 'language'));
    }
}
