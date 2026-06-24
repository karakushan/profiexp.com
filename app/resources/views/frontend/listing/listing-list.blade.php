@extends('frontend.layout')
@section('pageHeading')
    @if (!empty($categoryInfo) && !empty($categoryInfo->meta_title))
        {{ $categoryInfo->meta_title }}
    @elseif (!empty($pageHeading))
        {{ $pageHeading->listing_page_title }}
    @else
        {{ __('Pricing') }}
    @endif
@endsection

@section('metaKeywords')
    @if (!empty($categoryInfo) && !empty($categoryInfo->meta_title))
        {{ $categoryInfo->meta_title }}
    @elseif (!empty($seoInfo))
        {{ $seoInfo->meta_keyword_listings }}
    @endif
@endsection

@section('metaDescription')
    @if (!empty($categoryInfo) && !empty($categoryInfo->meta_description))
        {{ $categoryInfo->meta_description }}
    @elseif (!empty($seoInfo))
        {{ $seoInfo->meta_description_listings }}
    @endif
@endsection

@section('content')
    <!-- Listing-column-area start -->
    <div class="listing-column-area pt-100 pb-60">
        <div class="container">
            <div class="row gx-xl-5">
                <div class="col-lg-3">
                    @include('frontend.listing.side-bar')
                </div>
                <div class="col-lg-9">
                    <div class="product-sort-area mb-20" data-aos="fade-up">
                        <div class="row align-items-center">
                            <div class="col-4 d-xl-none">
                                <button class="btn btn-sm btn-outline icon-end radius-sm mb-20" type="button"
                                    data-bs-toggle="offcanvas" data-bs-target="#widgetOffcanvas"
                                    aria-controls="widgetOffcanvas">
                                    <i class="fal fa-filter"></i>
                                </button>
                            </div>
                            <div class="col-sm-8 col-xl-12">
                                <div class="sort-item d-flex align-items-center justify-content-sm-end mb-20">
                                    <div class="item">
                                        <form>
                                            <label class="color-dark" for="select_sort">{{ __('Sort By') }}:</label>
                                            <select name="select_sort" id="select_sort" class="niceselect right color-dark">
                                                <option {{ request()->input('sort') == 'new' ? 'selected' : '' }}
                                                    value="new">
                                                    {{ __('Date : Newest on top') }}
                                                </option>
                                                <option {{ request()->input('sort') == 'old' ? 'selected' : '' }}
                                                    value="old">
                                                    {{ __('Date : Oldest on top') }}
                                                </option>
                                                <option {{ request()->input('sort') == 'low' ? 'selected' : '' }}
                                                    value="low">
                                                    {{ __('Price : Low to High') }}</option>
                                                <option {{ request()->input('sort') == 'high' ? 'selected' : '' }}
                                                    value="high">
                                                    {{ __('Price : High to Low') }}</option>
                                            </select>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="search-container">
                            @if (count($featured_contents) < 1 && count($listing_contents) < 1)
                                <div class="p-4 text-center bg-light radius-md">
                                    <h3 class="mb-0">{{ __('NO LISTING FOUND') }}</h3>
                                </div>
                            @else
                                @foreach ($featured_contents as $listing_content)
                                    <div class="col-12" data-aos="fade-up">
                                        <div
                                            class="row g-0 product-default product-column border mb-25 align-items-center active">
                                            <figure class="product-img col-sm-3 col-xs-12">
                                                <a href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing_content->id]) }}"
                                                    class="lazy-container ratio ratio-1-1">
                                                    <img class="lazyload"
                                                        data-src="{{ asset('assets/img/listing/' . $listing_content->feature_image) }}"
                                                        alt="{{ optional($listing_content)->title }}">
                                                </a>
                                            </figure>
                                            <div class="product-details col-sm-5 col-xs-12 border-end">
                                                @php
                                                    $categorySlug = App\Models\ListingCategory::findorfail(
                                                        $listing_content->category_id,
                                                    );
                                                @endphp

                                                <a
                                                    href="{{ route('frontend.listings', ['category_id' => $categorySlug->slug]) }}">
                                                    <span class="product-category color-primary font-sm icon-start"><i
                                                            class="{{ $listing_content->icon }}"></i>
                                                        {{ $listing_content->category_name }}</span>
                                                </a>
                                                <h4 class="product-title mb-10"><a
                                                        href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing_content->id]) }}">{{ optional($listing_content)->title }}</a>
                                                </h4>


                                                @php

                                                    $location = implode(
                                                        ', ',
                                                        array_filter([
                                                            $listing_content->city_id
                                                                ? App\Models\Location\City::find(
                                                                    $listing_content->city_id,
                                                                )?->name
                                                                : null,
                                                            $listing_content->state_id
                                                                ? App\Models\Location\State::find(
                                                                    $listing_content->state_id,
                                                                )?->name
                                                                : null,
                                                            $listing_content->country_id
                                                                ? App\Models\Location\Country::find(
                                                                    $listing_content->country_id,
                                                                )?->name
                                                                : null,
                                                        ]),
                                                    );
                                                @endphp
                                                <span class="product-location icon-start font-sm"><i
                                                        class="fal fa-map-marker-alt"></i>
                                                    {{ $location }}
                                                </span>
                                                @if ($listingbs->google_map_api_key_status == 1 && !empty($listing_content->distance))
                                                    <span class="font-sm icon-start d-block">
                                                        <i class="fas fa-map-signs"></i>
                                                        {{ number_format($listing_content->distance, 2) }}
                                                        {{ __('kilometers away') }}
                                                    </span>
                                                @endif
                                                @php
                                                    if ($listing_content->vendor_id == 0) {
                                                        $vendorInfo = App\Models\Admin::first();
                                                        $userName = 'admin';
                                                    } else {
                                                        $vendorInfo = App\Models\Vendor::findorfail(
                                                            $listing_content->vendor_id,
                                                        );
                                                        $userName = $vendorInfo->username;
                                                    }
                                                @endphp

                                                <div class="author mb-15 pt-2">
                                                    <a class="color-medium"
                                                        href="{{ route('frontend.vendor.details', ['username' => $userName]) }}"
                                                        target="_self" title={{ $vendorInfo->username }}>

                                                        @if ($listing_content->vendor_id == 0)
                                                            <img class="lazyload" src="assets/images/placeholder.png"
                                                                data-src="{{ asset('assets/img/admins/' . $vendorInfo->image) }}"
                                                                alt="Vendor">
                                                        @else
                                                            @if ($vendorInfo->photo != null)
                                                                <img class="blur-up lazyload"
                                                                    data-src="{{ asset('assets/admin/img/vendor-photo/' . $vendorInfo->photo) }}"
                                                                    alt="Image">
                                                            @else
                                                                <img class="blur-up lazyload"
                                                                    data-src="{{ asset('assets/img/blank-user.jpg') }}"
                                                                    alt="Image">
                                                            @endif
                                                        @endif
                                                        <span>{{ __('By') }}
                                                            {{ $vendorInfo->username }}
                                                        </span>
                                                    </a>
                                                </div>
                                                <p class="mb-15 pt-1">
                                                    {{ strlen(strip_tags(convertUtf8(optional($listing_content)->summary))) > 100
                                                        ? substr(strip_tags(convertUtf8(optional($listing_content)->summary)), 0, 100) . '...'
                                                        : strip_tags(convertUtf8(optional($listing_content)->summary)) }}
                                                </p>
                                            </div>
                                            <div
                                                class="product-action col-sm-4 col-xs-12 d-flex align-items-center flex-column text-center">

                                                @if (Auth::guard('web')->check())
                                                    @php
                                                        $user_id = Auth::guard('web')->user()->id;
                                                        $checkWishList = checkWishList($listing_content->id, $user_id);
                                                    @endphp
                                                @else
                                                    @php
                                                        $checkWishList = false;
                                                        $user_id = null;
                                                    @endphp
                                                @endif

                                                <a href="{{ $checkWishList == false ? route('addto.wishlist', $listing_content->id) : route('remove.wishlist', $listing_content->id) }}"
                                                    class="btn-wishlist color-primary font-sm icon-start  {{ $checkWishList == false ? '' : 'wishlist-active' }}"
                                                    data-tooltip="tooltip" data-bs-placement="right"
                                                    title="{{ $checkWishList == false ? __('Save to Wishlist') : __('Saved') }}"><i
                                                        class="fal fa-heart"></i>{{ $checkWishList == false ? __('Save to Wishlist') : __('Saved') }}</a>

                                                @if ($listing_content->max_price && $listing_content->min_price)
                                                    <div class="product-price mt-10">
                                                        <span class="color-medium me-2">{{ __('From') }}</span>
                                                        <h6 class="price mb-0 lh-1">
                                                            {{ symbolPrice($listing_content->min_price) }} -
                                                            {{ symbolPrice($listing_content->max_price) }}</h6>
                                                    </div>
                                                @else
                                                    <div class="product-price">
                                                        <span class="color-medium font-sm">
                                                            <i class="fas fa-tag me-1 text-primary"></i>
                                                            {{ __('Price Not Mentioned') }}
                                                        </span>
                                                    </div>
                                                @endif
                                                <div class="product-ratings mb-10">
                                                    <div class="ratings">
                                                        <div class="rate"
                                                            style="background-image: url('{{ asset($rateStar) }}')">
                                                            <div class="rating-icon"
                                                                style="background-image: url('{{ asset($rateStar) }}'); width: {{ $listing_content->average_rating * 20 . '%;' }}">
                                                            </div>
                                                        </div>
                                                        <span
                                                            class="ratings-total font-sm">({{ number_format($listing_content->average_rating, 2) }})</span>
                                                        <span
                                                            class="ratings-total color-medium ms-1 font-sm">{{ totalListingReview($listing_content->id) }}
                                                            {{ __('Reviews') }}</span>
                                                    </div>
                                                </div>

                                                <div
                                                    class="product-action col-sm-4 col-xs-12 d-flex flex-column justify-content-center align-items-center text-center">
                                                    @php
                                                        $claimed =
                                                            !empty($listing_content->has_pending_claim) &&
                                                            $listing_content->has_pending_claim;
                                                    @endphp
                                                    @if (is_null($listing_content->vendor_id) || $listing_content->vendor_id == 0)
                                                        <a @if (!$claimed) href="#" data-bs-toggle="modal" data-bs-target="#ClaimRequestModal" @endif
                                                            class="btn btn-primary btn-sm claim-btn {{ $claimed ? 'disabled-link' : '' }}"
                                                            data-tooltip="tooltip" data-bs-placement="right"
                                                            title="{{ $claimed ? __('Already claimed, awaiting fulfillment') : __('Claim Listing') }}"
                                                            data-listing-id="{{ $listing_content->id }}"
                                                            data-vendor-id="{{ $listing_content->vendor_id }}"
                                                            aria-disabled="{{ $claimed ? 'true' : 'false' }}">
                                                            {{ $claimed ? __('Claimed') : __('Claim') }}
                                                        </a>
                                                    @endif
                                                </div>

                                            </div>
                                        </div><!-- product-default -->
                                    </div>
                                @endforeach
                                @foreach ($listing_contents as $listing_content)
                                    <div class="col-12" data-aos="fade-up">
                                        <div class="row g-0 product-default product-column border mb-25 align-items-center">
                                            <figure class="product-img col-sm-3 col-xs-12">
                                                <a href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing_content->id]) }}"
                                                    class="lazy-container ratio ratio-1-1">
                                                    <img class="lazyload "
                                                        data-src="{{ asset('assets/img/listing/' . $listing_content->feature_image) }}"
                                                        alt="{{ optional($listing_content)->title }}">
                                                </a>
                                            </figure>
                                            <div class="product-details col-sm-5 col-xs-12 border-end">
                                                @php
                                                    $categorySlug = App\Models\ListingCategory::findorfail(
                                                        $listing_content->category_id,
                                                    );
                                                @endphp

                                                <a
                                                    href="{{ route('frontend.listings', ['category_id' => $categorySlug->slug]) }}">
                                                    <span class="product-category color-primary font-sm icon-start"><i
                                                            class="{{ $listing_content->icon }}"></i>
                                                        {{ $listing_content->category_name }}</span>
                                                </a>
                                                <h4 class="product-title mb-10"><a
                                                        href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing_content->id]) }}">{{ optional($listing_content)->title }}</a>
                                                </h4>

                                                @php

                                                    $location = implode(
                                                        ', ',
                                                        array_filter([
                                                            $listing_content->city_id
                                                                ? App\Models\Location\City::find(
                                                                    $listing_content->city_id,
                                                                )?->name
                                                                : null,
                                                            $listing_content->state_id
                                                                ? App\Models\Location\State::find(
                                                                    $listing_content->state_id,
                                                                )?->name
                                                                : null,
                                                            $listing_content->country_id
                                                                ? App\Models\Location\Country::find(
                                                                    $listing_content->country_id,
                                                                )?->name
                                                                : null,
                                                        ]),
                                                    );
                                                @endphp
                                                <span class="product-location icon-start font-sm"><i
                                                        class="fal fa-map-marker-alt"></i>
                                                    {{ $location }}
                                                </span>
                                                @if ($listingbs->google_map_api_key_status == 1 && !empty($listing_content->distance))
                                                    <span class="font-sm icon-start d-block">
                                                        <i class="fas fa-map-signs"></i>
                                                        {{ number_format($listing_content->distance, 2) }}
                                                        {{ __('kilometers away') }}
                                                    </span>
                                                @endif
                                                @php
                                                    if ($listing_content->vendor_id == 0) {
                                                        $vendorInfo = App\Models\Admin::first();
                                                        $userName = 'admin';
                                                    } else {
                                                        $vendorInfo = App\Models\Vendor::findorfail(
                                                            $listing_content->vendor_id,
                                                        );
                                                        $userName = $vendorInfo->username;
                                                    }
                                                @endphp

                                                <div class="author mb-15 pt-2">
                                                    <a class="color-medium"
                                                        href="{{ route('frontend.vendor.details', ['username' => $userName]) }}"
                                                        target="_self" title={{ $vendorInfo->username }}>

                                                        @if ($listing_content->vendor_id == 0)
                                                            <img class="lazyload" src="assets/images/placeholder.png"
                                                                data-src="{{ asset('assets/img/admins/' . $vendorInfo->image) }}"
                                                                alt="Vendor">
                                                        @else
                                                            @if ($vendorInfo->photo != null)
                                                                <img class="blur-up lazyload"
                                                                    data-src="{{ asset('assets/admin/img/vendor-photo/' . $vendorInfo->photo) }}"
                                                                    alt="Image">
                                                            @else
                                                                <img class="blur-up lazyload"
                                                                    data-src="{{ asset('assets/img/blank-user.jpg') }}"
                                                                    alt="Image">
                                                            @endif
                                                        @endif
                                                        <span>{{ __('By') }}
                                                            {{ $vendorInfo->username }}
                                                        </span>
                                                    </a>
                                                </div>
                                                <p class="mb-15 pt-1">
                                                    {{ strlen(strip_tags(convertUtf8(optional($listing_content)->summary))) > 100
                                                        ? substr(strip_tags(convertUtf8(optional($listing_content)->summary)), 0, 100) . '...'
                                                        : strip_tags(convertUtf8(optional($listing_content)->summary)) }}
                                                </p>
                                            </div>
                                            <div
                                                class="product-action col-sm-4 col-xs-12 d-flex align-items-center flex-column text-center">
                                                @if (Auth::guard('web')->check())
                                                    @php
                                                        $user_id = Auth::guard('web')->user()->id;
                                                        $checkWishList = checkWishList($listing_content->id, $user_id);
                                                    @endphp
                                                @else
                                                    @php
                                                        $checkWishList = false;
                                                    @endphp
                                                @endif

                                                <a href="{{ $checkWishList == false ? route('addto.wishlist', $listing_content->id) : route('remove.wishlist', $listing_content->id) }}"
                                                    class="btn-wishlist color-primary font-sm icon-start  {{ $checkWishList == false ? '' : 'wishlist-active' }}"
                                                    data-tooltip="tooltip" data-bs-placement="right"
                                                    title="{{ $checkWishList == false ? __('Save to Wishlist') : __('Saved') }}"><i
                                                        class="fal fa-heart"></i>{{ $checkWishList == false ? __('Save to Wishlist') : __('Saved') }}</a>
                                                @if ($listing_content->max_price && $listing_content->min_price)
                                                    <div class="product-price mt-10">
                                                        <span class="color-medium me-2">{{ __('From') }}</span>
                                                        <h6 class="price mb-0 lh-1">
                                                            {{ symbolPrice($listing_content->min_price) }} -
                                                            {{ symbolPrice($listing_content->max_price) }}</h6>
                                                    </div>
                                                @else
                                                    <div class="product-price">
                                                        <span class="color-medium font-sm">
                                                            <i class="fas fa-tag me-1 text-primary"></i>
                                                            {{ __('Price Not Mentioned') }}
                                                        </span>
                                                    </div>
                                                @endif
                                                <div class="product-ratings mb-10">
                                                    <div class="ratings">
                                                        <div class="rate"
                                                            style="background-image: url('{{ asset($rateStar) }}')">
                                                            <div class="rating-icon"
                                                                style="background-image: url('{{ asset($rateStar) }}'); width: {{ $listing_content->average_rating * 20 . '%;' }}">
                                                            </div>
                                                        </div>
                                                        <span
                                                            class="ratings-total font-sm">({{ number_format($listing_content->average_rating, 2) }})</span>
                                                        <span
                                                            class="ratings-total color-medium ms-1 font-sm">{{ totalListingReview($listing_content->id) }}
                                                            {{ __('Reviews') }}</span>

                                                    </div>
                                                </div>

                                                <div
                                                    class="product-action col-sm-4 col-xs-12 d-flex flex-column justify-content-center align-items-center text-center">
                                                    @php
                                                        $claimed =
                                                            !empty($listing_content->has_pending_claim) &&
                                                            $listing_content->has_pending_claim;
                                                    @endphp
                                                    @if (is_null($listing_content->vendor_id) || $listing_content->vendor_id == 0)
                                                        <a @if (!$claimed) href="#" data-bs-toggle="modal" data-bs-target="#ClaimRequestModal" @endif
                                                            class="btn btn-primary btn-sm claim-btn {{ $claimed ? 'disabled-link' : '' }}"
                                                            data-tooltip="tooltip" data-bs-placement="right"
                                                            title="{{ $claimed ? __('Already claimed, awaiting fulfillment') : __('Claim Listing') }}"
                                                            data-listing-id="{{ $listing_content->id }}"
                                                            data-vendor-id="{{ $listing_content->vendor_id }}"
                                                            aria-disabled="{{ $claimed ? 'true' : 'false' }}">
                                                            {{ $claimed ? __('Claimed') : __('Claim') }}
                                                        </a>
                                                    @endif
                                                </div>
                                            </div>
                                        </div><!-- product-default -->
                                    </div>
                                @endforeach

                                @if ($listing_contents instanceof \Illuminate\Pagination\LengthAwarePaginator && $listing_contents->hasPages())
                                    <div class="pagination mt-20 mb-40 justify-content-center" data-aos="fade-up">
                                        {{ $listing_contents->appends(request()->except('page'))->links() }}
                                    </div>
                                @endif
                            @endif
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Listing-column-area end -->

    <form action="{{ route('frontend.listings') }}" id="searchForm" method="GET">
        <input type="hidden" name="title" id="title" value="{{ request()->input('title') }}">
        <input type="hidden" name="location_val" id="location_val" value="{{ request()->input('location') }}">
        <input type="hidden" name="category_id" id="category_id" value="{{ request()->input('category_id') }}">
        <input type="hidden" name="max_val" id="max_val" value="{{ request()->input('max_val') }}">
        <input type="hidden" name="min_val" id="min_val" value="{{ request()->input('min_val') }}">
        <input type="hidden" name="ratings" id="ratings" value="{{ request()->input('ratings') }}">
        <input type="hidden" name="amenitie" id="amenitie" value="{{ request()->input('amenitie') }}">
        <input type="hidden" name="sort" id="sort" value="{{ request()->input('sort') }}">
        <input type="hidden" name="vendor" id="vendor" value="{{ request()->input('vendor') }}">
        <input type="hidden" name="country" id="country" value="{{ request()->input('country') }}">
        <input type="hidden" name="state" id="state" value="{{ request()->input('state') }}">
        <input type="hidden" name="city" id="city" value="{{ request()->input('city') }}">
        <input type="hidden" name="price_not_mentioned" id="price_not_mentioned_value"
            value="{{ request()->input('price_not_mentioned') }}">
        <input type="hidden" name="page" id="page" value="">
    </form>
    @if (Auth::guard('web')->check())
        @include('frontend.listing.claim-request-modal')
    @endif
    @include('frontend.partials.map-modal')
