@extends('admin.layout')

@php
  use App\Models\Language;
  $selLang = Language::where('code', request()->input('language'))->first();
@endphp
@if (!empty($selLang->language) && $selLang->language->rtl == 1)
  @section('styles')
    <style>
      form input,
      form textarea,
      form select {
        direction: rtl;
      }

      form .note-editor.note-frame .note-editing-area .note-editable {
        direction: rtl;
        text-align: right;
      }
    </style>
  @endsection
@endif


@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Edit package') }}</h4>
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
        <a href="#">{{ __('Package Management') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Edit package') }}</a>
      </li>
    </ul>
  </div>
  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <div class="card-title d-inline-block">{{ __('Edit package') }}</div>
          <a class="btn btn-info btn-sm float-right d-inline-block" href="{{ route('admin.package.index') }}">
            <span class="btn-label">
              <i class="fas fa-backward"></i>
            </span>
            {{ __('Back') }}
          </a>
        </div>
        <div class="card-body pt-5 pb-5">
          <div class="row">
            <div class="col-lg-6 offset-lg-3">
              <form id="ajaxForm" class="" action="{{ route('admin.package.update') }}" method="post"
                enctype="multipart/form-data">
                @csrf
                <input type="hidden" name="package_id" value="{{ $package->id }}">
                <div class="form-group">
                  <label for="title">{{ __('Package title') . '*' }}</label>
                  <input id="title" type="text" class="form-control" name="title" value="{{ $package->title }}"
                    placeholder="{{ __('Enter Package title') }}">
                  <p id="err_title" class="mt-2 mb-0 text-danger em"></p>
                </div>

                <div class="form-group">
                  <label for="price">{{ __('Price') }} ({{ $settings->base_currency_text }})*</label>
                  <input id="price" type="number" class="form-control" name="price"
                    placeholder="{{ __('Enter Package price') }}" value="{{ $package->price }}">
                  <p class="text-warning">
                    <small>{{ __('If price is 0 , than it will appear as free') }}</small>
                  </p>
                  <p id="err_price" class="mt-2 mb-0 text-danger em"></p>
                </div>

                <div class="form-group">
                  <label for="">{{ __('Icon') . '*' }}</label>
                  <div class="btn-group d-block">
                    <button type="button" class="btn btn-primary iconpicker-component">
                      <i class="{{ $package->icon }}"></i>
                    </button>
                    <button type="button" class="icp icp-dd btn btn-primary dropdown-toggle" data-selected="fa-car"
                      data-toggle="dropdown"></button>
                    <div class="dropdown-menu"></div>
                  </div>
                  <input type="hidden" id="inputIcon" name="icon">
                </div>

                <div class="form-group">
                  <label for="term">{{ __('Package term') . '*' }}</label>
                  <select id="term" name="term" class="form-control">
                    <option value="" selected disabled>{{ __('Select a Term') }}</option>
                    <option value="monthly" {{ $package->term == 'monthly' ? 'selected' : '' }}>
                      {{ __('Monthly') }}</option>
                    <option value="yearly" {{ $package->term == 'yearly' ? 'selected' : '' }}>
                      {{ __('Yearly') }}</option>
                    <option value="lifetime" {{ $package->term == 'lifetime' ? 'selected' : '' }}>
                      {{ 'Lifetime' }}</option>
                  </select>
                  <p id="err_term" class="mb-0 text-danger em"></p>
                </div>


                @php
                  $permissions = $package->features;
                  if (!empty($package->features)) {
                      $permissions = json_decode($permissions, true);
                  }
                  $aiEnabled = is_array($permissions) && in_array('AI Content & Image Generator', $permissions);
                @endphp

                <div class="form-group">
                  <label class="form-label">{{ __('Package Features') }}</label>
                  <div class="selectgroup selectgroup-pills">

                    <label class="selectgroup-item">
                      <input type="checkbox" name="features[]" value="Listing Enquiry Form"
                        class="selectgroup-input"@if (is_array($permissions) && in_array('Listing Enquiry Form', $permissions)) checked @endif>
                      <span class="selectgroup-button">{{ __('Listing Enquiry Form') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="checkbox" name="features[]" value="Video"
                        class="selectgroup-input"@if (is_array($permissions) && in_array('Video', $permissions)) checked @endif>
                      <span class="selectgroup-button">{{ __('Video') }}</span>
                    </label>

                    <label class="selectgroup-item">
                      <input type="checkbox" name="features[]" value="Amenities"
                        class="selectgroup-input"@if (is_array($permissions) && in_array('Amenities', $permissions)) checked @endif>
                      <span class="selectgroup-button">{{ __('Amenities') }}</span>
                    </label>

                    <label class="selectgroup-item">
                      <input type="checkbox" name="features[]" value="Feature" class="selectgroup-input"
                        @if (is_array($permissions) && in_array('Feature', $permissions)) checked @endif>
                      <span class="selectgroup-button">{{ __('Features') }}</span>
                    </label>

                    <label class="selectgroup-item">
                      <input type="checkbox" name="features[]" value="Social Links"
                        class="selectgroup-input"@if (is_array($permissions) && in_array('Social Links', $permissions)) checked @endif>
                      <span class="selectgroup-button">{{ __('Social Links') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="checkbox" name="features[]" value="FAQ"
                        class="selectgroup-input"@if (is_array($permissions) && in_array('FAQ', $permissions)) checked @endif>
                      <span class="selectgroup-button">{{ __('FAQ') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="checkbox" name="features[]" value="Business Hours"
                        class="selectgroup-input"@if (is_array($permissions) && in_array('Business Hours', $permissions)) checked @endif>
                      <span class="selectgroup-button">{{ __('Business Hours') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="checkbox" name="features[]" value="Products"
                        class="selectgroup-input"@if (is_array($permissions) && in_array('Products', $permissions)) checked @endif>
                      <span class="selectgroup-button">{{ __('Products') }}</span>
                    </label>
                    <label class="selectgroup-item @if (is_array($permissions) && in_array('Products', $permissions)) @else d-none @endif"
                      id="productEnquiryFormLabel">
                      <input type="checkbox" name="features[]" value="Product Enquiry Form"
                        class="selectgroup-input"@if (is_array($permissions) && in_array('Product Enquiry Form', $permissions)) checked @endif>
                      <span class="selectgroup-button">{{ __('Product Enquiry Form') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="checkbox" name="features[]" value="Messenger"
                        class="selectgroup-input"@if (is_array($permissions) && in_array('Messenger', $permissions)) checked @endif>
                      <span class="selectgroup-button">{{ __('Messenger') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="checkbox" name="features[]" value="WhatsApp"
                        class="selectgroup-input"@if (is_array($permissions) && in_array('WhatsApp', $permissions)) checked @endif>
                      <span class="selectgroup-button">{{ __('WhatsApp') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="checkbox" name="features[]" value="Telegram"
                        class="selectgroup-input"@if (is_array($permissions) && in_array('Telegram', $permissions)) checked @endif>
                      <span class="selectgroup-button">{{ __('Telegram') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="checkbox" name="features[]" value="Tawk.To"
                        class="selectgroup-input"@if (is_array($permissions) && in_array('Tawk.To', $permissions)) checked @endif>
                      <span class="selectgroup-button">{{ __('Tawk.To') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="checkbox" name="features[]" value="AI Content & Image Generator"
                        class="selectgroup-input"@if ($aiEnabled) checked @endif>
                      <span class="selectgroup-button">{{ __('AI Content & Image Generator') }}</span>
                    </label>
                  </div>
                  <p id="err_features" class="mb-0 text-danger em"></p>
                </div>
                <div class="form-group">
                  <label class="form-label">{{ __('Number of Listings') . '*' }}</label>
                  <input type="number" class="form-control" name="number_of_listing"
                    placeholder="{{ __('Enter Number of Listings') }}"value="{{ $package->number_of_listing }}">
                  <p class="text-warning">{{ __('Enter 999999 , then it will appear as unlimited') }}</p>
                  <p id="err_number_of_listing" class="mb-0 text-danger em"></p>
                </div>
                <div class="form-group">
                  <label class="form-label">{{ __('Number of image per Listing') . '*' }}</label>
                  <input type="number" class="form-control" name="number_of_images_per_listing"
                    placeholder="{{ __('Enter Number of image per Listing') }}"value="{{ $package->number_of_images_per_listing }}">
                  <p class="text-warning">{{ __('Enter 999999 , then it will appear as unlimited') }}</p>
                  <p id="err_number_of_images_per_listing" class="mb-0 text-danger em"></p>
                </div>
                <div class="form-group  @if (is_array($permissions) && in_array('Amenities', $permissions)) @else d-none @endif amenities-box">
                  <label for="">{{ __('Number of Amenities per Listing') . '*' }} </label>
                  <input type="number" class="form-control" name="number_of_amenities_per_listing"
                    placeholder="{{ __('Enter Number of Amenities per Listing') }}"
                    value="{{ $package->number_of_amenities_per_listing }}">
                  <p class="text-warning">{{ __('Enter 999999 , then it will appear as unlimited') }}</p>
                  <p id="err_number_of_amenities_per_listing" class="mb-0 text-danger em"></p>
                </div>

                <div
                  class="form-group @if (is_array($permissions) && in_array('Feature', $permissions)) @else d-none @endif additional-specification-box">
                  <label for="">{{ __('Number of Features per Listing') . '*' }} </label>
                  <input type="number" class="form-control" name="number_of_additional_specification"
                    value="{{ $package->number_of_additional_specification }}"
                    placeholder="{{ __('Enter Number of Features per Listing') }}">
                  <p class="text-warning">{{ __('Enter 999999 , then it will appear as unlimited') }}</p>
                  <p id="err_number_of_additional_specification" class="mb-0 text-danger em"></p>
                </div>

                <div class="form-group @if (is_array($permissions) && in_array('Social Links', $permissions)) @else d-none @endif social-links-box">
                  <label for="">{{ __('Number of Social Links per Listing') . '*' }} </label>
                  <input type="number" class="form-control" name="number_of_social_links"
                    value="{{ $package->number_of_social_links }}"
                    placeholder="{{ __('Enter Number of Social Links per Listing') }}">
                  <p class="text-warning">{{ __('Enter 999999 , then it will appear as unlimited') }}</p>
                  <p id="err_number_of_social_links" class="mb-0 text-danger em"></p>
                </div>

                <div class="form-group @if (is_array($permissions) && in_array('FAQ', $permissions)) @else d-none @endif FAQ-box">
                  <label for="">{{ __('Number of FAQs per Listing') . '*' }} </label>
                  <input type="number" class="form-control" name="number_of_faq"
                    value="{{ $package->number_of_faq }}"placeholder="{{ __('Enter Number of FAQs per Listing') }}">
                  <p class="text-warning">{{ __('Enter 999999 , then it will appear as unlimited') }}</p>
                  <p id="err_number_of_faq" class="mb-0 text-danger em"></p>
                </div>

                <div class="form-group @if (is_array($permissions) && in_array('Products', $permissions)) @else d-none @endif Products-box">
                  <label for="">{{ __('Number of Products') . '*' }} </label>
                  <input type="number" class="form-control" name="number_of_products"
                    value="{{ $package->number_of_products }}"
                    placeholder="{{ __('Enter Number of Products') }}">
                  <p class="text-warning">{{ __('Enter 999999 , then it will appear as unlimited') }}</p>
                  <p id="err_number_of_products" class="mb-0 text-danger em"></p>
                </div>
                <div class="form-group @if (is_array($permissions) && in_array('Products', $permissions)) @else d-none @endif image-product-box">
                  <label for="">{{ __('Number of Images per Product') . '*' }} </label>
                  <input type="number" class="form-control" name="number_of_images_per_products"
                    value="{{ $package->number_of_images_per_products }}"
                    placeholder="{{ __('Enter Number of Images per Product') }}">
                  <p class="text-warning">{{ __('Enter 999999 , then it will appear as unlimited') }}</p>
                  <p id="err_number_of_images_per_products" class="mb-0 text-danger em"></p>
                </div>
                <div class="form-group">
                  <label for="status">{{ __('Status') . '*' }}</label>
                  <select id="status" class="form-control ltr" name="status">
                    <option value="" selected disabled>{{ __('Select a status') }}</option>
                    <option value="1" {{ $package->status == '1' ? 'selected' : '' }}>
                      {{ __('Active') }}</option>
                    <option value="0" {{ $package->status == '0' ? 'selected' : '' }}>
                      {{ __('Deactive') }}</option>
                  </select>
                  <p id="err_status" class="mb-0 text-danger em"></p>
                </div>
                <div class="form-group">
                  <label class="form-label">{{ __('Popular') }} </label>
                  <div class="selectgroup w-100">
                    <label class="selectgroup-item">
                      <input type="radio" name="recommended" value="1"
                        class="selectgroup-input"@if ($package->recommended == '1') checked @endif>
                      <span class="selectgroup-button">{{ __('Yes') }}</span>
                    </label>
                    <label class="selectgroup-item">
                      <input type="radio" name="recommended" value="0" class="selectgroup-input"
                        @if ($package->recommended == '0') checked @endif>
                      <span class="selectgroup-button">{{ __('No') }}</span>
                    </label>
                  </div>
                </div>
                <div class="ai-feature-wrap @if (!$aiEnabled) d-none @endif">
                  <div class=" p-3 mb-3 ai-feature-card">
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                          <label for="ai_engine">{{ __('AI Engine') }} <span class="text-danger">**</span></label>
                          <select id="ai_engine" name="ai_engine" class="form-control">
                            <option value="" selected disabled>{{ __('Choose AI Engine') }}</option>
                            <option value="gemini" {{ $package->ai_engine == 'gemini' ? 'selected' : '' }}>
                              {{ __('Gemini') }}</option>
                            <option value="openai" {{ $package->ai_engine == 'openai' ? 'selected' : '' }}>
                              {{ __('OpenAI') }}</option>

                          </select>
                          <p id="errai_engine" class="mb-0 text-danger em"></p>
                          <small class="text-info">
                            {{ '*' . __('Select the AI engine that will power content and image generation for this package') . '.' }}
                          </small>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label for="ai_token_limit">{{ __('Total AI Token Limit') }} <span
                              class="text-danger">**</span></label>
                          <input id="ai_token_limit" type="number" class="form-control" name="ai_token_limit"
                            placeholder="{{ __('Enter Total AI Token Limit') }}"
                            value="{{ $package->ai_token_limit }}">
                          <p id="errai_token_limit" class="mb-0 text-danger em"></p>
                          <small class="text-warning d-block">{{ __('Enter 999999 , then it will appear as unlimited') }}</small>
                          <small class="text-info d-block">
                            {{ '*' . __('Defines the total AI token usage allowed for this package for generating content') . '.' }}
                          </small>
                          <small class="text-warning d-block mt-2">
                            {{ '*' . __('Minimum 20,000 tokens may be required for content generation') . '. ' . __('English content is usually cheaper, while other languages may consume more tokens and cost higher') . '. ' . __('For reference, 1K token approximately equal to USD 0.0015') . '.' }}
                          </small>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label for="ai_image_limit">{{ __('Total AI Image Limit') }} <span
                              class="text-danger">**</span></label>
                          <input id="ai_image_limit" type="number" class="form-control" name="ai_image_limit"
                            placeholder="{{ __('Enter Total AI Image Limit') }}"
                            value="{{ $package->ai_image_limit }}">
                          <p id="errai_image_limit" class="mb-0 text-danger em"></p>
                          <small class="text-warning d-block">{{ __('Enter 999999 , then it will appear as unlimited') }}</small>
                          <small class="text-info d-block">
                            {{ '*' . __('This defines how many AI-generated images a vendor user can create under this package') . '.' }}
                          </small>
                          <small class="text-warning d-block">
                            {{ '*' . __('Each AI image generation approximately costs USD 0.04 per image') . '.' }}
                          </small>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label>{{ __('Custom Features') }}</label>
                  <textarea class="form-control" name="custom_features" rows="5"
                    placeholder="{{ __('Enter Custom Features') }}">{{ $package->custom_features }}</textarea>
                  <p class="text-warning">
                    <small>{{ __('Enter new line to seperate features') }}</small>
                  </p>
                </div>
              </form>
            </div>
          </div>
        </div>
        <div class="card-footer">
          <div class="form">
            <div class="form-group from-show-notify row">
              <div class="col-12 text-center">
                <button type="submit" id="submitBtn" class="btn btn-success">{{ __('Update') }}</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
@endsection

@section('script')
  <script src="{{ asset('assets/admin/js/packages-edit.js') }}"></script>
@endsection
