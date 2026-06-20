<!-- Footer-area start -->
<footer class="footer-area bg-primary-light" data-aos="fade-up">
  <div class="footer-top pt-100 pb-70">
    <div class="container">
      <div class="row justify-content-between">
        <div class="col-xl-3 col-lg-4 col-md-6 col-sm-12">
          <div class="footer-widget">
            <div class="navbar-brand">
              @if (!empty($basicInfo->footer_logo))
                <a href="{{ route('index') }}">
                  <img src="{{ asset('assets/img/' . $basicInfo->footer_logo) }}" alt="Logo">
                </a>
              @endif
            </div>
            <p>{{ !empty($footerInfo) ? $footerInfo->about_company : '' }}</p>
            @if (count($socialMediaInfos) > 0)
              <div class="social-link">
                @foreach ($socialMediaInfos as $socialMediaInfo)
                  <a href="{{ $socialMediaInfo->url }}" target="_blank"><i class="{{ $socialMediaInfo->icon }}"></i></a>
                @endforeach
              </div>
            @endif
          </div>
        </div>
        <div class="col-xl-2 col-lg-3 col-md-3 col-sm-5">
          <div class="footer-widget">
            <h3>{{ __('Useful Links') }}</h3>
            @if (count($quickLinkInfos) == 0)
              <p class="mb-0">{{ __('No Link Found') . '!' }}</p>
            @else
              <ul class="footer-links">
                @foreach ($quickLinkInfos as $quickLinkInfo)
                  <li>
                    <a href="{{ $quickLinkInfo->url }}">{{ $quickLinkInfo->title }}</a>
                  </li>
                @endforeach
              </ul>
            @endif
          </div>
        </div>
        <div class="col-xl-3 col-lg-4 col-md-5 col-sm-7">
          <div class="footer-widget">
            <h3>{{ __('Contact Us') }}</h3>
            <ul class="info-list">
              <li>
                <i class="fal fa-map-marker-alt"></i>
                @if (!empty($basicInfo->address))
                  <span>{{ $basicInfo->address }}</span>
                @endif
              </li>
              <li>
                <i class="fal fa-phone-plus"></i>
                <a href="tel:{{ $basicInfo->contact_number }}">{{ $basicInfo->contact_number }}</a>
              </li>
              @if (!empty($basicInfo->email_address))
                <li>
                  <i class="fal fa-envelope"></i>
                  <a href="mailto:{{ $basicInfo->email_address }}">{{ $basicInfo->email_address }}</a>
                </li>
              @endif
            </ul>
          </div>
        </div>
        <div class="col-xl-3 col-lg-6 col-md-7 col-sm-12">
          <div class="footer-widget">
            <h4>{{ __('Subscribe Us') }}</h4>
            <p class="lh-1 mb-20">{{ __('Stay update with us and get offer') . '!' }}</p>
            <div class="newsletter-form">
              <form id="newsletterForm" class="subscription-form" action="{{ route('store_subscriber') }}"
                method="POST">
                @csrf
                <div class="form-group">
                  <input class="form-control radius-0" placeholder="{{ __('Enter email') }}" type="text"
                    name="email_id" required="" autocomplete="off">
                  <button class="btn btn-md btn-primary" type="submit">{{ __('Subscribe') }}</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="copy-right-area border-top">
    <div class="container">
      <div class="copy-right-content">
        <span>
          <span>
            @isset($footerInfo->copyright_text)
              {!! @$footerInfo->copyright_text !!}
            @else
              {{ __('Copyright ©2024. All Rights Reserved.') }}
            @endisset
          </span>
      </div>
    </div>
  </div>
</footer>
<!-- Footer-area end-->
