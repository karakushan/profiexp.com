@php

  $customFeatures = [];
  $hasAiFeature = is_array($permissions) && in_array('AI Content & Image Generator', $permissions);

  if (!is_null($package->custom_features)) {
      $customFeatures = array_values(array_filter(array_map('trim', explode("\n", $package->custom_features))));
  }

@endphp

<li><i class="fal fa-check"></i>
  @if ($package->number_of_listing == 999999)
    {{ __('Pricing Business Cards (Unlimited)') }}
  @else
    <span>
      {{ __('Pricing Business Cards') }} — {{ $package->number_of_listing }}
      @if ($package->number_of_listing == 1)
        <br>
        <small class="pricing-feature-note">{{ __('1 card = 1 category + 1 city') }}</small>
      @elseif ($package->number_of_listing > 1)
        <br>
        <small class="pricing-feature-note">
          {{ $package->number_of_listing }}
          @if ($package->number_of_listing % 10 == 1 && $package->number_of_listing % 100 != 11)
            {{ __('Pricing category and/or city') }}
          @elseif ($package->number_of_listing % 10 >= 2 && $package->number_of_listing % 10 <= 4 && ($package->number_of_listing % 100 < 12 || $package->number_of_listing % 100 > 14))
            {{ __('Pricing categories and/or cities') }}
          @else
            {{ __('Pricing categories genitive and/or cities genitive') }}
          @endif
        </small>
      @endif
    </span>
  @endif
</li>

<li><i class="fal fa-check"></i>
  @if ($package->number_of_images_per_listing == 999999)
    {{ __('Pricing Images (Unlimited)') }}
  @else
    {{ __('Pricing Images') }} — {{ $package->number_of_images_per_listing }}
  @endif
</li>

@if ($hasAiFeature)
  <li>
    <i class="fal fa-check"></i>
    {{ __('Pricing AI Generator') }}
  </li>
@else
  <li>
    <i class="fal fa-times not-active"></i>
    {{ __('Pricing AI Generator') }}
  </li>
@endif

<li>
  <i class="@if (is_array($permissions) && in_array('Listing Enquiry Form', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
  {{ __('Pricing Feedback Form') }}
</li>

<li>
  <i class="@if (is_array($permissions) && in_array('Video', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
  {{ __('Video') }}
</li>

<li>
  <i class="@if (is_array($permissions) && in_array('Amenities', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
  @if (is_array($permissions) && in_array('Amenities', $permissions))
    @if ($package->number_of_amenities_per_listing == 999999)
      {{ __('Pricing Advantages (Unlimited)') }}
    @elseif($package->number_of_amenities_per_listing == 1)
      {{ __('Pricing Advantage') }} — {{ $package->number_of_amenities_per_listing }}
    @else
      {{ __('Pricing Advantages') }} — {{ $package->number_of_amenities_per_listing }}
    @endif
  @else
    {{ __('Pricing Advantages') }}
  @endif
</li>

<li>
  <i class="@if (is_array($permissions) && in_array('Feature', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
  @if (is_array($permissions) && in_array('Feature', $permissions))
    @if ($package->number_of_additional_specification == 999999)
      {{ __('Pricing Features (Unlimited)') }}
    @elseif($package->number_of_additional_specification == 1)
      {{ __('Pricing Feature') }} — {{ $package->number_of_additional_specification }}
    @else
      {{ __('Pricing Features') }} — {{ $package->number_of_additional_specification }}
    @endif
  @else
    {{ __('Pricing Features') }}
  @endif
</li>

<li>
  <i class="@if (is_array($permissions) && in_array('Social Links', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
  @if (is_array($permissions) && in_array('Social Links', $permissions))
    @if ($package->number_of_social_links == 999999)
      {{ __('Pricing Company Links (Unlimited)') }}
    @elseif($package->number_of_social_links == 1)
      {{ __('Pricing Social Network') }} — {{ $package->number_of_social_links }}
    @else
      {{ __('Pricing Social Networks') }} — {{ $package->number_of_social_links }}
    @endif
  @else
    {{ __('Pricing Social Networks') }}
  @endif
</li>

<li>
  <i class="@if (is_array($permissions) && in_array('FAQ', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
  @if (is_array($permissions) && in_array('FAQ', $permissions))
    @if ($package->number_of_faq == 999999)
      {{ __('Pricing FAQs (Unlimited)') }}
    @elseif($package->number_of_faq == 1)
      {{ __('Pricing FAQ') }} — {{ $package->number_of_faq }}
    @else
      {{ __('Pricing FAQs') }} — {{ $package->number_of_faq }}
    @endif
  @else
    {{ __('Pricing FAQs') }}
  @endif
</li>

<li>
  <i class="@if (is_array($permissions) && in_array('Business Hours', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
  {{ __('Business Hours') }}
</li>

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

<li>
  <i class="@if (is_array($permissions) && in_array('SEO Optimized Business Card', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
  {{ $package->number_of_listing > 1 ? __('Pricing SEO Optimized Business Cards') : __('Pricing SEO Optimized Business Card') }}
</li>

<li>
  <i class="@if (is_array($permissions) && in_array('IVA Included', $permissions)) fal fa-check @else fal fa-times not-active @endif"></i>
  {{ __('Pricing IVA Included') }}
</li>



@foreach ($customFeatures as $feature)
  <li><i class="fal fa-check"></i>{{ __($feature) }}</li>
@endforeach
