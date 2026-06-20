<div class="modal fade products-modal" id="productsModal_{{ $details->id }}" tabindex="-1" role="dialog"
  aria-labelledby="productsModal_{{ $details->id }}Label" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="productsModal_{{ $details->id }}Label">{{ __('Make Query') }}</h5>
        <button type="button" class="modal_close" data-bs-dismiss="modal" aria-label="Close">
          <span aria-hidden="true"><i class="fal fa-times"></i></span>
        </button>
      </div>

      <div class="modal-body">
        @if (is_array($permissions) && in_array('Product Enquiry Form', $permissions))
          <div class="query-form">
            <form id="vendorContactForm" action="{{ route('frontend.product.contact_message') }}" method="POST"
              enctype="multipart/form-data">
              @csrf
              <input type="hidden" name="vendor_id" value="{{ $details->vendor_id }}">
              <input type="hidden" name="product_id" value="{{ $details->id }}">
              <div class="row gx-xl-3">

                <div class="col-lg-6">
                  <div class="form-group mb-15">
                    <label for="name" class="form-label">{{ __('Name') }}*</label>
                    <input type="text" id="name" name="name" class="form-control" required
                      placeholder="{{ __('Name') }}">
                  </div>
                  <p id="err_name" class="text-danger"></p>
                </div>

                <div class="col-lg-6">
                  <div class="form-group mb-15">
                    <label for="email" class="form-label">{{ __('Email Address') }}*</label>
                    <input type="email" id="email" name="email" class="form-control" required
                      placeholder="{{ __('Email Address') }}">
                  </div>
                  <p id="err_email" class="text-danger"></p>
                </div>

                @foreach ($inputFields as $inputField)
                  @php
                    $fieldOptions = json_decode($inputField->options);
                  @endphp

                  @if ($inputField->type == 1)
                    <div class="col-md-6">
                      <div class="form-group mb-15">
                        <label>{{ __($inputField->label) }}{{ $inputField->is_required ? '*' : '' }}</label>
                        <input type="text" class="form-control" name="{{ $inputField->name }}"
                          placeholder="{{ __($inputField->placeholder) }}" value="{{ old($inputField->name) }}">

                        <p id="err_{{ $inputField->name }}" class="text-danger"></p>
                      </div>
                    </div>
                  @elseif ($inputField->type == 2)
                    <div class="col-md-6">
                      <div class="form-group mb-15">
                        <label>{{ __($inputField->label) }}{{ $inputField->is_required ? '*' : '' }}</label>
                        <input type="number" class="form-control" name="{{ $inputField->name }}"
                          placeholder="{{ __($inputField->placeholder) }}" value="{{ old($inputField->name) }}">

                        <p id="err_{{ $inputField->name }}" class="text-danger"></p>
                      </div>
                    </div>
                  @elseif ($inputField->type == 3)
                    <div class="col-md-6">
                      <div class="form-group mb-15">
                        <label>{{ __($inputField->label) }}{{ $inputField->is_required ? '*' : '' }}</label>
                        <select class="form-control" name="{{ $inputField->name }}">
                          <option selected disabled>{{ __($inputField->placeholder) }}</option>
                          @foreach ($fieldOptions as $option)
                            <option value="{{ $option }}"
                              {{ old($inputField->name) == $option ? 'selected' : '' }}>{{ __($option) }}</option>
                          @endforeach
                        </select>

                        <p id="err_{{ $inputField->name }}" class="text-danger"></p>
                      </div>
                    </div>
                  @elseif ($inputField->type == 4)
                    <div class="col-12">
                      <div class="form-group mb-15">
                        <label
                          class="mb-1">{{ __($inputField->label) }}{{ $inputField->is_required ? '*' : '' }}</label>
                        <br>
                        @foreach ($fieldOptions as $option)
                          <div class="custom-control custom-checkbox custom-control-inline">
                            <input type="checkbox" id="option-{{ $loop->iteration }}" name="{{ $inputField->name }}[]"
                              class="custom-control-input" value="{{ $option }}"
                              {{ is_array(old($inputField->name)) && in_array($option, old($inputField->name)) ? 'checked' : '' }}>
                            <label for="option-{{ $loop->iteration }}"
                              class="custom-control-label">{{ $option }}</label>
                          </div>
                        @endforeach

                        <p id="err_{{ $inputField->name }}" class="text-danger"></p>
                      </div>
                    </div>
                  @elseif ($inputField->type == 5)
                    <div class="col-12">
                      <div class="form-group mb-15">
                        <label>{{ __($inputField->label) }}{{ $inputField->is_required ? '*' : '' }}</label>
                        <textarea class="form-control" name="{{ $inputField->name }}" placeholder="{{ __($inputField->placeholder) }}"
                          rows="3">{{ old($inputField->name) }}</textarea>

                        <p id="err_{{ $inputField->name }}" class="text-danger"></p>
                      </div>
                    </div>
                  @elseif ($inputField->type == 6)
                    <div class="col-md-6">
                      <div class="form-group mb-15">
                        <label>{{ __($inputField->label) }}{{ $inputField->is_required ? '*' : '' }}</label>
                        <input type="date" class="form-control ltr" name="{{ $inputField->name }}"
                          placeholder="{{ __($inputField->placeholder) }}" autocomplete="off"
                          value="{{ old($inputField->name) }}">

                        <p id="err_{{ $inputField->name }}" class="text-danger"></p>
                      </div>
                    </div>
                  @elseif ($inputField->type == 7)
                    <div class="col-md-6">
                      <div class="form-group mb-15">
                        <label>{{ __($inputField->label) }}{{ $inputField->is_required ? '*' : '' }}</label>
                        <input type="time" class="form-control ltr" name="{{ $inputField->name }}"
                          placeholder="{{ __($inputField->placeholder) }}" autocomplete="off"
                          value="{{ old($inputField->name) }}">

                        <p id="err_{{ $inputField->name }}" class="text-danger"></p>
                      </div>
                    </div>
                  @else
                    <div class="col-md-6">
                      <div class="form-group mb-4">
                        <label class="form-label">
                          {{ __($inputField->label) }}{{ $inputField->is_required ? '*' : '' }}
                        </label>
                        <input type="file" class="form-control" name="{{ 'form_builder_' . $inputField->name }}"
                          accept=".zip">
                        <span class="text-info {{ $currentLanguageInfo->direction == 0 ? 'ms-2' : 'me-2' }}">
                          ({{ __('Only .zip file is allowed') . '.' }})
                        </span>
                        <p id="err_{{ $inputField->name }}" class="text-danger mt-1"></p>
                      </div>
                    </div>
                  @endif
                @endforeach

                <div class="col-12 d-flex justify-content-center mt-4">
                  <button class="btn btn-lg btn-primary radius-sm" type="submit"
                    aria-label="button">{{ __('Submit') }}</button>
                </div>
            </form>
          </div>
        @endif
      </div>
    </div>
  </div>
</div>
</div>
