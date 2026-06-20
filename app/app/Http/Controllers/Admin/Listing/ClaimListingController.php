<?php

namespace App\Http\Controllers\Admin\Listing;

use App;
use App\Http\Controllers\Controller;
use App\Models\ClaimListing;
use App\Models\Language;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use App\Http\Helpers\BasicMailer;
use App\Models\BasicSettings\Basic;
use App\Models\BasicSettings\MailTemplate;
use Illuminate\Support\Facades\File;

class ClaimListingController extends Controller
{

    public function index(Request $request)
    {
        $applange = App::getLocale();
        $langPart = explode('_', $applange);
        $language = Language::query()->where('code', '=', $langPart[1])->firstOrFail();

        $listingTitle = trim($request->input('listing_title', ''));
        $status = $request->input('status');

        $claimListings = ClaimListing::query()
            ->with([
                'listing',
                'listing.listing_content' => function ($q) use ($language) {
                    $q->where('language_id', $language->id)
                        ->select(['id', 'listing_id', 'language_id', 'title', 'slug'])
                        ->orderBy('id');
                },
                'user',
            ])
            ->when($status, fn($q) => $q->where('status', $status))
            ->when($listingTitle !== '', function ($q) use ($listingTitle, $language) {
                $q->whereHas('listing.listing_content', function ($qq) use ($listingTitle, $language) {
                    $qq->where('language_id', $language->id)
                        ->where('title', 'like', '%' . $listingTitle . '%');
                });
            })
            ->latest('id')
            ->paginate(20)
            ->appends([
                'status' => $status,
                'listing_title' => $listingTitle,
            ]);

        return view('admin.listing.claim-listing', compact('claimListings'));
    }

    public function details($id)
    {
        $claim = ClaimListing::with(['listing.listing_content', 'user', 'vendor'])
            ->findOrFail($id);

        // Decode the information JSON
        $information = $claim->information ? json_decode($claim->information, true) : [];

        return view('admin.listing.claim-details', compact('claim', 'information'));
    }


    public function updateStatus(Request $request, $id)
    {
        $claim = ClaimListing::findOrFail($id);

        $old = $claim->getOriginal('status');
        $claim->status = $request->input('status');

        if ($claim->status === 'approved') {

            $days = (int) Basic::where('uniqid', 12345)->value('redeem_token_expire_days') ?: 3;
            $rawToken = Str::uuid()->toString();
            $claim->redemption_token = hash('sha256', $rawToken);
            $claim->raw_redemption_token = $rawToken;
            $claim->redemption_expires_at = now()->addDays($days);
            $claim->approved_at = now();
            $claim->save();

            // redeem URL
            $redeemUrl = route('claims.redeem', ['claim' => $claim->id, 't' => $rawToken]);

            // load DB mail template for approval
            $tpl = MailTemplate::where('mail_type', 'claim_approved')->first();
            $subject = $tpl?->mail_subject ?? 'Your claim is approved';
            $body    = $tpl?->mail_body ?? 'Hi {user_name}, your claim is approved. {cta_link}';

            $userName     = $claim->user?->name ?? 'there';
            $listingTitle = optional($claim->listing->listing_content->first())->title ?? ('Listing #' . $claim->listing_id);
            $websiteTitle = Basic::value('website_title');
            $expiresAt    = optional($claim->redemption_expires_at)->format('d M Y, h:i A');
            $ctaLink      = '<p><a href="' . $redeemUrl . '" style="background:#4CAF50;color:#fff;padding:10px 16px;text-decoration:none;border-radius:4px;display:inline-block;">Complete Vendor Setup</a></p>';

            $replacements = [
                '{user_name}'     => e($userName),
                '{listing_title}' => e($listingTitle),
                '{website_title}' => e($websiteTitle),
                '{redeem_url}'    => $redeemUrl,
                '{cta_link}'      => $ctaLink,
                '{expires_at}'    => e($expiresAt),
                '{claim_id}'      => $claim->id,
                '{status}'        => 'approved',
            ];
            foreach ($replacements as $k => $v) {
                $body = str_replace($k, $v, $body);
            }

            BasicMailer::sendMail([
                'subject'   => $subject,
                'body'      => $body,
                'recipient' => $claim->customer_email,
            ]);
        } elseif ($claim->status === 'rejected' && $old !== 'rejected') {
            // save first
            $claim->redemption_token = null;
            $claim->redemption_expires_at = null;
            $claim->approved_at = null;
            $claim->save();

            // load DB mail template for rejection
            $tpl = MailTemplate::where('mail_type', 'claim_rejected')->first();
            $subject = $tpl?->mail_subject ?? 'Your claim was rejected';
            $body    = $tpl?->mail_body ?? 'Hi {user_name}, your claim for {listing_title} has been rejected.';

            $userName     = $claim->user?->name ?? 'there';
            $listingTitle = optional($claim->listing->listing_content->first())->title ?? ('Listing #' . $claim->listing_id);
            $websiteTitle = Basic::value('website_title');
            $reason       = $request->input('rejection_reason'); 

            $replacements = [
                '{user_name}'     => e($userName),
                '{listing_title}' => e($listingTitle),
                '{website_title}' => e($websiteTitle),
                '{reason}'        => e((string) $reason),
                '{claim_id}'      => $claim->id,
                '{status}'        => 'rejected',
            ];
            foreach ($replacements as $k => $v) {
                $body = str_replace($k, $v, $body);
            }

            BasicMailer::sendMail([
                'subject'   => $subject,
                'body'      => $body,
                'recipient' => $claim->customer_email,
            ]);
        } else {
            $claim->save();
        }

        return back()->with('success', __('Status updated'));
    }

