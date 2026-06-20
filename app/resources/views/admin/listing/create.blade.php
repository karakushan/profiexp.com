@extends('admin.layout')

@section('content')
    <div class="page-header">
        <h4 class="page-title">{{ __('Add Listing') }}</h4>
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
                <a href="{{ route('admin.listing_management.listings') }}">{{ __('Listings Management') }}</a>
            </li>
            <li class="separator">
                <i class="flaticon-right-arrow"></i>
            </li>
            <li class="nav-item">
                <a href="#">{{ __('Add Listing') }}</a>
            </li>
        </ul>
    </div>

    @php

        $vendorId = $vendor_id;

        if ($vendorId == 0) {
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
            $additionalFeatureLimit = 99999999;
            $SocialLinkLimit = 99999999;
            $numberoffImages = 99999999;
            $can_listing_add = 1;
        } else {
            if ($vendorId) {
                $current_package = App\Http\Helpers\VendorPermissionHelper::packagePermission($vendorId);

                $dowgraded = App\Http\Helpers\VendorPermissionHelper::packagesDowngraded($vendor_id);
                $listingCanAdd = packageTotalListing($vendor_id) - vendorTotalListing($vendor_id);

                if (!empty($current_package) && !empty($current_package->features)) {
                    $permissions = json_decode($current_package->features, true);
                } else {
                    $permissions = null;
                }
                if ($current_package != '[]') {
                    $numberoffImages = $current_package->number_of_images_per_listing;
                } else {
                    $numberoffImages = 0;
                }
            } else {
                $permissions = null;
                $numberoffImages = 0;
            }
        }

    @endphp

    <div class="row">
        <div class="col-md-12">
            @if ($vendorId != 0)
                @if ($current_package != '[]')
                    @if (vendorTotalAddedListing($vendorId) >= $current_package->number_of_listing)
                        <div class="alert alert-warning">
                            {{ __('You cannot add more listings for this vendor. Vendor will need to upgrade his plan') }}
                        </div>
                        @php
                            $can_listing_add = 2;
                        @endphp
                    @else
                        @php
                            $can_listing_add = 1;
                        @endphp
                    @endif
                @else
                    @php
                        $pendingMemb = \App\Models\Membership::query()
                            ->where([['vendor_id', '=', $vendor_id], ['status', 0]])
                            ->whereYear('start_date', '<>', '9999')
                            ->orderBy('id', 'DESC')
                            ->first();
                        $pendingPackage = isset($pendingMemb)
                            ? \App\Models\Package::query()->findOrFail($pendingMemb->package_id)
                            : null;
                    @endphp
                    @if ($pendingPackage)
                        <div class="alert alert-warning">
                            {{ __('You have requested a package which needs an action (Approval / Rejection) by Admin. You will be notified via mail once an action is taken.') }}
                        </div>
                        <div class="alert alert-warning">
                            <strong>{{ __('Pending Package') . ':' }} </strong> {{ $pendingPackage->title }}
                            <span class="badge badge-secondary">{{ $pendingPackage->term }}</span>
                            <span class="badge badge-warning">{{ __('Decision Pending') }}</span>
                        </div>
                    @else
                        @php
                            $newMemb = \App\Models\Membership::query()
                                ->where([['vendor_id', '=', $vendor_id], ['status', 0]])
                                ->first();
                        @endphp
                        @if ($newMemb)
                            <div class="alert alert-warning">
                                {{ __('Your membership is expired. Please purchase a new package / extend the current package.') }}
                            </div>
                        @endif
                        <div class="alert alert-warning">
                            {{ __('Please purchase a new package to add Listing.') }}
                        </div>
                    @endif
                    @php
                        $can_listing_add = 0;
                    @endphp
                @endif
            @endif
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="card-title d-inline-block">{{ __('Add Listing') }}</div>
                        </div>
                        <div class="col-sm-6 mt-2 mt-sm-0">
                            <div class="btn-groups gap-10 justify-content-sm-end">
                                @if ($vendor_id != 0)
                                    <button type="button" class="btn btn-primary btn-sm btn-sm btn-round" id="aa"
                                        data-toggle="modal" data-target="#adminCheckLimitModal">

                                        @if (
                                            $dowgraded['listingImgDown'] ||
                                                $dowgraded['listingFaqDown'] ||
                                                $dowgraded['listingProductDown'] ||
                                                $dowgraded['featureDown'] ||
                                                $dowgraded['socialLinkDown'] ||
                                                $dowgraded['amenitieDown'] ||
                                                $dowgraded['listingProductImgDown'] ||
                                                $listingCanAdd < 0)
                                            <i class="fas fa-exclamation-triangle text-danger"></i>
                                        @endif
                                        {{ __('Check Limit') }}
                                    </button>
                                @endif

                                <a class="btn btn-info btn-sm"
                                    href="{{ route('admin.listing_management.select_vendor') }}">
                                    <span class="btn-label">
                                        <i class="fas fa-backward"></i>
                                    </span>
                                    {{ __('Back') }}
                                </a>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-10 offset-lg-1">
                            <div class="alert alert-danger pb-1 dis-none" id="listingErrors">
                                <ul></ul>
                            </div>
                            <div class="col-lg-12">
                                <label for="" class="mb-2"><strong>{{ __('Gallery Images') . '*' }}
                                    </strong></label>
                                <form action="{{ route('admin.listing.imagesstore') }}" id="my-dropzone"
                                    enctype="multipart/formdata" class="dropzone create">
                                    @csrf
                                    <div class="fallback">
                                        <input name="file" type="file" multiple />
                                    </div>
                                </form>
                                <p class="em text-danger mb-0" id="errslider_images"></p>
                            </div>

                            <form id="listingForm" action="{{ route('admin.listing_management.store_listing') }}"
                                method="POST" enctype="multipart/form-data">
                                @csrf
                                <div class="row">
                                    <div class="col-lg-3">
                                        <div class="form-group">
                                            <label for="">{{ __('Featured Image') . '*' }}</label>
                                            <br>
                                            <div class="thumb-preview">
                                                <img src="{{ asset('assets/img/noimage.jpg') }}" alt="..."
                                                    class="uploaded-img">
                                            </div>

                                            <div class="mt-3">
                                                <div role="button" class="btn btn-primary btn-sm upload-btn">
                                                    {{ __('Choose Image') }}
                                                    <input type="file" class="img-input" name="feature_image">
                                                </div>
                                            </div>
                                            <p class="mt-2 mb-0 text-warning">{{ __('Image Size 600x400') }}</p>
                                        </div>

                                    </div>
                                    @if (is_array($permissions) && in_array('Video', $permissions))
                                        <div class="col-lg-3">
                                            <div class="form-group">
                                                <label for="">{{ __('Video Image') }}</label>
                                                <br>
                                                @php
                                                    $display = 'none';
                                                @endphp
                                                <div class="thumb-preview">
                                                    <img src="{{ asset('assets/img/noimage.jpg') }}" alt="..."
                                                        class="uploaded-img2">
                                                    <button class="remove-img2 btn btn-remove" type="button"
                                                        style="display:{{ $display }};">
                                                        <i class="fal fa-times"></i>
                                                    </button>
                                                </div>

                                                <div class="mt-3">
                                                    <div role="button" class="btn btn-primary btn-sm upload-btn">
                                                        {{ __('Choose Image') }}
                                                        <input type="file" class="video-img-input"
                                                            name="video_background_image">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    @endif
                                </div>

                                <div class="row">
                                    @if (is_array($permissions) && in_array('Video', $permissions))
                                        <div class="col-lg-3">
                                            <div class="form-group">
                                                <label>{{ __('Video Link') }} </label>
                                                <input type="text" class="form-control" name="video_url"
                                                    placeholder="{{ __('Enter Your video url') }}">
                                            </div>
                                        </div>
                                    @endif

                                    <div class="col-lg-3">
                                        <div class="form-group">
                                            <label>{{ __('Mail') . '*' }} </label>
                                            <input type="text" class="form-control" name="mail"
                                                placeholder="{{ __('Enter Contact Mail') }}">
                                        </div>
                                    </div>
                                    <div class="col-lg-3">
                                        <div class="form-group">
                                            <label>{{ __('Phone') . '*' }} </label>
                                            <input type="text" class="form-control" name="phone"
                                                placeholder="{{ __('Enter Phone Number') }}">
                                        </div>
                                    </div>
                                    @php
                                        $approve = App\Models\BasicSettings\Basic::select(
                                            'admin_approve_status',
                                        )->first();
                                        $status = $approve->admin_approve_status;
                                    @endphp

                                    <div class="col-lg-3">
                                        <div class="form-group">
                                            <label>{{ __('Approve Status') . '*' }} </label>
                                            <select name="status" id="status" class="form-control">
                                                <option @if ($status == 1) selected @endif value="1">
                                                    {{ __('Approved') }}
                                                </option>
                                                <option @if ($status == 0) selected @endif value="0">
                                                    {{ __('Pending') }}
                                                </option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-lg-3">
                                        <div class="form-group">
                                            <label>{{ __('Hide/Show') }} </label>
                                            <select name="visibility" id="visibility" class="form-control">
                                                <option value="1">{{ __('Show') }}
                                                </option>
                                                <option selected value="0">{{ __('Hide') }}
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                    @if ($settings->google_map_api_key_status == 0)
                                        <div class="col-lg-3">
                                            <div class="form-group">
                                                <label>{{ __('Latitude') . '*' }} </label>
                                                <input type="text" class="form-control" name="latitude"
                                                    placeholder="{{ __('Enter Latitude') }}">
                                                <p class="text-warning">
                                                    {{ __('The Latitude must be between -90 and 90. Ex:49.43453') }}</p>
                                            </div>
                                        </div>

                                        <div class="col-lg-3">
                                            <div class="form-group">
                                                <label>{{ __('Longitude') . '*' }} </label>
                                                <input type="text" class="form-control" name="longitude"
                                                    placeholder="{{ __('Enter Longitude') }}">
                                                <p class="text-warning">
                                                    {{ __('The Longitude must be between -180 and 180. Ex:149.91553') }}
                                                </p>
                                            </div>
                                        </div>
                                    @endif
                                    <div class="col-lg-3">
                                        <div class="form-group">
                                            <label>{{ __('Min Price') }}({{ $settings->base_currency_text }})</label>
                                            <input type="text" class="form-control" name="min_price"
                                                placeholder="{{ __('Enter Min Price') }}">
                                        </div>
                                    </div>

                                    <div class="col-lg-3">
                                        <div class="form-group">
                                            <label>{{ __('Max Price') }}({{ $settings->base_currency_text }})</label>
                                            <input type="text" class="form-control" name="max_price"
                                                placeholder="{{ __('Enter Max Price') }}">
                                        </div>
                                    </div>
                                    <input type="hidden" name="can_listing_add" id="can_listing_add" value="1">
                                    <input type="hidden" name="vendor_id" id="vendor_id" value="{{ $vendor_id }}">

                                </div>

                                <div id="accordion" class="mt-3 ">
                                    @foreach ($languages as $language)
                                        <div class="version">
                                            <div class="version-header" id="heading{{ $language->id }}">
                                                <h5 class="mb-0">
                                                    <button type="button" class="btn btn-link" data-toggle="collapse"
                                                        data-target="#collapse{{ $language->id }}"
                                                        aria-expanded="{{ $language->is_default == 1 ? 'true' : 'false' }}"
                                                        aria-controls="collapse{{ $language->id }}">
                                                        {{ $language->name . ' ' . __('Language') }}
                                                        {{ $language->is_default == 1 ? __('(Default)') : '' }}
                                                    </button>
                                                </h5>
                                            </div>

                                            <div id="collapse{{ $language->id }}"
                                                class="collapse {{ $language->is_default == 1 ? 'show' : '' }}"
                                                aria-labelledby="heading{{ $language->id }}" data-parent="#accordion">
                                                <div
                                                    class="version-body {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                                    <div class="row">
                                                        <div class="col-lg-6">
                                                            <div class="form-group">
                                                                <label>{{ __('Title') . '*' }} </label>
                                                                <input type="text" class="form-control"
                                                                    name="{{ $language->code }}_title"
                                                                    placeholder="{{ __('Enter Title') }}">
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-6">
                                                            <div class="form-group">
                                                                <label>{{ __('Category') . '*' }} </label>
                                                                <select name="{{ $language->code }}_category_id"
                                                                    data-code="{{ $language->code }}"
                                                                    class="form-control js-example-basic-single2">
                                                                </select>
                                                            </div>
                                                        </div>


                                                        <div class="col-lg-4">
                                                            <div
                                                                class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                                                <label>{{ __('Country') . '*' }}</label>
                                                                <select name="{{ $language->code }}_country_id"
                                                                    class="form-control js-country-basic"
                                                                    data-code="{{ $language->code }}">
                                                                </select>
                                                            </div>
                                                        </div>


                                                        <div class="col-lg-4 {{ $language->code }}_hide_state">
                                                            <div
                                                                class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                                                <label>{{ __('State') . '*' }} </label>
                                                                <select name="{{ $language->code }}_state_id"
                                                                    class="form-control js-state-basic stateDropDown {{ $language->code }}_country_state_id"
                                                                    data-code="{{ $language->code }}">
                                                                </select>
                                                            </div>
                                                        </div>


                                                        <div class="col-lg-4">
                                                            <div
                                                                class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                                                <label>{{ __('City') . '*' }} </label>
                                                                <select name="{{ $language->code }}_city_id"
                                                                    class="form-control  js-select-city-ajax {{ $language->code }}_state_city_id"
                                                                    data-code="{{ $language->code }}">
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-12">
                                                            <div class="form-group">
                                                                <label>{{ __('Address') . '*' }}</label>
                                                                <input type="text" class="form-control"
                                                                    value="{{ old($language->code . '_address') }}"
                                                                    name="{{ $language->code }}_address"
                                                                    placeholder="{{ __('Enter Address') }}"
                                                                    id="search-address">
                                                                @if ($language->is_default == 1 && $settings->google_map_api_key_status == 1)
                                                                    <a href=""
                                                                        class="btn btn-secondary mt-2 btn-sm"
                                                                        data-toggle="modal" data-target="#GoogleMapModal">
                                                                        <i class="fas fa-eye"></i> {{ __('Show Map') }}
                                                                    </a>
                                                                @endif
                                                            </div>
                                                        </div>

                                                        @if ($language->is_default == 1 && $settings->google_map_api_key_status == 1)
                                                            <div class="col-lg-6">
                                                                <div class="form-group">
                                                                    <label>{{ __('Latitude' . '*') }}</label>
                                                                    <input type="text" class="form-control"
                                                                        id="latitude" name="latitude"
                                                                        placeholder="{{ __('Enter Latitude') }}">
                                                                </div>
                                                                <p class="text-warning pl-10">
                                                                    {{ __('The Latitude must be between -90 to 90. Ex:49.43453') }}
                                                                </p>
                                                            </div>

                                                            <div class="col-lg-6">
                                                                <div class="form-group">
                                                                    <label>{{ __('Longitude' . '*') }}</label>
                                                                    <input type="text" id="longitude"
                                                                        class="form-control" name="longitude"
                                                                        placeholder="{{ __('Enter Longitude') }}">
                                                                </div>
                                                                <p class="text-warning pl-10">
                                                                    {{ __('The Longitude must be between -180 to 180. Ex:149.91553') }}
                                                                </p>
                                                            </div>
                                                        @endif

                                                        @if (is_array($permissions) && in_array('Amenities', $permissions))
                                                            <div class="col-lg-12">
                                                                <div
                                                                    class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                                                    @php
                                                                        $aminities = App\Models\Aminite::where(
                                                                            'language_id',
                                                                            $language->id,
                                                                        )->get();
                                                                    @endphp
                                                                    <label>{{ __('Select Amenities') . '*' }} </label>
                                                                    <div class="dropdown-content" id="checkboxes">
                                                                        @foreach ($aminities as $amenity)
                                                                            <input type="checkbox"
                                                                                id="{{ $amenity->id }}"
                                                                                name="{{ $language->code }}_aminities[]"
                                                                                value="{{ $amenity->id }}">
                                                                            <label
                                                                                class="amenities-label {{ $language->direction == 1 ? 'ml-2 mr-0' : 'mr-2' }}"
                                                                                for="{{ $amenity->id }}">{{ $amenity->title }}</label>
                                                                        @endforeach
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        @endif
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <div
                                                                class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                                                <label>{{ __('Summary') }} </label>
                                                                <textarea class="form-control" name="{{ $language->code }}_summary" data-height="300"></textarea>
                                                            </div>
                                                        </div>

                                                        <div class="col-lg-12">
                                                            <div
                                                                class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                                                <label>{{ __('Description') . '*' }} </label>
                                                                <textarea id="{{ $language->code }}_description" class="form-control summernote"
                                                                    name="{{ $language->code }}_description" data-height="300"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <div
                                                                class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                                                <label>{{ __('Meta Keywords') }} </label>
                                                                <input class="form-control"
                                                                    name="{{ $language->code }}_meta_keyword"
                                                                    placeholder="{{ __('Enter Meta Keywords') }}"
                                                                    data-role="tagsinput">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <div
                                                                class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                                                <label>{{ __('Meta Description') }} </label>
                                                                <textarea class="form-control" name="{{ $language->code }}_meta_description" rows="5"
                                                                    placeholder="{{ __('Enter Meta Description') }}"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            @php $currLang = $language; @endphp
                                                            @foreach ($languages as $language)
                                                                @continue($language->id == $currLang->id)
                                                                <div class="form-check py-0">
                                                                    <label class="form-check-label">
                                                                        <input class="form-check-input" type="checkbox"
                                                                            onchange="cloneInput('collapse{{ $currLang->id }}', 'collapse{{ $language->id }}', event)">
                                                                        <span
                                                                            class="form-check-sign">{{ __('Clone for') }}
                                                                            <strong
                                                                                class="text-capitalize text-secondary">{{ $language->name }}</strong>
                                                                            {{ __('language') }}</span>
                                                                    </label>
                                                                </div>
                                                            @endforeach
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    @endforeach
                                </div>
                                <div id="sliders">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <div class="row">
                        <div class="col-12 text-center">
                            <button type="submit" form="listingForm" data-can_listing_add="{{ $can_listing_add }}"
                                class="btn btn-success">
                                {{ __('Save') }}
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    @includeIf('admin.listing.check-limit')
    {{-- Google map Modal --}}
    <div class="modal fade" id="GoogleMapModal" tabindex="-1" role="dialog"
        aria-labelledby="GoogleMapModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="GoogleMapModalLongTitle">{{ __('Google Map') }}</h5>
                    <div>
                        <button type="button" class="btn btn-secondary btn-xs"
                            data-dismiss="modal">{{ __('Choose') }}</button>
                        <button type="button" class="btn btn-danger btn-xs" data-dismiss="modal">X</button>
                    </div>
                </div>
                <div class="modal-body">
                    <div id="map"></div>
                </div>
            </div>
        </div>
    </div>

