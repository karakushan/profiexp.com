@extends('frontend.layout')

@section('pageHeading')
    @if (!empty($listing))
        {{ $listing->listing_content->first()->title }}
    @endif
@endsection

@section('metaKeywords')
    @if (!empty($listing))
        {{ $listing->listing_content->first()->meta_keyword }}
    @endif
@endsection

@section('metaDescription')
    @if (!empty($listing))
        {{ $listing->listing_content->first()->meta_description }}
    @endif
@endsection
@section('sharetitle')
    @if (!empty($listing))
        {{ $listing->listing_content->first()->title }}
    @endif
@endsection
@section('shareimage')
    @if (!empty($listing))
        {{ asset('assets/img/listing/' . $listing->feature_image) }}
    @endif
@endsection

@section('content')
    @php
        if ($listing->vendor_id == 0) {
            $permissions = [
                'Listing Enquiry Form',
                'Video',
                'Amenities',
                'Feature',
                'Social Links',
                'FAQ',
                'Business Hours',
                'Products',
                'Product Enquiry Form',
                'Messenger',
                'WhatsApp',
                'Telegram',
                'Tawk.To',
            ];
        } else {
            $vendorId = $listing->vendor_id;
            $current_package = App\Http\Helpers\VendorPermissionHelper::packagePermission($vendorId);
            $permissions = $current_package->features;
            if (!empty($current_package->features)) {
                $permissions = json_decode($permissions, true);
            }
            $additionalFeatureLimit = packageTotalAdditionalSpecification($vendorId);
            $SocialLinkLimit = packageTotalSocialLink($vendorId);
        }

    @endphp

    <!-- Listing start -->
    <div class="listing-single header-next border-top pt-40 pb-60">
        <div class="container">
            <div class="row gx-xl-5">
                <div class="col-lg-8 col-xl-9">
                    <div class="product-single-details mb-40">
                        <div class="row" data-aos="fade-up">
                            <div class="col-12">
                                <h2 class="product-title mt-1 mb-2">{{ $listing->listing_content->first()->title }}</h2>
                            </div>
                            <div class="col-12">
                                <ul class="info-list list-unstyled">
                                    <li>
                                        @php
                                            $categoryId = $listing->listing_content->first()->category_id ?? null;
                                        @endphp
                                        @if ($categoryId)
                                        <a href="{{ listing_category_url($categoryId, $language->code) }}"
                                            title="Link" class="product-category font-sm icon-start">
                                            <span class="product-category color-primary icon-start">
                                                <i class="{{ $listing->listing_content->first()->category->icon }}"></i>
                                                {{ $listing->listing_content->first()->category->getName($language->id) }}
                                            </span></a>
                                        @endif
                                    </li>
                                    <li>

                                        @php
                                            $location = implode(
                                                ', ',
                                                array_filter([
                                                    $listing->listing_content->first()->city_id
                                                        ? App\Models\Location\City::find(
                                                            $listing->listing_content->first()->city_id,
                                                        )?->getName($language->id)
                                                        : null,
                                                    $listing->listing_content->first()->state_id
                                                        ? App\Models\Location\State::find(
                                                            $listing->listing_content->first()->state_id,
                                                        )?->getName($language->id)
                                                        : null,
                                                    $listing->listing_content->first()->country_id
                                                        ? App\Models\Location\Country::find(
                                                            $listing->listing_content->first()->country_id,
                                                        )?->getName($language->id)
                                                        : null,
                                                ]),
                                            );
                                        @endphp

                                        <span class="product-location icon-start">
                                            <i class="fal fa-map-marker-alt"></i>
                                            {{ $location }}
                                        </span>
                                    </li>
                                    <li>
                                        <div class="ratings">
                                            <div class="rate" style="background-image:url('{{ asset($rateStar) }}')">
                                                <div class="rating-icon"
                                                    style="background-image: url('{{ asset($rateStar) }}'); width: {{ $listing->average_rating * 20 . '%;' }}">
                                                </div>
                                            </div>
                                            <span
                                                class="ratings-total">({{ number_format($listing->average_rating, 2) }})</span>
                                            <span class="ratings-total ms-1">{{ $numOfReview }}
                                                {{ __('Reviews') }}</span>
                                        </div>
                                    </li>

                                    @if ($listing->min_price || $listing->max_price)
                                        <li>
                                            <span class="ratings-total ms-1">
                                                @if ($listing->min_price && $listing->max_price)
                                                    {{ __('From') }} :{{ symbolPrice($listing->min_price) }} -
                                                    {{ symbolPrice($listing->max_price) }}
                                                @else
                                                    {{ symbolPrice($listing->min_price ?: $listing->max_price) }}
                                                @endif
                                            </span>
                                        </li>
                                    @else
                                        <li>
                                            <div class="product-price ">
                                                <span class="color-medium font-sm">
                                                    <i class="fas fa-tag me-1 text-primary"></i>
                                                    {{ __('Price Not Mentioned') }}
                                                </span>
                                            </div>
                                        </li>
                                    @endif
                                    <li>
                                        <a class="btn blue icon-start" href="#" data-bs-toggle="modal"
                                            data-bs-target="#socialMediaModal">
                                            <i class="far fa-share-alt"></i>
                                            {{ __('Share') }}
                                        </a>
                                    </li>
                                    <li>
                                        @if (Auth::guard('web')->check())
                                            @php
                                                $user_id = Auth::guard('web')->user()->id;
                                                $checkWishList = checkWishList($listing->id, $user_id);
                                            @endphp
                                        @else
                                            @php
                                                $checkWishList = false;
                                            @endphp
                                        @endif
                                        <a href="{{ $checkWishList == false ? route('addto.wishlist', ['id' => $listing->id]) : route('remove.wishlist', ['id' => $listing->id]) }}"
                                            class="btn btn-icon icon-start {{ $checkWishList == false ? '' : 'wishlist-active' }}"
                                            data-tooltip="tooltip" data-bs-placement="right"
                                            title="{{ $checkWishList == false ? __('Save to Wishlist') : __('Saved') }}">
                                            <i
                                                class="fal fa-heart"></i>{{ $checkWishList == false ? __('Save') : __('Saved') }}
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="product-single-gallery gallery-popup" data-aos="fade">
                        <!-- Slider navigation buttons -->
                        <div class="slider-navigation">
                            <button type="button" title="Slide prev" class="slider-btn slider-btn-prev rounded-pill"
                                id="product-single-prev">
                                <i class="fal fa-angle-left"></i>
                            </button>
                            <button type="button" title="Slide next" class="slider-btn slider-btn-next rounded-pill"
                                id="product-single-next">
                                <i class="fal fa-angle-right"></i>
                            </button>
                        </div>
                        <div class="swiper product-single-slider">
                            <div class="swiper-wrapper">
                                @foreach ($listingImages as $gallery)
                                    <div class="swiper-slide radius-lg">
                                        <figure class="lazy-container ratio ratio-16-9">
                                            <a href="{{ asset('assets/img/listing-gallery/' . $gallery->image) }}">
                                                <img class="lazyload" src="assets/images/placeholder.png"
                                                    data-src="{{ asset('assets/img/listing-gallery/' . $gallery->image) }}"
                                                    alt="product image" />
                                            </a>
                                        </figure>
                                    </div>
                                @endforeach
                            </div>
                        </div>
                        <div class="swiper slider-thumbnails">
                            <div class="swiper-wrapper">

                                @foreach ($listingImages as $gallery)
                                    <div class="swiper-slide">
                                        <div class="thumbnail-img lazy-container radius-md ratio ratio-16-9">
                                            <img class="lazyload"
                                                data-src="{{ asset('assets/img/listing-gallery/' . $gallery->image) }}"
                                                alt="product image" />
                                        </div>
                                    </div>
                                @endforeach
                            </div>
                        </div>
                    </div>

                    <!-- Section gap -->
                    <div class="pt-40 d-none d-lg-block"></div>

                    <div class="product-single-details">
                        <div class="tabs-navigation tabs-navigation-2 text-center mb-40" data-aos="fade-up">
                            <ul class="nav nav-tabs w-100 radius-sm" data-hover="fancyHover">
                                <li class="nav-item active">
                                    <button class="nav-link hover-effect radius-sm active" data-bs-toggle="tab"
                                        data-bs-target="#description" type="button">{{ __('Description') }}</button>
                                </li>
                                @if (is_array($permissions) && in_array('Feature', $permissions))
                                    <li class="nav-item">
                                        <button class="nav-link hover-effect radius-sm" data-bs-toggle="tab"
                                            data-bs-target="#features" type="button">{{ __('Features') }}</button>
                                    </li>
                                @endif
                                <li class="nav-item">
                                    <button class="nav-link hover-effect radius-sm" data-bs-toggle="tab"
                                        data-bs-target="#reviews" type="button">{{ __('Reviews') }}</button>
                                </li>
                                @if (is_array($permissions) && in_array('FAQ', $permissions))
                                    <li class="nav-item">
                                        <button class="nav-link hover-effect radius-sm" data-bs-toggle="tab"
                                            data-bs-target="#faq" type="button">{{ __('FAQ') }}</button>
                                    </li>
                                @endif
                            </ul>
                        </div>

                        <div class="tab-content" data-aos="fade-up">
                            <div class="tab-pane slide show active" id="description">
                                <div class="product-desc mb-40">
                                    @if ($listing->listing_content->first()->summary)
                                        <h4 class="mb-15">{{ __('Summary') }}</h4>
                                        {!! optional($listing->listing_content->first())->summary !!}
                                    @endif

                                    <h3 class="mb-15 pt-3">{{ __('Description') }}</h3>
                                    <div class="tinymce-content">
                                        {!! optional($listing->listing_content->first())->description !!}
                                    </div>
                                </div>
                                @if (is_array($permissions) && in_array('Amenities', $permissions))
                                    <div class="product-amenities mb-40">
                                        <h3 class="mb-20">{{ __('Amenities') }}</h3>
                                        <ul class="amenities-list list-unstyled p-0 m-0">
                                            @php
                                                $aminities = App\Models\Aminite::with('contents')->get();
                                                $hasaminitie = $listing->aminities ?? [];
                                            @endphp
                                            @if (is_array($hasaminitie))
                                            @foreach ($aminities as $aminitie)
                                                @if (in_array($aminitie->id, $hasaminitie))
                                                    <li class="icon-start">
                                                        <i class="{{ $aminitie->icon }}"></i>
                                                        <span>{{ $aminitie->getTitle($language->id) }}</span>
                                                    </li>
                                                @endif
                                            @endforeach
                                            @endif
                                        </ul>
                                    </div>
                                @endif
                                @if (is_array($permissions) && in_array('Video', $permissions))
                                    @if ($listing->video_url)
                                        <div class="video-banner position-relative mb-40 radius-md">
                                            <div class="overlay opacity-75"></div>
                                            <!-- Background Image -->
                                            <div class="lazy-container ratio ratio-21-9">
                                                <img class="lazyload blur-up"
                                                    src="{{ asset('assets/img/listing/video/' . $listing->video_background_image) }}"
                                                    alt="Bg-img">
                                            </div>
                                            <a href="{{ $listing->video_url }}"
                                                class="video-btn youtube-popup position-absolute top-50 start-50 translate-middle">
                                                <i class="fas fa-play"></i>
                                            </a>
                                        </div>
                                    @endif
                                @endif
                                @if (!empty(showAd(3)))
                                    <div class="text-center mt-40">
                                        {!! showAd(3) !!}
                                    </div>
                                @endif
                            </div>
                            @if (is_array($permissions) && in_array('Feature', $permissions))
                                <div class="tab-pane slide" id="features">
                                    @if (count($listing_features) == 0)
                                        <h3 class="text-center">{{ __('NO FEATURE FOUND') . '!' }}</h3>
                                    @else
                                        @foreach ($listing_features as $listing_feature)
                                            <div class="product-featured mb-30">
                                                <h3 class="mb-15">{{ $listing_feature->feature_heading }} </h3>
                                                @php
                                                    $values = json_decode($listing_feature->feature_value);
                                                @endphp

                                                <ul class="featured-list list-unstyled p-0 m-0">
                                                    @if ($values)
                                                        @foreach ($values as $value)
                                                            <li class="d-inline-block icon-start">
                                                                <i class="fal fa-check-square"></i>
                                                                <span>{{ $value }}</span>
                                                            </li>
                                                        @endforeach
                                                    @endif
                                                </ul>
                                            </div>
                                        @endforeach
                                    @endif
                                    @if (!empty(showAd(3)))
                                        <div class="text-center mt-40">
                                            {!! showAd(3) !!}
                                        </div>
                                    @endif
                                </div>
                            @endif

                            @if (false)
                            <div class="tab-pane slide" id="products">
                                <div class="products mb-40">
                                    <div class="swiper products-slider">
                                        @if (count($product_contents) == 0)
                                            <h3 class="text-center">{{ __('NO PRODUCT FOUND') . '!' }}</h3>
                                        @else
                                            <div class="swiper-wrapper">
                                                @foreach ($product_contents as $product)
                                                    <div class="swiper-slide">
                                                        <div class="product-default border radius-md">
                                                            <figure class="product-img">
                                                                <a href="{{ route('shop.product_details', ['slug' => $product->slug]) }}" class="lazy-container ratio ratio-2-3">
                                                                    <img class="lazyload"
                                                                        data-src="{{ asset('assets/img/products/featured-images/' . $product->featured_image) }}"
                                                                        alt="{{ $product->title }}">
                                                                </a>
                                                            </figure>
                                                            <div class="product-details">
                                                                <a href="{{ route('shop.product_details', ['slug' => $product->slug]) }}">
                                                                    <h5 class="product-title">{{ $product->title }}</h5>
                                                                </a>
                                                                <div class="product-bottom mt-10">
                                                                    <div class="product-price">
                                                                        <span class="color-medium me-2">{{ __('Price') }}</span>
                                                                        <h6 class="price mb-0 lh-1">
                                                                            {{ symbolPrice($product->current_price) }}
                                                                            @if ($product->previous_price)
                                                                                <span class="prev-price">{{ symbolPrice($product->previous_price) }}</span>
                                                                            @endif
                                                                        </h6>
                                                                    </div>
                                                                    <a href="{{ route('shop.product_details', ['slug' => $product->slug]) }}" class="btn-text color-primary">{{ __('View Details') }}</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                @endforeach
                                            </div>
                                        @endif
                                        <div class="swiper-pagination position-static mt-20" id="products-slider-pagination"></div>
                                    </div>
                                </div>
                                @if (!empty(showAd(3)))
                                    <div class="text-center mt-40">{!! showAd(3) !!}</div>
                                @endif
                            </div>
                            @endif

                            <div class="tab-pane slide" id="reviews">
                                @if ($numOfReview > 0)
                                    <div class="review-box mb-40">
                                        <h3 class="mb-15">{{ __('Customer Review') }}</h3>
                                        <div class="review-box-inner radius-lg">
                                            <ul class="review-list">
                                                @foreach ($reviews as $review)
                                                    <li class="review list-unstyled p-0 mb-30">
                                                        <div class="review-body">
                                                            <div class="author">
                                                                <div class="lazy-container ratio ratio-1-1 radius-md">
                                                                    @if (empty($review->user->image))
                                                                        <img class="lazyload blur-up"
                                                                            src="assets/images/placeholder.png"
                                                                            data-src="{{ asset('assets/img/user.png') }}"
                                                                            alt="Person Image">
                                                                    @else
                                                                        <img class="lazyload blur-up"
                                                                            src="assets/images/placeholder.png"
                                                                            data-src="{{ asset('assets/img/users/' . $review->user->image) }}"
                                                                            alt="Person Image">
                                                                    @endif
                                                                </div>
                                                            </div>
                                                            <div class="content">
                                                                <h6 class="m-0">{{ $review->user->username }}</h6>

                                                                <span
                                                                    class="font-sm">{{ \Carbon\Carbon::parse($review->updated_at)->translatedFormat('j F Y, H:i') }}</span>
                                                                <div class="product-ratings mb-1">
                                                                    <div class="ratings">
                                                                        <div class="rate"
                                                                            style="background-image: url('{{ asset($rateStar) }}')">
                                                                            <div class="rating-icon"
                                                                                style="background-image:url('{{ asset($rateStar) }}'); width: {{ $review->rating * 20 . '%;' }}">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <p>
                                                                    {{ $review->review }}
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </li>
                                                @endforeach
                                            </ul>
                                        </div>
                                    </div>
                                @else
                                    <h3 class="text-center">{{ __('NO REVIEW FOUND') . '!' }}</h3>
                                @endif

                                @auth('web')
                                    <div class="review-form radius-lg mb-40">
                                        <h3 class="mb-10">{{ __('Write a Review') }}</h3>
                                        <form
                                            action="{{ route('listing.listing_details.store_review', ['id' => $listing->id]) }}"
                                            method="POST" id="reviewSubmitForm">
                                            @csrf
                                            <div class="row">
                                                <div class="col-12">
                                                    <div class="form-group mb-20">
                                                        <textarea class="form-control" name="review" id="review" cols="30" rows="9"
                                                            placeholder="{{ __('Write your review') }}"></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="mb-1">{{ __('Rating') . '*' }}</label>
                                                <ul class="rating list-unstyled mb-20">
                                                    <li class="review-value review-1">
                                                        <span class="fas fa-star" data-ratingVal="1"></span>
                                                    </li>
                                                    <li class="review-value review-2">
                                                        <span class="fas fa-star" data-ratingVal="2"></span>
                                                        <span class="fas fa-star" data-ratingVal="2"></span>
                                                    </li>
                                                    <li class="review-value review-3">
                                                        <span class="fas fa-star" data-ratingVal="3"></span>
                                                        <span class="fas fa-star" data-ratingVal="3"></span>
                                                        <span class="fas fa-star" data-ratingVal="3"></span>
                                                    </li>
                                                    <li class="review-value review-4">
                                                        <span class="fas fa-star" data-ratingVal="4"></span>
                                                        <span class="fas fa-star" data-ratingVal="4"></span>
                                                        <span class="fas fa-star" data-ratingVal="4"></span>
                                                        <span class="fas fa-star" data-ratingVal="4"></span>
                                                    </li>
                                                    <li class="review-value review-5">
                                                        <span class="fas fa-star" data-ratingVal="5"></span>
                                                        <span class="fas fa-star" data-ratingVal="5"></span>
                                                        <span class="fas fa-star" data-ratingVal="5"></span>
                                                        <span class="fas fa-star" data-ratingVal="5"></span>
                                                        <span class="fas fa-star" data-ratingVal="5"></span>
                                                    </li>
                                                </ul>
                                            </div>
                                            <input type="hidden" id="rating-id" name="rating">

                                            <div class="form-group mt-10">
                                                <button type="submit"
                                                    class="btn btn-lg btn-primary">{{ __('Submit Review') }}</button>
                                            </div>
                                        </form>

                                    </div>
                                @endauth
                                @guest('web')
                                    <div class="login-text mb-40">
                                        <span>{!! __('Please login to give your review', [
                                            'url' => route('user.login', ['redirectPath' => 'listingDetails']),
                                        ]) !!}</span>
                                    </div>
                                @endguest
                                @if (!empty(showAd(3)))
                                    <div class="text-center mt-40">
                                        {!! showAd(3) !!}
                                    </div>
                                @endif
                            </div>

                            <div class="tab-pane slide" id="faq">
                                @if (count($faqs) != 0)
                                    <h3 class="mb-15">{{ __('Frequently Asked Questions') }}</h3>
                                @endif

                                <div class="faq-area">
                                    <div class="accordion pb-25" id="faqAccordion">
                                        @if (count($faqs) == 0)
                                            <h3 class="text-center">{{ __('NO FAQ FOUND') . '!' }}</h3>
                                        @else
                                            @foreach ($faqs as $faq)
                                                <div class="accordion-item mb-30">
                                                    <h6 class="accordion-header" id="headingOne_{{ $faq->id }}">
                                                        <button
                                                            class="accordion-button {{ $loop->iteration == 1 ? '' : 'collapsed' }}"
                                                            type="button" data-bs-toggle="collapse"
                                                            data-bs-target="#collapseOne_{{ $faq->id }}"
                                                            aria-expanded="true"
                                                            aria-controls="collapseOne_{{ $faq->id }}">
                                                            {{ $faq->serial_number }}. {{ $faq->question }}
                                                        </button>
                                                    </h6>
                                                    <div id="collapseOne_{{ $faq->id }}"
                                                        class="accordion-collapse collapse {{ $loop->iteration == 1 ? 'show' : '' }}"
                                                        aria-labelledby="headingOne_{{ $faq->id }}"
                                                        data-bs-parent="#faqAccordion">
                                                        <div class="accordion-body">
                                                            <p>
                                                                {{ $faq->answer }}
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>
                                            @endforeach
                                        @endif
                                    </div>
                                </div>
                                @if (!empty(showAd(3)))
                                    <div class="text-center mt-40">
                                        {!! showAd(3) !!}
                                    </div>
                                @endif
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-xl-3"><!-- Section gap -->
                    <div class="pt-40 d-lg-none"></div>
                    <aside class="widget-area" data-aos="fade-up">
                        @if (is_array($permissions) && in_array('Listing Enquiry Form', $permissions))
                            <div class="widget widget-form radius-md mb-30">
                                <h5 class="title mb-20">
                                    {{ __('Contact Information') }}
                                </h5>
                                <div class="user mb-20">
                                    <div class="user-img">

                                        <div class="lazy-container ratio ratio-1-1 rounded-pill">
                                            <a href="{{ route('frontend.vendor.details', ['username' => $userName]) }}"
                                                target="_self">
                                                @if ($listing->vendor_id == 0)
                                                    <img class="lazyload"
                                                        data-src="{{ $vendor->image ? asset('assets/img/admins/' . $vendor->image) : asset('assets/front/images/avatar.svg') }}"
                                                        alt="Vendor">
                                                @else
                                                    <img class="lazyload"
                                                        data-src="{{ $vendor->photo ? asset('assets/admin/img/vendor-photo/' . $vendor->photo) : asset('assets/front/images/avatar.svg') }}"
                                                        alt="Person Image">
                                                @endif
                                            </a>
                                        </div>
                                    </div>
                                    <div class="user-info">
                                        <a href="{{ route('frontend.vendor.details', ['username' => $userName]) }}"
                                            target="_self">
                                            <h6 class="mb-1">{{ $vendor->username }}</h6>
                                        </a>
                                        @if ($listing->vendor_id != 0 && $vendorInfo)
                                            <h6 class="mb-1">{{ $vendorInfo->name }}</h6>
                                        @endif
                                        @if ($vendor->show_phone_number == 1)
                                            @if (!is_null($vendor->phone))
                                                <a href="tel:{{ $vendor->phone }}">{{ $vendor->phone }}</a>
                                            @endif
                                        @endif
                                        <br>
                                        @if ($vendor->show_email_addresss == 1)
                                            <a href="mailto:{{ $vendor->to_mail }}">{{ $vendor->to_mail }}</a>
                                        @endif
                                    </div>
                                </div>
                                <form id="contactForm" action="{{ route('frontend.listings.contact_message') }}"
                                    method="POST">
                                    @csrf
                                    <div class="form-group mb-20">
                                        <input type="text" name="name" class="form-control" required
                                            placeholder="{{ __('Name') . '*' }}" value="{{ old('name') }}">
                                    </div>
                                    <div class="form-group mb-20">
                                        <input type="email" name="email" class="form-control" required
                                            placeholder="{{ __('Email Address') . '*' }}"value="{{ old('email') }}">
                                    </div>
                                    <div class="form-group mb-20">
                                        <input type="number" name="phone" class="form-control" required
                                            placeholder="{{ __('Phone Number') . '*' }}"value="{{ old('phone') }}">
                                    </div>
                                    <div class="form-group mb-20">
                                        <textarea name="message" id="message" class="form-control" cols="30" rows="8" required
                                            data-error="Please enter your message" placeholder="{{ __('Message') . '*...' }}">{{ old('message') }}</textarea>
                                        <div class="help-block with-errors"></div>
                                    </div>
                                    @if ($bs->google_recaptcha_status == 1)
                                        <div class="form-group mb-20 listing-contract">
                                            {!! NoCaptcha::renderJs() !!}
                                            {!! NoCaptcha::display() !!}
                                            @error('g-recaptcha-response')
                                                <p class="mt-1 text-danger">{{ $message }}</p>
                                            @enderror
                                        </div>
                                    @endif
                                    <input type="hidden" id="vendor_id" value="{{ $listing->vendor_id }}"
                                        name="vendor_id">
                                    <input type="hidden" id="listing_id" value="{{ $listing->id }}"
                                        name="listing_id">
                                    <button type="submit"
                                        class="btn btn-md btn-primary w-100 showLoader">{{ __('Send message') }}</button>
                                </form>
                            </div>
                        @endif

                        <div class="widget widget-address radius-md mb-30">
                            <h5 class="title">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#amenities" aria-expanded="true" aria-controls="amenities">
                                    {{ __('Our Address') }}
                                </button>
                            </h5>
                            <div id="amenities" class="collapse show">
                                <div class="accordion-body">
                                    <div class="lazy-container radius-md ratio ratio-2-3">
                                        <div id="map"></div>
                                    </div>
                                    <ul class="list-group mt-20">

                                        <li class="icon-start">
                                            <i class="fal fa-map-marker-alt"></i>
                                            <span>{{ $listing->listing_content->first()->address }}</span>
                                        </li>
                                        <li class="icon-start">
                                            <i class="fal fa-phone"></i>
                                            <a href="tel:{{ $listing->phone }}">{{ $listing->phone }}</a>
                                        </li>
                                        <li class="icon-start">
                                            <i class="fal fa-envelope"></i>
                                            <a href="mailto:{{ $listing->mail }}">{{ $listing->mail }}</a>
                                        </li>
                                    </ul>
                                    @if (is_array($permissions) && in_array('Social Links', $permissions))
                                        <div class="social-link mt-20">
                                            @foreach ($socialLinks as $link)
                                                <a href="{{ $link->link }}" target="_blank"><i
                                                        class="{{ $link->icon }}"></i></a>
                                            @endforeach
                                        </div>
                                    @endif
                                </div>
                            </div>
                        </div>

                        @if (is_array($permissions) && in_array('Business Hours', $permissions))
                            <div class="widget widget-days radius-md mb-30">
                                <h5 class="title">
                                    <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                        data-bs-target="#price" aria-expanded="true" aria-controls="price">
                                        {{ __('Business Hours') }}
                                    </button>
                                </h5>
                                <div id="price" class="collapse show">
                                    <div class="accordion-body">
                                        <ul class="list-group">
                                            @foreach ($businessHours as $day)
                                                @if ($day->holiday == 1)
                                                    <li class="d-flex align-items-center justify-content-between font-sm">
                                                        <span>{{ __($day->day) }}</span>

                                                        @php
                                                            $start_time = Carbon\Carbon::parse(
                                                                $day->start_time,
                                                            )->format($basicInfo->time_format == 24 ? 'H:i' : 'h:i A');
                                                            $end_time = Carbon\Carbon::parse($day->end_time)->format(
                                                                $basicInfo->time_format == 24 ? 'H:i' : 'h:i A',
                                                            );
                                                        @endphp
                                                        <span dir="ltr">{{ $start_time }} -
                                                            {{ $end_time }}</span>
                                                    </li>
                                                @else
                                                    <li class="d-flex align-items-center justify-content-between font-sm">
                                                        <span>{{ __($day->day) }}</span>
                                                        <span class="text-danger">{{ __('Closed') }}</span>
                                                    </li>
                                                @endif
                                            @endforeach
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        @endif

                        <div class="widget-banner mb-40">
                            @if (!empty(showAd(1)))
                                <div class="text-center mt-40">
                                    {!! showAd(1) !!}
                                </div>
                            @endif
                        </div>
                    </aside>
                </div>
            </div>
        </div>
    </div>
    <!-- Listing end -->


    @include('frontend.listing.share')

    {{-- @include('frontend.listing.product-details', $product_contents); --}}
