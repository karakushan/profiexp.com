@extends('frontend.layout')

@section('pageHeading')
    {{ __('Home') }}
@endsection
@section('metaKeywords')
    @if (!empty($seoInfo))
        {{ $seoInfo->meta_keyword_home }}
    @endif
@endsection

@section('metaDescription')
    @if (!empty($seoInfo))
        {{ $seoInfo->meta_description_home }}
    @endif
@endsection

@section('content')
    <!-- Home-area start-->
    <section class="hero-banner hero-banner-2 @if (count($cities) < 1) no-city @endif">
        <!-- Background Image -->

        @if ($heroSectionImage)
            <img class="lazyload blur-up bg-img" alt="Bg-img"
                src="{{ asset('assets/img/hero-section/' . $heroSectionImage) }}">
        @else
            <img class="lazyload blur-up bg-img" alt="Bg-img" data-src="{{ asset('assets/img/noimage.jpg') }}" alt="Banner">
        @endif

        <div class="overlay opacity-80"></div>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-xl-8 col-lg-10">
                    <div class="content text-center">
                        <h1 class="title mb-10 color-white" data-aos="fade-up">
                            {{ !empty($heroSection->title) ? $heroSection->title : 'Are You Looking For A business?' }}
                        </h1>
                        <p class="text color-light mb-30 mx-auto" data-aos="fade-up" data-aos-delay="100">
                            {{ !empty($heroSection->text) ? $heroSection->text : '' }}
                        </p>
                    </div>
                    <div class="banner-filter-form" data-aos="fade-up" data-aos-delay="150">
                        <div class="form-wrapper radius-xl">
                            <form action="{{ route('frontend.listings') }}" id="searchForm2" method="GET">
                                <div class="row align-items-center gx-xl-3">
                                    <div class="col-lg-3 col-md-6">
                                        <div class="input-group border-end">
                                            <label for="search"><i class="ico-shopping-mall"></i></label>
                                            <input type="text" name="title" id="title" class="form-control"
                                                placeholder="{{ __('I’m Looking for') }}">
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="input-group border-end">
                                            <label for="category"><i class="ico-category"></i></label>
                                            <select aria-label="categories" id="category_id" name="category_id"
                                                class="select2 js-example-basic-single1">

                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-6">
                                        <div class="input-group">
                                            <label for="location"><i class="ico-location-pin"></i></label>
                                            <input type="text" name="location" id="search-address" class="form-control"
                                                placeholder="{{ __('Location') }}">
                                            @if ($basicInfo->google_map_api_key_status == 1)
                                                <button type="button"
                                                    class="btn btn-primary current-location-btn mt-2 btn-sm float-right"
                                                    onclick="getCurrentLocationHome()">
                                                    <i class="fas fa-location"></i>
                                                </button>
                                            @endif
                                        </div>
                                    </div>
                                    <div class="col-lg-2 col-md-6">
                                        <button type="button" id="searchBtn2"
                                            class="btn btn-lg btn-primary rounded-pill icon-start w-100">
                                            <i class="fal fa-search"></i>
                                            <span class="d-lg-none">
                                                {{ __('Search Now') }}
                                            </span>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Home-area end -->

    @if ($secInfo->location_section_status == 1)
        <!-- City-area start -->
        <div class="city-area spacer-negative @if (count($cities) < 1) mt-0 pt-100 @endif">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-10">

                        <div class="swiper px-3" id="city-slider-1" data-aos="fade-up">
                            <div class="swiper-wrapper">
                                @foreach ($cities as $city)
                                    <div class="swiper-slide">
                                        <div class="card radius-0">
                                            <a href="{{ route('frontend.listings', ['city' => $city->id]) }}">
                                                <div class="card-img">
                                                    <div class="lazy-container ratio ratio-1-3">
                                                        <img class="lazyload"
                                                            src="{{ $city->feature_image ? asset('assets/img/location/city/' . $city->feature_image) : asset('assets/admin/img/noimage.jpg') }}"
                                                            alt="{{ $city->name }}">
                                                    </div>
                                                </div>
                                                <div class="card-text text-center">
                                                    <h5 class="card-title color-white mb-1">{{ $city->name }}</h5>
                                                    <span class="font-sm">{{ $city->listing_city_count }}
                                                        {{ __('Listing') }}</span>
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                @endforeach

                            </div>
                            <!-- Slider navigation buttons -->
                            <div class="slider-navigation">
                                <button type="button" title="Slide prev" class="slider-btn btn-outline rounded-pill"
                                    id="city-slider-btn-prev">
                                    <i class="fal fa-angle-left"></i>
                                </button>
                                <button type="button" title="Slide next" class="slider-btn btn-outline rounded-pill"
                                    id="city-slider-btn-next">
                                    <i class="fal fa-angle-right"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- City-area end -->
    @endif

    <!-- Category-area start -->
    @if ($secInfo->category_section_status == 1)
        <section class="category-area category-2 pt-100 pb-70 has-grid">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="section-title title-inline mb-20" data-aos="fade-up">
                            <h2 class="title mb-20">{{ $catgorySecInfo ? $catgorySecInfo->title : 'CATEGORIES' }}</h2>
                        </div>
                    </div>
                    <div class="col-12">
                        @if (count($categories) < 1)
                            <div class="text-center">
                                <h3 class="mb-0">{{ __('NO CATEGORY FOUND') . '!' }}</h3>
                            </div>
                        @else
                            <div class="row category-grid gy-4" data-aos="fade-up" data-aos-delay="100">
                                @foreach ($categories as $key => $category)
                                    <div class="col-xl-3 col-lg-4 col-md-4 col-sm-6 category-grid-item {{ $key >= 8 ? 'd-none' : '' }}">
                                        <a
                                            href="{{ route('frontend.listings', ['category_id' => $category->slug]) }}">
                                            <div class="category-item border radius-md text-center">
                                                <div class="category-icon">
                                                    <i class="{{ $category->icon }}"></i>
                                                </div>
                                                <h3 class="category-title mb-0">{{ $category->name }}</h3>
                                                <span
                                                    class="category-qty">{{ $category->listing_contents_count }}</span>
                                            </div>
                                        </a>
                                    </div>
                                @endforeach
                            </div>
                        @endif
                    </div>
                    @if (count($categories) > 8)
                        <div class="col-12 text-center category-show-more-wrapper" data-aos="fade-up">
                            <a href="#" class="btn btn-lg btn-primary rounded-pill category-show-more">
                                <span class="show-more-text">{{ __('Show All Categories') }}</span>
                                <span class="show-less-text d-none">{{ __('Show Less') }}</span>
                            </a>
                        </div>
                    @endif
                </div>
            </div>
            <!-- Bg Shape -->
            <div class="shape">
                <img class="shape-1" src="{{ asset('assets/front/images/shape/shape-9.svg') }}" alt="Shape">
                <img class="shape-2" src="{{ asset('assets/front/images/shape/shape-10.svg') }}" alt="Shape">
            </div>
        </section>
    @endif
    <!-- Category-area end -->

    <!--Featured Product-area start -->
    @if ($secInfo->featured_listing_section_status == 1)
        <section class="product-area pt-100 pb-60">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-3">
                        <div class="content-title mb-40" data-aos="fade-up">
                            <h2 class="title mb-15">{{ $listingSecInfo ? $listingSecInfo->title : __('LISTINGS') }}</h2>
                            <p class="text mb-20">
                                {{ @$listingSecInfo->subtitle }}
                            </p>
                            @if (count($total_listing_contents) > count($listing_contents))
                                <a href="{{ route('frontend.listings') }}"
                                    class="btn btn-lg btn-primary rounded-pill">{{ $listingSecInfo ? $listingSecInfo->button_text : __('More') }}</a>
                            @endif
                        </div>
                    </div>
                    <div class="col-lg-9">
                        @if (count($listing_contents) < 1)
                            <h3 class="text-center mt-2">{{ __('NO LISTING FOUND') }}</h3>
                        @else
                            <div class="swiper mb-40" id="product-slider-1">
                                <div class="swiper-wrapper">

                                    @foreach ($listing_contents as $listing_content)
                                        <div class="swiper-slide" data-aos="fade-up">
                                            <div class="product-default border radius-md mb-25">
                                                <figure class="product-img">
                                                    <a href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing_content->id]) }}"
                                                        class="lazy-container ratio ratio-2-3">
                                                        <img class="lazyload"
                                                            data-src="{{ asset('assets/img/listing/' . $listing_content->feature_image) }}"
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
                                                                    <img class="lazyload"
                                                                        src="assets/images/placeholder.png"
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
                                                            $categorySlug = App\Models\ListingCategory::findorfail(
                                                                $listing_content->category_id,
                                                            );
                                                        @endphp

                                                        <a href="{{ route('frontend.listings', ['category_id' => $categorySlug->slug]) }}"
                                                            title="Link" class="product-category font-sm icon-start">
                                                            <i
                                                                class="{{ $listing_content->icon }}"></i>{{ $listing_content->category_name }}
                                                        </a>
                                                    </div>
                                                    <h5 class="product-title mb-10"><a
                                                            href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing_content->id]) }}">
                                                            {{ optional($listing_content)->title }}</a></h5>

                                                    <div class="product-ratings mb-10">
                                                        <div class="ratings">
                                                            <div class="rate"
                                                                style="background-image:url('{{ asset($rateStar) }}')">
                                                                <div class="rating-icon"
                                                                    style="background-image:url('{{ asset($rateStar) }}'); width: {{ $listing_content->average_rating * 20 . '%;' }}">
                                                                </div>
                                                            </div>
                                                            <span
                                                                class="ratings-total font-sm">({{ $listing_content->average_rating }})</span>
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
                                                            class="fal fa-map-marker-alt"></i>{{ $location }}
                                                    </span>
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
                                                                <span class="color-medium font-sm"><i
                                                                class="fas fa-tag me-1 text-primary"></i>{{ __('Price Not Mentioned') }}</span>
                                                            </div>
                                                        @endif
                                                    </div>
                                                </div>
                                            </div><!-- product-default -->
                                        </div>
                                    @endforeach

                                </div>
                                <!-- Slider pagination -->
                                <div class="swiper-pagination position-static" id="product-slider-1-pagination"></div>
                            </div>
                        @endif
                    </div>
                </div>
            </div>
            <!-- Bg Shape -->
            <div class="shape">
                <img class="shape-1" src="{{ asset('assets/front/images/shape/shape-11.svg') }}" alt="Shape">
                <img class="shape-2" src="{{ asset('assets/front/images/shape/shape-12.svg') }}" alt="Shape">
            </div>
        </section>
    @endif
    <!-- Product-area end -->

    <!-- Video banner start -->
    @if ($secInfo->video_section == 1)
        <section class="video-banner pt-100 pb-60">
            <!-- Background Image -->
            <img class="lazyload bg-img blur-up" src="{{ asset('assets/img/' . $videoSectionImage) }}" alt="Bg-img">
            <div class="overlay opacity-75"></div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-5">
                        <div class="content-title mb-40" data-aos="fade-up">
                            <h2 class="title color-white mb-10">{{ @$videoSecInfo->title }}</h2>
                            <p class="color-light mb-20 w-75 w-sm-100">{{ @$videoSecInfo->subtitle }}</p>
                            @if (@$videoSecInfo->button_url && @$videoSecInfo->button_name)
                                <a href="{{ @$videoSecInfo->button_url }}" class="btn btn-lg btn-primary rounded-pill"
                                    target="_blank">{{ @$videoSecInfo->button_name }}</a>
                            @endif
                        </div>
                    </div>
                    @if (@$videoSecInfo->video_url)
                        <div class="col-lg-7 py-4 py-lg-0">
                            <div class="h-100 position-relative mb-40" data-aos="fade-up">
                                <a href="{{ @$videoSecInfo->video_url }}"
                                    class="video-btn youtube-popup position-absolute top-50 start-50 translate-middle">
                                    <i class="fas fa-play"></i>
                                </a>
                            </div>
                        </div>
                    @endif
                </div>
            </div>
        </section>
    @endif
    <!-- Video banner end -->

    <!--Latest Product-area start -->
    @if ($secInfo->latest_listing_section_status == 1)
        <section class="product-area pt-100">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="section-title title-center" data-aos="fade-up">
                            <h2 class="title mb-30">{{ $featuredSecInfo ? $featuredSecInfo->title : __('LISTINGS') }} </h2>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="tab-content">
                            <div class="tab-pane fade active show">
                                <div class="row">
                                    @if (count($latest_listing_contents) < 1)
                                        <h3 class="text-center mt-2">{{ __('NO LISTING FOUND') }}</h3>
                                    @else
                                        @foreach ($latest_listing_contents as $listing_content)
                                            <div class="col-xl-3 col-lg-4 col-sm-6" data-aos="fade-up">
                                                <div class="product-default border radius-md mb-25">
                                                    <figure class="product-img">
                                                        <a href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing_content->id]) }}"
                                                            class="lazy-container ratio ratio-2-3">
                                                            <img class="lazyload"
                                                                data-src="{{ asset('assets/img/listing/' . $listing_content->feature_image) }}"
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
                                                                        <img class="lazyload"
                                                                            src="assets/images/placeholder.png"
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
                                                                $categorySlug = App\Models\ListingCategory::findorfail(
                                                                    $listing_content->category_id,
                                                                );
                                                            @endphp

                                                            <a href="{{ route('frontend.listings', ['category_id' => $categorySlug->slug]) }}"
                                                                title="Link"
                                                                class="product-category font-sm icon-start">
                                                                <i
                                                                    class="{{ $listing_content->icon }}"></i>{{ $listing_content->category_name }}
                                                            </a>
                                                        </div>
                                                        <h5 class="product-title mb-10"><a
                                                                href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing_content->id]) }}">{{ optional($listing_content)->title }}</a>
                                                        </h5>

                                                        <div class="product-ratings mb-10">
                                                            <div class="ratings">
                                                                <div class="rate"
                                                                    style="background-image:url('{{ asset($rateStar) }}')">
                                                                    <div class="rating-icon"
                                                                        style="background-image:url('{{ asset($rateStar) }}'); width: {{ $listing_content->average_rating * 20 . '%;' }}">
                                                                    </div>
                                                                </div>
                                                                <span
                                                                    class="ratings-total font-sm">({{ $listing_content->average_rating }})</span>
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
                                                                class="fal fa-map-marker-alt"></i>{{ $location }}
                                                        </span>
                                                        <div class="d-flex align-items-center justify-content-between mt-10 pt-10 border-top">
                                                        @if ($listing_content->max_price && $listing_content->min_price)
                                                            <div class="product-price ">
                                                                <span class="color-medium me-2">{{ __('From') }}</span>
                                                                <h6 class="price mb-0 lh-1">
                                                                    {{ symbolPrice($listing_content->min_price) }} -
                                                                    {{ symbolPrice($listing_content->max_price) }}
                                                                </h6>
                                                            </div>
                                                          @else
                                                                <div class="product-price">
                                                                    <span class="color-medium font-sm"><i
                                                                            class="fas fa-tag me-1 text-primary"></i>{{ __('Price Not Mentioned') }}</span>
                                                                </div>
                                                        @endif
                                                      </div>
                                                    </div>
                                                </div><!-- product-default -->
                                            </div>
                                        @endforeach
                                    @endif
                                </div>
                            </div>
                        </div>
                        @if (count($latest_listing_content_total) > count($listing_contents))
                            <div class="text-center mt-20">
                                <a href="{{ route('frontend.listings') }}"
                                    class="btn btn-lg btn-primary rounded-pill">{{ $featuredSecInfo ? $featuredSecInfo->button_text : __('More') }}</a>
                            </div>
                        @endif
                    </div>
                </div>
            </div>
            <!-- Bg Shape -->
            <div class="shape">
                <img class="shape-1" src="{{ asset('assets/front/images/shape/shape-13.svg') }}" alt="Shape">
                <img class="shape-2" src="{{ asset('assets/front/images/shape/shape-16.svg') }}" alt="Shape">
                <img class="shape-3" src="{{ asset('assets/front/images/shape/shape-15.svg') }}" alt="Shape">
                <img class="shape-4" src="{{ asset('assets/front/images/shape/shape-14.svg') }}" alt="Shape">
            </div>

        </section>
    @endif
    <!-- Product-area end -->

    <!-- Pricing-area start -->
    @if ($secInfo->package_section_status == 1)
        <section class="pricing-area pt-100 pb-75">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="section-title title-center mb-40" data-aos="fade-up">
                            <h2 class="title">{{ $packageSecInfo ? $packageSecInfo->title : 'Most Affordable Package' }}
                            </h2>
                        </div>
                        <div class="tabs-navigation tabs-navigation-2 text-center mb-40" data-aos="fade-up">
                            <ul class="nav nav-tabs rounded-pill" data-hover="fancyHover">
                                @php
                                    $totalTerms = count($terms);
                                    $middleTerm = intdiv($totalTerms, 2);
                                @endphp
                                @foreach ($terms as $index => $term)
                                    <li class="nav-item {{ $index == $middleTerm ? 'active' : '' }}">
                                        <button
                                            class="nav-link hover-effect rounded-pill {{ $index == $middleTerm ? 'active' : '' }}"
                                            data-bs-toggle="tab" data-bs-target="#{{ strtolower($term) }}"
                                            type="button">
                                            {{ __($term) }}
                                        </button>
                                    </li>
                                @endforeach
                            </ul>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="tab-content">
                            @if (count($terms) < 1)
                                <h3 class="text-center mt-2">{{ __('NO PACKAGE FOUND') }}</h3>
                            @else
                                @foreach ($terms as $index => $term)
                                    <div class="tab-pane fade {{ $index == $middleTerm ? 'show active' : '' }}"
                                        id="{{ strtolower($term) }}">
                                        <div class="row justify-content-center">
                                            @php
                                                $packages = \App\Models\Package::where('status', '1')
                                                    ->where('term', strtolower($term))
                                                    ->get();
                                                $totalItems = count($packages);
                                                $middleIndex = intdiv($totalItems, 2);
                                            @endphp
                                            @foreach ($packages as $index => $package)
                                                @php
                                                    $permissions = $package->features;
                                                    if (!empty($package->features)) {
                                                        $permissions = json_decode($permissions, true);
                                                    }
                                                @endphp
                                                <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="200">
                                                    <div
                                                        class="pricing-item radius-lg {{ $package->recommended ? 'active' : '' }} mb-30">
                                                        <div class="d-flex align-items-center">
                                                            <div class="icon"><i class="{{ $package->icon }}"></i>
                                                            </div>
                                                            <div class="label">
                                                                <h3> {{ __($package->title) }}</h3>
                                                                @if ($package->recommended == '1')
                                                                    <span>{{ __('Popular') }}</span>
                                                                @endif

                                                            </div>
                                                        </div>
                                                        <p class="text"></p>
                                                        <div class="d-flex align-items-center">
                                                            <span
                                                                class="price">{{ symbolPrice($package->price) }}</span>
                                                            @if ($package->term == 'monthly')
                                                                <span class="period">/ {{ __('Monthly') }}</span>
                                                            @elseif($package->term == 'yearly')
                                                                <span class="period">/ {{ __('Yearly') }}</span>
                                                            @elseif($package->term == 'lifetime')
                                                                <span class="period">/ {{ __('Lifetime') }}</span>
                                                            @endif
                                                        </div>
                                                        <h5>{{ __('What\'s Included') }}</h5>
                                                        <ul class="item-list list-unstyled p-0 pricing-list">
                                                            @include('frontend.partials.package-feature-list', [
                                                                'package' => $package,
                                                                'permissions' => $permissions,
                                                            ])
                                                        </ul>
                                                        @auth('vendor')
                                                            <a href="{{ route('vendor.plan.extend.checkout', $package->id) }}"
                                                                class="btn btn-outline btn-lg" title="Purchase"
                                                                target="_self">{{ __('Purchase') }}</a>
                                                        @endauth
                                                        @guest('vendor')
                                                            <a href="{{ route('vendor.login', ['redirectPath' => 'buy_plan', 'package' => $package->id]) }}"
                                                                class="btn btn-outline btn-lg" title="Purchase"
                                                                target="_self">{{ __('Purchase') }}</a>
                                                        @endguest
                                                    </div>
                                                </div>
                                            @endforeach

                                        </div>
                                    </div>
                                @endforeach
                            @endif
                        </div>
                    </div>
                </div>
            </div>
            <!-- Bg Shape -->
            <div class="shape">
                <img class="shape-1" src="{{ asset('assets/front/images/shape/shape-3.svg') }}" alt="Shape">
                <img class="shape-2" src="{{ asset('assets/front/images/shape/shape-6.svg') }}" alt="Shape">
                <img class="shape-3" src="{{ asset('assets/front/images/shape/shape-5.svg') }}" alt="Shape">
                <img class="shape-4" src="{{ asset('assets/front/images/shape/shape-2.svg') }}" alt="Shape">
            </div>
        </section>
    @endif
    <!-- Pricing-area end -->

    <!-- Testimonial-area start -->
    @if ($secInfo->testimonial_section_status == 1)
        <section class="testimonial-area testimonial-1 pb-60">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-8">
                        <div class="content w-75" data-aos="fade-up">
                            <div class="content-title">
                                <h2 class="title mb-15">
                                    {{ !empty($testimonialSecInfo->title) ? $testimonialSecInfo->title : '' }}
                                </h2>
                            </div>
                            <p class="text mb-20 w-75">
                                {{ !empty($testimonialSecInfo->subtitle) ? $testimonialSecInfo->subtitle : '' }}
                            </p>
                            <!-- Slider navigation buttons -->
                            <div class="slider-navigation">
                                <button type="button" title="Slide prev" class="slider-btn btn-outline rounded-pill"
                                    id="testimonial-slider-btn-prev">
                                    <i class="fal fa-angle-left"></i>
                                </button>
                                <button type="button" title="Slide next" class="slider-btn btn-outline rounded-pill"
                                    id="testimonial-slider-btn-next">
                                    <i class="fal fa-angle-right"></i>
                                </button>
                            </div>
                        </div>
                        <div class="swiper pt-30 mb-15" id="testimonial-slider-1">
                            <div class="swiper-wrapper">
                                @foreach ($testimonials as $testimonial)
                                    <div class="swiper-slide pb-25" data-aos="fade-up">
                                        <div class="slider-item radius-md">
                                            <div class="quote">
                                                <span class="icon"><i class="fas fa-quote-left"></i></span>
                                                <p class="text mb-0">
                                                    {{ $testimonial->comment }}
                                                </p>
                                            </div>
                                            <div class="client-info d-flex align-items-center">
                                                <div class="client-img">
                                                    <div class="lazy-container rounded-pill ratio ratio-1-1">
                                                        <img class="lazyload"
                                                            data-src="{{ asset('assets/img/clients/' . $testimonial->image) }}"
                                                            alt="Person Image">
                                                    </div>
                                                </div>
                                                <div class="content">
                                                    <h6 class="name">{{ $testimonial->name }}</h6>
                                                    <span class="designation">{{ $testimonial->occupation }}</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                @endforeach
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="img-content mb-40" data-aos="fade-left">
                            <div class="img">
                                <img class="lazyload blur-up"
                                    data-src="{{ asset('assets/img/' . $testimonialSecImage) }}" alt="Image">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Bg Shape -->
            <div class="shape">
                <img class="shape-1" src="{{ asset('assets/front/images/shape/shape-15.svg') }}" alt="Shape">
                <img class="shape-2" src="{{ asset('assets/front/images/shape/shape-14.svg') }}" alt="Shape">
                <img class="shape-3" src="{{ asset('assets/front/images/shape/shape-13.svg') }}" alt="Shape">
                <img class="shape-4" src="{{ asset('assets/front/images/shape/shape-16.svg') }}" alt="Shape">
            </div>
        </section>
    @endif
    <!-- Testimonial-area end -->

    <!-- Blog-area start -->
    @if ($secInfo->blog_section_status == 1)
        <section class="blog-area blog-2 pb-75">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="section-title title-inline mb-30" data-aos="fade-up">
                            <h2 class="title mb-20">
                                {{ !empty($blogSecInfo->title) ? $blogSecInfo->title : 'Read Our Latest Blog' }}
                            </h2>
                            @if (count($blog_count) > count($blogs))
                                <a href="{{ route('blog') }}" class="btn btn-lg btn-primary mb-20">
                                    {{ $blogSecInfo ? $blogSecInfo->button_text : __('More') }}</a>
                            @endif
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="row justify-content-center">
                            @if (count($blogs) < 1)
                                <h3 class="text-center mt-2">{{ __('NO POST FOUND') . '!' }}</h3>
                            @else
                                @foreach ($blogs as $blog)
                                    <div class="col-md-6 col-lg-4" data-aos="fade-up">
                                        <article class="card radius-md mb-25">
                                            <div class="card-img">
                                                <a href="{{ route('blog.details', ['slug' => $blog->slug]) }}"
                                                    class="lazy-container radius-md ratio ratio-16-10">
                                                    <img class="lazyload"
                                                        data-src="{{ asset('assets/img/blogs/' . $blog->image) }}"
                                                        alt="Blog Image">
                                                </a>
                                            </div>
                                            <div class="content border">
                                                <h3 class="card-title mt-1">
                                                    <a href="{{ route('blog.details', ['slug' => $blog->slug]) }}">
                                                        {{ @$blog->title }}
                                                    </a>
                                                </h3>
                                                <p class="card-text">
                                                    {{ strlen(strip_tags(convertUtf8($blog->content))) > 100 ? substr(strip_tags(convertUtf8($blog->content)), 0, 100) . '...' : strip_tags(convertUtf8($blog->content)) }}
                                                </p>
                                                <a href="{{ route('blog.details', ['slug' => $blog->slug]) }}"
                                                    class="card-btn">{{ __('Read More') }}</a>
                                            </div>
                                        </article>
                                    </div>
                                @endforeach
                            @endif
                        </div>
                    </div>
                </div>
            </div>
            <!-- Bg Shape -->
            <div class="shape">
                <img class="shape-1" src="{{ asset('assets/front/images/shape/shape-20.svg') }}" alt="Shape">
                <img class="shape-2" src="{{ asset('assets/front/images/shape/shape-18.svg') }}" alt="Shape">
                <img class="shape-3" src="{{ asset('assets/front/images/shape/shape-19.svg') }}" alt="Shape">
            </div>
        </section>
    @endif
    <!-- Blog-area end -->
    <!-- Modal -->
    @include('frontend.partials.map-modal')
@endsection

@section('script')
    <script>
        const getHomeCatUrl = "{{ route('frontend.get_home_categories') }}";
    </script>
    @if ($basicInfo->google_map_api_key_status == 1)
        <script src="{{ asset('assets/front/js/map-init.js') }}"></script>
        <script
            src="https://maps.googleapis.com/maps/api/js?key={{ $basicInfo->google_map_api_key }}&libraries=places&callback=initMap"
            async defer></script>
    @endif
    <script src="{{ asset('assets/front/js/search-home.js') }}"></script>
@endsection
