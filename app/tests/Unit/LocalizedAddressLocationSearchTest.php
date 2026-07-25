<?php

namespace Tests\Unit;

use App\Http\Controllers\FrontEnd\ListingContoller;
use Illuminate\Support\Facades\DB;
use ReflectionMethod;
use Tests\TestCase;

class LocalizedAddressLocationSearchTest extends TestCase
{
    public function test_it_finds_localized_addresses_case_insensitively(): void
    {
        $languageId = 999001;
        $matchingListingId = 999101;
        $nonMatchingListingId = 999102;

        DB::table('listing_contents')->insert([
            [
                'language_id' => $languageId,
                'listing_id' => $matchingListingId,
                'slug' => 'localized-address-match-' . uniqid(),
                'address' => 'Trabzon, Turquía',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'language_id' => $languageId,
                'listing_id' => $nonMatchingListingId,
                'slug' => 'localized-address-other-' . uniqid(),
                'address' => 'Hatay, Turquía',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);

        $method = new ReflectionMethod(ListingContoller::class, 'findListingIdsByLocalizedAddress');
        $method->setAccessible(true);

        $listingIds = $method->invoke(new ListingContoller(), 'tRaBz', $languageId);

        $this->assertSame([$matchingListingId], $listingIds);
    }
}
