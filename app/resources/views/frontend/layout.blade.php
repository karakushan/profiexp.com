<!DOCTYPE html>
<html lang="xxx" dir="{{ $currentLanguageInfo->direction == 1 ? 'rtl' : '' }}">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="author" content="{{ $basicInfo->website_title ?? '' }}">

    <meta name="keywords" content="@yield('metaKeywords')">
    <meta name="description" content="@yield('metaDescription')">
    <meta name="csrf-token" content="{{ csrf_token() }}" />
    <meta property="og:title" content="@yield('sharetitle')">
    <meta property="og:title" content="@yield('sharetitle')">
    <meta property="og:image" content="@yield('shareimage')">
    {{-- title --}}
    <title>@yield('pageHeading') {{ '| ' . $websiteInfo->website_title }}</title>
    {{-- fav icon --}}
    <link rel="shortcut icon" type="image/png" href="{{ asset('assets/img/' . $websiteInfo->favicon) }}">
    <link rel="apple-touch-icon" href="{{ asset('assets/img/' . $websiteInfo->favicon) }}">

    @includeIf('frontend.partials.styles')

</head>

<body class=" @if (
    ($basicInfo->theme_version == 2 && !request()->routeIs('index')) ||
        ($basicInfo->theme_version == 3 && !request()->routeIs('index'))) theme_2_3 @endif">
    <!-- Preloader start -->
    @if ($basicInfo->preloader_status == 1)
        <div id="preLoader">
            <img src="{{ asset('assets/img/' . $basicInfo->preloader) }}" alt="">
        </div>
    @endif
    <!-- Preloader end -->

    <div class="request-loader">
        <img src="{{ asset('assets/img/' . $basicInfo->preloader) }}" alt="">
    </div>

    <!-- Header-area start -->
    @if ($basicInfo->theme_version == 1)
        @includeIf('frontend.partials.header.header-v1')
    @elseif ($basicInfo->theme_version == 2)
        @includeIf('frontend.partials.header.header-v2')
    @elseif ($basicInfo->theme_version == 3)
        @includeIf('frontend.partials.header.header-v3')
    @elseif ($basicInfo->theme_version == 4)
        @includeIf('frontend.partials.header.header-v4')
    @endif
    <!-- Header-area end -->

    @yield('content')

    @include('frontend.partials.footer')

    <!-- Go to Top -->
    <div class="go-top"><i class="fal fa-angle-up"></i></div>
    <!-- Go to Top -->

    @includeIf('frontend.partials.popups')
    {{-- cookie alert --}}
    @if (!is_null($cookieAlertInfo) && $cookieAlertInfo->cookie_alert_status == 1)
        @include('cookie-consent::index')
    @endif

    <!-- WhatsApp Chat Button -->
    @if (!request()->routeIs('frontend.listing.details'))
        <div id="WAButton" class="whatsapp-btn-1"></div>
    @endif

    @if (session('open_claim_modal'))
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const modalEl = document.getElementById('ClaimRequestModal');
                if (modalEl) {
                    bootstrap.Modal.getOrCreateInstance(modalEl).show();
                }
            });
        </script>
    @endif

    @if ($basicInfo->shop_status == 1)
        <!-- Floating Cart Button -->
        <div id="cartIconWrapper" class="cartIconWrapper">
            @php
                $position = $basicInfo->base_currency_symbol_position;
                $symbol = $basicInfo->base_currency_symbol;
                $totalPrice = 0;
                if (session()->has('productCart')) {
                    $productCarts = session()->get('productCart');
                    foreach ($productCarts as $key => $product) {
                        $totalPrice += $product['price'];
                    }
                }
                $totalPrice = number_format($totalPrice);
                $productCartQuantity = 0;
                if (session()->has('productCart')) {
                    foreach (session()->get('productCart') as $value) {
                        $productCartQuantity = $productCartQuantity + $value['quantity'];
                    }
                }
            @endphp
            <a href="{{ route('shop.cart') }} " class="d-block" id="cartIcon">
                <div class="cart-length">
                    <i class="fal fa-shopping-bag"></i>
                    <span class="length totalItems">
                        {{ $productCartQuantity }} {{ __('Items') }}
                    </span>
                </div>
                <div class="cart-total">
                    {{ $position == 'left' ? $symbol : '' }}<span
                        class="totalPrice">{{ $totalPrice }}</span>{{ $position == 'right' ? $symbol : '' }}
                </div>
            </a>
        </div>
        <!-- Floating Cart Button End-->
    @endif

    @include('frontend.partials.scripts')
</body>


</html>
