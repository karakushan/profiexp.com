 @php
   $vendorId = Auth::guard('vendor')->user()->id;
   $current_package = App\Http\Helpers\VendorPermissionHelper::packagePermission($vendorId);
   $today = \Carbon\Carbon::now()->toDateString();
   $aiMembership = \App\Models\Membership::query()
       ->select([
           'ai_engine',
           'ai_token_limit',
           'ai_image_limit',
           'ai_used_tokens',
           'ai_used_images',
           'ai_token_purchased',
           'ai_image_purchased',
       ])
       ->where([
           ['vendor_id', $vendorId],
           ['start_date', '<=', $today],
           ['expire_date', '>=', $today],
           ['status', 1],
       ])
       ->whereYear('start_date', '<>', '9999')
       ->first();

   $aiEngine = $aiMembership?->ai_engine;
   $aiUsedTokens = max(0, (int) ($aiMembership?->ai_used_tokens ?? 0));
   $aiTokenLimit = max(0, (int) ($aiMembership?->ai_token_limit ?? 0));
   $aiTokenPurchased = max(0, (int) ($aiMembership?->ai_token_purchased ?? 0));
   $aiTokenTotalLimit = $aiTokenLimit + $aiTokenPurchased;

   $aiUsedImages = max(0, (int) ($aiMembership?->ai_used_images ?? 0));
   $aiImageLimit = max(0, (int) ($aiMembership?->ai_image_limit ?? 0));
   $aiImagePurchased = max(0, (int) ($aiMembership?->ai_image_purchased ?? 0));
   $aiImageTotalLimit = $aiImageLimit + $aiImagePurchased;

   if (!empty($current_package) && !empty($current_package->features)) {
       $permissions = json_decode($current_package->features, true);
   } else {
       $permissions = null;
   }

 @endphp
 @if ($current_package != '[]')

   <div class="modal fade" id="checkLimitModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
               class="text-warning">{{ __("If any feature has crossed its current subscription package's limit, then you won't be able to add/edit any other feature") . '.' }}</span>
           </div>
           <ul class="list-group list-group-bordered">

            @php
              $aiTokenTotalLabel = $aiTokenTotalLimit < 999999 ? $aiTokenTotalLimit : __('Unlimited');
              $aiImageTotalLabel = $aiImageTotalLimit < 999999 ? $aiImageTotalLimit : __('Unlimited');
            @endphp

                        <li class="list-group-item border">
              <div class="d-flex justify-content-between">
                <span class="ai-tooltip" tabindex="0">
                  {{ __('AI Engine') }} :
                  <span class="ai-tooltip-box" role="tooltip">
                    <ul class="ai-tooltip-list">
                      <li>{{ __('Total Tokens') }}: {{ $aiTokenTotalLabel }}</li>
                      <li>{{ __('Used Tokens') }}: {{ $aiUsedTokens }}</li>
                      <li>{{ __('Total Images') }}: {{ $aiImageTotalLabel }}</li>
                      <li>{{ __('Used Images') }}: {{ $aiUsedImages }}</li>
                    </ul>
                  </span>
                </span>
                <span class="badge badge-info badge-sm">
                  {{ $aiEngine ? strtoupper($aiEngine) : __('N/A') }}
                </span>
              </div>
            </li>
            <li class="list-group-item border">
              <div class="d-flex justify-content-between">
                <span class="ai-tooltip" tabindex="0">
                  {{ __('AI Total Tokens') }} :
                  <span class="ai-tooltip-box" role="tooltip">
                    <ul class="ai-tooltip-list">
                      <li>{{ __('Total Tokens') }}: {{ $aiTokenTotalLabel }}</li>
                      <li>{{ __('Used Tokens') }}: {{ $aiUsedTokens }}</li>
                    </ul>
                  </span>
                </span>
                <span class="badge badge-primary badge-sm">
                  {{ $aiUsedTokens }}/{{ $aiTokenTotalLabel }}
                </span>
              </div>
            </li>
            <li class="list-group-item border">
              <div class="d-flex justify-content-between">
                <span class="ai-tooltip" tabindex="0">
                  {{ __('AI Generated Total Images') }} :
                  <span class="ai-tooltip-box" role="tooltip">
                    <ul class="ai-tooltip-list">
                      <li>{{ __('Total Images') }}: {{ $aiImageTotalLabel }}</li>
                      <li>{{ __('Used Images') }}: {{ $aiUsedImages }}</li>
                    </ul>
                  </span>
                </span>
                <span class="badge badge-primary badge-sm">
                  {{ $aiUsedImages }}/{{ $aiImageTotalLabel }}
                </span>
              </div>
            </li>

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
                 <p class="text-warning m-0">{{ __('Limit has been crossed, you have to delete') }}
                   {{ abs($current_package->number_of_listing - vendorTotalListing($vendorId)) }}
                   {{ abs($current_package->number_of_listing - vendorTotalListing($vendorId)) == 1 ? 'listing' : 'listings' }}
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
                   @if ($listingImgDown)
                     <i class="fas fa-exclamation-circle text-danger"></i>
                   @endif
                   {{ __('Listing Images (Per Listing)') }} :
                 </span>
                 @if ($listingImgDown)
                   <button type="button" class="btn  btn-danger mr-2  btn-sm btn-round" data-toggle="modal"
                     data-target="#listingImgDownModal">
                     {{ __('Remove') }}
                   </button>
                 @else
                   <span class="badge badge-primary badge-sm">
                     {{ $current_package->number_of_images_per_listing }}
                   </span>
                 @endif
               </div>
               @if ($listingImgDown)
                 <p class="text-warning m-0">{{ __('Limit has been crossed, you have to delete') }}
                   {{ __('gallery images') }}
                 </p>
               @endif
             </li>
             @if (is_array($permissions) && in_array('Products', $permissions))
               <li class="list-group-item ">
                 <div class="d-flex  justify-content-between">
                   <span class="text-focus">
                     @if ($listingProductDown)
                       <i class="fas fa-exclamation-circle text-danger"></i>
                     @endif
                     {{ __('Products') }} :
                   </span>
                   @if ($listingProductDown)
                     <button type="button" class="btn  btn-danger mr-2  btn-sm btn-round" data-toggle="modal"
                       data-target="#listingProductDownModal">
                       {{ __('Remove') }}
                     </button>
                   @else
                     <span class="badge badge-primary badge-sm">
                       {{ $current_package->number_of_products }}
                     </span>
                   @endif
                 </div>
                 @if ($listingProductDown)
                   <p class="text-warning m-0">{{ __('Limit has been crossed, you have to delete,products') }}
                   </p>
                 @endif
               </li>
             @endif
             @if (is_array($permissions) && in_array('FAQ', $permissions))
               <li class="list-group-item ">
                 <div class="d-flex  justify-content-between">
                   <span class="text-focus">
                     @if ($listingFaqDown)
                       <i class="fas fa-exclamation-circle text-danger"></i>
                     @endif
                     {{ __('Faqs (Per Listing)') }} :
                   </span>
                   @if ($listingFaqDown)
                     <button type="button" class="btn  btn-danger mr-2  btn-sm btn-round" data-toggle="modal"
                       data-target="#listingFaqDownModal">
                       {{ __('Remove') }}
                     </button>
                   @else
                     <span class="badge badge-primary badge-sm">
                       {{ $current_package->number_of_faq }}
                     </span>
                   @endif
                 </div>
                 @if ($listingFaqDown)
                   <p class="text-warning m-0">{{ __('Limit has been crossed, you have to delete faqs') }}
                   </p>
                 @endif
               </li>
             @endif

             @if (is_array($permissions) && in_array('Feature', $permissions))
               <li class="list-group-item ">
                 <div class="d-flex  justify-content-between">
                   <span class="text-focus">
                     @if ($featureDown)
                       <i class="fas fa-exclamation-circle text-danger"></i>
                     @endif
                     {{ __('Features  (Per Listing)') }} :
                   </span>
                   @if ($featureDown)
                     <button type="button" class="btn  btn-danger mr-2  btn-sm btn-round" data-toggle="modal"
                       data-target="#listingFeatureDownModal">
                       {{ __('Remove') }}
                     </button>
                   @else
                     <span class="badge badge-primary badge-sm">
                       {{ $current_package->number_of_additional_specification }}
                     </span>
                   @endif
                 </div>
                 @if ($featureDown)
                   <p class="text-warning m-0">{{ __('Limit has been crossed, you have to delete Specifications') }}
                   </p>
                 @endif
               </li>
             @endif

             @if (is_array($permissions) && in_array('Social Links', $permissions))

               <li class="list-group-item ">
                 <div class="d-flex  justify-content-between">
                   <span class="text-focus">
                     @if ($socialLinkDown)
                       <i class="fas fa-exclamation-circle text-danger"></i>
                     @endif
                     {{ __('Social Links Per Listing') }} :
                   </span>
                   @if ($socialLinkDown)
                     <button type="button" class="btn  btn-danger mr-2  btn-sm btn-round" data-toggle="modal"
                       data-target="#listingSocialDownModal">
                       {{ __('Remove') }}
                     </button>
                   @else
                     <span class="badge badge-primary badge-sm">
                       {{ $current_package->number_of_social_links }}
                     </span>
                   @endif
                 </div>
                 @if ($socialLinkDown)
                   <p class="text-warning m-0">{{ __('Limit has been crossed, you have to delete Social Links') }}
                   </p>
                 @endif
               </li>
             @endif

             @if (is_array($permissions) && in_array('Amenities', $permissions))
               <li class="list-group-item ">
                 <div class="d-flex  justify-content-between">
                   <span class="text-focus">
                     @if ($amenitieDown)
                       <i class="fas fa-exclamation-circle text-danger"></i>
                     @endif
                     {{ __('Amenities (Per Listing)') }} :
                   </span>
                   @if ($amenitieDown)
                     <button type="button" class="btn  btn-danger mr-2  btn-sm btn-round" data-toggle="modal"
                       data-target="#listingamenitiesDownModal">
                       {{ __('Remove') }}
                     </button>
                   @else
                     <span class="badge badge-primary badge-sm">
                       {{ $current_package->number_of_amenities_per_listing }}
                     </span>
                   @endif
                 </div>
                 @if ($amenitieDown)
                   <p class="text-warning m-0">{{ __('Limit has been crossed, you have to delete Amenities') }}
                   </p>
                 @endif
               </li>
             @endif

             @if (is_array($permissions) && in_array('Products', $permissions))
               <li class="list-group-item ">
                 <div class="d-flex  justify-content-between">
                   <span class="text-focus">
                     @if ($listingProductImgDown)
                       <i class="fas fa-exclamation-circle text-danger"></i>
                     @endif
                     {{ __('Product Images Per Product') }} :
                   </span>
                   @if ($listingProductImgDown)
                     <button type="button" class="btn  btn-danger mr-2  btn-sm btn-round" data-toggle="modal"
                       data-target="#listingProductImgDownModal">
                       {{ __('Remove') }}
                     </button>
                   @else
                     <span class="badge badge-primary badge-sm">
                       {{ $current_package->number_of_images_per_products }}
                     </span>
                   @endif
                 </div>
                 @if ($listingProductImgDown)
                   <p class="text-warning m-0">{{ __('Limit has been crossed, you have to delete') }}
                     {{ __('gallery images') }}
                   </p>
                 @endif
               </li>
             @endif

           </ul>
         </div>
         <div class="modal-footer">
           <button type="button" class="btn btn-secondary"
             data-dismiss="modal">{{ $keywords['Close'] ?? __('Close') }}</button>

         </div>
       </div>
     </div>
   </div>
   <div class="modal fade" id="listingImgDownModal" tabindex="-1" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
     <div class="modal-dialog modal-dialog-centered">
       <div class="modal-content">
         <div class="modal-header">
           <h3 class="modal-title card-title" id="exampleModalLabel">
             {{ __('Remove Image from the below listings') }}</h3>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close">
             <span aria-hidden="true">&times;</span>
           </button>
         </div>
         <div class="modal-body">
           <ul class="list-group list-group-bordered">
             @foreach ($listingImgListingContents as $listing)
               <li class="list-group-item p-0">
                 <a href="{{ route('vendor.listing_management.edit_listing', ['id' => $listing->id]) }}"
                   class="dropdown-item">
                   <div class="d-flex">
                     <span>
                       {{ strlen(@$listing->title) > 50 ? mb_substr(@$listing->title, 0, 50, 'utf-8') . '.....' : @$listing->title }}
                     </span>
                     <span>
                       <i class="far fa-link"></i>
                     </span>
                   </div>
                 </a>
               </li>
             @endforeach
           </ul>
         </div>
         <div class="modal-footer">
           <button type="button" class="btn btn-secondary"
             data-dismiss="modal">{{ $keywords['Close'] ?? __('Close') }}</button>
         </div>
       </div>
     </div>
   </div>
   @if (is_array($permissions) && in_array('Products', $permissions))
     <div class="modal fade" id="listingProductImgDownModal" tabindex="-1" aria-labelledby="exampleModalLabel"
       aria-hidden="true">
       <div class="modal-dialog modal-dialog-centered">
         <div class="modal-content">
           <div class="modal-header">
             <h3 class="modal-title card-title" id="exampleModalLabel">
               {{ __('Remove Images from the below products') }}</h3>
             <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
             </button>
           </div>
           <div class="modal-body">
             <ul class="list-group list-group-bordered">
               @foreach ($ProductImgContents as $product)
                 <li class="list-group-item p-0">
                   <a href="{{ route('vendor.listing_management.edit_product', ['id' => $product->id]) }}"
                     class="dropdown-item">
                     <div class="d-flex">
                       <span>
                         {{ strlen(@$product->title) > 50 ? mb_substr(@$product->title, 0, 50, 'utf-8') . '.....' : @$product->title }}
                       </span>
                       <span>
                         <i class="far fa-link"></i>
                       </span>
                     </div>
                   </a>
                 </li>
               @endforeach
             </ul>
           </div>
           <div class="modal-footer">
             <button type="button" class="btn btn-secondary"
               data-dismiss="modal">{{ $keywords['Close'] ?? __('Close') }}</button>
           </div>
         </div>
       </div>
     </div>
   @endif
   @if (is_array($permissions) && in_array('Products', $permissions))
     <div class="modal fade" id="listingProductDownModal" tabindex="-1" aria-labelledby="exampleModalLabel"
       aria-hidden="true">
       <div class="modal-dialog modal-dialog-centered">
         <div class="modal-content">
           <div class="modal-header">
             <h3 class="modal-title card-title" id="exampleModalLabel">
               {{ __('Remove products from the below listings') }}</h3>
             <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
             </button>
           </div>
           <div class="modal-body">
             <ul class="list-group list-group-bordered">
               @foreach ($listingProductListingContents as $listing)
                 <li class="list-group-item p-0">
                   <a href="{{ route('vendor.listing_management.listing.products', ['id' => $listing->id, 'language' => $defaultLang->code]) }}"
                     class="dropdown-item">
                     <div class="d-flex">
                       <span>
                         {{ strlen(@$listing->title) > 50 ? mb_substr(@$listing->title, 0, 50, 'utf-8') . '.....' : @$listing->title }}
                       </span>
                       <span>
                         <i class="far fa-link"></i>
                       </span>
                     </div>
                   </a>
                 </li>
               @endforeach
             </ul>
           </div>
           <div class="modal-footer">
             <button type="button" class="btn btn-secondary"
               data-dismiss="modal">{{ $keywords['Close'] ?? __('Close') }}</button>
           </div>
         </div>
       </div>
     </div>
   @endif
   @if (is_array($permissions) && in_array('FAQ', $permissions))
     <div class="modal fade" id="listingFaqDownModal" tabindex="-1" aria-labelledby="exampleModalLabel"
       aria-hidden="true">
       <div class="modal-dialog modal-dialog-centered">
         <div class="modal-content">
           <div class="modal-header">
             <h3 class="modal-title card-title" id="exampleModalLabel">
               {{ __('Remove faqs from the below listings') }}</h3>
             <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
             </button>
           </div>
           <div class="modal-body">
             <ul class="list-group list-group-bordered">
               @foreach ($listingFaqListingContents as $listing)
                 <li class="list-group-item p-0">
                   <a href="{{ route('vendor.listing_management.listing.faq', ['id' => $listing->id, 'language' => $defaultLang->code]) }}"
                     class="dropdown-item">
                     <div class="d-flex">
                       <span>
                         {{ strlen(@$listing->title) > 50 ? mb_substr(@$listing->title, 0, 50, 'utf-8') . '.....' : @$listing->title }}
                       </span>
                       <span>
                         <i class="far fa-link"></i>
                       </span>
                     </div>
                   </a>
                 </li>
               @endforeach
             </ul>
           </div>
           <div class="modal-footer">
             <button type="button" class="btn btn-secondary"
               data-dismiss="modal">{{ $keywords['Close'] ?? __('Close') }}</button>
           </div>
         </div>
       </div>
     </div>
   @endif
   @if (is_array($permissions) && in_array('Feature', $permissions))
     <div class="modal fade" id="listingFeatureDownModal" tabindex="-1" aria-labelledby="exampleModalLabel"
       aria-hidden="true">
       <div class="modal-dialog modal-dialog-centered">
         <div class="modal-content">
           <div class="modal-header">
             <h3 class="modal-title card-title" id="exampleModalLabel">
               {{ __('Remove feature from the below listings') }}</h3>
             <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
             </button>
           </div>
           <div class="modal-body">
             <ul class="list-group list-group-bordered">
               @foreach ($listingFeaturesListingContents as $listing)
                 <li class="list-group-item p-0">
                   <a href="{{ route('vendor.listing_management.manage_additional_specifications', ['id' => $listing->id]) }}"
                     class="dropdown-item">
                     <div class="d-flex">
                       <span>
                         {{ strlen(@$listing->title) > 50 ? mb_substr(@$listing->title, 0, 50, 'utf-8') . '.....' : @$listing->title }}
                       </span>
                       <span>
                         <i class="far fa-link"></i>
                       </span>
                     </div>
                   </a>
                 </li>
               @endforeach
             </ul>
           </div>
           <div class="modal-footer">
             <button type="button" class="btn btn-secondary"
               data-dismiss="modal">{{ $keywords['Close'] ?? __('Close') }}</button>
           </div>
         </div>
       </div>
     </div>
   @endif
   @if (is_array($permissions) && in_array('Social Links', $permissions))
     <div class="modal fade" id="listingSocialDownModal" tabindex="-1" aria-labelledby="exampleModalLabel"
       aria-hidden="true">
       <div class="modal-dialog modal-dialog-centered">
         <div class="modal-content">
           <div class="modal-header">
             <h3 class="modal-title card-title" id="exampleModalLabel">
               {{ __('Remove socail link from the below listings') }}</h3>
             <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
             </button>
           </div>
           <div class="modal-body">
             <ul class="list-group list-group-bordered">
               @foreach ($socialListingContents as $listing)
                 <li class="list-group-item p-0">
                   <a href="{{ route('vendor.listing_management.manage_social_link', ['id' => $listing->id]) }}"
                     class="dropdown-item">
                     <div class="d-flex">
                       <span>
                         {{ strlen(@$listing->title) > 50 ? mb_substr(@$listing->title, 0, 50, 'utf-8') . '.....' : @$listing->title }}
                       </span>
                       <span>
                         <i class="far fa-link"></i>
                       </span>
                     </div>
                   </a>
                 </li>
               @endforeach
             </ul>
           </div>
           <div class="modal-footer">
             <button type="button" class="btn btn-secondary"
               data-dismiss="modal">{{ $keywords['Close'] ?? __('Close') }}</button>
           </div>
         </div>
       </div>
     </div>
   @endif
   @if (is_array($permissions) && in_array('Amenities', $permissions))
     <div class="modal fade" id="listingamenitiesDownModal" tabindex="-1" aria-labelledby="exampleModalLabel"
       aria-hidden="true">
       <div class="modal-dialog modal-dialog-centered">
         <div class="modal-content">
           <div class="modal-header">
             <h3 class="modal-title card-title" id="exampleModalLabel">
               {{ __('Remove amenities from the below listings') }}</h3>
             <button type="button" class="close" data-dismiss="modal" aria-label="Close">
               <span aria-hidden="true">&times;</span>
             </button>
           </div>
           <div class="modal-body">
             <ul class="list-group list-group-bordered">
               @foreach ($amenitieListingContents as $listing)
                 <li class="list-group-item p-0">
                   <a href="{{ route('vendor.listing_management.edit_listing', ['id' => $listing->id]) }}"
                     class="dropdown-item">
                     <div class="d-flex">
                       <span>
                         {{ strlen(@$listing->title) > 50 ? mb_substr(@$listing->title, 0, 50, 'utf-8') . '.....' : @$listing->title }}
                       </span>
                       <span>
                         <i class="far fa-link"></i>
                       </span>
                     </div>
                   </a>
                 </li>
               @endforeach
             </ul>
           </div>
           <div class="modal-footer">
             <button type="button" class="btn btn-secondary"
               data-dismiss="modal">{{ $keywords['Close'] ?? __('Close') }}</button>
           </div>
         </div>
       </div>
     </div>
   @endif
 @endif
