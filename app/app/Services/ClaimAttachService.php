<?php

namespace App\Services;

use App\Models\ClaimListing;
use App\Models\Listing\Listing;
use Illuminate\Support\Facades\DB;

class ClaimAttachService
{
  public function attachFromSession(int $vendorId, ?array $context): bool
  {
    if (!$context || empty($context['claim']) || empty($context['t'])) return false;

    $claimId = (int) $context['claim'];
    $raw = (string) $context['t'];

    $claim = ClaimListing::with('user')->find($claimId);
    if (!$claim) return false;

    // Verify claim is still valid
    if ($claim->status !== 'approved') return false;
    if (!$claim->redemption_expires_at || now()->greaterThan($claim->redemption_expires_at)) return false;
    if (!hash_equals($claim->redemption_token, hash('sha256', $raw))) return false;

    // Atomic re-assignment
    return DB::transaction(function () use ($claim, $vendorId) {
      // Lock listing row to avoid race conditions
      $listing = Listing::lockForUpdate()->find($claim->listing_id);
    
      if (!$listing) return false;

      // Idempotent: only update if different
      if ((int) $listing->vendor_id !== (int) $vendorId) {
        $listing->vendor_id = $vendorId;
        $listing->save();
      }

      // Finalize claim
      $claim->status = 'fulfilled';
      $claim->redemption_token = null;
      $claim->redemption_expires_at = null;
      $claim->save();

      return true;
    });
  }

  //  fulfill by claim_id for admin offline approval
  public function attachByClaimId(int $vendorId, int $claimId): bool
  {
    $claim = ClaimListing::find($claimId);
    if (!$claim) return false;

    // Ensure still fulfillable (approved + not expired) – relax if your business rules allow
    if ($claim->status !== 'approved') return false;
    if (!$claim->redemption_expires_at || now()->greaterThan($claim->redemption_expires_at)) return false;

    return DB::transaction(function () use ($claim, $vendorId) {
      $listing = Listing::lockForUpdate()->find($claim->listing_id);
      if (!$listing) return false;

      if ((int)$listing->vendor_id !== (int)$vendorId) {
        $listing->vendor_id = $vendorId;
        $listing->save();
      }

      $claim->status = 'fulfilled';
      $claim->redemption_token = null;
      $claim->redemption_expires_at = null;
      $claim->save();

      return true;
    });
  }
}
