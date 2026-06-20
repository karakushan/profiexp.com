@extends('frontend.layout')

@section('pageHeading')
  @if (!empty($pageHeading))
    {{ $pageHeading->pricing_page_title }}
  @else
    {{ __('Pricing') }}
  @endif
@endsection

@section('metaKeywords')
  @if (!empty($seoInfo))
    {{ $seoInfo->meta_keyword_pricing }}
  @endif
@endsection

@section('metaDescription')
  @if (!empty($seoInfo))
    {{ $seoInfo->meta_description_pricing }}
  @endif
@endsection

@section('content')
  <!-- Page title start-->
  @includeIf('frontend.partials.breadcrumb', [
      'breadcrumb' => $bgImg->breadcrumb,
      'title' => !empty($pageHeading) ? $pageHeading->pricing_page_title : __('Pricing'),
  ])
  <!-- Page title end-->

  <section class="pricing-area pt-100 pb-75">
    <div class="container">
      <div class="row">
        <div class="col-12">
          <div class="section-title title-center mb-40" data-aos="fade-up">
            <h2 class="title">{{ $packageSecInfo ? $packageSecInfo->title : 'Most Affordable Package' }}</h2>
          </div>
          <div class="tabs-navigation tabs-navigation-2 text-center mb-40" data-aos="fade-up">
            <ul class="nav nav-tabs rounded-pill bg-light" data-hover="fancyHover">
              @php
                $totalTerms = count($terms);
                $middleTerm = intdiv($totalTerms, 2);
              @endphp
              @foreach ($terms as $index => $term)
                <li class="nav-item {{ $index == $middleTerm ? 'active' : '' }}">
                  <button class="nav-link hover-effect rounded-pill {{ $index == $middleTerm ? 'active' : '' }}"
                    data-bs-toggle="tab" data-bs-target="#{{ strtolower($term) }}" type="button">
                    {{ __($term) }}
                  </button>
                </li>
              @endforeach
            </ul>
          </div>
        </div>
        <div class="col-12">
          <div class="tab-content">
            @foreach ($terms as $index => $term)
              <div class="tab-pane fade {{ $index == $middleTerm ? 'show active' : '' }}" id="{{ strtolower($term) }}">
                <div class="row justify-content-center">
                  @php
                    $packages = \App\Models\Package::where('status', '1')->where('term', strtolower($term))->get();
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
                      <div class="pricing-item radius-lg {{ $package->recommended ? 'active' : '' }} mb-30">
                        <div class="d-flex align-items-center">
                          <div class="icon"><i class="{{ $package->icon }}"></i></div>
                          <div class="label">
                            <h3> {{ __($package->title) }}</h3>
                            @if ($package->recommended == '1')
                              <span>{{ __('Popular') }}</span>
                            @endif

                          </div>
                        </div>
                        <p class="text"></p>
                        <div class="d-flex align-items-center">
                          <span class="price">{{ symbolPrice($package->price) }}</span>
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
                          <a href="{{ route('vendor.plan.extend.checkout', $package->id) }}" class="btn btn-outline btn-lg"
                            title="Purchase" target="_self">{{ __('Purchase') }}</a>
                        @endauth
                        @guest('vendor')
                          <a href="{{ route('vendor.login', ['redirectPath' => 'buy_plan', 'package' => $package->id]) }}"
                            class="btn btn-outline btn-lg" title="Purchase" target="_self">{{ __('Purchase') }}</a>
                        @endguest
                      </div>
                    </div>
                  @endforeach

                </div>
              </div>
            @endforeach
          </div>
        </div>
      </div>
    </div>
    <!-- Bg Shape -->
    <div class="shape">
      <img class="shape-1" src="{{ asset('assets/front/images/shape/shape-4.svg') }}" alt="Shape">
      <img class="shape-2" src="{{ asset('assets/front/images/shape/shape-3.svg') }}" alt="Shape">
      <img class="shape-3" src="{{ asset('assets/front/images/shape/shape-5.svg') }}" alt="Shape">
      <img class="shape-4" src="{{ asset('assets/front/images/shape/shape-6.svg') }}" alt="Shape">
    </div>
  </section>
@endsection
