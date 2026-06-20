@extends('admin.layout')
@includeIf('admin.partials.rtl-style')
@section('content')
    <div class="page-header">
        <h4 class="page-title">{{ __('Home Page') }}</h4>
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
                <a href="{{ route('admin.mobile_interface') }}">{{ __('Mobile App Settings') }}</a>
            </li>
            <li class="separator">
                <i class="flaticon-right-arrow"></i>
            </li>
            <li class="separator">
                <a href="#">{{ __('Home Page') }}</a>
            </li>
        </ul>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-lg-10">
                            <div class="card-title">{{ __('Home Page') }}</div>
                        </div>
                        <div class="col-lg-2">
                            @includeIf('backend.partials.languages')
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <form id="mobileGeneralForm" action="{{ route('admin.mobile_interface_update') }}" method="post"
                        enctype="multipart/form-data">
                        @csrf
                        <input type="hidden" value="{{ request()->input('language') }}" name="language">
                        <div class="row px-5">
                            <div class="col-lg-8 mx-auto">
                                <fieldset class="form-group border mb-5 border-secondary rounded">
                                    <legend class="w-auto px-2 h3 font-weight-bold text-warning">
                                        {{ __('Section Titles') }}
                                    </legend>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="form-group">
                                                <label for="">{{ __('Category Listing Section Title') }}</label>
                                                <input type="text" class="form-control"
                                                    name="category_listing_section_title"
                                                    value="{{ empty($data->category_listing_section_title) ? '' : $data->category_listing_section_title }}"
                                                    placeholder="{{ __('Enter category title') }}">
                                                @error('category_listing_section_title')
                                                    <div class="text-danger">{{ $message }}</div>
                                                @enderror
                                            </div>
                                            <div class="form-group">
                                                <label for="">{{ __('Featured Listing Section Title') }}</label>
                                                <input type="text" class="form-control"
                                                    name="featured_listing_section_title"
                                                    value="{{ empty($data->featured_listing_section_title) ? '' : $data->featured_listing_section_title }}"
                                                    placeholder="{{ __('Enter Featured Listing Section Title') }}">
                                                @error('featured_listing_section_title')
                                                    <div class="text-danger">{{ $message }}</div>
                                                @enderror
                                            </div>
                                        </div>
                                    </div>
                                </fieldset>

                                <fieldset class="form-group border mb-5 border-secondary rounded">
                                    <legend class="w-auto px-2 h3 font-weight-bold text-warning">
                                        {{ __('Banner Section') }}
                                    </legend>
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="form-group">
                                                <label for="">{{ __('Background Image') . '*' }}</label>
                                                <br>
                                                <div class="thumb-preview">
                                                    @if (!empty($data->banner_background_image))
                                                        <img src="{{ asset('assets/img/mobile-interface/' . $data->banner_background_image) }}"
                                                            alt="image" class="uploaded-img">
                                                    @else
                                                        <img src="{{ asset('assets/img/noimage.jpg') }}" alt="..."
                                                            class="uploaded-img">
                                                    @endif
                                                </div>
                                                <div class="mt-3">
                                                    <div role="button" class="btn btn-primary btn-sm upload-btn">
                                                        {{ __('Choose Image') }}
                                                        <input type="file" class="img-input"
                                                            name="banner_background_image">
                                                    </div>
                                                </div>
                                                @error('banner_background_image')
                                                    <p class="mt-2 mb-0 text-danger">{{ $message }}</p>
                                                @enderror
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="form-group">
                                                <label for="">{{ __('Banner Image') . '*' }}</label>
                                                <br>
                                                <div class="thumb-preview">
                                                    @if (!empty($data->banner_image))
                                                        <img src="{{ asset('assets/img/mobile-interface/' . $data->banner_image) }}"
                                                            alt="image" class="uploaded-img2">
                                                    @else
                                                        <img src="{{ asset('assets/img/noimage.jpg') }}" alt="..."
                                                            class="uploaded-img2">
                                                    @endif
                                                </div>
                                                <div class="mt-3">
                                                    <div role="button" class="btn btn-primary btn-sm upload-btn">
                                                        {{ __('Choose Image') }}
                                                        <input type="file" class="img-input2" name="banner_image">
                                                    </div>
                                                </div>
                                                @error('banner_image')
                                                    <p class="mt-2 mb-0 text-danger">{{ $message }}</p>
                                                @enderror
                                            </div>
                                        </div>

                                        <div class="col-lg-12">
                                            <div class="form-group">
                                                <label for="">{{ __('Banner Title') }} *</label>
                                                <input type="text" class="form-control" name="banner_title"
                                                    value="{{ empty($data->banner_title) ? '' : $data->banner_title }}"
                                                    placeholder="{{ __('Enter banner title') }}">
                                                @error('banner_title')
                                                    <div class="text-danger">{{ $message }}</div>
                                                @enderror
                                            </div>
                                        </div>

                                        <div class="col-lg-12">
                                            <div class="form-group">
                                                <label for="">{{ __('Banner Button Text') }} *</label>
                                                <input type="text" class="form-control" name="banner_button_text"
                                                    value="{{ empty($data->banner_button_text) ? '' : $data->banner_button_text }}"
                                                    placeholder="{{ __('Enter banner button text') }}">
                                                @error('banner_button_text')
                                                    <div class="text-danger">{{ $message }}</div>
                                                @enderror
                                            </div>
                                        </div>

                                        <div class="col-lg-12">
                                            <div class="form-group">
                                                <label for="">{{ __('Banner Button Url') }} *</label>
                                                <input type="text" class="form-control" name="banner_button_url"
                                                    value="{{ empty($data->banner_button_url) ? '' : $data->banner_button_url }}"
                                                    placeholder="{{ __('Enter banner button url') }}">
                                                @error('banner_button_url')
                                                    <div class="text-danger">{{ $message }}</div>
                                                @enderror
                                            </div>
                                        </div>

                                    </div>
                                </fieldset>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="card-footer">
                    <div class="row">
                        <div class="col-12 text-center">
                            <button type="submit" form="mobileGeneralForm" class="btn btn-success">
                                {{ __('Update') }}
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
