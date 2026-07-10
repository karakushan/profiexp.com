@extends('frontend.layout')
@section('pageHeading')
    @if (!empty($cityMetaTitle))
        {{ $cityMetaTitle }}
    @elseif (!empty($categoryContent) && !empty($categoryContent->meta_title))
        {{ $categoryContent->meta_title }}
    @elseif (!empty($categoryContent) && !empty($categoryContent->name))
        {{ $categoryContent->name }}
    @elseif (!empty($pageHeading))
        {{ $pageHeading->listing_page_title }}
    @else
        {{ __('Pricing') }}
    @endif
@endsection

@section('metaDescription')
    @if (!empty($cityMetaDescription))
        {{ $cityMetaDescription }}
    @elseif (!empty($categoryContent) && !empty($categoryContent->meta_description))
        {{ $categoryContent->meta_description }}
    @endif
@endsection

@section('content')

    @includeIf('frontend.partials.breadcrumb', [
        'breadcrumb' => $bgImg->breadcrumb,
        'title' => !empty($categoryContent) && !empty($categoryContent->name)
            ? $categoryContent->name
            : (!empty($pageHeading) ? $pageHeading->listing_page_title : __('Listings')),
    ])

    <!-- Listing-map-area start -->
    <div class="listing-map-area header-next border-top pt-40">
        <div class="container">
            <div class="row">
                <div class="col-xl-3" data-aos="fade-up">
                    @include('frontend.listing.side-bar')
                </div>
                <div class="col-xl-9" data-aos="fade-up">
                    <div class="product-sort-area pb-15">
                        <div class="row align-items-center">
                            <div class="col-4 d-xl-none">
                                <button class="btn btn-sm btn-outline icon-end radius-sm mb-20" type="button"
                                    data-bs-toggle="offcanvas" data-bs-target="#widgetOffcanvas"
                                    aria-controls="widgetOffcanvas">
                                    <i class="fal fa-filter"></i>
                                </button>
                            </div>
                            <div class="col-sm-8 col-xl-12">
                                <div class="sort-item d-flex align-items-center justify-content-end mb-20">
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
                    <div class="search-container">
                        @if (count($featured_contents) < 1 && count($listing_contents) < 1)
                            <div class="p-4 text-center bg-light radius-md">
                                <h3 class="mb-0">{{ __('NO LISTING FOUND') }}</h3>
                            </div>
                        @else
                            <div class="row">
                                @foreach ($featured_contents as $listing_content)
                                    <div class="col-md-6 col-lg-4" data-aos="fade-up">
                                        <div class="product-default border radius-md mb-25 active">
                                            <figure class="product-img">
                                                <a href="{{ listing_url($listing_content->slug, $language->code) }}"
                                                    class="lazy-container ratio ratio-2-3">
                                                    <img class="lazyload"
                                                        data-src="{{ asset('assets/img/listing/' . $listing_content->feature_image) }}"
                                                        alt="{{ optional($listing_content)->title }}">
                                                </a>

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
                                                <a href="{{ $checkWishList == false ? route('addto.wishlist', ['id' => $listing_content->id]) : route('remove.wishlist', ['id' => $listing_content->id]) }}"
                                                    class="btn-icon {{ $checkWishList == false ? '' : 'wishlist-active' }}"
                                                    data-tooltip="tooltip" data-bs-placement="top"
                                                    title="{{ $checkWishList == false ? __('Save to Wishlist') : __('Saved') }}">
                                                    <i class="fal fa-heart"></i>
                                                </a>
                                            </figure>

                                            <div class="product-details">
                                                <div class="product-top mb-10">

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

                                                    <div class="author">
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
                                                    @php
