@extends('vendors.layout')

@section('content')
    <div class="page-header">
        <h4 class="page-title">{{ __('Add Listing') }}</h4>
        <ul class="breadcrumbs">
            <li class="nav-home">
                <a href="{{ route('vendor.dashboard') }}">
                    <i class="flaticon-home"></i>
                </a>
            </li>
            <li class="separator">
                <i class="flaticon-right-arrow"></i>
            </li>
            <li class="nav-item">
                <a href="#">{{ __('Listings Management') }}</a>
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
        $vendorId = Auth::guard('vendor')->user()->id;

        if ($vendorId) {
            $current_package = App\Http\Helpers\VendorPermissionHelper::packagePermission($vendorId);

            if ($current_package != '[]') {
                $numberoffImages = $current_package->number_of_images_per_listing;
            } else {
                $numberoffImages = 0;
            }
            if (!empty($current_package) && !empty($current_package->features)) {
                $permissions = json_decode($current_package->features, true);
            } else {
                $permissions = null;
            }
        } else {
            $permissions = null;
        }
    @endphp


    <div class="row">
        <div class="col-md-12">
            @if ($current_package != '[]')
                @if (vendorTotalAddedListing($vendorId) >= $current_package->number_of_listing)
                    <div class="alert alert-warning">
                        {{ __('You can\'t add more Listing. Please buy/extend a plan to add Listing') }}
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
                        ->where([['vendor_id', '=', Auth::id()], ['status', 0]])
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
                            ->where([['vendor_id', '=', Auth::id()], ['status', 0]])
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
            <div class="card">
                <div class="card-header">
                    <div class="card-title d-inline-block">{{ __('Add Listing') }}</div>
                    <button type="button" class="btn btn-primary btn-sm float-right listing-ai-field-btn" id="aiGenerateItemSeoBtn"
                        data-field="" data-lang=""
                        data-title="{{ __('AI Generate Listing Content') }}">
                        <i class="fas fa-magic"></i> {{ __('Generate All Content') }}
                    </button>
                </div>
                <div class="card-body">

                    <div class="row">
                        <div class="col-lg-10 offset-lg-1">


                            <div class="alert alert-danger pb-1 dis-none" id="listingErrors">
                                <ul></ul>
                            </div>
                            <div class="col-lg-12">
                                <label for="" class="mb-2"><strong>{{ __('Gallery Images') }} *</strong></label>
                                <form action="{{ route('vendor.listing.imagesstore') }}" id="my-dropzone"
                                    enctype="multipart/formdata" class="dropzone create">
                                    @csrf
                                    <div class="fallback">
                                        <input name="file" type="file" multiple />
                                    </div>
                                </form>
                                <button type="button" class="btn btn-sm btn-primary mt-3" data-ai-slider-open
                                    data-dropzone="#my-dropzone"
                                    data-hidden-wrap="#sliders"
                                    data-hidden-input-name="slider_images[]"
                                    data-endpoint="{{ route('vendor.ai.generate.slider.images') }}"
                                    data-upload-endpoint="{{ route('vendor.listing.imagesstore') }}"
                                    data-remove-endpoint="{{ route('vendor.listing.imagermv') }}"
                                    data-remove-key="fileid"
                                    data-max-count="{{ $numberoffImages }}"
                                    data-count-default="3"
                                    data-size="custom_600_400">
                                    <i class="fas fa-magic"></i> {{ __('Generate Gallery Images') }}
                                </button>
                                <p class="em text-danger mb-0" id="errslider_images"></p>
                                @if ($current_package != '[]')
                                    @if (vendorTotalAddedListing($vendorId) <= $current_package->number_of_listing)
                                        <p class="text-warning">
                                            {{ __('You can upload maximum') . ' ' . $current_package->number_of_images_per_listing . ' ' . __('images under one listing') }}
                                        </p>
                                    @endif
                                @endif
                            </div>

                            <form id="listingForm" action="{{ route('vendor.listing_management.store_listing') }}"
                                method="POST" enctype="multipart/form-data">
                                @csrf
                                <div class="row">
                                    <div class="col-lg-3">
                                        <div class="form-group">
                                            <label for="">{{ __('Featured Image') . '*' }}</label>
                                            <br>
                                            <div class="thumb-preview">
                                                <img src="{{ asset('assets/img/noimage.jpg') }}" alt="..."
                                                    class="uploaded-img" id="listingFeaturePreview">
                                            </div>
                                            <input type="hidden" name="ai_feature_image" id="listingAiFeatureImage">

                                            <div class="mt-3">
                                                <div role="button" class="btn btn-primary btn-sm upload-btn">
                                                    {{ __('Choose Image') }}
                                                    <input type="file" class="img-input" name="feature_image">
                                                </div>
                                                <button type="button" class="btn btn-primary btn-sm ml-2"
                                                    data-ai-image-open
                                                    data-endpoint="{{ route('vendor.ai.generate.category.image') }}"
                                                    data-target="#listingFeaturePreview"
                                                    data-hidden="#listingAiFeatureImage"
                                                    data-file-input="input[name='feature_image']"
                                                    data-size="custom_600_400"
                                                    data-confirm-text="{{ __('Generate Image') }}">
                                                    <i class="fas fa-magic"></i> {{ __('Generate Image') }}
                                                </button>
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
                                                        class="uploaded-img2" id="listingVideoPreview">
                                                    <button class="remove-img2 btn btn-remove" type="button"
                                                        style="display:{{ $display }};">
                                                        <i class="fal fa-times"></i>
                                                    </button>
                                                </div>
                                                <input type="hidden" name="ai_video_background_image"
                                                    id="listingAiVideoImage">
                                                <div class="mt-3">
                                                    <div role="button" class="btn btn-primary btn-sm upload-btn">
                                                        {{ __('Choose Image') }}
                                                        <input type="file" class="video-img-input"
                                                            name="video_background_image">
                                                    </div>
                                                    <button type="button" class="btn btn-primary btn-sm ml-2"
                                                        data-ai-image-open
                                                        data-endpoint="{{ route('vendor.ai.generate.category.image') }}"
                                                        data-target="#listingVideoPreview"
                                                        data-hidden="#listingAiVideoImage"
                                                        data-file-input="input[name='video_background_image']"
                                                        data-size="landscape_1536_1024"
                                                        data-confirm-text="{{ __('Generate Image') }}">
                                                        <i class="fas fa-magic"></i> {{ __('Generate Image') }}
                                                    </button>
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
                                    @php
                                        $approve = App\Models\BasicSettings\Basic::select(
                                            'admin_approve_status',
                                        )->first();
                                        $status = $approve->admin_approve_status;
                                    @endphp
                                    <input type="hidden" value="{{ $status }}"name="status" id="status">
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
                                            <input type="text" class="form-control"
                                                name="max_price"placeholder="{{ __('Enter Max Price') }}">
                                        </div>
                                    </div>

                                    <input type="hidden" name="vendor_id" id="vendor_id"
                                        value="{{ Auth::guard('vendor')->user()->id }}">
                                    <input type="hidden" name="can_listing_add" value="{{ $can_listing_add }}">
                                </div>

                                <div class="col-12">
                                    <div class="card border mb-3">
                                        <div class="card-header bg-light">
                                            <h5 class="mb-0">{{ __('Location') }}</h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="form-group">
                                                        <label>{{ __('Search address on map') }}</label>
                                                        <input type="text" class="form-control" id="search-address"
                                                            placeholder="{{ __('Enter address to search on map') }}">
                                                    </div>
                                                </div>

                                                <div class="col-lg-6">
                                                    <div class="form-group">
                                                        <label>{{ __('Latitude') . '*' }} </label>
                                                        <input type="text" class="form-control" name="latitude"
                                                            placeholder="{{ __('Enter Latitude') }}">
                                                        <p class="text-warning mb-0">
                                                            {{ __('The Latitude must be between -90 and 90. Ex:49.43453') }}</p>
                                                    </div>
                                                </div>

                                                <div class="col-lg-6">
                                                    <div class="form-group">
                                                        <label>{{ __('Longitude') . '*' }} </label>
                                                        <input type="text" class="form-control" name="longitude"
                                                            placeholder="{{ __('Enter Longitude') }}">
                                                        <p class="text-warning mb-0">
                                                            {{ __('The Longitude must be between -180 and 180. Ex:149.91553') }}
                                                        </p>
                                                    </div>
                                                </div>

                                                @if ($settings->google_map_api_key_status == 1)
                                                    <div class="col-lg-12">
                                                        <div class="form-group mb-0">
                                                            <a href="" class="btn btn-secondary btn-sm"
                                                                data-toggle="modal" data-target="#GoogleMapModal">
                                                                <i class="fas fa-eye"></i>
                                                                {{ __('Show Map') }}
                                                            </a>
                                                        </div>
                                                    </div>
                                                @endif
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-4">
                                        <div class="form-group">
                                            <label>{{ __('Category') . '*' }} </label>
                                            <select name="category_id"
                                                data-code="{{ $language->code }}"
                                                class="form-control js-example-basic-single2">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="form-group">
                                            <label>{{ __('Country') . '*' }}</label>
                                            <select name="country_id" class="form-control" id="listing_country_id">
                                                <option value="">{{ __('Select a Country') }}</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 d-none" id="listing_state_wrapper">
                                        <div class="form-group">
                                            <label>{{ __('State') . '*' }}</label>
                                            <select name="state_id" class="form-control" id="listing_state_id">
                                                <option value="">{{ __('Select a State') }}</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 d-none" id="listing_city_wrapper">
                                        <div class="form-group">
                                            <label>{{ __('City') . '*' }}</label>
                                            <select name="city_id" class="form-control" id="listing_city_id">
                                                <option value="">{{ __('Select a City') }}</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <div class="d-flex justify-content-between align-items-center flex-wrap mb-2">
                                                <label class="mb-0">{{ __('Title') . '*' }}</label>
                                                <button type="button"
                                                    class="btn btn-sm btn-primary listing-ai-field-btn"
                                                    data-field="title" data-lang="{{ $language->code }}"
                                                    data-title="{{ __('Title') }}">
                                                    <i class="fas fa-magic"></i> {{ __('Generate') }}
                                                </button>
                                            </div>
                                            <input type="text" class="form-control"
                                                name="{{ $language->code }}_title"
                                                placeholder="{{ __('Enter Title') }}">
                                        </div>
                                    </div>

                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <label>{{ __('Address displayed in the listing') . '*' }}</label>
                                             <input type="text" class="form-control"
                                                 value="{{ old($language->code . '_address') }}"
                                                 name="{{ $language->code }}_address"
                                                 placeholder="{{ __('Enter Address') }}">
                                            @if ($language->is_default == 1 && $settings->google_map_api_key_status == 1)
                                                <a href=""
                                                    class="btn btn-secondary mt-2 btn-sm"
                                                    data-toggle="modal" data-target="#GoogleMapModal">
                                                    <i class="fas fa-eye"></i> {{ __('Show Map') }}
                                                </a>
                                            @endif
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <div class="d-flex justify-content-between align-items-center flex-wrap mb-2">
                                                <label class="mb-0">{{ __('Description') . '*' }}</label>
                                                <button type="button"
                                                    class="btn btn-sm btn-primary listing-ai-field-btn"
                                                    data-field="description"
                                                    data-lang="{{ $language->code }}"
                                                    data-title="{{ __('Description') }}">
                                                    <i class="fas fa-magic"></i> {{ __('Generate') }}
                                                </button>
                                            </div>
                                            <textarea id="{{ $language->code }}_description" class="form-control summernote"
                                                name="{{ $language->code }}_description" data-height="300"></textarea>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <div class="d-flex justify-content-between align-items-center flex-wrap mb-2">
                                                <label class="mb-0">{{ __('Meta Keywords') }}</label>
                                                <button type="button"
                                                    class="btn btn-sm btn-primary listing-ai-field-btn"
                                                    data-field="meta_keywords"
                                                    data-lang="{{ $language->code }}"
                                                    data-title="{{ __('Meta Keywords') }}">
                                                    <i class="fas fa-magic"></i> {{ __('Generate') }}
                                                </button>
                                            </div>
                                            <input class="form-control"
                                                name="{{ $language->code }}_meta_keyword"
                                                placeholder="{{ __('Enter Meta Keywords') }}"
                                                data-role="tagsinput">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <div class="d-flex justify-content-between align-items-center flex-wrap mb-2">
                                                <label class="mb-0">{{ __('Summary') }}</label>
                                                <button type="button"
                                                    class="btn btn-sm btn-primary listing-ai-field-btn"
                                                    data-field="summary"
                                                    data-lang="{{ $language->code }}"
                                                    data-title="{{ __('Summary') }}">
                                                    <i class="fas fa-magic"></i> {{ __('Generate') }}
                                                </button>
                                            </div>
                                            <textarea class="form-control" name="{{ $language->code }}_summary" data-height="300"></textarea>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="form-group">
                                            <div class="d-flex justify-content-between align-items-center flex-wrap mb-2">
                                                <label class="mb-0">{{ __('Meta Description') }}</label>
                                                <button type="button"
                                                    class="btn btn-sm btn-primary listing-ai-field-btn"
                                                    data-field="meta_description"
                                                    data-lang="{{ $language->code }}"
                                                    data-title="{{ __('Meta Description') }}">
                                                    <i class="fas fa-magic"></i> {{ __('Generate') }}
                                                </button>
                                            </div>
                                            <textarea class="form-control" name="{{ $language->code }}_meta_description" rows="5"
                                                placeholder="{{ __('Enter Meta Description') }}"></textarea>
                                        </div>
                                    </div>
                                </div>

                                @if (is_array($permissions) && in_array('Amenities', $permissions))
                                    <div class="card border mb-3 mt-3">
                                        <div class="card-header bg-light">
                                            <h5 class="mb-0">{{ __('Select Amenities') . '*' }}</h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    @php
                                                        $aminities = App\Models\Aminite::with('contents')->get();
                                                    @endphp
                                                    <div class="dropdown-content" id="checkboxes">
                                                        @foreach ($aminities as $amenity)
                                                            <input type="checkbox"
                                                                name="aminities[]"
                                                                value="{{ $amenity->id }}"
                                                                id="{{ $amenity->id }}">
                                                            <label class="amenities-label mr-2"
                                                                for="{{ $amenity->id }}">{{ $amenity->getTitle($language->id) }}</label>
                                                        @endforeach
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                @endif

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
    @if ($settings->google_map_api_key_status == 1)
        <script src="{{ asset('assets/admin/js/map-init2.js') }}"></script>
        <script
            src="https://maps.googleapis.com/maps/api/js?key={{ $settings->google_map_api_key }}&libraries=places&callback=initMap"
            async defer></script>
    @endif
    <script>
        'use strict';
        const countryUrl = "{{ route('vendor.get_country') }}";
        const cityUrl = "{{ route('vendor.get_city') }}";
        const stateUrl = "{{ route('vendor.get_state') }}";
        const getHomeCatUrl = "{{ route('vendor.get_categories') }}";

        var storeUrl = "{{ route('vendor.listing.imagesstore') }}";
        var removeUrl = "{{ route('vendor.listing.imagermv') }}";
        var getStateUrl = "{{ route('vendor.listing_management.get-state') }}";
        var getCityUrl = "{{ route('vendor.listing_management.get-city') }}";
        var galleryImages = {{ $numberoffImages }};
        var languages = {!! json_encode($langs) !!};
        var listingAiLanguages = {!! $langs->map(function ($lang) {
            return ['code' => $lang->code];
        })->values()->toJson() !!};
        const baseURL = "{{ url('/') }}";
        var defaultLangCode = '{{ $language->code }}';
    </script>

    <script>
        'use strict';
        $(document).ready(function () {
            $('#listing_country_id').select2({
                placeholder: '{{ __("Select a Country") }}',
                allowClear: true,
                minimumInputLength: 0,
                ajax: {
                    url: countryUrl,
                    dataType: 'json',
                    delay: 250,
                    data: function (params) {
                        return {
                            search: params.term || '',
                            page: params.page || 1,
                            lang: defaultLangCode
                        };
                    },
                    processResults: function (data, params) {
                        return {
                            results: data.results.map(function (item) {
                                return { text: item.name, id: item.id };
                            }),
                            pagination: { more: data.more }
                        };
                    },
                    cache: true
                }
            });

            $('#listing_country_id').on('change', function () {
                var countryId = $(this).val();
                $('#listing_state_id').empty().append('<option value="">{{ __("Select a State") }}</option>');
                $('#listing_city_id').empty().append('<option value="">{{ __("Select a City") }}</option>');
                $('#listing_city_wrapper').addClass('d-none');

                if (countryId) {
                    $.ajax({
                        url: getStateUrl,
                        type: 'POST',
                        data: { id: countryId, lang: defaultLangCode },
                        success: function (response) {
                            if (response.states && response.states.length > 0) {
                                $('#listing_state_wrapper').removeClass('d-none');
                                $.each(response.states, function (i, state) {
                                    $('#listing_state_id').append('<option value="' + state.id + '">' + state.name + '</option>');
                                });
                            } else {
                                $('#listing_state_wrapper').addClass('d-none');
                                if (response.cities && response.cities.length > 0) {
                                    $('#listing_city_wrapper').removeClass('d-none');
                                    $.each(response.cities, function (i, city) {
                                        $('#listing_city_id').append('<option value="' + city.id + '">' + city.name + '</option>');
                                    });
                                }
                            }
                        }
                    });
                } else {
                    $('#listing_state_wrapper').addClass('d-none');
                }
            });

            $('#listing_state_id').on('change', function () {
                var stateId = $(this).val();
                $('#listing_city_id').empty().append('<option value="">{{ __("Select a City") }}</option>');

                if (stateId) {
                    $.ajax({
                        url: getCityUrl,
                        type: 'POST',
                        data: { id: stateId, lang: defaultLangCode },
                        success: function (response) {
                            $('#listing_city_wrapper').removeClass('d-none');
                            $.each(response, function (i, city) {
                                $('#listing_city_id').append('<option value="' + city.id + '">' + city.name + '</option>');
                            });
                        }
                    });
                } else {
                    $('#listing_city_wrapper').addClass('d-none');
                }
            });
        });
    </script>

    <script src="{{ asset('assets/admin/js/ai-image-modal.js') }}"></script>
    <script src="{{ asset('assets/admin/js/ai-slider-dropzone.js') }}"></script>
    <script src="{{ asset('assets/admin/js/ai-form-generator.js') }}"></script>

    <script>
        "use strict";
        AiFormGenerator.init({
            openBtn: '.listing-ai-field-btn',
            modalId: '#aiItemSeoModal',
            modalTitleEl: '#aiItemSeoModalTitle',

            confirmBtn: '#aiItemSeoConfirmBtn',
            endpoint: "{{ route('vendor.ai.generate.content') }}",

            prompt: {
                from: '#ai_item_prompt'
            },

            hiddenField: '#ai_item_field',
            hiddenLang: '#ai_item_lang',

            extra: {
                mode: () => 'item_seo'
            },
            outputs: function () {
                const outputs = {};

                (listingAiLanguages || []).forEach(function (language) {
                    const code = language.code;
                    outputs[code + '_title'] = '[name="' + code + '_title"]';
                    outputs[code + '_summary'] = '[name="' + code + '_summary"]';
                    outputs[code + '_description'] = '[name="' + code + '_description"]';
                    outputs[code + '_meta_keywords'] = '[name="' + code + '_meta_keyword"]';
                    outputs[code + '_meta_description'] = '[name="' + code + '_meta_description"]';
                });

                return outputs;
            }
        });
    </script>

    <script type="text/javascript" src="{{ asset('assets/admin/js/admin-partial.js') }}"></script>
    <script type="text/javascript" src="{{ asset('assets/admin/js/admin-listing.js') }}"></script>
    <script type="text/javascript" src="{{ asset('assets/admin/js/admin-dropzone.js') }}"></script>
@endsection
