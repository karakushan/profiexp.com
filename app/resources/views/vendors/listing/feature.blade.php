@extends('vendors.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Features') }}</h4>
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
        <a
          href="{{ route('vendor.listing_management.listings', ['language' => $defaultLang->code]) }}">{{ __('Manage Listings') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      @php
        $dContent = App\Models\Listing\ListingContent::where('listing_id', $listing_id)
            ->where('language_id', $defaultLang->id)
            ->first();
        $title = !empty($dContent) ? $dContent->title : '';
      @endphp
      <li class="nav-item">
        <a href="#">
          @if (!empty($title))
            {{ strlen(@$title) > 20 ? mb_substr(@$title, 0, 20, 'utf-8') . '...' : @$title }}
          @endif
        </a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Features') }}</a>
      </li>
    </ul>
  </div>

  @php
    $vendorId = Auth::guard('vendor')->user()->id;

    if ($vendorId) {
        $current_package = App\Http\Helpers\VendorPermissionHelper::packagePermission($vendorId);

        if (!empty($current_package) && !empty($current_package->features)) {
            $permissions = json_decode($current_package->features, true);
            $additionalFeatureLimit = packageTotalAdditionalSpecification($vendorId) - $totalFeature;
        } else {
            $permissions = null;
            $additionalFeatureLimit = 0;
        }
    } else {
        $permissions = null;
        $additionalFeatureLimit = 0;
    }
  @endphp

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <div class="card-title d-inline-block">{{ __('Features') }}</div>
          <a class="btn btn-info btn-sm float-right d-inline-block"
            href="{{ route('vendor.listing_management.listings', ['language' => $defaultLang->code]) }}">
            <span class="btn-label">
              <i class="fas fa-backward"></i>
            </span>
            {{ __('Back') }}
          </a>
          @php
            $dContent = App\Models\Listing\ListingContent::where('listing_id', $listing_id)
                ->where('language_id', $defaultLang->id)
                ->first();
            $slug = !empty($dContent) ? $dContent->slug : '';
          @endphp
          @if ($dContent)
            <a class="btn btn-success btn-sm float-right mr-1 d-inline-block"
              href="{{ route('frontend.listing.details', ['slug' => $slug, 'id' => $listing_id]) }}" target="_blank">
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
                <button type="button" class="close" data-dismiss="alert">×</button>
                <ul></ul>
              </div>

              <form id="listingForm"
                action="{{ route('vendor.listing_management.update_additional_specification', $listing_id) }}"
                method="POST" enctype="multipart/form-data">
                @csrf
                <input type="hidden" name="listing_id" value="{{ $listing_id }}">

               @if (is_array($permissions) && in_array('Feature', $permissions))
                  <div class="row">
                    <div class="col-lg-12">
                      <h4>{{ __('Features') }}</h4>
                      <div class="js-repeater">
                        <div class="mb-3">
                          <button class="btn btn-primary js-repeater-add"
                            type="button">+{{ __('Add Feature') }}</button>
                        </div>
                        <div id="js-repeater-container">
                          @foreach ($features as $feature)
                            <div class="js-repeater-item p-3 pb-0" data-item="{{ $feature->indx }}">
                              <div class="row align-items-end gutters-2">
                                @foreach ($languages as $language)
                                  @php
                                    $feature_content = App\Models\Listing\ListingFeatureContent::where([
                                        ['language_id', $language->id],
                                        ['listing_feature_id', $feature->id],
                                    ])->first();
                                  @endphp

                                  <div class="col-sm-4 col-lg-3 {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                    <label for="form" class="form-label mb-1">{{ __('Label') }}
                                      (In {{ $language->name }})
                                    </label>
                                    <div class="mb-2">
                                      <input class="form-control" required
                                        value="{{ $feature_content->feature_heading ?? '' }}" type="text"
                                        placeholder="" name="{{ $language->code }}_feature_heading[]">
                                    </div>
                                  </div>
                                @endforeach

                                <a href="javascript:void(0)" data-feature="{{ $feature->id }}"
                                  class="btn btn-danger btn-sm js-repeater-remove mb-2 mr-2 deleteFeature">
                                  X</a>
                                <button class="btn btn-success btn-sm js-repeater-child-add mb-2" type="button"
                                  data-it="{{ $feature->indx }}">{{ __('Add Option') }}
                                </button>

                                <div class="repeater-child-list col-12" id="options{{ $feature->indx }}">
                                  @php
                                    $feature_content = App\Models\Listing\ListingFeatureContent::where(
                                        'listing_feature_id',
                                        $feature->id,
                                    )->get();

                                    $op = json_decode($feature_content[0]['feature_value']);
                                  @endphp
                                  @if ($op)
                                    @foreach ($op as $opIn => $w)
                                      <div class="repeater-child-item" id="options{{ $feature->indx }}">
                                        <div class="row align-items-end gutters-2">
                                          @php
                                            $opArr = [];
                                            for ($i = 0; $i < count($languages); $i++) {
                                                $opArr[$i] = json_decode($feature_content[$i]['feature_value'] ?? '');
                                            }
                                          @endphp
                                          @for ($i = 0; $i < count($languages); $i++)
                                            <div
                                              class="col-sm-4 col-lg-3 mb-2 {{ $languages[$i]->direction == 1 ? 'rtl text-right' : '' }}">
                                              <label for="form" class="form-label mb-1">{{ __('Value') }}
                                                (In {{ $languages[$i]->name }})
                                              </label>
                                              <input class="form-control"
                                                name="{{ $languages[$i]->code }}_feature_value_{{ $feature->indx }}[]"
                                                type="text" value="{{ $opArr[$i][$opIn] ?? '' }}" placeholder="">
                                            </div>
                                          @endfor
                                          <div class="col-sm-4 col-lg-3 mb-2">
                                            <button class="btn btn-danger js-repeater-child-remove btn-sm" type="button"
                                              onclick="$(this).parents('.repeater-child-item').remove()">X</button>
                                          </div>
                                        </div>
                                      </div>
                                    @endforeach
                                  @endif
                                </div>
                              </div>
                            </div>
                          @endforeach
                        </div>
                      </div>
                    </div>
                  </div>
                @endif
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
@endsection

@section('script')
  <script type="text/javascript" src="{{ asset('assets/admin/js/feature.js') }}"></script>
  <script src="{{ asset('assets/admin/js/admin-listing.js') }}"></script>
@endsection

@section('variables')
  <script>
    "use strict";
    var featureRmvUrl = "{{ route('vendor.listing_management.feature_delete') }}"
    var additionalFeatureLimit = {{ $additionalFeatureLimit - 1 }};
    var languages = {!! json_encode($languages) !!};
  </script>
@endsection
