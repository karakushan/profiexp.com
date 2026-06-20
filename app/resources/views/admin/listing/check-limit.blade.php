@php
  $vendorId = $vendor_id;
  $current_package = App\Http\Helpers\VendorPermissionHelper::packagePermission($vendorId);

  if (!empty($current_package) && !empty($current_package->features)) {
      $permissions = json_decode($current_package->features, true);
  } else {
      $permissions = null;
  }

  $vendor_id = $vendor_id;

  if ($vendor_id != 0) {
      $dowgraded = App\Http\Helpers\VendorPermissionHelper::packagesDowngraded($vendor_id);
      $listingCanAdd = packageTotalListing($vendor_id) - vendorTotalListing($vendor_id);
  }

@endphp
@if ($current_package != '[]')

  <div class="modal fade" id="adminCheckLimitModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h3 class="modal-title card-title" id="exampleModalLabel">
            {{ __('All Limit') }}</h3>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          @php
            $listingCanAdd = packageTotalListing($vendorId) - vendorTotalListing($vendorId);
          @endphp
          <div class="alert alert-warning">
            <span
              class="text-warning">{{ __('If any feature is downgraded , you can\'t create or edit any feature.') }}</span>
          </div>
          <ul class="list-group border ">

            <li class="list-group-item">
              <div class="d-flex  justify-content-between">
                <span class="text-focus">
                  @if ($listingCanAdd < 0)
                    <i class="fas fa-exclamation-circle text-danger"></i>
                  @endif
                  {{ __('Listings Left') }} :
                </span>

                <span class="badge badge-primary badge-sm">
                  {{ $current_package->number_of_listing - vendorTotalListing($vendorId) >= 999999 ? 'Unlimited' : ($current_package->number_of_listing - vendorTotalListing($vendorId) < 0 ? 0 : $current_package->number_of_listing - vendorTotalListing($vendorId)) }}
                </span>
              </div>

              @if (vendorTotalListing($vendorId) > $current_package->number_of_listing)
                <p class="text-warning m-0">{{ __('Limit has been crossed,vendor has to delete') }}

                  {{ abs($current_package->number_of_listing - vendorTotalListing($vendorId)) }}
                  {{ abs($current_package->number_of_listing - vendorTotalListing($vendorId)) == 1 ? __('listing') : __('listings') }}

                </p>
              @endif
              @if (vendorTotalListing($vendorId) == $current_package->number_of_listing)
                <p class="text-info m-0">{{ __('You reach your limit') }}
                </p>
              @endif
            </li>
            <li class="list-group-item ">
              <div class="d-flex  justify-content-between">
                <span class="text-focus">
                  @if ($dowgraded['listingImgDown'])
                    <i class="fas fa-exclamation-circle text-danger"></i>
                  @endif
                  {{ __('Listing Images (Per Listing)') }} :
                </span>
                <span class="badge badge-primary badge-sm">
                  {{ $current_package->number_of_images_per_listing }}
                </span>

              </div>
              @if ($dowgraded['listingImgDown'])
                <p class="text-warning m-0">{{ __('Limit has been crossed,vendor has to delete') }}
                  {{ __('gallery images') }}
                </p>
              @endif
            </li>
            @if (is_array($permissions) && in_array('Products', $permissions))
              <li class="list-group-item ">
                <div class="d-flex  justify-content-between">
                  <span class="text-focus">
                    @if ($dowgraded['listingProductDown'])
                      <i class="fas fa-exclamation-circle text-danger"></i>
                    @endif
                    {{ __('Products') }} :
                  </span>
                  <span class="badge badge-primary badge-sm">
                    {{ $current_package->number_of_products }}
                  </span>
                </div>
                @if ($dowgraded['listingProductDown'])
                  <p class="text-warning m-0">{{ __('Limit has been crossed, vendor has to delete,products') }}
                  </p>
                @endif
              </li>
            @endif
            @if (is_array($permissions) && in_array('FAQ', $permissions))
              <li class="list-group-item ">
                <div class="d-flex  justify-content-between">
                  <span class="text-focus">
                    @if ($dowgraded['listingFaqDown'])
                      <i class="fas fa-exclamation-circle text-danger"></i>
                    @endif
                    {{ __('Faqs (Per Listing)') }} :
                  </span>
                  <span class="badge badge-primary badge-sm">
                    {{ $current_package->number_of_faq }}
                  </span>
                </div>
                @if ($dowgraded['listingFaqDown'])
                  <p class="text-warning m-0">{{ __('Limit has been crossed, vendor has to delete faqs') }}
                  </p>
                @endif
              </li>
            @endif

            @if (is_array($permissions) && in_array('Feature', $permissions))
              <li class="list-group-item ">
                <div class="d-flex  justify-content-between">
                  <span class="text-focus">
                    @if ($dowgraded['featureDown'])
                      <i class="fas fa-exclamation-circle text-danger"></i>
                    @endif
                    {{ __('Features  (Per Listing)') }} :
                  </span>
                  <span class="badge badge-primary badge-sm">
                    {{ $current_package->number_of_additional_specification }}
                  </span>
                </div>
                @if ($dowgraded['featureDown'])
                  <p class="text-warning m-0">{{ __('Limit has been crossed, vendor has to delete Specifications') }}
                  </p>
                @endif
              </li>
            @endif

            @if (is_array($permissions) && in_array('Social Links', $permissions))
              <li class="list-group-item ">
                <div class="d-flex  justify-content-between">
                  <span class="text-focus">
                    @if ($dowgraded['socialLinkDown'])
                      <i class="fas fa-exclamation-circle text-danger"></i>
                    @endif
                    {{ __('Socail Links (Per Listing)') }} :
                  </span>
                  <span class="badge badge-primary badge-sm">
                    {{ $current_package->number_of_social_links }}
                  </span>
                </div>
                @if ($dowgraded['socialLinkDown'])
                  <p class="text-warning m-0">{{ __('Limit has been crossed, vendor has to delete Social Links') }}
                  </p>
                @endif
              </li>
            @endif

            @if (is_array($permissions) && in_array('Amenities', $permissions))
              <li class="list-group-item ">
                <div class="d-flex  justify-content-between">
                  <span class="text-focus">
                    @if ($dowgraded['amenitieDown'])
                      <i class="fas fa-exclamation-circle text-danger"></i>
                    @endif
                    {{ __('Amenities (Per Listing)') }} :
                  </span>
                  <span class="badge badge-primary badge-sm">
                    {{ $current_package->number_of_amenities_per_listing }}
                  </span>
                </div>
                @if ($dowgraded['amenitieDown'])
                  <p class="text-warning m-0">{{ __('Limit has been crossed, vendor has to delete Amenities') }}
                  </p>
                @endif
              </li>
            @endif

            @if (is_array($permissions) && in_array('Products', $permissions))
              <li class="list-group-item ">
                <div class="d-flex  justify-content-between">
                  <span class="text-focus">
                    @if ($dowgraded['listingProductImgDown'])
                      <i class="fas fa-exclamation-circle text-danger"></i>
                    @endif
                    {{ __('Product Images Per Product') }} :
                  </span>
                  <span class="badge badge-primary badge-sm">
                    {{ $current_package->number_of_images_per_products }}
                  </span>
                </div>
                @if ($dowgraded['listingProductImgDown'])
                  <p class="text-warning m-0">{{ __('Limit has been crossed, vendor has to delete') }}
                    {{ __('gallery images') }}
                  </p>
                @endif
              </li>
            @endif
          </ul>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">{{ __('Close') }}</button>
        </div>
      </div>
    </div>
  </div>
@endif