    protected function getClaimFromRequest(Request $request): ClaimListing
    {
        $id = (int) $request->query('claim');
        $raw = (string) $request->query('t');

        $claim = ClaimListing::with('user', 'listing')->findOrFail($id);

        abort_if($claim->status !== 'approved', 403);
        abort_if(!$claim->redemption_expires_at || now()->greaterThan($claim->redemption_expires_at), 403);

        $valid = hash_equals($claim->redemption_token, hash('sha256', $raw));
        abort_unless($valid, 403);

        return $claim;
    }

    public function start(Request $request)
    {
        $claim = $this->getClaimFromRequest($request);
        // dd(!auth()->check() || auth()->id() !== $claim->user_id);

        // Only claimant can proceed
        // if (!auth()->check() || auth()->id() !== $claim->user_id) {

        //     $request->session()->put('claim.redeem', [
        //         'claim' => $request->query('claim'),
        //         't'     => $request->query('t'),
        //     ]);
        //     return redirect()->route('user.login'); 
        // }

        // No vendor yet: send to vendor signup, but persist redeem context
        $request->session()->put('claim.redeem', [
            'claim' => $request->query('claim'),
            't'     => $request->query('t'),
        ]);
        return redirect()->route('vendor.signup'); 
    }

    public function destroy($id)
    {
        try {
            $claim = ClaimListing::findOrFail($id);

            if ($claim->information) {
                $information = json_decode($claim->information, true);

                if (!empty($information)) {
                    foreach ($information as $fieldData) {
                        // Type 8 = File upload
                        if (isset($fieldData['type']) && $fieldData['type'] == 8) {
                            if (isset($fieldData['value'])) {
                                $filePath = public_path('assets/file/zip-files/' . $fieldData['value']);

                                if (File::exists($filePath)) {
                                    File::delete($filePath);
                                }
                            }
                        }
                    }
                }
            }

            $claim->delete();

            return redirect()->back()->with('success', __('Claim request deleted successfully') . '!');
        } catch (\Exception $e) {
            return redirect()->back()->with('error', __('Something went wrong') . '!');
        }
    }

    public function bulkDestroy(Request $request)
    {
        try {
            $ids = $request->ids;

            if (empty($ids)) {
                return response()->json([
                    'status' => 'error',
                    'message' => __('No items selected') . '!'
                ], 400);
            }

            $claims = ClaimListing::whereIn('id', $ids)->get();

            foreach ($claims as $claim) {

                if ($claim->information) {
                    $information = json_decode($claim->information, true);

                    if (!empty($information)) {
                        foreach ($information as $fieldData) {
                            // Type 8 = File upload
                            if (isset($fieldData['type']) && $fieldData['type'] == 8) {
                                if (isset($fieldData['value'])) {
                                    $filePath = public_path('assets/file/zip-files/' . $fieldData['value']);

                                    if (File::exists($filePath)) {
                                        File::delete($filePath);
                                    }
                                }
                            }
                        }
                    }
                }

                $claim->delete();
            }

            return response()->json([
                'status' => 'success',
                'message' => __('Claim requests deleted successfully') . '!'
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => __('Something went wrong') . '!'
            ], 500);
        }
    }
}