$listing_content->category_id
                                                    @endphp
                                                    <a href="{{ listing_category_url($listing_content->category_id, $language->code) }}"
                                                        title="Link" class="product-category font-sm icon-start">
                                                        <i
                                                            class="{{ $listing_content->icon }}"></i>{{ $listing_content->category_name }}
                                                    </a>
                                                </div>
                                                <h6 class="product-title mb-10"><a
                                                        href="{{ listing_url($listing_content->slug, $language->code) }}">{{ optional($listing_content)->title }}</a>
                                                </h6>
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
                                                @php

                                                    $location = implode(
                                                        ', ',
                                                        array_filter([
                                                            $listing_content->city_id
                                                                ? App\Models\Location\City::find(
                                                                    $listing_content->city_id,
                                                                )?->getName($language->id)
                                                                : null,
                                                            $listing_content->state_id
                                                                ? App\Models\Location\State::find(
                                                                    $listing_content->state_id,
                                                                )?->getName($language->id)
                                                                : null,
                                                            $listing_content->country_id
                                                                ? App\Models\Location\Country::find(
                                                                    $listing_content->country_id,
                                                                )?->getName($language->id)
                                                                : null,
                                                        ]),
                                                    );
                                                @endphp

                                                <span class="product-location icon-start font-sm"><i
                                                        class="fal fa-map-marker-alt"></i>{{ $location }}
                                                </span>
                                                @if ($listingbs->google_map_api_key_status == 1 && !empty($listing_content->distance))
                                                    <span class="font-sm icon-start d-block">
                                                        <i class="fas fa-map-signs"></i>
                                                        {{ number_format($listing_content->distance, 2) }}
                                                        {{ __('kilometers away') }}
                                                    </span>
                                                @endif
                                                <div
                                                    class="d-flex align-items-center justify-content-between mt-10 pt-10 border-top">
                                                    @if ($listing_content->max_price && $listing_content->min_price)
                                                        <div class="product-price">
                                                            <span class="color-medium me-2">{{ __('From') }}</span>
                                                            <h6 class="price mb-0 lh-1">
                                                                {{ symbolPrice($listing_content->min_price) }} -
                                                                {{ symbolPrice($listing_content->max_price) }}
                                                            </h6>
                                                        </div>
                                                    @else
                                                        <div class="product-price">
                                                            <span class="color-medium font-sm">
                                                                <i class="fas fa-tag me-1 text-primary"></i>
                                                                {{ __('Price Not Mentioned') }}
                                                            </span>
                                                        </div>
                                                    @endif

                                                    @php
                                                    $claimed =
                                                            !empty($listing_content->has_pending_claim) &&
                                                            $listing_content->has_pending_claim;
                                                    @endphp
                                                    @if (is_null($listing_content->vendor_id) || $listing_content->vendor_id == 0)
                                                        <a @if (!$claimed) href="#" data-bs-toggle="modal" data-bs-target="#ClaimRequestModal" @endif
                                                            class="btn btn-primary btn-sm ms-auto claim-btn {{ $claimed ? 'disabled-link' : '' }}"
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
                                    <div class="col-md-6 col-lg-4" data-aos="fade-up">
                                        <div class="product-default border radius-md mb-25">
                                            <figure class="product-img">
                                                <a href="{{ listing_url($listing_content->slug, $language->code) }}"
                                                    class="lazy-container ratio ratio-2-3">
                                                    <img class="lazyload"
                                                        data-src="{{ asset('assets/img/listing/' . $listing_content->feature_image) }}"
                                                        alt="{{ optional($listing_content)->title }}">
                                                </a>

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
                                                <a href="{{ $checkWishList == false ? route('addto.wishlist', ['id' => $listing_content->id]) : route('remove.wishlist', ['id' => $listing_content->id]) }}"
                                                    class="btn-icon {{ $checkWishList == false ? '' : 'wishlist-active' }}"
                                                    data-tooltip="tooltip" data-bs-placement="top"
                                                    title="{{ $checkWishList == false ? __('Save to Wishlist') : __('Saved') }}">
                                                    <i class="fal fa-heart"></i>
                                                </a>
                                            </figure>

                                            <div class="product-details">
                                                <div class="product-top mb-10">

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

                                                    <div class="author">
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
                                                    @php
