@extends('admin.layout')

{{-- this style will be applied when the direction of language is right-to-left --}}
@includeIf('admin.partials.rtl_style')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Listings') }}</h4>
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
        <a href="#">{{ __('Listings') }}</a>
      </li>
    </ul>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <div class="row">
            <div class="col-lg-2">
              <div class="card-title d-inline-block">{{ __('Listings') }}</div>
            </div>

            <div class="col-lg-8">
              <form action="{{ route('admin.listing_management.listings') }}" method="get" id="listingSearchForm">
                <div class="row">
                  <div class="col-sm-6 col-xl-2 mb-1 mb-xl-0">
                    <select name="vendor_id" id="" class="select2"
                      onchange="document.getElementById('listingSearchForm').submit()">
                      <option value="" selected disabled>{{ __('Vendor') }}</option>
                      <option value="All" {{ request()->input('vendor_id') == 'All' ? 'selected' : '' }}>
                        {{ __('All') }}</option>
                      @php
                        $vendorInfo = App\Models\Admin::first();
                      @endphp
                      <option value="admin" @selected(request()->input('vendor_id') == 'admin')>{{ $vendorInfo->username }}
                        ({{ __('admin') }})</option>
                      @foreach ($vendors as $vendor)
                        <option @selected($vendor->id == request()->input('vendor_id')) value="{{ $vendor->id }}">
                          {{ $vendor->username }}
                        </option>
                      @endforeach
                    </select>
                  </div>
                  <div class="col-sm-6 col-xl-2 mb-1 mb-xl-0">
                    <select name="category" id="" class="select2"
                      onchange="document.getElementById('listingSearchForm').submit()">
                      <option value="" selected disabled>{{ __('Category') }}</option>
                      <option value="All" {{ request()->input('category') == 'All' ? 'selected' : '' }}>
                        {{ __('All') }}</option>
                      @foreach ($categories as $category)
                        <option @selected($category->slug == request()->input('category')) value="{{ $category->slug }}">
                          {{ $category->name }}
                        </option>
                      @endforeach
                    </select>
                  </div>
                  <div class="col-sm-6 col-xl-2 mb-1 mb-xl-0">
                    <select name="status" id="" class="select2"
                      onchange="document.getElementById('listingSearchForm').submit()">
                      <option value="" selected disabled>{{ __('Status') }}</option>
                      <option value="All" {{ request()->input('status') == 'All' ? 'selected' : '' }}>
                        {{ __('All') }}</option>
                      <option value="approved" {{ request()->input('status') == 'approved' ? 'selected' : '' }}>
                        {{ __('Approved') }}
                      </option>
                      <option value="pending" {{ request()->input('status') == 'pending' ? 'selected' : '' }}>
                        {{ __('Pending') }}
                      </option>
                      <option value="rejected" {{ request()->input('status') == 'rejected' ? 'selected' : '' }}>
                        {{ __('Rejected') }}
                      </option>
                    </select>
                  </div>
                  <div class="col-sm-6 col-xl-2 mb-1 mb-xl-0">
                    <input type="text" name="title" value="{{ request()->input('title') }}" class="form-control"
                      placeholder="{{ __('Title') }}">
                  </div>
                  <div class="col-sm-6 col-xl-2 mb-1 mb-xl-0">
                    <select name="featured" id="" class="select2"
                      onchange="document.getElementById('listingSearchForm').submit()">
                      <option value="" selected disabled>{{ __('Featured') }}</option>
                      <option value="All" {{ request()->input('featured') == 'All' ? 'selected' : '' }}>
                        {{ __('All') }}</option>
                      <option value="active" {{ request()->input('featured') == 'active' ? 'selected' : '' }}>
                        {{ __('Active') }}
                      </option>
                      <option value="pending" {{ request()->input('featured') == 'pending' ? 'selected' : '' }}>
                        {{ __('Pending') }}
                      </option>
                      <option value="rejected" {{ request()->input('featured') == 'rejected' ? 'selected' : '' }}>
                        {{ __('Rejected') }}
                      </option>
                    </select>
                  </div>
                </div>
              </form>
            </div>

            <div class="col-lg-2 mt-2 mt-lg-0">
              <div class="text-right">
                <a href="{{ route('admin.listing_management.select_vendor') }}" class="btn btn-primary btn-sm"><i
                    class="fas fa-plus"></i> {{ __('Add Listing') }}</a>
                <button class="btn btn-danger btn-sm ml-2 d-none bulk-delete"
                  data-href="{{ route('admin.listing_management.bulk_delete.listing') }}"><i
                    class="flaticon-interface-5"></i>
                  {{ __('Delete') }}
                </button>
              </div>
            </div>
          </div>
        </div>

        <div class="card-body">
          <div class="row">
            <div class="col-lg-12">
              @if (count($listings) == 0)
                <h3 class="text-center">{{ __('NO LISTING FOUND') . '!' }}</h3>
              @else
                <div class="table-responsive">
                  <table class="table table-striped mt-3">
                    <thead>
                      <tr>
                        <th scope="col">
                          <input type="checkbox" class="bulk-check" data-val="all">
                        </th>
                        <th scope="col">{{ __('Featured Image') }}</th>
                        <th scope="col">{{ __('Title') }}</th>
                        <th scope="col">{{ __('Vendor') }}</th>
                        @if (count($charges) > 0)
                          <th scope="col">{{ __('Featured Status') }}</th>
                        @endif
                        <th scope="col">{{ __('Category') }}</th>
                        <th scope="col">{{ __('Approve Status') }}</th>
                        <th scope="col">{{ __('Hide/Show') }}</th>
                        <th scope="col">{{ __('Actions') }}</th>
                      </tr>
                    </thead>
                    <tbody>
                      @foreach ($listings as $listing)
                        @php
                          $listing_content = $listing->listing_content->first();
                          
                          if (is_null($listing_content)) {
                              $listing_content = App\Models\Listing\ListingContent::where('listing_id', $listing->id)
                                  ->where('language_id', $language->id)
                                  ->first();
                          }
                          if (empty($listing->vendor_id) || $listing->vendor_id == 0) {
                              $vendorId = 0;
                              $current_package = [];
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
                          } else {
                              $vendorId = $listing->vendor_id;
                              $current_package = App\Http\Helpers\VendorPermissionHelper::packagePermission($vendorId);
                              if (!empty($current_package->features)) {
                                  $permissions = $current_package->features;
                              }
                              if (!empty($current_package->features)) {
                                  $permissions = json_decode($permissions, true);
                              }
                          }
                        @endphp
                        <tr>
                          <td>
                            <input type="checkbox" class="bulk-check" data-val="{{ $listing->id }}">
                          </td>
                          <td>
                            @if (!empty($listing_content))
                              <a href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing->id]) }}"
                                target="_blank">
                                <div class="max-dimensions">
                                  <img
                                    src="{{ $listing->feature_image ? asset('assets/img/listing/' . $listing->feature_image) : asset('assets/admin/img/noimage.jpg') }}"
                                    alt="..." class="uploaded-img">
                                </div>
                              </a>
                            @else
                              <div class="max-dimensions">
                                <img
                                  src="{{ $listing->feature_image ? asset('assets/img/listing/' . $listing->feature_image) : asset('assets/admin/img/noimage.jpg') }}"
                                  alt="..." class="uploaded-img">
                              </div>
                            @endif
                          </td>
                          <td class="title">
                            @if (!empty($listing_content))
                              <a href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing->id]) }}"
                                target="_blank">
                                {{ strlen(@$listing_content->title) > 50 ? mb_substr(@$listing_content->title, 0, 50, 'utf-8') . '...' : @$listing_content->title }}
                              </a>
                            @else
                              --
                            @endif
                          </td>
                          <td>
                            @if ($listing->vendor_id != 0)
                              <a
                                href="{{ route('admin.vendor_management.vendor_details', ['id' => @$listing->vendor->id, 'language' => $defaultLang->code]) }}">{{ @$listing->vendor->username }}</a>
                            @else
                              <span class="badge badge-success">{{ __('Admin') }}</span>
                            @endif
                          </td>

                          @if (count($charges) > 0)
                            <td>
                              @php
                                $order_status = App\Models\FeatureOrder::where('listing_id', $listing->id)->first();
                                $today_date = now()->format('Y-m-d');
                              @endphp

                              @if (is_null($order_status))
                                <button class="btn btn-primary featurePaymentModal btn-sm " data-toggle="modal"
                                  data-target="#featurePaymentModal_{{ $listing->id }}" data-id="{{ $listing->id }}"
                                  data-listing-id="{{ $listing->id }}">
                                  {{ __('Feature It') }}
                                </button>
                              @endif

                              @if ($order_status)
                                @if ($order_status->order_status == 'pending')
                                  <h2 class="d-inline-block"><span
                                      class="badge badge-warning">{{ __('pending') }}</span>
                                  </h2>
                                @endif
                                @if ($order_status->order_status == 'completed')
                                  @if ($order_status->end_date < $today_date)
                                    <button class="btn btn-primary featurePaymentModal  btn-sm"
                                      data-toggle="modal"data-target="#featurePaymentModal_{{ $listing->id }}"
                                      data-id="{{ $listing->id }}">{{ __('Feature It') }}</button>
                                  @else
                                    @if ($listing->vendor_id != 0)
                                      <h1 class="d-inline-block text-large"><span
                                          class="badge badge-success">{{ __('Active') }}</span>
                                      </h1>
                                    @else
                                      <form class="deleteForm d-block"
                                        action="{{ route('admin.featured_listing.delete', ['id' => $order_status->id]) }}"
                                        method="post">
                                        @csrf
                                        <button type="submit" class="btn btn-danger  mt-1 btn-sm unFeatureBtn">
                                          {{ __('Unfeature') }}
                                          </h1>
                                        </button>
                                      </form>
                                    @endif
                                  @endif
                                @endif
                                @if ($order_status->order_status == 'rejected')
                                  <button class="btn btn-primary featurePaymentModal btn-sm "
                                    data-toggle="modal"data-target="#featurePaymentModal_{{ $listing->id }}"
                                    data-id="{{ $listing->id }}">{{ __('Feature It') }}</button>
                                @endif
                              @endif
                            </td>
                          @endif
                          </td>
                          <td>
                            @if (!empty($listing_content))
                              @php
                                $categoryName = App\Models\ListingCategory::where(
                                    'id',
                                    $listing_content->category_id,
                                )->first();
                              @endphp

                              <a href="{{ route('frontend.listings', ['category_id' => @$categoryName->slug]) }}"
                                target="_blank">

                                {{ @$categoryName->name }}
                              </a>
                            @else
                              --
                            @endif
                          </td>

                          <td>
                            <form id="statusForm{{ $listing->id }}" class="d-inline-block"
                              action="{{ route('admin.listing_management.update_listing_status') }}" method="post">
                              @csrf
                              <input type="hidden" name="listingId" value="{{ $listing->id }}">
                              <select
                                class="form-control {{ $listing->status == 1 ? 'bg-success' : ($listing->status == 2 ? 'bg-danger' : 'bg-warning') }} form-control-sm"
                                name="status"
                                onchange="document.getElementById('statusForm{{ $listing->id }}').submit();">
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
                            <form id="visibilityStatusForm{{ $listing->id }}" class="d-inline-block"
                              action="{{ route('admin.listing_management.update_listing_visibility') }}"
                              method="post">
                              @csrf
                              <input type="hidden" name="listingId" value="{{ $listing->id }}">
                              <select
                                class="form-control {{ $listing->visibility == 1 ? 'bg-success' : 'bg-danger' }} form-control-sm"
                                name="visibility"
                                onchange="document.getElementById('visibilityStatusForm{{ $listing->id }}').submit();">
                                <option value="1" {{ $listing->visibility == 1 ? 'selected' : '' }}>
                                  {{ __('Show') }}
                                </option>
                                <option value="0" {{ $listing->visibility == 0 ? 'selected' : '' }}>
                                  {{ __('Hide') }}
                                </option>

                              </select>
                            </form>
                          </td>
                          <td>
                            @if ($current_package == '[]')
                              <form class="deleteForm d-block"
                                action="{{ route('admin.listing_management.delete_listing', ['id' => $listing->id]) }}"
                                method="post">
                                @csrf
                                <button type="submit" class="btn btn-danger  mt-1 btn-sm deleteBtn">
                                  <span class="btn-label">
                                    <i class="fas fa-trash"></i>
                                  </span>
                                </button>
                              </form>
                            @else
                              <div class="dropdown">
                                <button class="btn btn-secondary btn-sm dropdown-toggle" type="button"
                                  id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true"
                                  aria-expanded="false">
                                  {{ __('Select') }}
                                </button>

                                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">

                                  <a href="{{ route('admin.listing_management.edit_listing', ['id' => $listing->id]) }}"
                                    class="dropdown-item">
                                    {{ __('Edit') }}
                                  </a>
                                  @if (!empty($listing_content))
                                    <a href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing->id]) }}"
                                      class="dropdown-item"target="_blank">
                                      {{ __('Preview') }}
                                    </a>
                                  @endif

                                  @if (is_array($permissions) &&
                                          (in_array('Messenger', $permissions) ||
                                              in_array('WhatsApp', $permissions) ||
                                              in_array('Telegram', $permissions) ||
                                              in_array('Tawk.To', $permissions)))
                                    <a href="{{ route('admin.listing_management.listing.plugins', ['id' => $listing->id]) }}"
                                      class="dropdown-item">
                                      {{ __('Manage Plugins') }}
                                    </a>
                                  @endif
                                  @if (is_array($permissions) && in_array('Business Hours', $permissions))
                                    <a href="{{ route('admin.listing_management.listing.business_hours', ['id' => $listing->id]) }}"
                                      class="dropdown-item">
                                      {{ __('Business Hours') }}
                                    </a>
                                  @endif
                                  @if (is_array($permissions) && in_array('Social Links', $permissions))
                                    <a href="{{ route('admin.listing_management.manage_social_link', ['id' => $listing->id]) }}"
                                      class="dropdown-item">
                                      {{ __('Social Links') }}
                                    </a>
                                  @endif
                                  @if (is_array($permissions) && in_array('Feature', $permissions))
                                    <a href="{{ route('admin.listing_management.manage_additional_specification_link', ['id' => $listing->id]) }}"
                                      class="dropdown-item">
                                      {{ __('Features') }}
                                    </a>
                                  @endif
                                  @if (is_array($permissions) && in_array('FAQ', $permissions))
                                    <a href="{{ route('admin.listing_management.listing.faq', ['id' => $listing->id]) }}"
                                      class="dropdown-item">
                                      {{ __('FAQs') }}
                                    </a>
                                  @endif
                                  <form class="deleteForm d-block"
                                    action="{{ route('admin.listing_management.delete_listing', ['id' => $listing->id]) }}"
                                    method="post">
                                    @csrf
                                    <button type="submit" class="deleteBtn">
                                      {{ __('Delete') }}
                                    </button>
                                  </form>
                                </div>
                              </div>
                            @endif
                          </td>
                        </tr>
                        @include('admin.listing.feature-payment')
                      @endforeach
                      @if (count($listings) < 3)
                        <tr class="opacity-0">
                          <td></td>
                        </tr>
                        <tr class="opacity-0">
                          <td></td>
                        </tr>
                      @endif
                    </tbody>
                  </table>
                </div>
              @endif
            </div>
          </div>
        </div>
        <div class="card-footer">
          <div class="center">
            {{ $listings->appends([
                    'vendor_id' => request()->input('vendor_id'),
                    'title' => request()->input('title'),
                    'status' => request()->input('status'),
                    'category' => request()->input('category'),
                    'language' => request()->input('language'),
                    'featured' => request()->input('featured'),
                ])->links() }}
          </div>
        </div>
      </div>
    </div>
  </div>
@endsection
