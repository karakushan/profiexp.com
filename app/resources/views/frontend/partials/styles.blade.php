<!-- Bootstrap CSS -->
<link rel="stylesheet" href="{{ asset('assets/front/css/vendors/bootstrap.min.css') }}">
<!-- Bootstrap Datepicker CSS -->
<link rel="stylesheet" href="{{ asset('assets/front/css/vendors/bootstrap-datepicker.min.css') }}">
<!-- Data Tables CSS -->
<link rel="stylesheet" href="{{ asset('assets/front/css/vendors/datatables.min.css') }}">
<!-- Fontawesome Icon CSS -->
<link rel="stylesheet" href="{{ asset('assets/front/fonts/fontawesome/css/all.min.css') }}">
<!-- Icomoon Icon CSS -->
<link rel="stylesheet" href="{{ asset('assets/front/fonts/icomoon/style.css') }}">
<!-- Magnific Popup CSS -->
<link rel="stylesheet" href="{{ asset('assets/front/css/vendors/magnific-popup.min.css') }}">
<!-- Swiper Slider -->
<link rel="stylesheet" href="{{ asset('assets/front/css/vendors/swiper-bundle.min.css') }}">
<!-- NoUi Range Slider -->
<link rel="stylesheet" href="{{ asset('assets/front/css/vendors/nouislider.min.css') }}">
<!-- Nice Select -->
<link rel="stylesheet" href="{{ asset('assets/front/css/vendors/nice-select.css') }}">
<!-- Select2 -->
<link rel="stylesheet" href="{{ asset('assets/front/css/vendors/select2.min.css') }}">
<!-- AOS Animation CSS -->
<link rel="stylesheet" href="{{ asset('assets/front/css/vendors/aos.min.css') }}">
{{-- whatsapp css --}}
<link rel="stylesheet" href="{{ asset('assets/front/css/floating-whatsapp.css') }}">
{{-- toastr --}}
<link rel="stylesheet" href="{{ asset('assets/admin/css/toastr.min.css') }}">
<!-- Leaflet Map CSS  -->
<link rel="stylesheet" href="{{ asset('assets/front/css/vendors/leaflet.css') }}" />
<link rel="stylesheet" href="{{ asset('assets/front/css/vendors/leaflet.fullscreen.css') }}" />
<link rel="stylesheet" href="{{ asset('assets/front/css/vendors/MarkerCluster.css') }}">
<!-- Tinymce-content CSS  -->
<link rel="stylesheet" href="{{ asset('assets/front/css/tinymce-content.css') }}">
<!-- Main Style CSS -->
<link rel="stylesheet" href="{{ asset('assets/front/css/style.css') }}">
<!-- Responsive CSS -->
<link rel="stylesheet" href="{{ asset('assets/front/css/responsive.css') }}">
{{-- rtl css are goes here --}}
@if ($currentLanguageInfo->direction == 1)
  <link rel="stylesheet" href="{{ asset('assets/front/css/rtl.css') }}">
@endif

@php
  $primaryColor = $basicInfo->primary_color;
  // check, whether color has '#' or not, will return 0 or 1
  function checkColorCode($color)
  {
      return preg_match('/^#[a-f0-9]{6}/i', $color);
  }

  // if, primary color value does not contain '#', then add '#' before color value
  if (isset($primaryColor) && checkColorCode($primaryColor) == 0) {
      $primaryColor = '#' . $primaryColor;
  }

  // change decimal point into hex value for opacity
  function rgb($color = null)
  {
      if (!$color) {
          echo '';
      }
      $hex = htmlspecialchars($color);
      [$r, $g, $b] = sscanf($hex, '#%02x%02x%02x');
      echo "$r, $g, $b";
  }
@endphp
<style>
  :root {
    --color-primary: {{ $primaryColor }};
    --color-primary-rgb: {{ rgb(htmlspecialchars($primaryColor)) }};
  }
</style>


@yield('style')
