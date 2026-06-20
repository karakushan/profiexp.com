@extends('admin.layout')


@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Featured Listing Section') }}</h4>
    <ul class="breadcrumbs">
      <li class="nav-home">
        <a href="{{ route('admin.dashboard') }}">
          <i class="flaticon-home"></i>
        </a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Home Page') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Featured Listing Section') }}</a>
      </li>
    </ul>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <div class="row">
            <div class="col-lg-8">
              <div class="card-title">{{ __('Featured Listing Section') }}</div>
            </div>

            <div class="col-lg-4">
            </div>
          </div>
        </div>

        <div class="card-body">
          <div class="row">
            <div class="col-lg-12">
              <form id="listingForm"
                action="{{ route('admin.home_page.update_listing_section', ['language' => request()->input('language')]) }}"
                method="POST">
                @csrf
                <div class="row">
                  <div class="col-md-6 mx-auto">
                    <div class="form-group">
                      <label for="">{{ __('Title') . '*' }}</label>
                      <input type="text" class="form-control" name="title"
                        value="{{ empty($data->title) ? '' : $data->title }}" placeholder="{{ __('Enter Title') }}">
                      @if ($errors->has('title'))
                        <p class="mt-1 mb-0 text-danger">{{ $errors->first('title') }}</p>
                      @endif
                    </div>
                    @if ($settings->theme_version == 2)
                      <div class="form-group">
                        <label for="">{{ __('Subtitle') }}</label>
                        <input type="text" class="form-control" name="subtitle"
                          value="{{ empty($data->subtitle) ? '' : $data->subtitle }}"
                          placeholder="{{ __('Enter Subtitle') }}">
                      </div>
                    @endif
                    <div class="form-group">
                      <label for="">{{ __('Button Text') . '*' }}</label>
                      <input type="text" class="form-control" name="button_text"
                        value="{{ empty($data->button_text) ? '' : $data->button_text }}"
                        placeholder="{{ __('Enter Button Text') }}">
                      @if ($errors->has('button_text'))
                        <p class="mt-1 mb-0 text-danger">{{ $errors->first('button_text') }}</p>
                      @endif
                    </div>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>

        <div class="card-footer">
          <div class="row">
            <div class="col-12 text-center">
              <button type="submit" form="listingForm" class="btn btn-success">
                {{ __('Update') }}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
@endsection