@endsection
@section('script')
    <script>
        const countryUrl = "{{ route('frontend.get_country') }}";
        const cityUrl = "{{ route('frontend.get_city') }}";
        const stateUrl = "{{ route('frontend.get_state') }}";
        const listing_view = " {{ $basicInfo->listing_view }}";
    </script>
    <!-- Map JS -->
    @if ($basicInfo->google_map_api_key_status == 1)
        <script src="{{ asset('assets/front/js/api-search-2.js') }}"></script>
        <script
            src="https://maps.googleapis.com/maps/api/js?key={{ $basicInfo->google_map_api_key }}&libraries=places&callback=initMap"
            async defer></script>
    @endif
    @if ($basicInfo->listing_view == 0)
        <script src="{{ asset('assets/front/js/map.js') }}"></script>
    @endif
    <script>
        "use strict";
        var featured_contents = {!! json_encode($featured_contents) !!};
        var listing_contents = {!! json_encode($listing_contents) !!};
        var searchUrl = "{{ route('frontend.search_listing') }}";
        var getStateUrl = "{{ route('frontend.listings.get-state') }}";
        var getCityUrl = "{{ route('frontend.listings.get-city') }}";
        var isLoggedIn = {{ Auth::guard('web')->check() ? 'true' : 'false' }};
        var claimErrMsg = "{{ __('Please login first to claim this listing') . '.' }}";
        var currentUser = @json(Auth::guard('web')->check() ? Auth::guard('web')->user() : null);
    </script>
    <script src="{{ asset('assets/front/js/search.js') }}"></script>
@endsection