@endsection

@section('script')
    <script>
        const countryUrl = "{{ route('admin.get_country') }}";
        const cityUrl = "{{ route('admin.get_city') }}";
        const stateUrl = "{{ route('admin.get_state') }}";
        const getHomeCatUrl = "{{ route('admin.get_categories') }}";
    </script>
    @if ($settings->google_map_api_key_status == 1)
        <script src="{{ asset('assets/admin/js/map-init2.js') }}"></script>
        <script
            src="https://maps.googleapis.com/maps/api/js?key={{ $settings->google_map_api_key }}&libraries=places&callback=initMap"
            async defer></script>
    @endif
    <script>
        'use strict';
        var storeUrl = "{{ route('admin.listing.imagesstore') }}";
        var removeUrl = "{{ route('admin.listing.imagermv') }}";
        var getStateUrl = "{{ route('admin.listing_management.get-state') }}";
        var getCityUrl = "{{ route('admin.listing_management.get-city') }}";
        var galleryImages = {{ $numberoffImages }};
        const baseURL = "{{ url('/') }}";
    </script>

    <script type="text/javascript" src="{{ asset('assets/admin/js/admin-listing.js') }}"></script>
    <script type="text/javascript" src="{{ asset('assets/admin/js/admin-dropzone.js') }}"></script>
@endsection
