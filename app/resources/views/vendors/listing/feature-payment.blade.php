<div class="modal fade" id="featured" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
  aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">{{ __('Send Request') }}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <div class="modal-body">
        <form id="feature-payment-form" class="modal-form"
          action="{{ route('vendor.listing_management.listing.purchase_feature') }}" method="post"
          enctype="multipart/form-data">
          @csrf
          <input type="hidden" name="listing_id" id="listing_id">

          <div class="form-group p-0 mt-2">
            <label for="form-check">{{ __('Promotion List') . '*' }}</label>
            @foreach ($charges as $index => $charge)
              <ul class="list-group list-group-bordered mb-2">
                <li class="list-group-item">
                  <div class="form-check p-0">
                    <label class="form-check-label mb-0" for="radio_{{ $charge->id }}">
                      <input class="form-check-input ml-0" type="radio" name="charge" id="radio_{{ $charge->id }}"
                        value="{{ $charge->id }}" {{ $index === 0 ? 'checked' : '' }}>
                      {{ $charge->days }} {{ __('Days For') }}
                      {{ symbolPrice($charge->price) }}
                    </label>
                  </div>
                </li>
              </ul>
            @endforeach

            <span id="err_charge" class="mt-2 mb-0 text-danger em"></span>
          </div>

          <div class="form-group p-0 mt-2">
            <label>{{ __('Payment Method') . '*' }}</label>
            <div class="mb-30">

              <select name="gateway" id="gateway" class="form-control form-select niceselect">
                <option value="" selected="" disabled>{{ __('Choose a Payment Method') }}</option>
                @foreach ($onlineGateways as $onlineGateway)
                  <option @selected(old('gateway') == $onlineGateway->keyword) value="{{ $onlineGateway->keyword }}">
                    {{ __($onlineGateway->name) }}</option>
                @endforeach

                @if (count($offline_gateways) > 0)
                  @foreach ($offline_gateways as $offlineGateway)
                    <option @selected(old('gateway') == $offlineGateway->id) value="{{ $offlineGateway->id }}">
                      {{ __($offlineGateway->name) }}</option>
                  @endforeach
                @endif
              </select>
              <span id="err_gateway" class="mt-2 mb-0 text-danger em"></span>
            </div>

            <!-- Stripe Payment Will be Inserted here -->
            <div id="stripe-element" class="mb-2">
              <!-- A Stripe Element will be inserted here. -->
            </div>

            <!-- Used to display form errors -->
            <div id="stripe-errors" class="pb-2" role="alert"></div>
            <span id="err_stripeToken" class="mt-2 mb-0 text-danger em"></span>

            <!-- iyzico payment -->
            <div id="iyzico-element" class="d-none">
              <input type="text" name="identity_number" class="form-control"
                placeholder="{{ __('Identity Number') }}">
              @error('identity_number')
                <p class="text-danger text-left">{{ $message }}</p>
              @enderror
            </div>

            @php
              $display = 'none';
            @endphp
            {{-- START: Authorize.net Card Details Form --}}
            <div class="row gateway-details pb-4 d-none" id="authorizenet-element">
              <div class="col-lg-6">
                <div class="form-group mb-3">
                  <input class="form-control" type="text" id="anetCardNumber" placeholder="{{ __('Card Number') }}"
                    disabled />
                </div>
              </div>
              <div class="col-lg-6 mb-3">
                <div class="form-group">
                  <input class="form-control" type="text" id="anetExpMonth" placeholder="{{ __('Expire Month') }}"
                    disabled />
                </div>
              </div>
              <div class="col-lg-6 ">
                <div class="form-group">
                  <input class="form-control" type="text" id="anetExpYear" placeholder="{{ __('Expire Year') }}"
                    disabled />
                </div>
              </div>
              <div class="col-lg-6 ">
                <div class="form-group">
                  <input class="form-control" type="text" id="anetCardCode" placeholder="{{ __('Card Code') }}"
                    disabled />
                </div>
              </div>
              <input type="hidden" name="opaqueDataValue" id="opaqueDataValue" disabled />
              <input type="hidden" name="opaqueDataDescriptor" id="opaqueDataDescriptor" disabled />
              <ul id="authorizeNetErrors" style="display:{{ $display }};"></ul>
            </div>
            {{-- END: Authorize.net Card Details Form --}}


            <!-- offline payment instruction -->
            @foreach ($offline_gateways as $offlineGateway)
              <div class="@if ($errors->has('attachment') && request()->session()->get('gatewayId') == $offlineGateway->id) d-block @else d-none @endif offline-gateway-info"
                id="{{ 'offline-gateway-' . $offlineGateway->id }}">
                @if (!is_null($offlineGateway->short_description))
                  <div class="form-group">
                    <label>{{ __('Description') }}</label>
                    <p>{{ $offlineGateway->short_description }}</p>
                  </div>
                @endif

                @if (!is_null($offlineGateway->instructions))
                  <div class="form-group">
                    <label>{{ __('Instructions') }}</label>
                    {!! replaceBaseUrl($offlineGateway->instructions, 'summernote') !!}
                  </div>
                @endif

                @if ($offlineGateway->has_attachment == 1)
                  <div class="form-group mb-4">
                    <label>{{ __('Attachment') . '*' }}</label>
                    <br>
                    <input type="file" name="attachment">
                    <span id="err_attachment" class="mt-2 mb-0 text-danger em"></span>
                  </div>
                @endif
              </div>
              <span id="err_currency" class="mt-2 mb-0 text-danger em"></span>
            @endforeach
            <button class="btn btn-primary" type="submit" form="feature-payment-form"
              id="featuredBtn">{{ __('Submit') }}</button>
          </div>
        </form>
      </div>
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>