@endsection
@section('script')
    <script>
        "use strict";
        var visitor_store_url = "{{ route('frontend.store_visitor') }}";
        var listing_id = "{{ $listing->id }}";
        var latitude = "{{ $listing->latitude }}";
        var longitude = "{{ $listing->longitude }}";
        var markerIcon = "{{ asset('assets/front/css/vendors/images/marker-icon.svg') }}";
    </script>
    <script src="{{ asset('assets/front/js/single-map.js') }}"></script>
    <script src="{{ asset('assets/front/js/review.js') }}"></script>
    <script src="{{ asset('assets/front/js/store-visitor.js') }}"></script>

    <div class="floating-btns">
        <!-- WhatsApp Chat Button -->
        <div id="WAButton2"></div>
        <!-- WhatsApp Chat Button -->

        @if (is_array($permissions) && in_array('WhatsApp', $permissions))
            @if ($listing->whatsapp_status == 1)
                <script type="text/javascript">
                    var whatsapp_popup = "{{ $listing->whatsapp_popup_status }}";
                    var whatsappImg = "{{ asset('assets/img/whatsapp.svg') }}";

                    $(function() {
                        $('#WAButton2').floatingWhatsApp({
                            phone: "{{ $listing->whatsapp_number }}",
                            headerTitle: "{{ $listing->whatsapp_header_title }}",
                            popupMessage: `{!! nl2br($listing->whatsapp_popup_message) !!}`,
                            showPopup: whatsapp_popup == 1 ? true : false,
                            buttonImage: '<img src="' + whatsappImg + '" />',
                            position: "right"
                        });
                    });
                </script>
            @endif
        @endif

        {{-- Telegram --}}
        @if (is_array($permissions) && in_array('Telegram', $permissions))
            @if ($listing->telegram_status == 1)
                <a class="telegram-btn" href="//telegram.me/{{ $listing->telegram_username }}" target="_blank">
                    <img src="{{ asset('assets/front/images/telegram.png') }}" alt="Image">
                </a>
            @endif
        @endif

        {{-- Messenger --}}
        @if (is_array($permissions) && in_array('Messenger', $permissions))
            @if ($listing->messenger_status == 1)
                <a class="facebook-btn" href="{{ $listing->messenger_direct_chat_link }}" target="_blank">
                    <img src="{{ asset('assets/front/images/messenger.png') }}" alt="Image">
                </a>
            @endif
        @endif

        @php
            $tawkToDirectChatLink = $listing->tawkto_direct_chat_link ?? null;
            $hasValidTawkToLink = filter_var($tawkToDirectChatLink, FILTER_VALIDATE_URL) &&
                str_starts_with($tawkToDirectChatLink, 'https://embed.tawk.to/');
        @endphp

        <!--Start of Tawk.to Script-->
        @if (is_array($permissions) && in_array('Tawk.To', $permissions))
            @if ($listing->tawkto_status == 1 && $hasValidTawkToLink)
                <script type="text/javascript">
                    var Tawk_API = Tawk_API || {},
                        Tawk_LoadStart = new Date();
                    (function() {
                        var s1 = document.createElement("script"),
                            s0 = document.getElementsByTagName("script")[0];
                        s1.async = true;
                        s1.src = "{{ $tawkToDirectChatLink }}";
                        s1.charset = 'UTF-8';
                        s1.setAttribute('crossorigin', '*');
                        s0.parentNode.insertBefore(s1, s0);
                    })();
                </script>
            @endif
        @endif
    </div>

@endsection
