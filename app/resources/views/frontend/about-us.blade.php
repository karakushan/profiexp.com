@extends('frontend.layout')

@section('pageHeading')
  {{ !empty($pageHeading) ? $pageHeading->about_us_title : __('About Us') }}
@endsection

@section('metaKeywords')
  @if (!empty($seoInfo))
    {{ $seoInfo->meta_keywords_about_page }}
  @endif
@endsection

@section('metaDescription')
  @if (!empty($seoInfo))
    {{ $seoInfo->meta_description_about_page }}
  @endif
@endsection

@section('content')
  @includeIf('frontend.partials.breadcrumb', [
      'breadcrumb' => $bgImg->breadcrumb,
      'title' => !empty($pageHeading) ? $pageHeading->about_us_title : __('About Us'),
  ])

  <!-- Work-area start -->
  @if ($secInfo->work_process_section_status == 1)
    <section class="work-area work-process-1 pt-100 pb-75">
      <div class="container">
        <div class="row">
          <div class="col-12">
            <div class="section-title title-inline mb-30" data-aos="fade-up">
              <h2 class="title mb-20">{{ @$workProcessSecInfo->title }}</h2>
            </div>
          </div>
          <div class="col-12">
            <div class="row gx-xl-5">
              @foreach ($processes as $process)
                <div class="col-lg-4 col-sm-6" data-aos="fade-up">
                  <div class="card radius-lg mb-25">
                    <div class="card-content radius-md">
                      <div class="card-step h3"><span
                          data-hover="0{{ $process->serial_number }}">0{{ $process->serial_number }}</span>
                      </div>
                      <div class="card-icon radius-md">
                        <i class="{{ $process->icon }}"></i>
                      </div>
                      <h3 class="card-title m-0">{{ $process->title }}</h3>
                    </div>
                  </div>
                </div>
              @endforeach
            </div>
          </div>
        </div>
      </div>
    </section>
  @endif
  <!-- Work-area end -->

  <!-- Counter-area start -->
  @if ($secInfo->counter_section_status == 1)
    <div class="counter-area pt-100 pb-70">
      <!-- Background Image -->
      <img class="lazyload blur-up bg-img" src="{{ asset('assets/img/' . $counterSectionImage) }}" alt="Bg-img">
      <div class="overlay opacity-65"></div>
      <div class="container">
        <div class="section-title title-center mb-50" data-aos="fade-up">
          <h2 class="title color-white mb-0">{{ $counterSectionInfo ? $counterSectionInfo->title : '' }}</h2>
        </div>
        <div class="row gx-xl-5 justify-content-center">

          @foreach ($counters as $counter)
            <div class="col-6 col-lg-3" data-aos="fade-up" data-aos-delay="150">
              <div class="card mb-30">
                <div class="d-flex align-items-center">
                  <div class="card-icon color-white"><i class="{{ $counter->icon }}"></i></div>
                  <div class="card-content">
                    <h2 class="mb-1 color-white"><span class="counter">{{ $counter->amount }}</span>+
                    </h2>
                    <p class="card-text font-lg color-white">{{ $counter->title }}</p>
                  </div>
                </div>
              </div>
            </div>
          @endforeach
        </div>
      </div>
    </div>
  @endif
  <!-- Counter-area end -->

  <!-- Testimonial-area start -->
  @if ($secInfo->testimonial_section_status == 1)
    <section class="testimonial-area testimonial-1 pt-100 pb-60">
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
                            <img class="lazyload" src="{{ asset('assets/img/clients/' . $testimonial->image) }}"
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
                <img class="lazyload blur-up" src="{{ asset('assets/img/' . $testimonialSecImage) }}" alt="Image">
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    @if (!empty(showAd(3)))
      <div class="text-center mt-4">
        {!! showAd(3) !!}
      </div>
      {{-- Spacer --}}
      <div class="pb-100"></div>
    @endif
  @endif
  <!-- Testimonial-area end -->

@endsection
