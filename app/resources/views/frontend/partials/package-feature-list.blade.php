@php

  $customFeatures = [];
  $hasAiFeature = is_array($permissions) && in_array('AI Content & Image Generator', $permissions);

  if (!is_null($package->custom_features)) {
      $customFeatures = array_values(array_filter(array_map('trim', explode("\n", $package->custom_features))));
  }

@endphp

<li><i class="fal fa-check"></i>
  @if ($package->number_of_listing == 999999)
    {{ __('Listing (Unlimited)') }}
  @elseif($package->number_of_listing == 1)
    {{ __('Listing') }} ({{ $package->number_of_listing }})
  @else
    {{ __('Listings') }} ({{ $package->number_of_listing }})
  @endif
</li>

<li><i class="fal fa-check"></i>
  @if ($package->number_of_images_per_listing == 999999)
    {{ __('Images Per Listing (Unlimited)') }}
  @elseif($package->number_of_images_per_listing == 1)
    {{ __('Image Per Listing') }} ({{ $package->number_of_images_per_listing }})
  @else
    {{ __('Images Per Listings') }} ({{ $package->number_of_images_per_listing }})
  @endif
</li>

@if ($hasAiFeature)
  <li class="pricing-feature-group">
    <div class="pricing-feature-label">
      <i class="fal fa-check"></i>
      <span>{{ __('AI Content & Image Generator') }}</span>
    </div>

    <ul class="pricing-sublist list-unstyled">
      @if (filled($package->ai_engine))
        <li>
          <i class="fal fa-check"></i>
          <span>{{ __('AI Engine') }} : {{ strtoupper($package->ai_engine) }}</span>
        </li>
      @endif
      @if (!is_null($package->ai_token_limit))
        <li>
          <i class="fal fa-check"></i>
          <span>{{ __('AI Token Limit') }} : {{ $package->ai_token_limit }}</span>
        </li>
      @endif
      @if (!is_null($package->ai_image_limit))
        <li>
          <i class="fal fa-check"></i>
          <span>{{ __('AI Image Limit') }} : {{ $package->ai_image_limit }}</span>
        </li>
      @endif
    </ul>
  </li>
@else
  <li>
    <i class="fal fa-times not-active"></i>
    {{ __('AI Content & Image Generator') }}
  </li>
@endif

<li>
  <i class="@if (is_array($permissions) && in_array('Listing Enquiry Form', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
  {{ __('Enquiry Form') }}
</li>

<li>
  <i class="@if (is_array($permissions) && in_array('Video', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
  {{ __('Video') }}
</li>

<li>
  <i class="@if (is_array($permissions) && in_array('Amenities', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
  @if (is_array($permissions) && in_array('Amenities', $permissions))
    @if ($package->number_of_amenities_per_listing == 999999)
      {{ __('Amenities Per Listing(Unlimited)') }}
    @elseif($package->number_of_amenities_per_listing == 1)
      {{ __('Amenitie Per Listing') }} ({{ $package->number_of_amenities_per_listing }})
    @else
      {{ __('Amenities Per Listing') }} ({{ $package->number_of_amenities_per_listing }})
    @endif
  @else
    {{ __('Amenities Per Listing') }}
  @endif
</li>

<li>
  <i class="@if (is_array($permissions) && in_array('Feature', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
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

<li>
  <i class="@if (is_array($permissions) && in_array('Social Links', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
  @if (is_array($permissions) && in_array('Social Links', $permissions))
    @if ($package->number_of_social_links == 999999)
      {{ __('Social Links Per Listing(Unlimited)') }}
    @elseif($package->number_of_social_links == 1)
      {{ __('Social Link Per Listing') }} ({{ $package->number_of_social_links }})
    @else
      {{ __('Social Links Per Listing') }} ({{ $package->number_of_social_links }})
    @endif
  @else
    {{ __('Social Link Per Listing') }}
  @endif
</li>

<li>
  <i class="@if (is_array($permissions) && in_array('FAQ', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
  @if (is_array($permissions) && in_array('FAQ', $permissions))
    @if ($package->number_of_faq == 999999)
      {{ __('FAQ Per Listing(Unlimited)') }}
    @elseif($package->number_of_faq == 1)
      {{ __('FAQ Per Listing') }} ({{ $package->number_of_faq }})
    @else
      {{ __('FAQs Per Listing') }} ({{ $package->number_of_faq }})
    @endif
  @else
    {{ __('FAQ Per Listing') }}
  @endif
</li>

<li>
  <i class="@if (is_array($permissions) && in_array('Business Hours', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
  {{ __('Business Hours') }}
</li>

<li>
  <i class="@if (is_array($permissions) && in_array('Products', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
  @if (is_array($permissions) && in_array('Products', $permissions))
    @if ($package->number_of_products == 999999)
      {{ __('Products (Unlimited)') }}
    @elseif($package->number_of_products == 1)
      {{ __('Product') }} ({{ $package->number_of_products }})
    @else
      {{ __('Products') }} ({{ $package->number_of_products }})
    @endif
  @else
    {{ __('Products') }}
  @endif
</li>

@if (is_array($permissions) && in_array('Products', $permissions))
  <li><i class="fal fa-check"></i>
    @if ($package->number_of_images_per_products == 999999)
      {{ __('Product Image Per Product (Unlimited)') }}
    @elseif($package->number_of_images_per_products == 1)
      {{ __('Product Image Per Product') }} ({{ $package->number_of_images_per_products }})
    @else
      {{ __('Product Images Per Product') }} ({{ $package->number_of_images_per_products }})
    @endif
  </li>
@else
  <li><i class="fal fa-times not-active"></i>{{ __('Product Image Per Product') }}</li>
@endif

@if (is_array($permissions) && in_array('Products', $permissions))
  <li>
    <i class="@if (is_array($permissions) && in_array('Product Enquiry Form', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
    {{ __('Product Enquiry Form') }}
  </li>
@else
  <li><i class="fal fa-times not-active"></i>{{ __('Product Enquiry Form') }}</li>
@endif

<li>
  <i class="@if (is_array($permissions) && in_array('Messenger', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
  {{ __('Messenger') }}
</li>

<li>
  <i class="@if (is_array($permissions) && in_array('WhatsApp', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
  {{ __('WhatsApp') }}
</li>

<li>
  <i class="@if (is_array($permissions) && in_array('Telegram', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
  {{ __('Telegram') }}
</li>

<li>
  <i class="@if (is_array($permissions) && in_array('Tawk.To', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
  {{ __('Tawk.To') }}
</li>



@foreach ($customFeatures as $feature)
  <li><i class="fal fa-check"></i>{{ __($feature) }}</li>
@endforeach
