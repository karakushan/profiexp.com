@extends('admin.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Section Show/Hide') }}</h4>
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
        <a href="#">{{ __('Section Show/Hide') }}</a>
      </li>
    </ul>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <form action="{{ route('admin.home_page.update_section_status') }}" method="POST">
          @csrf
          <div class="card-header">
            <div class="card-title d-inline-block">{{ __('Section Show/Hide') }}</div>
          </div>

          <div class="card-body">
            <div class="row">
              <div class="col-lg-6 offset-lg-3">

                <div class="form-group">
                  <label>{{ __('Category Section Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="category_section_status" value="1" class="selectgroup-input"
                        {{ $sectionInfo->category_section_status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Enable') }}</span>
                    </label>

                    <label class="selectgroup-item">
                      <input type="radio" name="category_section_status" value="0" class="selectgroup-input"
                        {{ $sectionInfo->category_section_status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Disable') }}</span>
                    </label>
                  </div>
                  @error('category_section_status')
                    <p class="mb-0 text-danger">{{ $message }}</p>
                  @enderror
                </div>

                <div class="form-group">
                  <label>{{ __('Featured Listing Section Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="featured_listing_section_status" value="1"
                        class="selectgroup-input"
                        {{ $sectionInfo->featured_listing_section_status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Enable') }}</span>
                    </label>

                    <label class="selectgroup-item">
                      <input type="radio" name="featured_listing_section_status" value="0"
                        class="selectgroup-input"
                        {{ $sectionInfo->featured_listing_section_status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Disable') }}</span>
                    </label>
                  </div>
                  @error('featured_listing_section_status')
                    <p class="mb-0 text-danger">{{ $message }}</p>
                  @enderror
                </div>

                @if ($themeVersion == 2)
                  <div class="form-group">
                    <label>{{ __('Latest Listing Section Status') }}</label>
                    <div class="selectgroup w-100">
                      <label class="selectgroup-item">
                        <input type="radio" name="latest_listing_section_status" value="1"
                          class="selectgroup-input"
                          {{ $sectionInfo->latest_listing_section_status == 1 ? 'checked' : '' }}>
                        <span class="selectgroup-button">{{ __('Enable') }}</span>
                      </label>

                      <label class="selectgroup-item">
                        <input type="radio" name="latest_listing_section_status" value="0"
                          class="selectgroup-input"
                          {{ $sectionInfo->latest_listing_section_status == 0 ? 'checked' : '' }}>
                        <span class="selectgroup-button">{{ __('Disable') }}</span>
                      </label>
                    </div>
                    @error('latest_listing_section_status')
                      <p class="mb-0 text-danger">{{ $message }}</p>
                    @enderror
                  </div>
                @endif

                <div class="form-group">
                  <label>{{ __('Package Section Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="package_section_status" value="1" class="selectgroup-input"
                        {{ $sectionInfo->package_section_status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Enable') }}</span>
                    </label>

                    <label class="selectgroup-item">
                      <input type="radio" name="package_section_status" value="0" class="selectgroup-input"
                        {{ $sectionInfo->package_section_status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Disable') }}</span>
                    </label>
                  </div>
                  @error('package_section_status')
                    <p class="mb-0 text-danger">{{ $message }}</p>
                  @enderror
                </div>

                @if ($themeVersion == 1 || $themeVersion == 3)
                  <div class="form-group">
                    <label>{{ __('Counter Section Status') }}</label>
                    <div class="selectgroup w-100">
                      <label class="selectgroup-item">
                        <input type="radio" name="counter_section_status" value="1" class="selectgroup-input"
                          {{ $sectionInfo->counter_section_status == 1 ? 'checked' : '' }}>
                        <span class="selectgroup-button">{{ __('Enable') }}</span>
                      </label>

                      <label class="selectgroup-item">
                        <input type="radio" name="counter_section_status" value="0" class="selectgroup-input"
                          {{ $sectionInfo->counter_section_status == 0 ? 'checked' : '' }}>
                        <span class="selectgroup-button">{{ __('Disable') }}</span>
                      </label>
                    </div>
                    @error('counter_section_status')
                      <p class="mb-0 text-danger">{{ $message }}</p>
                    @enderror
                  </div>
                @endif

                @if ($themeVersion == 3 || $themeVersion == 2)
                  <div class="form-group">
                    <label>{{ __('Location Section Status') }}</label>
                    <div class="selectgroup w-100">
                      <label class="selectgroup-item">
                        <input type="radio" name="location_section_status" value="1" class="selectgroup-input"
                          {{ $sectionInfo->location_section_status == 1 ? 'checked' : '' }}>
                        <span class="selectgroup-button">{{ __('Enable') }}</span>
                      </label>

                      <label class="selectgroup-item">
                        <input type="radio" name="location_section_status" value="0" class="selectgroup-input"
                          {{ $sectionInfo->location_section_status == 0 ? 'checked' : '' }}>
                        <span class="selectgroup-button">{{ __('Disable') }}</span>
                      </label>
                    </div>
                    @error('location_section_status')
                      <p class="mb-0 text-danger">{{ $message }}</p>
                    @enderror
                @endif

                @if ($themeVersion == 1 || $themeVersion == 4)
                  <div class="form-group">
                    <label>{{ __('Work Process Section Status') }}</label>
                    <div class="selectgroup w-100">
                      <label class="selectgroup-item">
                        <input type="radio" name="work_process_section_status" value="1"
                          class="selectgroup-input"
                          {{ $sectionInfo->work_process_section_status == 1 ? 'checked' : '' }}>
                        <span class="selectgroup-button">{{ __('Enable') }}</span>
                      </label>

                      <label class="selectgroup-item">
                        <input type="radio" name="work_process_section_status" value="0"
                          class="selectgroup-input"
                          {{ $sectionInfo->work_process_section_status == 0 ? 'checked' : '' }}>
                        <span class="selectgroup-button">{{ __('Disable') }}</span>
                      </label>
                    </div>
                    @error('work_process_section_status')
                      <p class="mb-0 text-danger">{{ $message }}</p>
                    @enderror
                  </div>
                @endif

                @if ($themeVersion == 2 || $themeVersion == 4)
                  <div class="form-group">
                    <label>{{ __('Video Section Status') }}</label>
                    <div class="selectgroup w-100">
                      <label class="selectgroup-item">
                        <input type="radio" name="video_section" value="1" class="selectgroup-input"
                          {{ $sectionInfo->video_section == 1 ? 'checked' : '' }}>
                        <span class="selectgroup-button">{{ __('Enable') }}</span>
                      </label>

                      <label class="selectgroup-item">
                        <input type="radio" name="video_section" value="0" class="selectgroup-input"
                          {{ $sectionInfo->video_section == 0 ? 'checked' : '' }}>
                        <span class="selectgroup-button">{{ __('Disable') }}</span>
                      </label>
                    </div>
                    @error('video_section')
                      <p class="mb-0 text-danger">{{ $message }}</p>
                    @enderror
                  </div>
                @endif
                @if ($themeVersion == 2 || $themeVersion == 3)
                  <div class="form-group">
                    <label>{{ __('Testimonial Section Status') }}</label>
                    <div class="selectgroup w-100">
                      <label class="selectgroup-item">
                        <input type="radio" name="testimonial_section_status" value="1"
                          class="selectgroup-input"
                          {{ $sectionInfo->testimonial_section_status == 1 ? 'checked' : '' }}>
                        <span class="selectgroup-button">{{ __('Enable') }}</span>
                      </label>

                      <label class="selectgroup-item">
                        <input type="radio" name="testimonial_section_status" value="0"
                          class="selectgroup-input"
                          {{ $sectionInfo->testimonial_section_status == 0 ? 'checked' : '' }}>
                        <span class="selectgroup-button">{{ __('Disable') }}</span>
                      </label>
                    </div>
                    @error('testimonial_section_status')
                      <p class="mb-0 text-danger">{{ $message }}</p>
                    @enderror
                  </div>
                @endif

                @if ($themeVersion == 1 || $themeVersion == 4)
                  <div class="form-group">
                    <label>{{ __('Call To Action Section Status') }}</label>
                    <div class="selectgroup w-100">
                      <label class="selectgroup-item">
                        <input type="radio" name="call_to_action_section_status" value="1"
                          class="selectgroup-input"
                          {{ $sectionInfo->call_to_action_section_status == 1 ? 'checked' : '' }}>
                        <span class="selectgroup-button">{{ __('Enable') }}</span>
                      </label>

                      <label class="selectgroup-item">
                        <input type="radio" name="call_to_action_section_status" value="0"
                          class="selectgroup-input"
                          {{ $sectionInfo->call_to_action_section_status == 0 ? 'checked' : '' }}>
                        <span class="selectgroup-button">{{ __('Disable') }}</span>
                      </label>
                    </div>
                    @error('call_to_action_section_status')
                      <p class="mb-0 text-danger">{{ $message }}</p>
                    @enderror
                  </div>
                @endif
                <div class="form-group">
                  <label>{{ __('Blog Section Status') }}</label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="blog_section_status" value="1" class="selectgroup-input"
                        {{ $sectionInfo->blog_section_status == 1 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Enable') }}</span>
                    </label>

                    <label class="selectgroup-item">
                      <input type="radio" name="blog_section_status" value="0" class="selectgroup-input"
                        {{ $sectionInfo->blog_section_status == 0 ? 'checked' : '' }}>
                      <span class="selectgroup-button">{{ __('Disable') }}</span>
                    </label>
                  </div>
                  @error('blog_section_status')
                    <p class="mb-0 text-danger">{{ $message }}</p>
                  @enderror
                </div>
              </div>
            </div>
          </div>

          <div class="card-footer">
            <div class="row">
              <div class="col-12 text-center">
                <button type="submit" class="btn btn-success">
                  {{ __('Update') }}
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
@endsection
