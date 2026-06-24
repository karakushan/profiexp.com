<?php

namespace App\Console\Commands;

use App\Http\Helpers\VendorPermissionHelper;
use App\Jobs\IyzicoPendingListingFeature;
use App\Jobs\IyzicoPendingMembership;
use App\Jobs\IyzicoPendingProductPurchase;
use App\Jobs\SubscriptionExpiredMail;
use App\Jobs\SubscriptionReminderMail;
use App\Models\BasicSettings\Basic;
use App\Models\FeatureOrder;
use App\Models\Membership;
use App\Models\Shop\ProductOrder;
use Carbon\Carbon;
use Illuminate\Console\Command;

class SubcheckExpired extends Command
{
    protected $signature = 'subcheck:expired';
    protected $description = 'Process expired memberships, reminders, and pending Iyzico payments';

    public function handle(): int
    {
        try {
            $bs = Basic::first();

            $expiredMembers = Membership::whereDate('expire_date', Carbon::now()->subDays(1))->get();
            foreach ($expiredMembers as $expiredMember) {
                if (!empty($expiredMember->vendor)) {
                    $vendor = $expiredMember->vendor;
                    $currentPackage = VendorPermissionHelper::userPackage($vendor->id);
                    if (is_null($currentPackage)) {
                        SubscriptionExpiredMail::dispatch($vendor, $bs);
                    }
                }
            }

            $remindMembers = Membership::whereDate('expire_date', Carbon::now()->addDays($bs->expiration_reminder))->get();
            foreach ($remindMembers as $remindMember) {
                if (!empty($remindMember->vendor)) {
                    $vendor = $remindMember->vendor;

                    $nextPackageCount = Membership::where([
                        ['vendor_id', $vendor->id],
                        ['start_date', '>', Carbon::now()->toDateString()]
                    ])->where('status', '<>', 2)->count();

                    if ($nextPackageCount == 0) {
                        SubscriptionReminderMail::dispatch($vendor, $bs, $remindMember->expire_date);
                    }
                }
                \Artisan::call('queue:work --stop-when-empty');
            }

            $pendingMemberships = Membership::where([['payment_method', 'Iyzico'], ['status', 0]])->get();
            foreach ($pendingMemberships as $pendingMembership) {
                IyzicoPendingMembership::dispatch($pendingMembership->id);
            }

            $listingFeatures = FeatureOrder::where([['payment_method', 'Iyzico'], ['payment_status', 'pending']])->get();
            foreach ($listingFeatures as $listingFeature) {
                IyzicoPendingListingFeature::dispatch($listingFeature->id);
            }

            $pendingOrders = ProductOrder::where([['payment_method', 'Iyzico'], ['payment_status', 'pending']])->get();
            foreach ($pendingOrders as $order) {
                IyzicoPendingProductPurchase::dispatch($order->id);
            }
        } catch (\Exception $e) {
            return self::FAILURE;
        }

        return self::SUCCESS;
    }
}