$listing_content->category_id
                                                    @endphp
                                                    <a href="{{ listing_category_url($listing_content->category_id, $language->code) }}"
                                                        title="Link" class="product-category font-sm icon-start">
                                                        <i
                                                            class="{{ $listing_content->icon }}"></i>{{ $listing_content->category_name }}
                                                    </a>
                                                </div>
                                                <h6 class="product-title mb-10"><a
                                                        href="{{ listing_url($listing_content->slug, $language->code) }}">{{ optional($listing_content)->title }}</a>
                                                </h6>
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
                                                @php

                                                    $location = implode(
                                                        ', ',
                                                        array_filter([
                                                            $listing_content->city_id
                                                                ? App\Models\Location\City::find(
                                                                    $listing_content->city_id,
                                                                )?->getName($language->id)
                                                                : null,
                                                            $listing_content->state_id
                                                                ? App\Models\Location\State::find(
                                                                    $listing_content->state_id,
                                                                )?->getName($language->id)
                                                                : null,
                                                            $listing_content->country_id
                                                                ? App\Models\Location\Country::find(
                                                                    $listing_content->country_id,
                                                                )?->getName($language->id)
                                                                : null,
                                                        ]),
                                                    );
                                                @endphp
                                                <span class="product-location icon-start font-sm"><i
                                                        class="fal fa-map-marker-alt"></i>{{ $location }}
                                                </span>
                                                @if ($listingbs->google_map_api_key_status == 1 && !empty($listing_content->distance))
                                                    <span class="font-sm icon-start d-block">
                                                        <i class="fas fa-map-signs"></i>
                                                        {{ number_format($listing_content->distance, 2) }}
                                                        {{ __('kilometers away') }}
                                                    </span>
                                                @endif

                                                <div
                                                    class="d-flex align-items-center justify-content-between mt-10 pt-10 border-top">
                                                    @if ($listing_content->max_price && $listing_content->min_price)
                                                        <div class="product-price">
                                                            <span class="color-medium me-2">{{ __('From') }}</span>
                                                            <h6 class="price mb-0 lh-1">
                                                                {{ symbolPrice($listing_content->min_price) }} -
                                                                {{ symbolPrice($listing_content->max_price) }}
                                                            </h6>
                                                        </div>
                                                    @else
                                                        <div class="product-price">
                                                            <span class="color-medium font-sm">
                                                                <i class="fas fa-tag me-1 text-primary"></i>
                                                                {{ __('Price Not Mentioned') }}
                                                            </span>
                                                        </div>
                                                    @endif

                                                    @php
                                                    $claimed =
                                                            !empty($listing_content->has_pending_claim) &&
                                                            $listing_content->has_pending_claim;
                                                    @endphp

                                                    @if (is_null($listing_content->vendor_id) || $listing_content->vendor_id == 0)
                                                        <a @if (!$claimed) href="#" data-bs-toggle="modal" data-bs-target="#ClaimRequestModal" @endif
                                                            class="btn btn-primary btn-sm ms-auto claim-btn {{ $claimed ? 'disabled-link' : '' }}"
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
                            </div>

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
    <!-- Listing-map-area end -->

    @if (!empty($categoryContent) && !empty($categoryContent->seo_text))
        <section class="category-seo-text pt-30 pb-40">
            <div class="container">
                <div class="row">
                    <div class="col-xl-9 offset-xl-3">
                        <div class="seo-text-content">
                            {!! $categoryContent->seo_text !!}
                        </div>
                    </div>
                </div>
            </div>
        </section>
    @endif

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
        const listing_view = "{{ $basicInfo->listing_view }}";
    </script>
    <!-- Map JS -->
    @if ($basicInfo->google_map_api_key_status == 1)
        <script src="{{ asset('assets/front/js/api-search-2.js') }}"></script>
        <script
            src="https://maps.googleapis.com/maps/api/js?key={{ $basicInfo->google_map_api_key }}&libraries=places&callback=initMap"
            async defer></script>
    @endif
    <!-- Map JS -->
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
