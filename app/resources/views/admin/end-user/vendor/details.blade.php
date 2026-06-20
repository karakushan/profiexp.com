
  @extends('admin.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Vendor Details') }}</h4>
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
        <a href="#">{{ __('Vendors Management') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="{{ route('admin.vendor_management.registered_vendor') }}">{{ __('Registered vendors') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Vendor Details') }}</a>
      </li>
    </ul>
  </div>
  
  @php

    $vendor_id = $vendor->id; 
    
    if ($vendor_id != 0) {
        $current_package = App\Http\Helpers\VendorPermissionHelper::packagePermission($vendor_id);
        $dowgraded = App\Http\Helpers\VendorPermissionHelper::packagesDowngraded($vendor_id);
        $listingCanAdd = packageTotalListing($vendor_id) - vendorTotalListing($vendor_id);
    }
  @endphp

  <div class="row">
    <div class="col-md-12">
      <div class="row">

        <div class="col-md-4">
          <div class="card">
            <div class="card-header">
              <div class="h4 card-title">{{ __('Vendor Information') }}</div>
              <h2 class="text-center">
                @if ($vendor->photo != null)
                  <img class="admin-vendor-photo" src="{{ asset('assets/admin/img/vendor-photo/' . $vendor->photo) }}" alt="..." class="uploaded-img">
                @else
                  <img class="admin-vendor-photo" src="{{ asset('assets/img/blank-user.jpg') }}" alt="..." class="uploaded-img">
                @endif
              </h2>
            </div>

            <div class="card-body">
              <div class="payment-information">

                @php
                  $currPackage = \App\Http\Helpers\VendorPermissionHelper::currPackageOrPending($vendor->id);
                  $currMemb = \App\Http\Helpers\VendorPermissionHelper::currMembOrPending($vendor->id);
                @endphp
                <div class="row mb-3">
                  <div class="col-lg-6">
                    <strong>{{ __('Current Package') . ':' }}</strong>
                  </div>
                  <div class="col-lg-6">
                    @if ($currPackage)
                      <a target="_blank" href="{{ route('admin.package.edit', $currPackage->id) }}">{{ $currPackage->title }}</a>
                      <span class="badge badge-secondary badge-xs mr-2">{{ __($currPackage->term) }}</span>
                      <button type="submit" class="btn btn-xs btn-warning" data-toggle="modal" data-target="#editCurrentPackage"><i class="far fa-edit"></i></button>
                      <form action="{{ route('vendor.currPackage.remove') }}" class="d-inline-block deleteForm" method="POST">
                        @csrf
                        <input type="hidden" name="vendor_id" value="{{ $vendor->id }}">
                        <button type="submit" class="btn btn-xs btn-danger deleteBtn"><i class="fas fa-trash"></i></button>
                      </form>

                      <p class="mb-0">
                        @if ($currMemb->is_trial == 1)
                          ({{ __('Expire Date') . ':' }} {{ Carbon\Carbon::parse($currMemb->expire_date)->format('M-d-Y') }})
                          <span class="badge badge-primary">{{ __('Trial') }}</span>
                        @else
                          ({{ __('Expire Date') . ':' }} {{ $currPackage->term === 'lifetime' ? __('Lifetime') : Carbon\Carbon::parse($currMemb->expire_date)->format('M-d-Y') }})
                        @endif
                        @if ($currMemb->status == 0)
                          <form id="statusForm{{ $currMemb->id }}" class="d-inline-block" action="{{ route('admin.payment-log.update') }}" method="post">
                            @csrf
                            <input type="hidden" name="id" value="{{ $currMemb->id }}">
                            <select class="form-control form-control-sm bg-warning" name="status" onchange="document.getElementById('statusForm{{ $currMemb->id }}').submit();">
                              <option value=0 selected>{{ __('Pending') }}</option>
                              <option value=1>{{ __('Success') }}</option>
                              <option value=2>{{ __('Rejected') }}</option>
                            </select>
                          </form>
                        @endif
                      </p>
                    @else
                      <a data-target="#addCurrentPackage" data-toggle="modal" class="btn btn-xs btn-primary text-white"><i class="fas fa-plus"></i> {{ __('Add Package') }}</a>
                    @endif
                  </div>
                </div>

                @php
                  $nextPackage = \App\Http\Helpers\VendorPermissionHelper::nextPackage($vendor->id);
                  $nextMemb = \App\Http\Helpers\VendorPermissionHelper::nextMembership($vendor->id);
                @endphp
                <div class="row mb-3">
                  <div class="col-lg-6">
                    <strong>{{ __('Next Package') . ':' }}</strong>
                  </div>
                  <div class="col-lg-6">
                    @if ($nextPackage)
                      <a target="_blank" href="{{ route('admin.package.edit', $nextPackage->id) }}">{{ $nextPackage->title }}</a>
                      <span class="badge badge-secondary badge-xs mr-2">{{ __($nextPackage->term) }}</span>
                      <button type="button" class="btn btn-xs btn-warning" data-toggle="modal" data-target="#editNextPackage"><i class="far fa-edit"></i></button>
                      <form action="{{ route('vendor.nextPackage.remove') }}" class="d-inline-block deleteForm" method="POST">
                        @csrf
                        <input type="hidden" name="vendor_id" value="{{ $vendor->id }}">
                        <button type="submit" class="btn btn-xs btn-danger deleteBtn"><i class="fas fa-trash"></i></button>
                      </form>

                      <p class="mb-0">
                        @if ($currPackage->term != 'lifetime' && $nextMemb->is_trial != 1)
                          ( {{ __('Activation Date') }}: {{ Carbon\Carbon::parse($nextMemb->start_date)->format('M-d-Y') }}, {{ __('Expire Date') }}: {{ $nextPackage->term === 'lifetime' ? 'Lifetime' : Carbon\Carbon::parse($nextMemb->expire_date)->format('M-d-Y') }} )
                        @endif
                        @if ($nextMemb->status == 0)
                          <form id="statusForm{{ $nextMemb->id }}" class="d-inline-block" action="{{ route('admin.payment-log.update') }}" method="post">
                            @csrf
                            <input type="hidden" name="id" value="{{ $nextMemb->id }}">
                            <select class="form-control form-control-sm bg-warning" name="status" onchange="document.getElementById('statusForm{{ $nextMemb->id }}').submit();">
                              <option value=0 selected>{{ __('Pending') }}</option>
                              <option value=1>{{ __('Success') }}</option>
                              <option value=2>{{ __('Rejected') }}</option>
                            </select>
                          </form>
                        @endif
                      </p>
                    @else
                      @if (!empty($currPackage))
                        <a class="btn btn-xs btn-primary text-white" data-toggle="modal" data-target="#addNextPackage"><i class="fas fa-plus"></i> {{ __('Add Package') }}</a>
                      @else
                        -
                      @endif
                    @endif
                  </div>
                </div>

                <div class="row mb-2">
                  <div class="col-lg-4">
                    <strong>{{ __('Name') . ' :' }}</strong>
                  </div>
                  <div class="col-lg-8">
                    {{ @$vendor->vendor_info->name }}
                  </div>
                </div>

                <div class="row mb-2">
                  <div class="col-lg-4">
                    <strong>{{ __('Username') . ' :' }}</strong>
                  </div>
                  <div class="col-lg-8">
                    {{ $vendor->username }}
                  </div>
                </div>

                <div class="row mb-2">
                  <div class="col-lg-4">
                    <strong>{{ __('Email') . ' :' }}</strong>
                  </div>
                  <div class="col-lg-8">
                    {{ $vendor->email }}
                  </div>
                </div>

                <div class="row mb-2">
                  <div class="col-lg-4">
                    <strong>{{ __('Phone') . ' :' }}</strong>
                  </div>
                  <div class="col-lg-8">
                    {{ $vendor->phone }}
                  </div>
                </div>

                <div class="row mb-2">
                  <div class="col-lg-4">
                    <strong>{{ __('Country') . ' :' }}</strong>
                  </div>
                  <div class="col-lg-8">
                    {{ @$vendor->vendor_info->country }}
                  </div>
                </div>
                <div class="row mb-2">
                  <div class="col-lg-4">
                    <strong>{{ __('City') . ' :' }}</strong>
                  </div>
                  <div class="col-lg-8">
                    {{ @$vendor->vendor_info->city }}
                  </div>
                </div>
                <div class="row mb-2">
                  <div class="col-lg-4">
                    <strong>{{ __('State') . ' :' }}</strong>
                  </div>
                  <div class="col-lg-8">
                    {{ @$vendor->vendor_info->state }}
                  </div>
                </div>
                <div class="row mb-2">
                  <div class="col-lg-4">
                    <strong>{{ __('Zip Code') . ' :' }}</strong>
                  </div>
                  <div class="col-lg-8">
                    {{ @$vendor->vendor_info->zip_code }}
                  </div>
                </div>
                <div class="row mb-2">
                  <div class="col-lg-4">
                    <strong>{{ __('Address') . ' :' }}</strong>
                  </div>
                  <div class="col-lg-8">
                    {{ @$vendor->vendor_info->address }}
                  </div>
                </div>
                <div class="row mb-2">
                  <div class="col-lg-4">
                    <strong>{{ __('Details') . ' :' }}</strong>
                  </div>
                  <div class="col-lg-8">
                    {{ @$vendor->vendor_info->details }}
                  </div>
                </div>

              </div>
            </div>
          </div>
        </div>
        <div class="col-md-8">
          <div class="card">
            <div class="card-header">
              <div class="row">
                <div class="col-lg-6 col-md-6 mb-2 mb-md-0">
                  <div class="card-title d-inline-block">{{ __('All Listings') }}</div>
                </div>

                <div class="col-lg-6 col-md-6 text-md-right">
                  <div class="btn-groups gap-10 justify-content-lg-end">
                    @if ($vendor_id != 0)
                      <button type="button" class="btn btn-primary btn-sm" id="aa" data-toggle="modal" data-target="#adminCheckLimitModal">
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

                    <button class="btn btn-danger btn-sm d-none bulk-delete" data-href="#">
                      <i class="flaticon-interface-5"></i> {{ __('Delete') }}
                    </button>
                  </div>
                </div>
              </div>
            </div>

            <div class="card-body">
              <div class="col-lg-12">
                @if (count($listings) == 0)
                  <h3 class="text-center mt-2">{{ __('NO LISTING FOUND') . '!' }}</h3>
                @else
                  <div class="table-responsive">
                    <table class="table table-striped mt-3" id="basic-datatables">
                      <thead>
                        <tr>
                          <th scope="col">
                            <input type="checkbox" class="bulk-check" data-val="all">
                          </th>
                          <th scope="col">{{ __('Title') }}</th>
                          @if (count($charges) > 0)
                            <th scope="col">{{ __('Featured') }}</th>
                          @endif
                          <th scope="col">{{ __('Status') }}</th>
                          <th scope="col">{{ __('Actions') }}</th>
                        </tr>
                      </thead>
                      <tbody>
                        @foreach ($listings as $listing)
                          <tr>
                            <td>
                              <input type="checkbox" class="bulk-check" data-val="{{ $listing->id }}">
                            </td>
                            <td>
                              {{ strlen(optional($listing->listing_content->first())->title) > 40 ? mb_substr(optional($listing->listing_content->first())->title, 0, 40, 'utf-8') . '...' : optional($listing->listing_content->first())->title }}
                            </td>
                            @if (count($charges) > 0)
                              <td>
                                @php
                                  $order_status = App\Models\FeatureOrder::where('listing_id', $listing->id)->first();
                                  $today_date = now()->format('Y-m-d');
                                @endphp

                                @if (is_null($order_status))
                                  <button class="btn btn-primary featurePaymentModal btn-sm " data-toggle="modal" data-target="#featurePaymentModal_{{ $listing->id }}" data-id="{{ $listing->id }}" data-listing-id="{{ $listing->id }}">
                                    {{ __('Manage') }}
                                  </button>
                                @endif

                                @if ($order_status)
                                  @if ($order_status->order_status == 'pending')
                                    <h2 class="d-inline-block"><span class="badge badge-warning">{{ ucfirst('pending') }}</span></h2>
                                  @endif
                                  @if ($order_status->order_status == 'completed')
                                    @if ($order_status->end_date < $today_date)
                                      <button class="btn btn-primary featurePaymentModal  btn-sm" data-toggle="modal" data-target="#featurePaymentModal_{{ $listing->id }}" data-id="{{ $listing->id }}">{{ __('Manage') }}</button>
                                    @else
                                      <h1 class="d-inline-block text-large"><span class="badge badge-success">{{ ucfirst('Active') }}</span></h1>
                                    @endif
                                  @endif
                                  @if ($order_status->order_status == 'rejected')
                                    <button class="btn btn-primary featurePaymentModal btn-sm " data-toggle="modal" data-target="#featurePaymentModal_{{ $listing->id }}" data-id="{{ $listing->id }}">{{ __('Manage') }}</button>
                                  @endif
                                @endif
                              </td>
                            @endif

                            <td>
                              <form id="statusForm{{ $listing->id }}" class="d-inline-block" action="{{ route('admin.listing_management.update_listing_status') }}" method="post">
                                @csrf
                                <input type="hidden" name="listingId" value="{{ $listing->id }}">
                                <select class="form-control {{ $listing->status == 1 ? 'bg-success' : ($listing->status == 2 ? 'bg-danger' : 'bg-warning') }} form-control-sm" name="status" onchange="document.getElementById('statusForm{{ $listing->id }}').submit();">
                                  <option value="1" {{ $listing->status == 1 ? 'selected' : '' }}>
                                    {{ __('Approved') }}
                                  </option>
                                  <option value="0" {{ $listing->status == 0 ? 'selected' : '' }}>
                                    {{ __('Pending') }}
                                  </option>
                                  <option value="2" {{ $listing->status == 2 ? 'selected' : '' }}>
                                    {{ __('Rejected') }}
                                  </option>
                                </select>
                              </form>
                            </td>

                            <td>
                              <a class="btn btn-secondary btn-sm mr-1 mb-1" href="{{ route('admin.listing_management.edit_listing', ['id' => $listing->id]) }}">
                                <span class="btn-label">
                                  <i class="fas fa-edit" class="mar--3"></i>
                                </span>
                              </a>
                              <form class="deleteForm d-inline-block" action="{{ route('admin.listing_management.delete_listing', ['id' => $listing->id]) }}" method="post">
                                @csrf
                                <button type="submit" class="btn btn-danger btn-sm deleteBtn  mb-1">
                                  <span class="btn-label">
                                    <i class="fas fa-trash" class="mar--3"></i>
                                  </span>
                                </button>
                              </form>
                            </td>
                          </tr>
                          @include('admin.listing.feature-payment')
                        @endforeach
                      </tbody>
                    </table>
                  </div>
                @endif
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    @includeIf('admin.end-user.vendor.edit-current-package')
    @includeIf('admin.end-user.vendor.add-current-package')
    @includeIf('admin.end-user.vendor.edit-next-package')
    @includeIf('admin.end-user.vendor.add-next-package')
    
    {{-- Include the check limit modal --}}
    @includeIf('admin.listing.check-limit')
@endsection

