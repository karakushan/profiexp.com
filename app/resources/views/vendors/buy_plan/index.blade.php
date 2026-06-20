@extends('vendors.layout')
@php
  Config::set('app.timezone', App\Models\BasicSettings\Basic::first()->timezone);
@endphp

@php
  $vendor = Auth::guard('vendor')->user();
  $package = \App\Http\Helpers\VendorPermissionHelper::currentPackagePermission($vendor->id);
@endphp
@section('content')
  @if (is_null($package))
    @php
      $pendingMemb = \App\Models\Membership::query()
          ->where([['vendor_id', '=', $vendor->id], ['status', 0]])
          ->whereYear('start_date', '<>', '9999')
          ->orderBy('id', 'DESC')
          ->first();
      $pendingPackage = isset($pendingMemb) ? \App\Models\Package::query()->findOrFail($pendingMemb->package_id) : null;
    @endphp

    @if ($pendingPackage)
      <div class="alert alert-warning text-dark">
        {{ __('You have requested a package which needs an action (Approval / Rejection) by Admin. You will be notified via mail once an action is taken.') }}
      </div>
      <div class="alert alert-warning text-dark">
        <strong>{{ __('Pending Package') . ':' }} </strong> {{ $pendingPackage->title }}
        <span class="badge badge-secondary">{{ $pendingPackage->term }}</span>
        <span class="badge badge-warning">{{ __('Decision Pending') }}</span>
      </div>
    @else
      @php
        $newMemb = \App\Models\Membership::query()
            ->where([['vendor_id', '=', Auth::id()], ['status', 0]])
            ->first();
      @endphp
      @if ($newMemb)
        <div class="alert alert-warning text-dark">
          {{ __('Your membership is expired. Please purchase a new package / extend the current package.') }}
        </div>
      @endif
      <div class="alert alert-warning text-dark">
        {{ __('Please purchase a new package .') }}
      </div>
    @endif
  @else
    <div class="row justify-content-center align-items-center mb-1">
      <div class="col-12">
        <div class="alert border-left border-primary text-dark">
          @if ($package_count >= 2 && $next_membership)
            @if ($next_membership->status == 0)
              <strong
                class="text-danger">{{ __('You have requested a package which needs an action (Approval / Rejection) by Admin. You will be notified via mail once an action is taken.') }}</strong><br>
            @elseif ($next_membership->status == 1)
              <strong
                class="text-danger">{{ __('You have another package to activate after the current package expires. You cannot purchase / extend any package, until the next package is activated') }}</strong><br>
            @endif
          @endif

          <strong>{{ __('Current Package') . ':' }} </strong> {{ $current_package->title }}
          <span class="badge badge-secondary">{{ __($current_package->term) }}</span>
          @if ($current_membership->is_trial == 1)
            ({{ __('Expire Date') . ':' }}
            {{ Carbon\Carbon::parse($current_membership->expire_date)->format('M-d-Y') }})
            <span class="badge badge-primary">{{ __('Trial') }}</span>
          @else
            ({{ __('Expire Date') . ':' }}
            {{ $current_package->term === 'lifetime' ? __('Lifetime') : Carbon\Carbon::parse($current_membership->expire_date)->format('M-d-Y') }})
          @endif

          @if ($package_count >= 2 && $next_package)
            <div>
              <strong>{{ __('Next Package To Activate') . ':' }} </strong> {{ $next_package->title }} <span
                class="badge badge-secondary">{{ __($next_package->term) }}</span>
              @if ($current_package->term != 'lifetime' && $current_membership->is_trial != 1)
                (
                {{ __('Activation Date') . ':' }}
                {{ Carbon\Carbon::parse($next_membership->start_date)->format('M-d-Y') }},
                {{ __('Expire Date') . ':' }}
                {{ $next_package->term === 'lifetime' ? __('Lifetime') : Carbon\Carbon::parse($next_membership->expire_date)->format('M-d-Y') }})
              @endif
              @if ($next_membership->status == 0)
                <span class="badge badge-warning">{{ __('Decision Pending') }}</span>
              @endif
            </div>
          @endif
        </div>
      </div>
    </div>
  @endif
  <div class="row mb-5 justify-content-center">
    @foreach ($packages as $key => $package)
      @php
        $permissions = $package->features;

        if (!empty($package->features)) {
            $permissions = json_decode($permissions, true);
        }
        $hasAiFeature = is_array($permissions) && in_array('AI Content & Image Generator', $permissions);
      @endphp

      <div class="col-md-3 pr-md-0 mb-5">
        <div class="card-pricing2 @if (isset($current_package->id) && $current_package->id === $package->id) card-success @else card-primary @endif">
          <div class="pricing-header">
            <h3 class="fw-bold d-inline-block">
              {{ $package->title }}
            </h3>
            @if (isset($current_package->id) && $current_package->id === $package->id)
              <h3 class="badge badge-danger d-inline-block float-right ml-2">{{ __('Current') }}</h3>
            @endif
            @if ($package_count >= 2)
              @if ($next_package)
                @if ($next_package->id == $package->id)
                  <h3 class="badge badge-warning d-inline-block float-right ml-2">{{ __('Next') }}</h3>
                @endif
              @endif
            @endif
            <span class="sub-title"></span>
          </div>
          <div class="price-value">
            <div class="value">
              <span class="amount">{{ $package->price == 0 ? 'Free' : format_price($package->price) }}</span>
              @if ($package->term == 'monthly')
                <span class="month">/ {{ __('Monthly') }}</span>
              @elseif($package->term == 'yearly')
                <span class="month">/ {{ __('Yearly') }}</span>
              @elseif($package->term == 'lifetime')
                <span class="month">/ {{ __('Lifetime') }}</span>
              @endif

            </div>
          </div>

          <ul class="pricing-content">
            <li>
              @if ($package->number_of_listing == 999999)
                {{ __('Listing (Unlimited)') }}
              @elseif($package->number_of_listing == 1)
                {{ __('Listing') }} ({{ $package->number_of_listing }})
              @else
                {{ __('Listings') }}({{ $package->number_of_listing }})
              @endif
            </li>

            <li>
              @if ($package->number_of_images_per_listing == 999999)
                {{ __('Images Per Listing (Unlimited)') }}
              @elseif ($package->number_of_images_per_listing == 1)
                {{ __('Image Per Listing') }}({{ $package->number_of_images_per_listing }})
              @else
                {{ __('Image Per Listings') }}({{ $package->number_of_images_per_listing }})
              @endif
            </li>

            @if ($hasAiFeature)
              <li class="vendor-ai-feature-group">
                <div class="vendor-ai-feature-label">{{ __('AI Content & Image Generator') }}</div>
                <ul class="vendor-ai-sublist">
                  @if (filled($package->ai_engine))
                    <li>{{ __('AI Engine') }} : {{ strtoupper($package->ai_engine) }}</li>
                  @endif
                  @if (!is_null($package->ai_token_limit))
                    <li>{{ __('AI Token Limit') }} : {{ $package->ai_token_limit }}</li>
                  @endif
                  @if (!is_null($package->ai_image_limit))
                    <li>{{ __('AI Image Limit') }} : {{ $package->ai_image_limit }}</li>
                  @endif
                </ul>
              </li>
            @else
              <li class="disable">{{ __('AI Content & Image Generator') }}</li>
            @endif

            <li class="@if (is_array($permissions) && !in_array('Listing Enquiry Form', $permissions)) disable @endif">{{ __('Listing Enquiry Form') }}
            </li>

            <li class="@if (is_array($permissions) && !in_array('Video', $permissions)) disable @endif">{{ __('Video') }}</li>

            <li class="@if (is_array($permissions) && !in_array('Amenities', $permissions)) disable @endif">
              @if (is_array($permissions) && in_array('Amenities', $permissions))
                @if ($package->number_of_amenities_per_listing == 999999)
                  {{ __('Amenities Per Listing(Unlimited)') }}
                @elseif($package->number_of_amenities_per_listing == 1)
                  {{ __('Amenitie Per Listing') }}({{ $package->number_of_amenities_per_listing }})
                @else
                  {{ __('Amenities Per Listing') }}({{ $package->number_of_amenities_per_listing }})
                @endif
              @else
                {{ __('Amenities Per Listing') }}
              @endif
            </li>

            <li class="@if (is_array($permissions) && !in_array('Feature', $permissions)) disable @endif">
              @if (is_array($permissions) && in_array('Feature', $permissions))
                @if ($package->number_of_additional_specification == 999999)
                  {{ __('Feature Per Listing (Unlimited)') }}
                @elseif($package->number_of_additional_specification == 1)
                  {{ __('Feature Per Listing') }} ({{ $package->number_of_additional_specification }})
                @else
                  {{ __('Features Per Listing') }} ({{ $package->number_of_additional_specification }})
                @endif
              @else
                {{ __('Feature Per Listing') }}
              @endif
            </li>
            <li class="@if (is_array($permissions) && !in_array('Social Links', $permissions)) disable @endif">
              @if (is_array($permissions) && in_array('Social Links', $permissions))
                @if ($package->number_of_social_links == 999999)
                  {{ __('Social Links Per Listing(Unlimited)') }}
                @elseif($package->number_of_social_links == 1)
                  {{ __('Social Link Per Listing') }}({{ $package->number_of_social_links }})
                @else
                  {{ __('Social Links Per Listing') }} ({{ $package->number_of_social_links }})
                @endif
              @else
                {{ __('Social Link Per Listing') }}
              @endif
            </li>
            <li class="@if (is_array($permissions) && !in_array('FAQ', $permissions)) disable @endif">
              @if (is_array($permissions) && in_array('FAQ', $permissions))
                @if ($package->number_of_faq == 999999)
                  {{ __('FAQs Per Listing(Unlimited)') }}
                @elseif($package->number_of_faq == 1)
                  {{ __('FAQ Per Listing') }} ({{ $package->number_of_faq }})
                @else
                  {{ __('FAQs Per Listing') }} ({{ $package->number_of_faq }})
                @endif
              @else
                {{ __('FAQ Per Listing') }}
              @endif
            </li>

            <li class="@if (is_array($permissions) && !in_array('Business Hours', $permissions)) disable @endif">
              {{ __('Business Hours') }}
            </li>

            <li class="@if (is_array($permissions) && !in_array('Products', $permissions)) disable @endif">
              @if (is_array($permissions) && in_array('Products', $permissions))
                @if ($package->number_of_products == 999999)
                  {{ __('Products (Unlimited)') }}
                @elseif($package->number_of_products == 1)
                  {{ __('Product') .' ' }}({{ $package->number_of_products }})
                @else
                  {{ __('Products') . ' ' }}({{ $package->number_of_products }})
                @endif
              @else
                {{ __('Products') }}
              @endif
            </li>

            @if (is_array($permissions) && in_array('Products', $permissions))
              <li class="@if (is_array($permissions) && !in_array('Products', $permissions)) disable @endif">
                @if ($package->number_of_images_per_products == 999999)
                  {{ __('Product Image Per Product (Unlimited)') }}
                @elseif($package->number_of_images_per_products == 1)
                  {{ __('Product Image Per Product') }}({{ $package->number_of_images_per_products }})
                @else
                  {{ __('Product Images Per Product') }} ({{ $package->number_of_images_per_products }})
                @endif
              </li>
            @else
              <li class="@if (is_array($permissions) && !in_array('Products', $permissions)) disable @endif">
                {{ __('Product Image Per Product') }}</li>
            @endif

            @if (is_array($permissions) && in_array('Products', $permissions))
              <li class="@if (is_array($permissions) && (!in_array('Products', $permissions) || !in_array('Product Enquiry Form', $permissions))) disable @endif">
                {{ __('Product Enquiry Form') }}
              </li>
            @else
              <li class="@if (is_array($permissions) && (!in_array('Products', $permissions) || !in_array('Product Enquiry Form', $permissions))) disable @endif">
                {{ __('Product Enquiry Form') }}</li>
            @endif
            <li class="@if (is_array($permissions) && !in_array('Messenger', $permissions)) disable @endif">{{ __('Messenger') }}</li>
            <li class="@if (is_array($permissions) && !in_array('WhatsApp', $permissions)) disable @endif">{{ __('WhatsApp') }}</li>
            <li class="@if (is_array($permissions) && !in_array('Telegram', $permissions)) disable @endif">{{ __('Telegram') }}</li>
            <li class="@if (is_array($permissions) && !in_array('Tawk.To', $permissions)) disable @endif">{{ __('Tawk.To') }}</li>

            @if (!is_null($package->custom_features) && $package->custom_features != '')
             @php
                $features = explode("\n", $package->custom_features);
              @endphp
              @if (count($features) > 0)
                @foreach ($features as $key => $value)
                  <li>{{ $value }}</li>
                @endforeach
              @endif
            @endif

          </ul>

          @php
            $hasPendingMemb = \App\Http\Helpers\VendorPermissionHelper::hasPendingMembership(Auth::id());
          @endphp
          @if ($package_count < 2 && !$hasPendingMemb)
            <div class="px-4">
              @if (isset($current_package->id) && $current_package->id === $package->id)
                @if ($package->term != 'lifetime' || $current_membership->is_trial == 1)
                  <a href="{{ route('vendor.plan.extend.checkout', $package->id) }}"
                    class="btn btn-success btn-lg w-75 fw-bold mb-3">{{ __('Extend') }}</a>
                @endif
              @else
                <a href="{{ route('vendor.plan.extend.checkout', ['package_id' => $package->id, 'claim' => request('claim'), 't' => request('t')]) }}"
                  class="btn btn-primary btn-block btn-lg fw-bold mb-3">{{ __('Buy Now') }}</a>
              @endif
            </div>
          @endif
        </div>
      </div>
    @endforeach
  </div>
@endsection
