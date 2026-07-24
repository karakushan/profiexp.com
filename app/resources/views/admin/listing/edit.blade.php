@extends('admin.layout')

@section('content')
    <div class="page-header">
        <h4 class="page-title">{{ __('Edit Listing') }}</h4>
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
                <a href="#">{{ __('Edit Listing') }}</a>
            </li>
        </ul>
    </div>

    @php
        $vendor_id = $listing->vendor_id;
        if ($listing->vendor_id == 0) {
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
            $numberoffImages = 99999999;
        } else {
            $vendorId = $listing->vendor_id;
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
            <div class="card">
                <div class="card-header">
                    <div class="card-title d-inline-block">{{ __('Edit Listing') }}</div>
                    <a class="btn btn-info btn-sm float-right d-inline-block"
                        href="{{ route('admin.listing_management.listings', ['language' => $defaultLang->code]) }}">
                        <span class="btn-label">
                            <i class="fas fa-backward"></i>
                        </span>
                        {{ __('Back') }}
                    </a>
                    @php
                        $dContent = App\Models\Listing\ListingContent::where('listing_id', $listing->id)
                            ->where('language_id', $defaultLang->id)
                            ->first();
                        $slug = !empty($dContent) ? $dContent->slug : '';
                    @endphp
                    @if ($dContent)
                        <a class="btn btn-success btn-sm float-right mr-1 d-inline-block"
                            href="{{ route('frontend.listing.details', ['slug' => $slug, 'id' => $listing->id]) }}"
                            target="_blank">
                            <span class="btn-label">
                                <i class="fas fa-eye"></i>
                            </span>
                            {{ __('Preview') }}
                        </a>
                    @endif

                    @if ($vendor_id != 0)
                        <button type="button" class="btn btn-primary btn-sm btn-sm btn-round float-right" id="aa"
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

                </div>

                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-10 offset-lg-1">
                            <div class="alert alert-danger pb-1 dis-none" id="listingErrors">
                                <ul></ul>
                            </div>
                            <div class="col-lg-12">
                                <label for=""
                                    class="mb-2"><strong>{{ __('Gallery Images') . '*' }}</strong></label>
                                <div class="row">
                                    <div class="col-12">
                                        <table class="table table-striped" id="imgtable">
                                            @foreach ($listing->galleries as $item)
                                                <tr class="trdb table-row" id="trdb{{ $item->id }}">
                                                    <td>
                                                        <div class="">
                                                            <img class="thumb-preview wf-150"
                                                                src="{{ asset('assets/img/listing-gallery/' . $item->image) }}"
                                                                alt="Ad Image">
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <i class="fa fa-times rmvbtndb"
                                                            data-indb="{{ $item->id }}"></i>
                                                    </td>
                                                </tr>
                                            @endforeach
                                        </table>
                                    </div>
                                </div>
                                <form action="{{ route('admin.listing.imagesstore') }}" id="my-dropzone"
                                    enctype="multipart/formdata" class="dropzone create">
                                    @csrf
                                    <div class="fallback">
                                        <input name="file" type="file" multiple />
                                    </div>
                                    <input type="hidden" value="{{ $listing->id }}" name="listing_id">
                                </form>
                                <p class="em text-danger mb-0" id="errslider_images"></p>
                            </div>

                            <form id="listingForm"
                                action="{{ route('admin.listing_management.update_listing', $listing->id) }}"
                                method="POST" enctype="multipart/form-data">
                                @csrf
                                <input type="hidden" name="listing_id" value="{{ $listing->id }}">
                                <div class="row">
                                    <div class="col-lg-3">
                                        <div class="form-group">
                                            <label for="">{{ __('Featured Image') . '*' }}</label>
                                            <br>
                                            <div class="thumb-preview">
                                                <img src="{{ $listing->feature_image ? asset('assets/img/listing/' . $listing->feature_image) : asset('assets/admin/img/noimage.jpg') }}"
                                                    alt="..." class="uploaded-img">
                                            </div>
                                            <div class="mt-3">
                                                <div role="button" class="btn btn-primary btn-sm upload-btn">
                                                    {{ __('Choose Image') }}
                                                    <input type="file" class="img-input" name="thumbnail">
                                                </div>
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
                                                    <img src="{{ $listing->video_background_image ? asset('assets/img/listing/video/' . $listing->video_background_image) : asset('assets/img/noimage.jpg') }}"
                                                        alt="..." class="uploaded-img2">
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
                                                <label>{{ __('Video Link') }} *</label>
                                                <input type="text" class="form-control"
                                                    value="{{ $listing->video_url }}" name="video_url"
                                                    placeholder="{{ __('Enter Your video url') }}">
                                            </div>
                                        </div>
                                    @endif
                                    <div class="col-lg-3">
                                        <div class="form-group">
                                            <label>{{ __('Mail') . '*' }} </label>
                                            <input type="text" class="form-control" value="{{ $listing->mail }}"
                                                name="mail" placeholder="{{ __('Enter Contact Mail') }}">
                                        </div>
                                    </div>
                                    <div class="col-lg-3">
                                        <div class="form-group">
                                            <label>{{ __('Phone') . '*' }} </label>
                                            <input type="text" class="form-control" value="{{ $listing->phone }}"
                                                name="phone" placeholder="{{ __('Enter Phone Number') }}">
                                        </div>
                                    </div>

                                    <div class="col-lg-3">
                                        <div class="form-group">
                                            <label>{{ __('Approve Status') . '*' }} </label>
                                            <select name="status" id="status" class="form-control">
                                                <option @if ($listing->status == 1) selected @endif value="1">
                                                    {{ __('Approved') }}
                                                </option>
                                                <option @if ($listing->status == 0) selected @endif value="0">
                                                    {{ __('Pending') }}
                                                </option>
                                                <option @if ($listing->status == 2) selected @endif value="2">
                                                    {{ __('Rejected') }}
                                                </option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-lg-3">
                                        <div class="form-group">
                                            <label>{{ __('Hide/Show') }}</label>
                                            <select name="visibility" id="visibility" class="form-control">
                                                <option @if ($listing->visibility == 1) selected @endif value="1">
                                                    {{ __('Show') }}
                                                </option>
                                                <option @if ($listing->visibility == 0) selected @endif value="0">
                                                    {{ __('Hide') }}
                                                </option>
                                            </select>
                                        </div>
                                    </div>

                                    @php
                                        // The admin language comes from the admin locale view composer.
                                        // Keep it intact so location data is loaded in the selected language.
                                        $defaultListingContent = App\Models\Listing\ListingContent::where('listing_id', $listing->id)
                                            ->where('language_id', $defaultLang->id)
                                            ->first();
                                    @endphp

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
                                                            <input type="text" class="form-control"
                                                                id="search-address"
                                                                placeholder="{{ __('Enter address to search on map') }}">
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="form-group">
                                                            <label>{{ __('Latitude') . '*' }} </label>
                                                            <input type="text" class="form-control"
                                                                value="{{ $listing->latitude }}" name="latitude"
                                                                placeholder="{{ __('Enter Latitude') }}">
                                                            <p class="text-warning mb-0">
                                                                {{ __('The Latitude must be between -90 and 90. Ex:49.43453') }}</p>
                                                        </div>
                                                    </div>

                                                    <div class="col-lg-6">
                                                        <div class="form-group">
                                                            <label>{{ __('Longitude') . '*' }} </label>
                                                            <input type="text" class="form-control"
                                                                value="{{ $listing->longitude }}" name="longitude"
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
                                    <div class="col-lg-3">
                                        <div class="form-group">
                                            <label>{{ __('Min Price') }}({{ $settings->base_currency_text }})</label>
                                            <input type="text" class="form-control" name="min_price"
                                                value="{{ $listing->min_price }}"
                                                placeholder="{{ __('Enter Min Price') }}">
                                        </div>
                                    </div>

                                    <div class="col-lg-3">
                                        <div class="form-group">
                                            <label>{{ __('Max Price') }}({{ $settings->base_currency_text }})</label>
                                            <input type="text" class="form-control" name="max_price"
                                                value="{{ $listing->max_price }}"
                                                placeholder="{{ __('Enter Max Price') }}">
                                        </div>
                                    </div>

                                    <input type="hidden" name="vendor_id" id="vendor_id"
                                        value="{{ $listing->vendor_id }}">
                                </div>

                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group">
                                            <label>{{ __('Category') . '*' }} </label>
                                            <select name="category_id" class="form-control js-example-basic-single2" data-code="{{ $defaultLang->code }}">
                                                @php
                                                    $currentCategory = $defaultListingContent && $defaultListingContent->category_id
                                                        ? App\Models\ListingCategory::where('id', $defaultListingContent->category_id)->where('status', 1)->first()
                                                        : null;
                                                @endphp
                                                @if($currentCategory)
                                                    <option selected value="{{ $currentCategory->id }}">{{ $currentCategory->getName($defaultLang->id) }}</option>
                                                @endif
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mt-3">
                                    <div class="col-lg-4">
                                        <div class="form-group">
                                            <label>{{ __('Country') . '*' }}</label>
                                            <select name="country_id" class="form-control js-example-basic-single2-country" id="listing_country_id">
                                                <option value="">{{ __('Select a Country') }}</option>
                                                @if($defaultListingContent && $defaultListingContent->country_id)
                                                    @php
                                                        $selectedCountry = App\Models\Location\CountryContent::where('country_id', $defaultListingContent->country_id)
                                                            ->where('language_id', $defaultLang->id)
                                                            ->select('country_id as id', 'name')
                                                            ->first();
                                                    @endphp
                                                    @if($selectedCountry)
                                                        <option selected value="{{ $selectedCountry->id }}">{{ $selectedCountry->name }}</option>
                                                    @endif
                                                @endif
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 @if(!$defaultListingContent || !$defaultListingContent->country_id || App\Models\Location\State::where('country_id', $defaultListingContent->country_id)->forLanguage($defaultLang->id)->count() == 0) d-none @endif" id="listing_state_wrapper">
                                        <div class="form-group">
                                            <label>{{ __('State') . '*' }}</label>
                                            <select name="state_id" class="form-control" id="listing_state_id">
                                                <option value="">{{ __('Select a State') }}</option>
                                                @if($defaultListingContent && $defaultListingContent->state_id)
                                                    @php
                                                    $selectedState = App\Models\Location\StateContent::where('state_id', $defaultListingContent->state_id)
                                                        ->where('language_id', $defaultLang->id)
                                                        ->select('state_id as id', 'name')
                                                        ->first();
                                                    @endphp
                                                    @if($selectedState)
                                                        <option selected value="{{ $selectedState->id }}">{{ $selectedState->name }}</option>
                                                    @endif
                                                @endif
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 @if(!$defaultListingContent || !$defaultListingContent->city_id) d-none @endif" id="listing_city_wrapper">
                                        <div class="form-group">
                                            <label>{{ __('City') . '*' }}</label>
                                            <select name="city_id" class="form-control" id="listing_city_id">
                                                <option value="">{{ __('Select a City') }}</option>
                                                @if($defaultListingContent && $defaultListingContent->city_id)
                                                    @php
                                                    $selectedCity = App\Models\Location\CityContent::where('city_id', $defaultListingContent->city_id)
                                                        ->where('language_id', $defaultLang->id)
                                                        ->select('city_id as id', 'name')
                                                        ->first();
                                                    @endphp
                                                    @if($selectedCity)
                                                        <option selected value="{{ $selectedCity->id }}">{{ $selectedCity->name }}</option>
                                                    @endif
                                                @endif
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div id="accordion" class="mt-3">
                                    @foreach ($languages as $language)
                                        @php
                                            $listingContent = App\Models\Listing\ListingContent::where(
                                                'listing_id',
                                                $listing->id,
                                            )
                                            
                                                ->where('language_id', $language->id)
                                                ->first();
                                        @endphp
                                        <div class="version">
                                            <div class="version-header" id="heading{{ $language->id }}">
                                                <h5 class="mb-0">
                                                    <button type="button" class="btn btn-link" data-toggle="collapse"
                                                        data-target="#collapse{{ $language->id }}"
                                                        aria-expanded="{{ $language->id == $defaultLang->id ? 'true' : 'false' }}"
                                                        aria-controls="collapse{{ $language->id }}">
                                                        {{ $language->name . __(' Language') }}
                                                        {{ $language->is_default == 1 ? '(Default)' : '' }}
                                                    </button>
                                                </h5>
                                            </div>

                                            <div id="collapse{{ $language->id }}"
                                                class="collapse {{ $language->id == $defaultLang->id ? 'show' : '' }}"
                                                aria-labelledby="heading{{ $language->id }}" data-parent="#accordion">
                                                <div
                                                    class="version-body {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <div
                                                                class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                                                <label>{{ __('Title') . '*' }} </label>
                                                                <input type="text" class="form-control"
                                                                    name="{{ $language->code }}_title"
                                                                    placeholder="{{ __('Enter Title') }}"
                                                                    value="{{ $listingContent ? $listingContent->title : '' }}">
                                                            </div>
                                                        </div>




                                                        <div class="col-lg-12">
                                                            <div class="form-group">
                                                                <label>{{ __('Address displayed in the listing') . '*' }}</label>
                                                                <input type="text"
                                                                    name="{{ $language->code }}_address"
                                                                    class="form-control"
                                                                    placeholder="{{ __('Enter Address') }}"
                                                                    value="{{ $listingContent ? $listingContent->address : '' }}">
                                                            </div>
                                                        </div>



                                                    </div>
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <div
                                                                class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                                                <label>{{ __('Summary') }} </label>
                                                                <textarea class="form-control" name="{{ $language->code }}_summary" data-height="300">{{ @$listingContent->summary }}</textarea>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12">
                                                            <div
                                                                class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                                                <label>{{ __('Description') . '*' }} </label>
                                                                <textarea class="form-control summernote" id="{{ $language->code }}_description"
                                                                    name="{{ $language->code }}_description" data-height="300">{{ @$listingContent->description }}</textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <div
                                                                class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                                                <label>{{ __('Meta Keywords') }}</label>
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
                                                            <div
                                                                class="form-group {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                                                <label>{{ __('Meta Description') }}</label>
                                                                <textarea class="form-control" name="{{ $language->code }}_meta_description" rows="5"
                                                                    placeholder="{{ __('Enter Meta Description') }}">{{ $listingContent ? @$listingContent->meta_description : '' }}</textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
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
                                                        $hasaminitie = $listing->aminities ?? [];
                                                    @endphp
                                                    <div class="dropdown-content" id="checkboxes">
                                                        @foreach ($aminities as $aminitie)
                                                            <input type="checkbox"
                                                                name="aminities[]"
                                                                value="{{ $aminitie->id }}"
                                                                id="{{ $aminitie->id }}"
                                                                {{ $hasaminitie && in_array($aminitie->id, $hasaminitie) ? 'checked' : '' }}>
                                                            <label class="amenities-label mr-2"
                                                                for="{{ $aminitie->id }}">{{ $aminitie->getTitle($defaultLang->id) }}</label>
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
    @includeIf('admin.listing.check-limit')
    {{-- Google map modal --}}
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
        <script src="{{ asset('assets/admin/js/edit-map-init.js') }}"></script>
        <script
            src="https://maps.googleapis.com/maps/api/js?key={{ $settings->google_map_api_key }}&libraries=places&callback=initMap"
            async defer></script>
    @endif
    <script>
        "use strict";
        var address = "{{ $listingAddress }}";
        var videoId = {{ $listing->id }};
        var videormvdbUrl = "{{ route('admin.listing_management.video_image.delete', ['id' => ':videoId']) }}";
        videormvdbUrl = videormvdbUrl.replace(':videoId', videoId);
        var storeUrl = "{{ route('admin.listing.imagesstore') }}";
        var removeUrl = "{{ route('admin.listing.imagermv') }}";
        var rmvdbUrl = "{{ route('admin.listing.imgdbrmv') }}";
        var getStateUrl = "{{ route('admin.listing_management.get-state') }}";
        var getCityUrl = "{{ route('admin.listing_management.get-city') }}";
        var featureRmvUrl = "{{ route('admin.listing_management.feature_delete') }}"
        var socialRmvUrl = "{{ route('admin.listing_management.social_delete') }}"
        const baseURL = "{{ url('/') }}";
        var galleryImages = {{ $numberoffImages - count($listing->galleries) }};

        const countryUrl = "{{ route('admin.get_country') }}";
        const cityUrl = "{{ route('admin.get_city') }}";
        const stateUrl = "{{ route('admin.get_state') }}";
        const getHomeCatUrl = "{{ route('admin.get_categories') }}";
        var defaultLangCode = '{{ $defaultLang->code }}';
        var selectedCountryId = '{{ $defaultListingContent->country_id ?? '' }}';
        var selectedStateId = '{{ $defaultListingContent->state_id ?? '' }}';
        var selectedCityId = '{{ $defaultListingContent->city_id ?? '' }}';
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

            function loadStates(countryId) {
                if (!countryId) return;
                $.ajax({
                    url: getStateUrl,
                    type: 'POST',
                    data: { id: countryId, lang: defaultLangCode },
                    success: function (response) {
                        $('#listing_state_id').empty().append('<option value="">{{ __("Select a State") }}</option>');
                        $('#listing_city_id').empty().append('<option value="">{{ __("Select a City") }}</option>');
                        $('#listing_city_wrapper').addClass('d-none');

                        if (response.states && response.states.length > 0) {
                            $('#listing_state_wrapper').removeClass('d-none');
                            $.each(response.states, function (i, state) {
                                var selected = state.id == selectedStateId ? 'selected' : '';
                                $('#listing_state_id').append('<option value="' + state.id + '" ' + selected + '>' + state.name + '</option>');
                            });
                            if (selectedStateId) {
                                loadCities(selectedStateId);
                            }
                        } else {
                            $('#listing_state_wrapper').addClass('d-none');
                            if (response.cities && response.cities.length > 0) {
                                $('#listing_city_wrapper').removeClass('d-none');
                                $.each(response.cities, function (i, city) {
                                    var selected = city.id == selectedCityId ? 'selected' : '';
                                    $('#listing_city_id').append('<option value="' + city.id + '" ' + selected + '>' + city.name + '</option>');
                                });
                            }
                        }
                    }
                });
            }

            function loadCities(stateId) {
                if (!stateId) return;
                $.ajax({
                    url: getCityUrl,
                    type: 'POST',
                    data: { id: stateId, lang: defaultLangCode },
                    success: function (response) {
                        $('#listing_city_id').empty().append('<option value="">{{ __("Select a City") }}</option>');
                        if (response && response.length > 0) {
                            $('#listing_city_wrapper').removeClass('d-none');
                            $.each(response, function (i, city) {
                                var selected = city.id == selectedCityId ? 'selected' : '';
                                $('#listing_city_id').append('<option value="' + city.id + '" ' + selected + '>' + city.name + '</option>');
                            });
                        }
                    }
                });
            }

            if (selectedCountryId) {
                loadStates(selectedCountryId);
            }

            $('#listing_country_id').on('change', function () {
                selectedStateId = '';
                selectedCityId = '';
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

    <script type="text/javascript" src="{{ asset('assets/admin/js/admin-partial.js') }}"></script>
    <script type="text/javascript" src="{{ asset('assets/admin/js/admin-dropzone.js') }}"></script>
    <script src="{{ asset('assets/admin/js/admin-listing.js') }}"></script>
@endsection
