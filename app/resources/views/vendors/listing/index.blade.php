@extends('vendors.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Listings') }}</h4>
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
        <a href="#">{{ __('Listings') }}</a>
      </li>
    </ul>
  </div>
  @php
    $vendor_id = Auth::guard('vendor')->user()->id;

    if ($vendor_id) {
        $current_package = App\Http\Helpers\VendorPermissionHelper::packagePermission($vendor_id);

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
          <div class="row align-items-center">
            <div class="col-lg-2">
              <div class="card-title d-inline-block">{{ __('Listings') }}</div>
            </div>

            <div class="col-lg-7">
              <form action="{{ route('vendor.listing_management.listings') }}" method="get" id="listingSearchForm">
                <div class="row">

                  <div class="col-md-3 mt-2 mt-lg-0">
                    <select name="category" id="" class="select2"
                      onchange="document.getElementById('listingSearchForm').submit()">
                      <option value="" selected disabled>{{ __('Search by Category') }}</option>
                      <option value="All" {{ request()->input('category') == 'All' ? 'selected' : '' }}>
                        {{ __('All') }}</option>
                      @foreach ($categories as $category)
                        <option @selected($category->slug == request()->input('category')) value="{{ $category->slug }}">{{ $category->name }}
                        </option>
                      @endforeach
                    </select>
                  </div>
                  <div class="col-md-3 mt-2 mt-lg-0">
                    <input type="text" name="title" value="{{ request()->input('title') }}" class="form-control"
                      placeholder="{{ __('Title') }}">
                  </div>
                  <div class="col-md-3 mt-2 mt-lg-0">
                    <select name="status" id="" class="select2"
                      onchange="document.getElementById('listingSearchForm').submit()">
                      <option value="" selected disabled>{{ __('Search by Approve Status') }}</option>
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
                  <div class="col-md-3 mt-2 mt-lg-0">
                    @includeIf('admin.partials.languages')
                  </div>
                </div>
              </form>
            </div>

            <div class="col-lg-3 mt-3 mt-lg-0">
              <div class="btn-groups gap-10 justify-content-lg-end">
                <a href="{{ route('vendor.listing_management.create_listing') }}" class="btn btn-primary btn-sm"><i
                    class="fas fa-plus"></i> {{ __('Add Listing') }}</a>
                <button class="btn btn-danger btn-sm d-none bulk-delete"
                  data-href="{{ route('vendor.listing_management.bulk_delete.listing') }}"><i
                    class="flaticon-interface-5"></i>
                  {{ __('Delete') }}</button>
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
                          @if (count($charges) > 0)
                            <td>
                              @php
                                $order_status = App\Models\FeatureOrder::where('listing_id', $listing->id)->first();
                                $today_date = now()->format('Y-m-d');
                              @endphp

                              @if (is_null($order_status))
                                <button class="btn btn-primary featured btn-sm " data-toggle="modal"
                                  data-target="#featured" data-id="{{ $listing->id }}"
                                  data-listing-id="{{ $listing->id }}">
                                  {{ __('Pay to Feature') }}
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
                                    <button class="btn btn-primary featured  btn-sm"
                                      data-toggle="modal"data-target="#featured"
                                      data-id="{{ $listing->id }}">{{ __('Pay to Feature') }}</button>
                                  @else
                                    <h1 class="d-inline-block text-large"><span
                                        class="badge badge-success">{{ __('Active') }}</span>
                                    </h1>
                                  @endif
                                @endif
                                @if ($order_status->order_status == 'rejected')
                                  <button class="btn btn-primary featured btn-sm "
                                    data-toggle="modal"data-target="#featured"
                                    data-id="{{ $listing->id }}">{{ __('Pay to Feature') }}</button>
                                @endif
                              @endif
                            </td>
                          @endif
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
                            @if ($listing->status == 1)
                              <h2 class="d-inline-block"><span class="badge badge-success">{{ __('Approved') }}</span>
                              </h2>
                            @elseif($listing->status == 2)
                              <h2 class="d-inline-block"><span class="badge badge-danger">{{ __('Rejected') }}</span>
                              </h2>
                            @else
                              <h2 class="d-inline-block"><span class="badge badge-warning">{{ __('Pending') }}</span>
                              </h2>
                            @endif
                          </td>
                          <td>
                            <form id="visibilityStatusForm{{ $listing->id }}" class="d-inline-block"
                              action="{{ route('vendor.listing_management.update_listing_visibility') }}"
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
                                action="{{ route('vendor.listing_management.delete_listing', ['id' => $listing->id]) }}"
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

                                  <a href="{{ route('vendor.listing_management.edit_listing', ['id' => $listing->id]) }}"
                                    class="dropdown-item">
                                    {{ __('Edit') }}
                                  </a>
                                  @if (!empty($listing_content))
                                    <a href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing->id]) }}"
                                      class="dropdown-item"target="_blank">
                                      {{ __('Preview') }}
                                    </a>
                                  @endif
                                  {{-- @if (is_array($permissions) && in_array('Products', $permissions))
                                    <a href="{{ route('vendor.listing_management.listing.products', ['id' => $listing->id, 'language' => $defaultLang->code]) }}"
                                      class="dropdown-item">
                                      {{ __('Manage Products') }}
                                    </a>
                                  @endif --}}

                                  @if (is_array($permissions) &&
                                          (in_array('Messenger', $permissions) ||
                                              in_array('WhatsApp', $permissions) ||
                                              in_array('Telegram', $permissions) ||
                                              in_array('Tawk.To', $permissions)))
                                    <a href="{{ route('vendor.listing_management.listing.plugins', ['id' => $listing->id,'language' => $defaultLang->code]) }}"
                                      class="dropdown-item">
                                      {{ __('Manage Plugins') }}
                                    </a>
                                  @endif

                                  @if (is_array($permissions) && in_array('Business Hours', $permissions))
                                    <a href="{{ route('vendor.listing_management.listing.business_hours', ['id' => $listing->id]) }}"
                                      class="dropdown-item">
                                      {{ __('Business Hours') }}
                                    </a>
                                  @endif
                                  @if (is_array($permissions) && in_array('Social Links', $permissions))
                                    <a href="{{ route('vendor.listing_management.manage_social_link', ['id' => $listing->id]) }}"
                                      class="dropdown-item">
                                      {{ __('Social Links') }}
                                    </a>
                                  @endif
                                  @if (is_array($permissions) && in_array('Feature', $permissions))
                                    <a href="{{ route('vendor.listing_management.manage_additional_specifications', ['id' => $listing->id]) }}"
                                      class="dropdown-item">
                                      {{ __('Features') }}
                                    </a>
                                  @endif

                                  @if (is_array($permissions) && in_array('FAQ', $permissions))
                                    <a href="{{ route('vendor.listing_management.listing.faq', ['id' => $listing->id, 'language' => $defaultLang->code]) }}"
                                      class="dropdown-item">
                                      {{ __('FAQs') }}
                                    </a>
                                    </a>
                                  @endif

                                  <form class="deleteForm d-block"
                                    action="{{ route('vendor.listing_management.delete_listing', ['id' => $listing->id]) }}"
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
                    'title' => request()->input('title'),
                    'category' => request()->input('category'),
                    'status' => request()->input('status'),
                    'language' => request()->input('language'),
                ])->links() }}
          </div>
        </div>
      </div>
    </div>
  </div>
  <div id="razorPayForm"></div>
  @include('vendors.listing.feature-payment')
@endsection
@section('script')
  @if ($midtrans['is_production'] == 1)
    <script src="https://app.sandbox.midtrans.com/snap/snap.js" data-client-key="{{ config('midtrans.client_key') }}">
    </script>
  @else
    <script src="https://app.midtrans.com/snap/snap.js" data-client-key="{{ config('midtrans.client_key') }}"></script>
  @endif
  <script src="https://js.stripe.com/v3/"></script>
  <script src="{{ $anetSource }}"></script>
  <script>
    "use strict";
    let stripe_key = "{{ $stripe_key }}";
    let authorize_public_key = "{{ $anetClientKey }}";
    let authorize_login_key = "{{ $anetLoginId }}";
    var featurePament = "{{ Session::get('featurePaymentModal') }}";
    var modalName = "{{ Session::get('modalName') }}";
  </script>
  <script src="{{ asset('assets/js/vendor-feature-checkout.js') }}"></script>
  <script>
    "use strict";
    @if (old('gateway') == 'autorize.net')
      $(document).ready(function() {
        $('#stripe-element').removeClass('d-none');
      })
    @endif
  </script>
@endsection
