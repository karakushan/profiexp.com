@extends('frontend.layout')

@section('pageHeading')
    {{ __('Product Details') }}
@endsection

@section('metaKeywords')
    @if (!empty($details))
        {{ $details->meta_keywords }}
    @endif
@endsection

@section('metaDescription')
    @if (!empty($details))
        {{ $details->meta_description }}
    @endif
@endsection
@section('style')
    <link rel="stylesheet" href="{{ asset('assets/front/css/shop.css') }}">
@endsection

@section('content')

 @php
    if ($details->vendor_id == 0) {
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
        $vendorId = $details->vendor_id;
        $current_package = App\Http\Helpers\VendorPermissionHelper::packagePermission($vendorId);
        $permissions = $current_package->features;
        if (!empty($current_package->features)) {
            $permissions = json_decode($permissions, true);
        }
        $additionalFeatureLimit = packageTotalAdditionalSpecification($vendorId);
        $SocialLinkLimit = packageTotalSocialLink($vendorId);
    }

  @endphp

    {{-- breadcrub start --}}

    @includeIf('frontend.partials.details-breadcrumb', [
        'breadcrumb' => $bgImg->breadcrumb,
        'heading' => @$details->title,
        'title' => !empty($pageHeading) ? $pageHeading->products_page_title : 'product',
    ])
    {{-- breadcrub end --}}

    <!-- Shop-single-area start -->
    <div class="shop-single-area pt-100 pb-60">
        <div class="container">
            <div class="row gx-xl-5 align-items-center">
                <div class="col-lg-6">
                    <div class="shop-single-gallery gallery-popup mb-40" data-aos="fade-up">
                        <div class="swiper shop-single-slider">
                            <div class="swiper-wrapper">
                                @php $sliderImages = json_decode($details->slider_images); @endphp
                                @foreach ($sliderImages as $sliderImage)
                                    <div class="swiper-slide">
                                        <figure class="lazy-container ratio ratio-1-1">
                                            <a href="{{ asset('assets/img/products/slider-images/' . $sliderImage) }}"
                                                class="lightbox-single">
                                                <img class="lazyload" src="assets/images/placeholder.png"
                                                    data-src="{{ asset('assets/img/products/slider-images/' . $sliderImage) }}"
                                                    alt="product image" />
                                            </a>
                                        </figure>
                                    </div>
                                @endforeach

                            </div>
                            <!-- Slider navigation buttons -->
                            <div class="slider-navigation">
                                <button type="button" title="Slide prev" class="slider-btn slider-btn-prev radius-0">
                                    <i class="fal fa-angle-left"></i>
                                </button>
                                <button type="button" title="Slide next" class="slider-btn slider-btn-next radius-0">
                                    <i class="fal fa-angle-right"></i>
                                </button>
                            </div>
                        </div>
                        <div class="shop-thumb">
                            <div class="swiper shop-thumbnails">
                                <div class="swiper-wrapper">
                                    @foreach ($sliderImages as $sliderImage)
                                        <div class="swiper-slide">
                                            <div class="thumbnail-img lazy-container ratio ratio-1-1">
                                                <img class="lazyload" src="assets/images/placeholder.png"
                                                    data-src="{{ asset('assets/img/products/slider-images/' . $sliderImage) }}"
                                                    alt="product image" />
                                            </div>
                                        </div>
                                    @endforeach

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="product-single-details mb-40" data-aos="fade-up">
                        <h3 class="product-title mb-3 mb-xl-4">{{ $details->title }}</h3>

                        <div class="product-price mb-3 mb-xl-4">
                            <h4 class="new-price color-primary mb-0">{{ symbolPrice($details->current_price) }}</h4>
                            @if (!empty($details->previous_price))
                                <span
                                    class="old-price h5 color-medium mb-0">{{ symbolPrice($details->previous_price) }}</span>
                            @endif
                        </div>
                        <div class="product-desc">
                            {!! $details->content !!}
                        </div>
                        <div class="btn-groups mt-3 mt-xl-3">

                            <a href="#" data-bs-toggle="modal"
                                    data-bs-target="#productsModal_{{ $details->id }}"
                                class="btn btn-md btn-primary add-to-cart-btn" title="{{ __('Contact') }}"
                                target="_self">{{ __('Contact') }}</a>
                        </div>
                        <div class="social-link style-2 mt-3 mt-xl-3">
                            <a href="//www.facebook.com/sharer/sharer.php?u={{ urlencode(url()->current()) }}"
                                target="_blank" title="{{ __('Facebook') }}"><i class="fab fa-facebook-f"></i></a>

                            <a href="//twitter.com/intent/tweet?text=my share text&amp;url={{ urlencode(url()->current()) }}"
                                target="_blank" title="{{ __('Twitter') }}"><i class="fab fa-twitter"></i></a>

                            <a href="//www.linkedin.com/shareArticle?mini=true&amp;url={{ urlencode(url()->current()) }}&amp;title={{ $details->title }}"
                                target="_blank" title="{{ __('Linkedin') }}"><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        @if (!empty(showAd(3)))
            <div class="text-center mt-40">
                {!! showAd(3) !!}
            </div>
        @endif

    </div>
    <!-- Shop-single-area end -->


    </div>
    <!-- Shop-single-area end -->
    @include('frontend.listing.product-details', $details);

@endsection

@section('script')
    <script src="{{ asset('assets/front/js/shop.js') }}"></script>
@endsection
