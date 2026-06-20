@extends('admin.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Business Hours') }}</h4>
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
        <a
          href="{{ route('admin.listing_management.listings', ['language' => $defaultLang->code]) }}">{{ __('Manage Listings') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">
          @if (!empty($title))
            {{ strlen(@$title->title) > 30 ? mb_substr(@$title->title, 0, 30, 'utf-8') . '...' : @$title->title }}
          @endif
        </a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Business Hours') }}</a>
      </li>
    </ul>
  </div>
  @php
    $vendor_id = App\Models\Listing\Listing::where('id', $id)->pluck('vendor_id')->first();
    if ($vendor_id != 0) {
        $dowgraded = App\Http\Helpers\VendorPermissionHelper::packagesDowngraded($vendor_id);
        $listingCanAdd = packageTotalListing($vendor_id) - vendorTotalListing($vendor_id);
    }
  @endphp

  <div class="row">
    <div class="col-lg-12">
      <div class="card">
        <div class="card-header">
          <div class="card-title d-inline-block">{{ __('Business Hours') }}</div>
          <a class="btn btn-info btn-sm float-right d-inline-block"
            href="{{ route('admin.listing_management.listings', ['language' => $defaultLang->code]) }}">
            <span class="btn-label">
              <i class="fas fa-backward"></i>
            </span>
            {{ __('Back') }}
          </a>
          @php
            $dContent = App\Models\Listing\ListingContent::where('listing_id', $id)
                ->where('language_id', $defaultLang->id)
                ->first();
            $slug = !empty($dContent) ? $dContent->slug : '';
          @endphp
          @if ($dContent)
            <a class="btn btn-success btn-sm float-right mr-1 d-inline-block"
              href="{{ route('frontend.listing.details', ['slug' => $slug, 'id' => $id]) }}" target="_blank">
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
            <div class="col-lg-12">
              <div class="table-responsive">
                <form action="{{ route('admin.listing_management.listing.business_hours_update', ['id' => $id]) }}"
                  method="post">
                  @csrf
                  <table class="table table-striped mt-3">
                    <thead>
                      <tr>
                        <th scope="col">{{ __('Day') }}</th>
                        <th scope="col">{{ __('Start Time') }}</th>
                        <th scope="col">{{ __('End Time') }}</th>
                        <th scope="col">{{ __('Holiday') }}</th>
                      </tr>
                    </thead>
                    <tbody>
                      @foreach ($days as $day)
                        <input type="hidden" name="{{ $day->day }}_id" value="{{ $day->id }}">
                        <tr>
                          <td>
                            {{ __($day->day) }}
                          </td>
                          <td>
                            @if ($day->holiday == 0)
                              --
                            @else
                              <div class="">
                                <input type="text" name="{{ $day->day }}_start_time"
                                  class="form-control in_start_time" placeholder="Choose Start Time" id="in_start_time"
                                  value="{{ $day->start_time }}">
                                <p id="err_start_time" class="mt-1 mb-0 text-danger em"></p>
                              </div>
                            @endif
                          </td>
                          <td>
                            @if ($day->holiday == 0)
                              --
                            @else
                              <div class="">
                                <input type="text" name="{{ $day->day }}_end_time"
                                  class="form-control in_start_time" placeholder="Choose Start Time" id="in_start_time"
                                  value="{{ $day->end_time }}">
                                <p id="err_start_time" class="mt-1 mb-0 text-danger em"></p>
                              </div>
                            @endif
                          </td>
                          <td>
                            <label for="holidaySelect{{ $day->id }}">
                              <select id="holidaySelect{{ $day->id }}"
                                class="form-control {{ $day->holiday == 1 ? 'bg-success' : 'bg-danger' }} form-control-sm"
                                name="holiday" onchange="updateHoliday('{{ $day->id }}', this.value);">
                                <option value="1" {{ $day->holiday == 1 ? 'selected' : '' }}>
                                  {{ __('Open') }}
                                </option>
                                <option value="0" {{ $day->holiday == 0 ? 'selected' : '' }}>
                                  {{ __('Close') }}
                                </option>
                              </select>
                            </label>
                          </td>
                        </tr>
                      @endforeach
                    </tbody>
                  </table>
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
        </div>
      </div>
    </div>
  </div>
  @includeIf('admin.listing.check-limit')
@endsection
@section('script')
  <script>
    "use strict";
    var storeHoliday = "{{ route('admin.listing_management.listing.business_hours.update_holiday') }}";
  </script>
  <script type="text/javascript" src="{{ asset('assets/admin/js/holiday.js') }}"></script>
@endsection
