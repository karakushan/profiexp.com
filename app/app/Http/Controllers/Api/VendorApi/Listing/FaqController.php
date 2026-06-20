<?php

namespace App\Http\Controllers\Api\VendorApi\Listing;

use App\Http\Controllers\Controller;
use App\Http\Helpers\VendorPermissionHelper;
use App\Models\Language;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingContent;
use App\Models\Listing\ListingFaq;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class FaqController extends Controller
{
    // --------------------------------------------------------------------------
    // Guard: verify listing belongs to authenticated vendor, package active, FAQ permission
    // --------------------------------------------------------------------------
    private function authoriseListing(int $listingId, Request $request): array
    {
        $listing = Listing::find($listingId);

        if (!$listing) {
            return ['error' => [__('Listing not found'), 404]];
        }

        if ((int) $listing->vendor_id !== (int) $request->user()->id) {
            return ['error' => [__('Unauthorised'), 403]];
        }

        $package = VendorPermissionHelper::packagePermission($listing->vendor_id);

        if ($package === '[]' || !$package) {
            return ['error' => [__('Please buy a plan to manage FAQs') . '!', 403]];
        }

        if (!faqPermission($listingId)) {
            return ['error' => [__('Your FAQ permission is not granted') . '!', 403]];
        }

        return ['listing' => $listing, 'package' => $package];
    }

    // --------------------------------------------------------------------------
    // GET /api/vendor/listings/{listing_id}/faqs
    // Query: language (code, optional – defaults to site default)
    // --------------------------------------------------------------------------
    public function index(Request $request, int $listingId)
    {
        $auth = $this->authoriseListing($listingId, $request);
        if (isset($auth['error'])) {
            [$msg, $code] = $auth['error'];
            return response()->json(['error' => $msg], $code);
        }

        $language = $request->filled('language')
            ? Language::where('code', $request->language)->first()
            : Language::where('is_default', 1)->first();

        if (!$language) {
            return response()->json(['error' => __('Language not found')], 404);
        }

        $faqs = ListingFaq::where('listing_id', $listingId)
            ->where('language_id', $language->id)
            ->orderBy('serial_number')
            ->get();

        $content = ListingContent::where('listing_id', $listingId)
            ->where('language_id', $language->id)
            ->select('title', 'slug')
            ->first();

        $faqLimit = packageTotalFaqs($listingId);

        $languages = Language::select('id', 'name', 'code', 'direction', 'is_default')
            ->orderBy('is_default', 'desc')
            ->get();

        return response()->json([
            'success'    => true,
            'language'   => $language,
            'languages'  => $languages,
            'listing'    => $content,
            'faqs'       => $faqs,
            'faq_limit'  => $faqLimit,
            'faq_count'  => $faqs->count(),
            'can_add'    => $faqs->count() < $faqLimit,
        ], 200);
    }

    // --------------------------------------------------------------------------
    // POST /api/vendor/listings/{listing_id}/faqs/store
    // Body: language_id, question, answer, serial_number
    // --------------------------------------------------------------------------
    public function store(Request $request, int $listingId)
    {
        $auth = $this->authoriseListing($listingId, $request);
        if (isset($auth['error'])) {
            [$msg, $code] = $auth['error'];
            return response()->json(['error' => $msg], $code);
        }

        $rules = [
            'language_id'   => 'required|exists:languages,id',
            'question'      => 'required',
            'answer'        => 'required',
            'serial_number' => 'required|integer',
        ];

        $validator = Validator::make($request->all(), $rules, [
            'language_id.required' => __('The language field is required.'),
            'language_id.exists'   => __('The selected language is invalid.'),
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $totalFaq = ListingFaq::where('listing_id', $listingId)
            ->where('language_id', $request->language_id)
            ->count();

        $limit = packageTotalFaqs($listingId);

        if ($totalFaq >= $limit) {
            return response()->json([
                'error' => __('You can add only :limit FAQs.', ['limit' => $limit]),
            ], 422);
        }

        $faq = ListingFaq::create([
            'listing_id'    => $listingId,
            'language_id'   => $request->language_id,
            'question'      => $request->question,
            'answer'        => $request->answer,
            'serial_number' => $request->serial_number,
        ]);

        return response()->json([
            'success' => true,
            'message' => __('New FAQ added successfully') . '!',
            'faq'     => $faq,
        ], 201);
    }

    // --------------------------------------------------------------------------
    // POST /api/vendor/listings/{listing_id}/faqs/{faq_id}/update
    // Body: question, answer, serial_number
    // --------------------------------------------------------------------------
    public function update(Request $request, int $listingId, int $faqId)
    {
        $auth = $this->authoriseListing($listingId, $request);
        if (isset($auth['error'])) {
            [$msg, $code] = $auth['error'];
            return response()->json(['error' => $msg], $code);
        }

        $faq = ListingFaq::where('id', $faqId)->where('listing_id', $listingId)->first();

        if (!$faq) {
            return response()->json(['error' => __('FAQ not found')], 404);
        }

        $rules = [
            'question'      => 'required',
            'answer'        => 'required',
            'serial_number' => 'required|integer',
        ];

        $validator = Validator::make($request->all(), $rules);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $faq->update([
            'question'      => $request->question,
            'answer'        => $request->answer,
            'serial_number' => $request->serial_number,
        ]);

        return response()->json([
            'success' => true,
            'message' => __('FAQ updated successfully') . '!',
            'faq'     => $faq->fresh(),
        ], 200);
    }

    // --------------------------------------------------------------------------
    // POST /api/vendor/listings/{listing_id}/faqs/{faq_id}/delete
    // --------------------------------------------------------------------------
    public function destroy(Request $request, int $listingId, int $faqId)
    {
        $auth = $this->authoriseListing($listingId, $request);
        if (isset($auth['error'])) {
            [$msg, $code] = $auth['error'];
            return response()->json(['error' => $msg], $code);
        }

        $faq = ListingFaq::where('id', $faqId)->where('listing_id', $listingId)->first();

        if (!$faq) {
            return response()->json(['error' => __('FAQ not found')], 404);
        }

        $faq->delete();

        return response()->json([
            'success' => true,
            'message' => __('FAQ deleted successfully') . '!',
        ], 200);
    }

    // --------------------------------------------------------------------------
    // POST /api/vendor/listings/{listing_id}/faqs/bulk-delete
    // Body: ids[] (array of FAQ ids belonging to this listing)
    // --------------------------------------------------------------------------
    public function bulkDestroy(Request $request, int $listingId)
    {
        $auth = $this->authoriseListing($listingId, $request);
        if (isset($auth['error'])) {
            [$msg, $code] = $auth['error'];
            return response()->json(['error' => $msg], $code);
        }

        $validator = Validator::make($request->all(), [
            'ids'   => 'required|array|min:1',
            'ids.*' => 'integer',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $deleted = ListingFaq::where('listing_id', $listingId)
            ->whereIn('id', $request->ids)
            ->delete();

        return response()->json([
            'success' => true,
            'message' => __('FAQs deleted successfully') . '!',
            'deleted' => $deleted,
        ], 200);
    }
}
