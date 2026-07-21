@extends('vendors.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Edit Listing') }}</h4>
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
        <a href="#">{{ __('Edit Listing') }}</a>
      </li>
    </ul>
  </div>

  @php
    $vendorId = Auth::guard('vendor')->user()->id;

    if ($vendorId) {
        $current_package = App\Http\Helpers\VendorPermissionHelper::packagePermission($vendorId);

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
      <div class="card">
        <div class="card-header">
          <div class="card-title d-inline-block">{{ __('Edit Listing') }}</div>
          <a class="btn btn-info btn-sm float-right d-inline-block"
            href="{{ route('vendor.listing_management.listings', ['language' => $defaultLang->code]) }}">
            <span class="btn-label">
              <i class="fas fa-backward"></i>
            </span>
            {{ __('Back') }}
          </a>
          <button type="button" class="btn btn-primary btn-sm float-right mr-1 listing-ai-field-btn" id="aiGenerateItemSeoBtn"
            data-field="" data-lang=""
            data-title="{{ __('AI Generate Listing Content') }}">
            <i class="fas fa-magic"></i> {{ __('Generate All Content') }}
          </button>
          @php
            $dContent = App\Models\Listing\ListingContent::where('listing_id', $listing->id)
                ->where('language_id', $defaultLang->id)
                ->first();
            $slug = !empty($dContent) ? $dContent->slug : '';
          @endphp
          @if ($dContent && $slug)
            <a class="btn btn-success btn-sm float-right mr-1 d-inline-block"
              href="{{ route('frontend.listing.details.localized_legacy', ['lang' => $defaultLang->code, 'slug' => $slug, 'id' => $listing->id]) }}" target="_blank">
              <span class="btn-label">
                <i class="fas fa-eye"></i>
              </span>
              {{ __('Preview') }}
            </a>
          @endif
        </div>

        <div class="card-body">
          <div class="row">
            <div class="col-lg-10 offset-lg-1">

              <div class="alert alert-danger pb-1 dis-none" id="listingErrors">
                <ul></ul>
              </div>
              <div class="col-lg-12">
                <label for="" class="mb-2"><strong>{{ __('Gallery Images') . '*' }}</strong></label>
                <div class="row">
                  <div class="col-12">
                    <table class="table table-striped" id="imgtable">
                      @foreach ($listing->galleries as $item)
                        <tr class="trdb table-row" id="trdb{{ $item->id }}">
                          <td>
                            <div class="">
                                                              <img class="thumb-preview wf-150"
                                                                  src="{{ asset('assets/img/listing-gallery/' . $item->image) }}" alt="{{ __('Gallery Images') }}">
                            </div>
                          </td>
                          <td>
                            <i class="fa fa-times rmvbtndb" data-indb="{{ $item->id }}"></i>
                          </td>
                        </tr>
                      @endforeach
                    </table>
                  </div>
                </div>
                <form action="{{ route('vendor.listing.imagesstore') }}" id="my-dropzone" enctype="multipart/formdata"
                  class="dropzone create">
                  @csrf
                  <div class="fallback">
                    <input name="file" type="file" multiple />
                  </div>
                  <input type="hidden" value="{{ $listing->id }}" name="listing_id">
                </form>
                <button type="button" class="btn btn-sm btn-primary mt-3" data-ai-slider-open
                  data-dropzone="#my-dropzone"
                  data-hidden-wrap="#sliders"
                  data-hidden-input-name="slider_images[]"
                  data-endpoint="{{ route('vendor.ai.generate.slider.images') }}"
                  data-upload-endpoint="{{ route('vendor.listing.imagesstore') }}"
                  data-remove-endpoint="{{ route('vendor.listing.imagermv') }}"
                  data-remove-key="fileid"
                  data-max-count="{{ $current_package->number_of_images_per_listing }}"
                  data-count-default="3"
                  data-size="custom_600_400">
                  <i class="fas fa-magic"></i> {{ __('Generate Gallery Images') }}
                </button>
                <p class="em text-danger mb-0" id="errslider_images"></p>
                <p class="text-warning">
                  {{ __('You can upload maximum') . ' ' . $current_package->number_of_images_per_listing . ' ' . __('images under one listing') }}
                </p>
              </div>

              <form id="listingForm" action="{{ route('vendor.listing_management.update_listing', $listing->id) }}"
                method="POST" enctype="multipart/form-data">
                @csrf
                <input type="hidden" name="listing_id" value="{{ $listing->id }}">
                <div class="row">
                  <div class="col-lg-3">
                    <div class="form-group">
                      <label for="">{{ __('Featured Image') . '*' }}</label>
                      <br>
                      <div class="thumb-preview">
                        <img
                          src="{{ $listing->feature_image ? asset('assets/img/listing/' . $listing->feature_image) : asset('assets/admin/img/noimage.jpg') }}"
                          alt="..." class="uploaded-img" id="listingFeaturePreview">
                      </div>
                      <input type="hidden" name="ai_feature_image" id="listingAiFeatureImage">
                      <div class="mt-3">
                        <div role="button" class="btn btn-primary btn-sm upload-btn">
                          {{ __('Choose Image') }}
                          <input type="file" class="img-input" name="thumbnail">
                        </div>
                        <button type="button" class="btn btn-primary btn-sm ml-2"
                          data-ai-image-open
                          data-endpoint="{{ route('vendor.ai.generate.category.image') }}"
                          data-target="#listingFeaturePreview"
                          data-hidden="#listingAiFeatureImage"
                          data-file-input="input[name='thumbnail']"
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
                      <div class="form-group position-relative">
                        <label for="">{{ __('Video Image') }}</label>
                        <br>
                        <div class="thumb-preview position-relative">
                          @if ($listing->video_background_image)
                            <button class="videoimagermvbtndb btn btn-remove" type="button"
                              data-indb="{{ $listing->id }}">
                              <i class="fal fa-times"></i>
                            </button>
                          @endif
                          @php
                            $display = 'none';
                          @endphp
                          <img
                            src="{{ $listing->video_background_image ? asset('assets/img/listing/video/' . $listing->video_background_image) : asset('assets/img/noimage.jpg') }}"
                            alt="..." class="uploaded-img2" id="listingVideoPreview">
                          <input type="hidden" name="ai_video_background_image" id="listingAiVideoImage">
                          <button class="remove-img2 btn btn-remove" type="button" style="display:{{ $display }};">
                            <i class="fal fa-times"></i>
                          </button>
                        </div>
                        <div class="mt-3">
                          <div role="button" class="btn btn-primary btn-sm upload-btn">
                            {{ __('Choose Image') }}
                            <input type="file" class="video-img-input" name="video_background_image">
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
                        <input type="text" class="form-control" value="{{ $listing->video_url }}" name="video_url"
                          placeholder="{{ __('Enter Your video url') }}">
                      </div>
                    </div>
                  @endif

                  <div class="col-lg-3">
                    <div class="form-group">
                      <label>{{ __('Mail') . '*' }} </label>
                      <input type="text" class="form-control" value="{{ $listing->mail }}" name="mail"
                        placeholder="{{ __('Enter Contact Mail') }}">
                    </div>
                  </div>

                  <div class="col-lg-3">
                    <div class="form-group">
                      <label>{{ __('Phone') . '*' }} </label>
                      <input type="text" class="form-control" value="{{ $listing->phone }}" name="phone"
                        placeholder="{{ __('Enter Phone Number') }}">
                    </div>
                  </div>
                  <div class="col-lg-3">
                    <div class="form-group">
                      <label>{{ __('Hide/Show') }}</label>
                      <select name="visibility" id="visibility" class="form-control">
                        <option @if ($listing->visibility == 1) selected @endif value="1">{{ __('Show') }}
                        </option>
                        <option @if ($listing->visibility == 0) selected @endif value="0">{{ __('Hide') }}
                        </option>
                      </select>
                    </div>
                  </div>
                  @php
                    $approve = App\Models\BasicSettings\Basic::select('admin_approve_status')->first();
                    $status = $approve->admin_approve_status;
                  @endphp
                  <input type="hidden" value="{{ $status }}"name="status" id="status">

                  <div class="col-lg-3">
                    <div class="form-group">
                      <label>{{ __('Min Price') }}({{ $settings->base_currency_text }})</label>
                      <input type="text" class="form-control" name="min_price" value="{{ $listing->min_price }}"
                        placeholder="{{ __('Enter Min Price') }}">
                    </div>
                  </div>
                  <div class="col-lg-3">
                    <div class="form-group">
                      <label>{{ __('Max Price') }}({{ $settings->base_currency_text }})</label>
                      <input type="text" class="form-control" name="max_price" value="{{ $listing->max_price }}"
                        placeholder="{{ __('Enter Max Price') }}">
                    </div>
                  </div>

                  <input type="hidden" name="vendor_id" id="vendor_id"
                    value="{{ Auth::guard('vendor')->user()->id }}">
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
                            <label>{{ __('Search Address') }}</label>
                            <input type="text" class="form-control" id="search-address"
                              placeholder="{{ __('Search Address') }}" value="{{ $listingAddress }}">
                          </div>
                        </div>

                        <div class="col-lg-6">
                          <div class="form-group">
                            <label>{{ __('Latitude') . '*' }} </label>
                            <input type="text" class="form-control" name="latitude" id="latitude"
                              placeholder="{{ __('Enter Latitude') }}" value="{{ $listing->latitude }}">
                            <p class="text-warning mb-0">
                              {{ __('The Latitude must be between -90 and 90. Ex:49.43453') }}</p>
                          </div>
                        </div>

                        <div class="col-lg-6">
                          <div class="form-group">
                            <label>{{ __('Longitude') . '*' }} </label>
                            <input type="text" class="form-control" name="longitude" id="longitude"
                              placeholder="{{ __('Enter Longitude') }}" value="{{ $listing->longitude }}">
                            <p class="text-warning mb-0">
                              {{ __('The Longitude must be between -180 and 180. Ex:149.91553') }}
                            </p>
                          </div>
                        </div>

                        @if ($settings->google_map_api_key_status == 1)
                          <div class="col-lg-12">
                            <div class="form-group mb-0">
                              <a href="" class="btn btn-secondary btn-sm" data-toggle="modal" data-target="#GoogleMapModal">
                                <i class="fas fa-eye"></i> {{ __('Show Map') }}
                              </a>
                            </div>
                          </div>
                        @endif
                      </div>
                    </div>
                  </div>
                </div>

                @php
                  $category = App\Models\ListingCategory::where([
                      ['id', $listingContent->category_id ?? 0],
                      ['status', 1],
                  ])->first();
                @endphp

                <input type="hidden" id="current_country_id" value="{{ $listingContent->country_id ?? '' }}">
                <input type="hidden" id="current_state_id" value="{{ $listingContent->state_id ?? '' }}">
                <input type="hidden" id="current_city_id" value="{{ $listingContent->city_id ?? '' }}">

                <div class="row">
                  <div class="col-lg-4">
                    <div class="form-group">
                      <label>{{ __('Category') . '*' }} </label>
                      <select name="category_id"
                        data-code="{{ $language->code }}"
                        class="form-control js-example-basic-single2">
                        <option selected value="{{ $listingContent->category_id ?? '' }}">{{ $category ? $category->getName($language->id) : '' }}</option>
                      </select>
                    </div>
                  </div>
                  <div class="col-lg-4">
                    <div class="form-group">
                      <label>{{ __('Country') . '*' }}</label>
                      <select name="country_id" class="form-control" id="listing_country_id">
                        @php
                          $currentCountry = $listingContent->country_id ? App\Models\Location\CountryContent::where('country_id', $listingContent->country_id)->where('language_id', $language->id)->select('name')->first() : null;
                        @endphp
                        <option value="">{{ __('Select a Country') }}</option>
                        @if ($currentCountry)
                          <option value="{{ $listingContent->country_id }}" selected>{{ $currentCountry->name }}</option>
                        @endif
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
                                placeholder="{{ __('Enter Title') }}"
                                value="{{ $listingContent ? $listingContent->title : '' }}">
                        </div>
                    </div>

                    <div class="col-lg-12">
                        <div class="form-group">
                            <label>{{ __('Address') . '*' }}</label>
                            <input type="text" class="form-control"
                                name="{{ $language->code }}_address"
                                placeholder="{{ __('Enter Address') }}"
                                value="{{ $listingContent ? $listingContent->address : '' }}">
                            @if ($language->is_default == 1 && $settings->google_map_api_key_status == 1)
                                <a href="" class="btn btn-secondary mt-2 btn-sm" data-toggle="modal"
                                    data-target="#GoogleMapModal">
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
                                    data-field="description" data-lang="{{ $language->code }}"
                                    data-title="{{ __('Description') }}">
                                    <i class="fas fa-magic"></i> {{ __('Generate') }}
                                </button>
                            </div>
                            <textarea id="{{ $language->code }}_description" class="form-control summernote"
                                name="{{ $language->code }}_description" data-height="300">{{ @$listingContent->description }}</textarea>
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
                                    data-field="meta_keywords" data-lang="{{ $language->code }}"
                                    data-title="{{ __('Meta Keywords') }}">
                                    <i class="fas fa-magic"></i> {{ __('Generate') }}
                                </button>
                            </div>
                            <input class="form-control"
                                name="{{ $language->code }}_meta_keyword"
                                placeholder="{{ __('Enter Meta Keywords') }}"
                                data-role="tagsinput"
                                value="{{ $listingContent ? @$listingContent->meta_keyword : '' }}">
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
                                    data-field="summary" data-lang="{{ $language->code }}"
                                    data-title="{{ __('Summary') }}">
                                    <i class="fas fa-magic"></i> {{ __('Generate') }}
                                </button>
                            </div>
                            <textarea class="form-control" name="{{ $language->code }}_summary" data-height="300">{{ @$listingContent->summary }}</textarea>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="form-group">
                            <div class="d-flex justify-content-between align-items-center flex-wrap mb-2">
                                <label class="mb-0">{{ __('Meta Description') }}</label>
                                <button type="button"
                                    class="btn btn-sm btn-primary listing-ai-field-btn"
                                    data-field="meta_description" data-lang="{{ $language->code }}"
                                    data-title="{{ __('Meta Description') }}">
                                    <i class="fas fa-magic"></i> {{ __('Generate') }}
                                </button>
                            </div>
                            <textarea class="form-control" name="{{ $language->code }}_meta_description" rows="5"
                                placeholder="{{ __('Enter Meta Description') }}">{{ $listingContent ? @$listingContent->meta_description : '' }}</textarea>
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
                                        $hasaminitie = $listingContent
                                            ? json_decode($listingContent->aminities)
                                            : [];
                                    @endphp
                                    <div class="dropdown-content" id="checkboxes">
                                        @foreach ($aminities as $amenity)
                                            <input type="checkbox"
                                                name="aminities[]"
                                                value="{{ $amenity->id }}"
                                                id="{{ $amenity->id }}"
                                                {{ $hasaminitie && in_array($amenity->id, $hasaminitie) ? 'checked' : '' }}>
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
              <button type="submit" form="listingForm" class="btn btn-primary">
                {{ __('Update') }}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  {{-- Google map modal --}}
  <div class="modal fade" id="GoogleMapModal" tabindex="-1" role="dialog"
    aria-labelledby="GoogleMapModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="GoogleMapModalLongTitle">{{ __('Google Map') }}</h5>
          <div>
            <button type="button" class="btn btn-secondary btn-xs" data-dismiss="modal">{{ __('Choose') }}</button>
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
    <script src="{{ asset('assets/admin/js/edit-map-init.js') }}"></script>
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
    var rmvdbUrl = "{{ route('vendor.listing.imgdbrmv') }}";
    var videoId = {{ $listing->id }};
    var videormvdbUrl = "{{ route('vendor.listing_management.video_image.delete', ['id' => ':videoId']) }}";
    videormvdbUrl = videormvdbUrl.replace(':videoId', videoId);
    var getStateUrl = "{{ route('vendor.listing_management.get-state') }}";
    var getCityUrl = "{{ route('vendor.listing_management.get-city') }}";
    var featureRmvUrl = "{{ route('vendor.listing_management.feature_delete') }}"
    var updateAminitie = "{{ route('vendor.listing_management.update_aminitie') }}"
    var galleryImages = {{ $current_package->number_of_images_per_listing - count($listing->galleries) }};
    var languages = {!! json_encode($langs) !!};
    var listingAiLanguages = {!! $langs->map(function ($lang) {
        return ['code' => $lang->code];
    })->values()->toJson() !!};
    const baseURL = "{{ url('/') }}";
    var address = "{{ $listingAddress }}";
    var defaultLangCode = '{{ $language->code }}';
    var categoryPlaceholder = '{{ __("Select Category") }}';
  </script>

  <script type="text/javascript" src="{{ asset('assets/admin/js/feature.js') }}"></script>
  <script type="text/javascript" src="{{ asset('assets/admin/js/admin-partial.js') }}"></script>
  <script type="text/javascript" src="{{ asset('assets/admin/js/admin-dropzone.js') }}"></script>
  <script>
    if (typeof Dropzone !== 'undefined' && Dropzone.options.myDropzone) {
      Dropzone.options.myDropzone.dictDefaultMessage = "{{ __('Drop files here to upload') }}";
    }
  </script>
  <script src="{{ asset('assets/admin/js/admin-listing.js') }}"></script>
  <script src="{{ asset('assets/admin/js/ai-image-modal.js') }}"></script>
  <script src="{{ asset('assets/admin/js/ai-slider-dropzone.js') }}"></script>
  <script src="{{ asset('assets/admin/js/ai-form-generator.js') }}"></script>

  <script>
    'use strict';
    function loadStates(countryId, selectedStateId, selectedCityId) {
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
                var selected = selectedStateId && state.id == selectedStateId;
                $('#listing_state_id').append('<option value="' + state.id + '" ' + (selected ? 'selected' : '') + '>' + state.name + '</option>');
              });
              if (selectedStateId) {
                $('#listing_state_id').val(selectedStateId);
                loadCities(selectedStateId, selectedCityId);
              }
            } else {
              $('#listing_state_wrapper').addClass('d-none');
              if (response.cities && response.cities.length > 0) {
                $('#listing_city_wrapper').removeClass('d-none');
                $.each(response.cities, function (i, city) {
                  var selected = selectedCityId && city.id == selectedCityId;
                  $('#listing_city_id').append('<option value="' + city.id + '" ' + (selected ? 'selected' : '') + '>' + city.name + '</option>');
                });
              }
            }
          }
        });
      } else {
        $('#listing_state_wrapper').addClass('d-none');
      }
    }

    function loadCities(stateId, selectedCityId) {
      $('#listing_city_id').empty().append('<option value="">{{ __("Select a City") }}</option>');

      if (stateId) {
        $.ajax({
          url: getCityUrl,
          type: 'POST',
          data: { id: stateId, lang: defaultLangCode },
          success: function (response) {
            $('#listing_city_wrapper').removeClass('d-none');
            $.each(response, function (i, city) {
              var selected = selectedCityId && city.id == selectedCityId;
              $('#listing_city_id').append('<option value="' + city.id + '" ' + (selected ? 'selected' : '') + '>' + city.name + '</option>');
            });
          }
        });
      } else {
        $('#listing_city_wrapper').addClass('d-none');
      }
    }

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

      var currentCountryId = $('#current_country_id').val();
      var currentStateId = $('#current_state_id').val();
      var currentCityId = $('#current_city_id').val();

      if (currentCountryId) {
        loadStates(currentCountryId, currentStateId, currentCityId);
      }

      $('#listing_country_id').on('change', function () {
        loadStates($(this).val(), null);
      });

      $('#listing_state_id').on('change', function () {
        loadCities($(this).val(), null);
      });
    });
  </script>

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
@endsection
