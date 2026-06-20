@extends('vendors.layout')
@php
  $vendorId = Auth::guard('vendor')->user()->id;
  if ($vendorId) {
      $current_package = App\Http\Helpers\VendorPermissionHelper::packagePermission($vendorId);
      $listingCanAdd = packageTotalListing($vendorId) - vendorTotalListing($vendorId);

      if (!empty($current_package) && !empty($current_package->features)) {
          $permissions = json_decode($current_package->features, true);
      }
  }
  $requiredPermissions = ['Messenger', 'WhatsApp', 'Telegram', 'Tawk.To'];
  $intersection = array_intersect($permissions, $requiredPermissions);
  $count = count($intersection);
@endphp

@section('content')
  <div class="page-header">
    <h4 class="page-title">
      @if ($count == 1)
        {{ __('Plugin') }}
      @else
        {{ __('Plugins') }}
      @endif
    </h4>
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
        <a href="{{ route('vendor.listing_management.listings') }}">{{ __('Listings Management') }}</a>
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
        <a href="#">
          @if ($count == 1)
            {{ __('Plugin') }}
          @else
            {{ __('Plugins') }}
          @endif
        </a>
      </li>
    </ul>
  </div>

  <div class="card">
    <div class="card-header">
      <div class="card-title d-inline-block">
        @if ($count == 1)
          {{ __('Plugin') }}
        @else
          {{ __('Plugins') }}
        @endif
      </div>
      <a class="btn btn-info btn-sm float-right d-inline-block"
        href="{{ route('vendor.listing_management.listings', ['language' => $defaultLang->code]) }}">
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
    </div>

    <div class="card-body">
      <div class="row">
        @if (is_array($permissions) && in_array('Tawk.To', $permissions))
          <div class="col-lg-4">
            <div class="card">
              <form action="{{ route('vendor.listing_management.listing.update_tawkto', ['id' => $id]) }}"
                method="post">
                @csrf
                <div class="card-header">
                  <div class="row">
                    <div class="col-lg-12">
                      <div class="card-title">{{ __('Tawk.To') }}</div>
                    </div>
                  </div>
                </div>

                <div class="card-body">
                  <div class="row">
                    <div class="col-lg-12">
                      <div class="form-group">
                        <label>{{ __('Tawk.To Status') . '*' }}</label>
                        <div class="selectgroup w-100">
                          <label class="selectgroup-item">
                            <input type="radio" name="tawkto_status" value="1" class="selectgroup-input"
                              {{ $data->tawkto_status == 1 ? 'checked' : '' }}>
                            <span class="selectgroup-button">{{ __('Active') }}</span>
                          </label>

                          <label class="selectgroup-item">
                            <input type="radio" name="tawkto_status" value="0" class="selectgroup-input"
                              {{ $data->tawkto_status == 0 ? 'checked' : '' }}>
                            <span class="selectgroup-button">{{ __('Deactive') }}</span>
                          </label>
                        </div>

                        @if ($errors->has('tawkto_status'))
                          <p class="mt-1 mb-0 text-danger">{{ $errors->first('tawkto_status') }}</p>
                        @endif
                      </div>

                      <div class="form-group">
                        <label>{{ __('Tawk.To Direct Chat Link') . '*' }}</label>
                        <input type="text" class="form-control" name="tawkto_direct_chat_link"
                          value="{{ $data->tawkto_direct_chat_link }}">

                        @if ($errors->has('tawkto_direct_chat_link'))
                          <p class="mt-1 mb-0 text-danger">{{ $errors->first('tawkto_direct_chat_link') }}</p>
                        @endif
                      </div>
                    </div>
                  </div>
                </div>

                <div class="card-footer">
                  <div class="row">
                    <div class="col-12 text-center">
                      @if (
                          $listingFaqDown ||
                              $listingProductDown ||
                              $listingImgDown ||
                              $featureDown ||
                              $socialLinkDown ||
                              $amenitieDown ||
                              $listingProductImgDown ||
                              $listingCanAdd < 0)
                        <button type="button" class="btn btn-success updateButton" data-toggle="modal"
                          data-target="#checkLimitModal">
                          {{ __('Update') }}
                        </button>
                      @else
                        <button type="submit" class="btn btn-success">
                          {{ __('Update') }}
                        </button>
                      @endif
                    </div>
                  </div>
                </div>
              </form>
            </div>
          </div>
        @endif

        @if (is_array($permissions) && in_array('Telegram', $permissions))
          <div class="col-lg-4">
            <div class="card">
              <form action="{{ route('vendor.listing_management.listing.update_telegram', ['id' => $id]) }}"
                method="post">
                @csrf
                <div class="card-header">
                  <div class="row">
                    <div class="col-lg-12">
                      <div class="card-title">{{ __('Telegram') }}</div>
                    </div>
                  </div>
                </div>

                <div class="card-body">
                  <div class="row">
                    <div class="col-lg-12">
                      <div class="form-group">
                        <label>{{ __('Telegram Status') . '*' }}</label>
                        <div class="selectgroup w-100">
                          <label class="selectgroup-item">
                            <input type="radio" name="telegram_status" value="1" class="selectgroup-input"
                              {{ $data->telegram_status == 1 ? 'checked' : '' }}>
                            <span class="selectgroup-button">{{ __('Active') }}</span>
                          </label>

                          <label class="selectgroup-item">
                            <input type="radio" name="telegram_status" value="0" class="selectgroup-input"
                              {{ $data->telegram_status == 0 ? 'checked' : '' }}>
                            <span class="selectgroup-button">{{ __('Deactive') }}</span>
                          </label>
                        </div>

                        @if ($errors->has('telegram_status'))
                          <p class="mt-1 mb-0 text-danger">{{ $errors->first('telegram_status') }}</p>
                        @endif
                      </div>

                      <div class="form-group">
                        <label>{{ __('Telegram Username') . '*' }}</label>
                        <input type="text" class="form-control" name="telegram_username"
                          value="{{ $data->telegram_username }}">

                        @if ($errors->has('telegram_username'))
                          <p class="mt-1 mb-0 text-danger">{{ $errors->first('telegram_username') }}</p>
                        @endif
                      </div>
                    </div>
                  </div>
                </div>

                <div class="card-footer">
                  <div class="row">
                    <div class="col-12 text-center">
                      @if (
                          $listingFaqDown ||
                              $listingProductDown ||
                              $listingImgDown ||
                              $featureDown ||
                              $socialLinkDown ||
                              $amenitieDown ||
                              $listingProductImgDown ||
                              $listingCanAdd < 0)
                        <button type="button" class="btn btn-success updateButton" data-toggle="modal"
                          data-target="#checkLimitModal">
                          {{ __('Update') }}
                        </button>
                      @else
                        <button type="submit" class="btn btn-success">
                          {{ __('Update') }}
                        </button>
                      @endif
                    </div>
                  </div>
                </div>
              </form>
            </div>
          </div>
        @endif

        @if (is_array($permissions) && in_array('Messenger', $permissions))
          <div class="col-lg-4">
            <div class="card">
              <form action="{{ route('vendor.listing_management.listing.update_messenger', ['id' => $id]) }}"
                method="post">
                @csrf
                <div class="card-header">
                  <div class="row">
                    <div class="col-lg-12">
                      <div class="card-title">{{ __('Messenger') }}</div>
                    </div>
                  </div>
                </div>

                <div class="card-body">
                  <div class="row">
                    <div class="col-lg-12">
                      <div class="form-group">
                        <label>{{ __('Messenger Status') . '*' }}</label>
                        <div class="selectgroup w-100">
                          <label class="selectgroup-item">
                            <input type="radio" name="messenger_status" value="1" class="selectgroup-input"
                              {{ $data->messenger_status == 1 ? 'checked' : '' }}>
                            <span class="selectgroup-button">{{ __('Active') }}</span>
                          </label>

                          <label class="selectgroup-item">
                            <input type="radio" name="messenger_status" value="0" class="selectgroup-input"
                              {{ $data->messenger_status == 0 ? 'checked' : '' }}>
                            <span class="selectgroup-button">{{ __('Deactive') }}</span>
                          </label>
                        </div>

                        @if ($errors->has('messenger_status'))
                          <p class="mt-1 mb-0 text-danger">{{ $errors->first('messenger_status') }}</p>
                        @endif
                      </div>

                      <div class="form-group">
                       <label>{{ __('Messenger Direct Chat Link') . '*' }}</label>
                        <input type="text" class="form-control" name="messenger_direct_chat_link"
                          value="{{ $data->messenger_direct_chat_link }}">

                        @if ($errors->has('messenger_direct_chat_link'))
                          <p class="mt-1 mb-0 text-danger">{{ $errors->first('messenger_direct_chat_link') }}</p>
                        @endif
                      </div>
                    </div>
                  </div>
                </div>

                <div class="card-footer">
                  <div class="row">
                    <div class="col-12 text-center">
                      @if (
                          $listingFaqDown ||
                              $listingProductDown ||
                              $listingImgDown ||
                              $featureDown ||
                              $socialLinkDown ||
                              $amenitieDown ||
                              $listingProductImgDown ||
                              $listingCanAdd < 0)
                        <button type="button" class="btn btn-success updateButton" data-toggle="modal"
                          data-target="#checkLimitModal">
                          {{ __('Update') }}
                        </button>
                      @else
                        <button type="submit" class="btn btn-success">
                          {{ __('Update') }}
                        </button>
                      @endif
                    </div>
                  </div>
                </div>
              </form>
            </div>
          </div>
        @endif

        @if (is_array($permissions) && in_array('WhatsApp', $permissions))
          <div class="col-lg-4">
            <div class="card">
              <form action="{{ route('vendor.listing_management.listing.update_whatsapp', ['id' => $id]) }}"
                method="post">
                @csrf
                <div class="card-header">
                  <div class="row">
                    <div class="col-lg-12">
                      <div class="card-title">{{ __('WhatsApp') }}</div>
                    </div>
                  </div>
                </div>

                <div class="card-body">
                  <div class="row">
                    <div class="col-lg-12">
                      <div class="form-group">
                        <label>{{ __('WhatsApp Status') . '*' }}</label>
                        <div class="selectgroup w-100">
                          <label class="selectgroup-item">
                            <input type="radio" name="whatsapp_status" value="1" class="selectgroup-input"
                              {{ $data->whatsapp_status == 1 ? 'checked' : '' }}>
                            <span class="selectgroup-button">{{ __('Active') }}</span>
                          </label>

                          <label class="selectgroup-item">
                            <input type="radio" name="whatsapp_status" value="0" class="selectgroup-input"
                              {{ $data->whatsapp_status == 0 ? 'checked' : '' }}>
                            <span class="selectgroup-button">{{ __('Deactive') }}</span>
                          </label>
                        </div>

                        @if ($errors->has('whatsapp_status'))
                          <p class="mt-1 mb-0 text-danger">{{ $errors->first('whatsapp_status') }}</p>
                        @endif
                      </div>

                      <div class="form-group">
                        <label>{{ __('WhatsApp Number') . '*' }}</label>
                        <input type="text" class="form-control" name="whatsapp_number"
                          value="{{ $data->whatsapp_number }}">

                        @if ($errors->has('whatsapp_number'))
                          <p class="mt-1 mb-0 text-danger">{{ $errors->first('whatsapp_number') }}</p>
                        @endif
                      </div>

                      <div class="form-group">
                        <label>{{ __('WhatsApp Header Title') . '*' }}</label>
                        <input type="text" class="form-control" name="whatsapp_header_title"
                          value="{{ $data->whatsapp_header_title }}">

                        @if ($errors->has('whatsapp_header_title'))
                          <p class="mt-1 mb-0 text-danger">{{ $errors->first('whatsapp_header_title') }}</p>
                        @endif
                      </div>

                      <div class="form-group">
                        <label>{{ __('WhatsApp Popup Status') . '*' }}</label>
                        <div class="selectgroup w-100">
                          <label class="selectgroup-item">
                            <input type="radio" name="whatsapp_popup_status" value="1"
                              class="selectgroup-input" {{ $data->whatsapp_popup_status == 1 ? 'checked' : '' }}>
                            <span class="selectgroup-button">{{ __('Active') }}</span>
                          </label>

                          <label class="selectgroup-item">
                            <input type="radio" name="whatsapp_popup_status" value="0"
                              class="selectgroup-input" {{ $data->whatsapp_popup_status == 0 ? 'checked' : '' }}>
                            <span class="selectgroup-button">{{ __('Deactive') }}</span>
                          </label>
                        </div>

                        @if ($errors->has('whatsapp_popup_status'))
                          <p class="mt-1 mb-0 text-danger">{{ $errors->first('whatsapp_popup_status') }}</p>
                        @endif
                      </div>

                      <div class="form-group">
                        <label>{{ __('WhatsApp Popup Message') . '*' }}</label>
                        <textarea class="form-control" name="whatsapp_popup_message" rows="2">{{ $data->whatsapp_popup_message }}</textarea>

                        @if ($errors->has('whatsapp_popup_message'))
                          <p class="mt-1 mb-0 text-danger">{{ $errors->first('whatsapp_popup_message') }}</p>
                        @endif
                      </div>
                    </div>
                  </div>
                </div>

                <div class="card-footer">
                  <div class="row">
                    <div class="col-12 text-center">
                      @if (
                          $listingFaqDown ||
                              $listingProductDown ||
                              $listingImgDown ||
                              $featureDown ||
                              $socialLinkDown ||
                              $amenitieDown ||
                              $listingProductImgDown ||
                              $listingCanAdd < 0)
                        <button type="button" class="btn btn-success updateButton" data-toggle="modal"
                          data-target="#checkLimitModal">
                          {{ __('Update') }}
                        </button>
                      @else
                        <button type="submit" class="btn btn-success">
                          {{ __('Update') }}
                        </button>
                      @endif
                    </div>
                  </div>
                </div>
              </form>
            </div>
          </div>
        @endif
      </div>
    </div>
    <div class="card-footer">

    </div>
  </div>
@endsection
