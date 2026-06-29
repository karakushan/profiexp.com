@extends('frontend.layout')

@section('pageHeading')
    {{ $vendor->username }}
@endsection
@section('metaKeywords')
    {{ $vendor->username }}, {{ !request()->filled('admin') ? @$vendorInfo->name : '' }}
@endsection

@section('metaDescription')
    {{ !request()->filled('admin') ? @$vendorInfo->details : '' }}
@endsection

@section('content')

    <!-- Page title start-->
    <div class="page-title-area ptb-100">
        <!-- Background Image -->
        <img class="lazyload blur-up bg-img"
            @if (!empty($bgImg->breadcrumb)) src="{{ asset('assets/img/' . $bgImg->breadcrumb) }}" @else
    src="{{ asset('assets/front/images/page-title-bg.jpg') }}" @endif
            alt="Bg-img">
        <div class="container">
            <div class="content">
                <div class="vendor mb-15">
                    <figure class="vendor-img">
                        <a href="javaScript:void(0)" class="lazy-container ratio ratio-1-1 radius-md">
                            @if ($vendor_id == 0)
                                <img class="lazyload" src="assets/images/placeholder.png"
                                    data-src="{{ asset('assets/img/admins/' . $vendor->image) }}" alt="Vendor">
                            @else
                                @if ($vendor->photo != null)
                                    <img class="lazyload" src="assets/images/placeholder.png"
                                        data-src="{{ asset('assets/admin/img/vendor-photo/' . $vendor->photo) }}"
                                        alt="Vendor">
                                @else
                                    <img class="lazyload" src="assets/images/placeholder.png"
                                        data-src="{{ asset('assets/img/blank-user.jpg') }}" alt="Vendor">
                                @endif
                            @endif
                        </a>
                    </figure>
                    <div class="vendor-info">
                        <h5 class="mb-1 color-white">{{ $vendor->username }}</h5>
                        <span class="text-light font-sm">
                            {{ $vendor->first_name ? @$vendor->first_name : @$vendorInfo->name }}
                        </span>
                        <span class="text-light font-sm d-block">{{ __('Member since') }}
                            {{ \Carbon\Carbon::parse($vendor->created_at)->format('F Y') }}</span>
                        <span class="text-light font-sm d-block">{{ __('Total Listings') . ' : ' }}
                            @php
                                $total_vendor_listing = App\Models\Listing\Listing::where([
                                    ['vendor_id', $vendor_id],
                                    ['listings.status', '=', '1'],
                                    ['listings.visibility', '=', '1'],
                                ])
                                    ->get()
                                    ->count();
                            @endphp
                            {{ $total_vendor_listing }}
                        </span>
                    </div>
                </div>
                <ul class="list-unstyled">
                    <li class="d-inline"><a href="{{ route('index') }}">{{ __('Home') }}</a></li>
                    <li class="d-inline">/</li>
                    <li class="d-inline active opacity-75">
                        {{ __('Vendor Details') }}</li>
                </ul>
            </div>
        </div>
    </div>
    <!-- Page title end-->

    <!-- Vendor-area start -->
    <div class="vendor-area pt-100 pb-60">
        <div class="container">
            <div class="row gx-xl-5">
                <div class="col-lg-9">
                    <h4 class="title mb-20">{{ __('All Listings') }}</h4>
                    <div class="tabs-navigation tabs-navigation-3 mb-20">
                        <ul class="nav nav-tabs">
                            <li class="nav-item">
                                <button class="nav-link btn-md active" data-bs-toggle="tab" data-bs-target="#tab_all"
                                    type="button">{{ __('All Listings') }}</button>
                            </li>
                            @php
                                if (request()->filled('admin')) {
                                    $vendor_id = 0;
                                } else {
                                    $vendor_id = $vendor_id;
                                }
                            @endphp
                            @foreach ($categories as $category)
                                @php
                                    $category_id = $category->id;
                                    $listings_count = App\Models\Listing\Listing::join(
                                        'listing_contents',
                                        'listing_contents.listing_id',
                                        'listings.id',
                                    )
                                        ->where([
                                            ['vendor_id', $vendor_id],
                                            ['listings.status', '=', '1'],
                                            ['listings.visibility', '=', '1'],
                                        ])
                                        ->where('listing_contents.language_id', $language->id)
                                        ->where('listing_contents.category_id', $category_id)
                                        ->get()
                                        ->count();
                                @endphp
                                @if ($listings_count > 0)
                                    <li class="nav-item">
                                        <button class="nav-link btn-md" data-bs-toggle="tab"
                                            data-bs-target="#tab_{{ $category->id }}"
                                            type="button">{{ $category->getName($language->id) }}</button>
                                    </li>
                                @endif
                            @endforeach
                        </ul>
                    </div>
                    <div class="tab-content" data-aos="fade-up">
                        <div class="tab-pane fade show active" id="tab_all">
                            <div class="row">
                                @if (count($listings) > 0)
                                    @foreach ($listings as $listing)
                                        @php
                                            $listing_content = App\Models\Listing\ListingContent::where([
                                                ['language_id', $language->id],
                                                ['listing_id', $listing->id],
                                            ])->first();
                                            $total_review = App\Models\Listing\ListingReview::where(
                                                'listing_id',
                                                $listing->id,
                                            )->count();
                                            $today_date = now()->format('Y-m-d');
                                            $feature = App\Models\FeatureOrder::where('order_status', '=', 'completed')
                                                ->where('listing_id', $listing->id)
                                                ->whereDate('end_date', '>=', $today_date)
                                                ->first();
                                        @endphp
                                        @if (!empty($listing_content))
                                            <div class="col-md-6 col-xl-4" data-aos="fade-up">
                                                <div
                                                    class="product-default border radius-md mb-25 @if ($feature) active @endif">
                                                    <figure class="product-img">
                                                        <a href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing->id]) }}"
                                                            class="lazy-container ratio ratio-2-3">
                                                            <img class="lazyload"
                                                                data-src="{{ asset('assets/img/listing/' . $listing->feature_image) }}"
                                                                alt="{{ optional($listing_content)->title }}">
                                                        </a>

                                                        @if (Auth::guard('web')->check())
                                                            @php
                                                                $user_id = Auth::guard('web')->user()->id;
                                                                $checkWishList = checkWishList(
                                                                    $listing_content->id,
                                                                    $user_id,
                                                                );
                                                            @endphp
                                                        @else
                                                            @php
                                                                $checkWishList = false;
                                                            @endphp
                                                        @endif
                                                        <a href="{{ $checkWishList == false ? route('addto.wishlist', $listing_content->id) : route('remove.wishlist', $listing_content->id) }}"
                                                            class="btn-icon {{ $checkWishList == false ? '' : 'wishlist-active' }}"
                                                            data-tooltip="tooltip" data-bs-placement="top"
                                                            title="{{ $checkWishList == false ? __('Save to Wishlist') : __('Saved') }}">
                                                            <i class="fal fa-heart"></i>
                                                        </a>
                                                    </figure>

                                                    <div class="product-details">
                                                            <a href="{{ route('frontend.listings', ['category_id' => $listing_content->category_id]) }}"
                                                                title="Link" class="product-category font-sm icon-start">
                                                                <i
                                                                    class="{{ $listing_content->icon }}"></i>{{ $listing_content->category_name }}
                                                        </a>

                                                        <h5 class="product-title mb-10 mt-1">
                                                            <a
                                                                href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing->id]) }}">{{ optional($listing_content)->title }}</a>
                                                        </h5>
                                                        <div class="product-ratings mb-10">
                                                            <div class="ratings">
                                                                <div class="rate"
                                                                    style="background-image:url('{{ asset($rateStar) }}')">
                                                                    <div class="rating-icon"
                                                                        style="background-image: url('{{ asset($rateStar) }}'); width: {{ $listing->average_rating * 20 . '%;' }}">
                                                                    </div>
                                                                </div>
                                                                <span
                                                                    class="ratings-total font-xsm">({{ number_format($listing->average_rating, 2) }})</span>
                                                                <span
                                                                    class="ratings-total color-medium ms-2">{{ $listing_content->review_count }}
                                                                    {{ $total_review }} {{ __('Reviews') }}</span>
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
                                                        <div
                                                            class="d-flex align-items-center justify-content-between mt-10 pt-10 border-top">

                                                            @if ($listing_content->max_price && $listing_content->min_price)
                                                                <div class="product-price">
                                                                    <span
                                                                        class="color-medium me-2">{{ __('From') }}</span>
                                                                    <h6 class="price mb-0 lh-1">
                                                                        {{ $currencyInfo->base_currency_symbol }}{{ $listing_content->min_price }}
                                                                        -
                                                                        {{ $currencyInfo->base_currency_symbol }}{{ $listing_content->max_price }}
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
                                                        </div>
                                                    </div>
                                                </div><!-- product-default -->
                                            </div>
                                        @endif
                                    @endforeach
                                @else
                                    <h4 class="text-center mt-4 mb-4">{{ __('NO LISTING FOUND') }}</h4>
                                @endif
                            </div>
                        </div>
                        @foreach ($categories as $category)
                            @php
                                $category_id = $category->id;
                                $listings = App\Models\Listing\Listing::join(
                                    'listing_contents',
                                    'listing_contents.listing_id',
                                    'listings.id',
                                )
                                    ->where([
                                        ['vendor_id', $vendor_id],
                                        ['listings.status', '=', '1'],
                                        ['listings.visibility', '=', '1'],
                                    ])
                                    ->where('listing_contents.language_id', $language->id)
                                    ->where('listing_contents.category_id', $category_id)
                                    ->select('listings.*', 'listing_contents.slug', 'listing_contents.title')
                                    ->orderBy('id', 'desc')
                                    ->get();
                            @endphp
                            @if (count($listings) > 0)
                                <div class="tab-pane fade" id="tab_{{ $category->id }}">
                                    <div class="row">
                                        @foreach ($listings as $listing)
                                            @php
                                                $listing_content = App\Models\Listing\ListingContent::where([
                                                    ['language_id', $language->id],
                                                    ['listing_id', $listing->id],
                                                ])->first();
                                                $total_review = App\Models\Listing\ListingReview::where(
                                                    'listing_id',
                                                    $listing->id,
                                                )->count();
                                                $today_date = now()->format('Y-m-d');
                                                $feature = App\Models\FeatureOrder::where(
                                                    'order_status',
                                                    '=',
                                                    'completed',
                                                )
                                                    ->where('listing_id', $listing->id)
                                                    ->whereDate('end_date', '>=', $today_date)
                                                    ->first();
                                            @endphp
                                            @if (!empty($listing_content))
                                                <div class="col-md-6 col-xl-4" data-aos="fade-up">
                                                    <div
                                                        class="product-default border radius-md mb-25 @if ($feature) active @endif">
                                                        <figure class="product-img">
                                                            <a href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing->id]) }}"
                                                                class="lazy-container ratio ratio-2-3">
                                                                <img class="lazyload"
                                                                    data-src="{{ asset('assets/img/listing/' . $listing->feature_image) }}"
                                                                    alt="{{ optional($listing_content)->title }}">
                                                            </a>

                                                            @if (Auth::guard('web')->check())
                                                                @php
                                                                    $user_id = Auth::guard('web')->user()->id;
                                                                    $checkWishList = checkWishList(
                                                                        $listing_content->id,
                                                                        $user_id,
                                                                    );
                                                                @endphp
                                                            @else
                                                                @php
                                                                    $checkWishList = false;
                                                                @endphp
                                                            @endif
                                                            <a href="{{ $checkWishList == false ? route('addto.wishlist', $listing_content->id) : route('remove.wishlist', $listing_content->id) }}"
                                                                class="btn-icon {{ $checkWishList == false ? '' : 'wishlist-active' }}"
                                                                data-tooltip="tooltip" data-bs-placement="top"
                                                                title="{{ $checkWishList == false ? __('Save to Wishlist') : __('Saved') }}">
                                                                <i class="fal fa-heart"></i>
                                                            </a>
                                                        </figure>

                                                        <div class="product-details">
                                                            <a href="{{ route('frontend.listings', ['category_id' => $listing_content->category_id]) }}"
                                                                title="Link"
                                                                class="product-category font-sm icon-start">
                                                                <i
                                                                    class="{{ $listing_content->icon }}"></i>{{ $listing_content->category_name }}
                                                            </a>

                                                            <h5 class="product-title mb-10 mt-1">
                                                                <a
                                                                    href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing->id]) }}">{{ optional($listing_content)->title }}</a>
                                                            </h5>
                                                            <div class="product-ratings mb-10">
                                                                <div class="ratings">
                                                                    <div class="rate"
                                                                        style="background-image: url('{{ asset($rateStar) }}')">
                                                                        <div class="rating-icon"
                                                                            style="background-image: url('{{ asset($rateStar) }}'); width: {{ $listing->average_rating * 20 . '%;' }}">
                                                                        </div>
                                                                    </div>
                                                                    <span
                                                                        class="ratings-total font-xsm">({{ number_format($listing->average_rating, 2) }})</span>
                                                                    <span
                                                                        class="ratings-total color-medium ms-2">{{ $listing_content->review_count }}
                                                                        {{ $total_review }} {{ __('Reviews') }}</span>
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

                                                            <div
                                                                class="d-flex align-items-center justify-content-between mt-10 pt-10 border-top">

                                                                @if ($listing_content->max_price && $listing_content->min_price)
                                                                    <div class="product-price">
                                                                        <span
                                                                            class="color-medium me-2">{{ __('From') }}</span>
                                                                        <h6 class="price mb-0 lh-1">
                                                                            {{ $currencyInfo->base_currency_symbol }}{{ $listing_content->min_price }}
                                                                            -
                                                                            {{ $currencyInfo->base_currency_symbol }}{{ $listing_content->max_price }}
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
                                                            </div>
                                                        </div>
                                                    </div><!-- product-default -->
                                                </div>
                                            @endif
                                        @endforeach
                                    </div>
                                </div>
                            @endif
                        @endforeach
                    </div>
                    @if (!empty(showAd(3)))
                        <div class="text-center mb-4">
                            {!! showAd(3) !!}
                        </div>
                    @endif
                </div>
                <div class="col-lg-3">
                    <aside class="widget-area" data-aos="fade-up">
                        <div class="widget-vendor mb-40 border p-3">
                            <div class="vendor mb-20 text-center">
                                <figure class="vendor-img mx-auto mb-15">
                                    <div class="lazy-container ratio ratio-1-1 radius-md">

                                        @if ($vendor_id == 0)
                                            <img class="lazyload" src="assets/images/placeholder.png"
                                                data-src="{{ asset('assets/img/admins/' . $vendor->image) }}"
                                                alt="Vendor">
                                        @else
                                            @if ($vendor->photo != null)
                                                <img class="lazyload"
                                                    data-src="{{ asset('assets/admin/img/vendor-photo/' . $vendor->photo) }}"
                                                    alt="Vendor">
                                            @else
                                                <img class="lazyload" data-src="{{ asset('assets/img/blank-user.jpg') }}"
                                                    alt="Vendor">
                                            @endif
                                        @endif
                                    </div>
                                </figure>
                                <div class="vendor-info">
                                    <h5 class="mb-1">{{ $vendor->username }}</h5>
                                    <span class="verification">
                                        {{ $vendor->first_name ? @$vendor->first_name : @$vendorInfo->name }}
                                    </span>
                                </div>
                            </div>
                            <!-- about text -->
                            @if (request()->input('admin') == true)
                                @if (!is_null($vendor->details))
                                    <div class="font-sm">
                                        <div class="click-show">
                                            <p class="text mb-0">
                                                <span class="color-dark"><b>{{ __('About') . ':' }}</b></span>
                                                {{ $vendor->details }}
                                            </p>
                                        </div>
                                        <div class="read-more-btn"><span>{{ __('Read more') }}</span></div>
                                    </div>
                                @endif
                            @else
                                @if (!is_null(@$vendorInfo->details))
                                    <div class="font-sm">
                                        <div class="click-show">
                                            <p class="text mb-0">
                                                <span class="color-dark"><b>{{ __('About') . ':' }}</b></span>
                                                {{ @$vendorInfo->details }}
                                            </p>
                                        </div>
                                        <div class="read-more-btn"><span>{{ __('Read more') }}</span></div>
                                    </div>
                                @endif
                            @endif
                            <hr>
                            <!-- Toggle list start -->
                            <ul class="toggle-list list-unstyled mt-15" id="toggleList" data-toggle-show="6">
                                <li>
                                    <span class="first">{{ __('Total Listings') . ':' }}</span>
                                    <span class="last">{{ $total_vendor_listing }} </span>
                                </li>

                                @if ($vendor->show_email_addresss == 1)
                                    <li>
                                        <span class="first">{{ __('Email') . ':' }}</span>
                                        <span class="last"><a
                                                href="mailto:{{ $vendor->email }}">{{ $vendor->email }}</a></span>
                                    </li>
                                @endif

                                @if ($vendor->show_phone_number == 1)
                                    <li>
                                        <span class="first">{{ __('Phone') }}</span>
                                        <span class="last"><a
                                                href="tel:{{ $vendor->phone }}">{{ $vendor->phone != null ? $vendor->phone : '-' }}</a></span>
                                    </li>
                                @endif

                                @if (request()->input('admin') != true)
                                    @if (!is_null(@$vendorInfo->city))
                                        <li>
                                            <span class="first">{{ __('City') . ':' }}</span>
                                            <span class="last">{{ @$vendorInfo->city }}</span>
                                        </li>
                                    @endif

                                    @if (!is_null(@$vendorInfo->state))
                                        <li>
                                            <span class="first">{{ __('State') . ':' }}</span>
                                            <span class="last">{{ @$vendorInfo->state }}</span>
                                        </li>
                                    @endif

                                    @if (!is_null(@$vendorInfo->country))
                                        <li>
                                            <span class="first">{{ __('Country') . ':' }}</span>
                                            <span class="last">{{ @$vendorInfo->country }}</span>
                                        </li>
                                    @endif
                                @endif

                                @if (request()->input('admin') == true)
                                    <li>
                                        <span class="first">{{ __('Address') . ' : ' }}</span>
                                        <span
                                            class="last">{{ $vendor->address != null ? $vendor->address : '-' }}</span>
                                    </li>
                                @else
                                    <li>
                                        <span class="first">{{ __('Address') . ' : ' }}</span>
                                        <span
                                            class="last">{{ @$vendorInfo->address != null ? @$vendorInfo->address : '-' }}</span>
                                    </li>
                                @endif

                                @if (request()->input('admin') != true)
                                    @if (!is_null(@$vendorInfo->zip_code))
                                        <li>
                                            <span class="first">{{ __('Zip Code') . ':' }}</span>
                                            <span class="last">{{ @$vendorInfo->zip_code }}</span>
                                        </li>
                                    @endif
                                @endif


                                @if (request()->input('admin') != true)
                                    <li>
                                        <span class="first">{{ __('Member since') . ':' }}</span>
                                        <span
                                            class="last font-sm">{{ \Carbon\Carbon::parse($vendor->created_at)->format('F Y') }}</span>
                                    </li>
                                @endif

                            </ul>
                            <span class="show-more-btn" data-toggle-btn="toggleListBtn">
                                {{ __('Show More') . ' +' }}
                            </span>
                            <hr>
                            <!-- Toggle list end -->
                            @if ($vendor->show_contact_form == 1)
                                <div class="cta-btn mt-20">
                                    <button class="btn btn-lg btn-primary w-100" data-bs-toggle="modal"
                                        data-bs-target="#contactModal" type="button"
                                        aria-label="button">{{ __('Contact Now') }}</button>
                                </div>
                            @endif
                        </div>

                        @if (!empty(showAd(1)))
                            <div class="text-center mb-40">
                                {!! showAd(1) !!}
                            </div>
                        @endif
                    </aside>
                </div>
            </div>
        </div>
    </div>
    <!-- Vendor-area end -->

    <!-- Contact Modal -->
    <div class="modal contact-modal fade" id="contactModal" tabindex="-1" aria-labelledby="contactModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title mb-0" id="contactModalLabel">{{ __('Contact Now') }}</h1>
                        <button type="button" class="btn-close m-0" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="{{ route('vendor.contact.message') }}" method="POST" id="vendorContactForm">
                        @csrf
                        <input type="hidden" name="vendor_email" value="{{ $vendor->email }}">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="form-group mb-20">
                                    <input type="text" class="form-control"
                                        placeholder="{{ __('Enter Your Full Name') }}" name="name" required>
                                    <p class="text-danger em" id="err_name"></p>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="form-group mb-20">
                                    <input type="email" class="form-control"
                                        placeholder="{{ __('Enter Your Email') }}" name="email" required>
                                    <p class="text-danger em" id="err_email"></p>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="form-group mb-20">
                                    <input type="text" class="form-control" placeholder="{{ __('Enter Subject') }}"
                                        name="subject" required>
                                    <p class="text-danger em" id="err_subject"></p>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="form-group mb-20">
                                    <textarea name="message" class="form-control"required placeholder="{{ __('Message') }}"></textarea>
                                    <p class="text-danger em" id="err_message"></p>
                                </div>
                            </div>
                            @if ($info->google_recaptcha_status == 1)
                                <div class="col-md-12">
                                    <div class="form-group mb-20">
                                        {!! NoCaptcha::renderJs() !!}
                                        {!! NoCaptcha::display() !!}
                                        <p class="text-danger em" id="err_g-recaptcha-response"></p>
                                    </div>
                                </div>
                            @endif
                            <div class="col-lg-12 text-center">
                                <button class="btn btn-lg btn-primary" id="vendorSubmitBtn" type="submit"
                                    aria-label="button">{{ __('Send message') }}</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
@endsection
