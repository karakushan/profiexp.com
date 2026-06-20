<div class="page-title-area ptb-100">
  <!-- Background Image -->
  <img class="lazyload blur-up bg-img"
    @if (!empty($breadcrumb)) src="{{ asset('assets/img/' . $breadcrumb) }}" @else 
    src="{{ asset('assets/front/images/page-title-bg.jpg') }}" @endif
    alt="Bg-img">
  <div class="container">
    <div class="content">
      <h1> {{ !empty($title) ? $title : '' }}
      </h1>
      <ul class="list-unstyled">
        <li class="d-inline"><a href="{{ route('index') }}">{{ __('Home') }}</a></li>
        <li class="d-inline">></li>
        <li class="d-inline active">{{ !empty($title) ? $title : '' }}</li>
      </ul>
    </div>
  </div>
</div>
