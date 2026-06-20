@extends('vendors.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Manage Social Link') }}</h4>
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
        <a href="#">{{ __('Manage Social Link') }}</a>
      </li>
    </ul>
  </div>

  @php
    $vendorId = Auth::guard('vendor')->user()->id;

    if ($vendorId) {
        $current_package = App\Http\Helpers\VendorPermissionHelper::packagePermission($vendorId);

        if (!empty($current_package) && !empty($current_package->features)) {
            $permissions = json_decode($current_package->features, true);
            $SocialLinkLimit = packageTotalSocialLink($vendorId);
        } else {
            $permissions = null;
            $SocialLinkLimit = 0;
        }
    } else {
        $permissions = null;
        $SocialLinkLimit = 0;
    }
  @endphp

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <div class="card-title d-inline-block">{{ __('Manage Social Link') }}</div>
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
              <form id="listingForm" action="{{ route('vendor.listing_management.update_social_link', $listing_id) }}"
                method="POST" enctype="multipart/form-data">
                @csrf
                <input type="hidden" name="listing_id" value="{{ $listing_id }}">

                @if (is_array($permissions) && in_array('Social Links', $permissions))
                  <div class="row">
                    <div class="col-lg-12">
                      <h4>{{ __('Social Links') }}</h4>
                      <div class="js-repeaters">
                        <div class="mb-3">
                          <br>
                          <button class="btn btn-primary js-repeaters-add"
                            type="button">+{{ __('Add Social Link') }}</button>
                        </div>
                        <div id="js-repeaters-container">

                          @foreach ($socialLinks as $keys => $link)
                            <div class="js-repeaters-item p-3" data-item="{{ $keys }}">
                              <div class="row align-items-end gutters-2">
                                <div class="col-sm-4 col-lg-3">
                                  <label for="form" class="form-label mb-1">{{ __('Social Link') }}</label>
                                  <div class="mb-2">
                                    <input type="text" required class="form-control" value="{{ $link->link }}"
                                      name="socail_link[]">
                                  </div>
                                </div>
                                <div class="col-sm-4 col-lg-3">
                                  <label for="form" class="form-label mb-1">{{ __('Select Icon') }}</label>
                                  <div class="mb-2">
                                    <button class="btn btn-primary iconpicker-component aaa">
                                      <i class="{{ $link->icon }}"></i>
                                    </button>
                                    <button type="button" class="icp icp-dd btn btn-primary dropdown-toggle"
                                      data-selected="fa-car" data-toggle="dropdown">
                                    </button>
                                    <div class="dropdown-menu"></div>
                                  </div>
                                </div>
                                <div class="col">
                                  <a href="javascript:void(0)" data-social_link="{{ $link->id }}"
                                    class="btn btn-danger btn-sm js-repeaters-remove mb-2 mr-2 deleteSocialLink">
                                    X</a>
                                </div>
                                <div class="repeaters-child-list mt-2 col-12" id="options${it}"></div>
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
  <script type="text/javascript" src="{{ asset('assets/admin/js/admin-partial.js') }}"></script>
  <script src="{{ asset('assets/admin/js/admin-listing.js') }}"></script>
  <script type="text/javascript" src="{{ asset('assets/admin/js/social-link.js') }}"></script>
@endsection

@section('variables')
  <script>
    "use strict";
    var socialRmvUrl = "{{ route('vendor.listing_management.social_delete') }}"
    var SocialLinkLimit = {{ $SocialLinkLimit - 1 }};
  </script>
@endsection
