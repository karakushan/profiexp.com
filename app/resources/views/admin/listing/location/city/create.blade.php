<div class="modal fade" id="createModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
  aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">{{ __('Add City') }}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <div class="modal-body">
        <form id="ajaxForm" class="modal-form create"
          action="{{ route('admin.listing_specification.location.store_city') }}" method="post"
          enctype="multipart/form-data">
          @csrf

          <div class="form-group d-none" id="hide_country">
            <label for="">{{ __('Country') . '*' }}</label>
            <select name="country_id" class="form-control" id="country_id">
              <option selected disabled>{{ __('Select a country') }}</option>
            </select>
            <p id="err_country_id" class="mt-2 mb-0 text-danger em"></p>
          </div>
          <div class="form-group d-none" id="hide_state">
            <label for="">{{ __('State') . '*' }}</label>
            <select name="state_id" class="form-control">
              <option selected disabled>{{ __('Select a state') }}</option>
            </select>
            <p id="err_state_id" class="mt-2 mb-0 text-danger em"></p>
          </div>

          <div id="createAccordion" class="mt-3">
            @foreach ($langs as $language)
              <div class="version">
                <div class="version-header" id="create-heading{{ $language->id }}">
                  <h5 class="mb-0">
                    <button type="button" class="btn btn-link" data-toggle="collapse"
                      data-target="#create-collapse{{ $language->id }}"
                      aria-expanded="{{ $language->is_default == 1 ? 'true' : 'false' }}"
                      aria-controls="create-collapse{{ $language->id }}">
                      {{ $language->name }}
                      {{ $language->is_default == 1 ? __('(Default)') : '' }}
                    </button>
                  </h5>
                </div>
                <div id="create-collapse{{ $language->id }}" class="collapse {{ $language->is_default == 1 ? 'show' : '' }}"
                  aria-labelledby="create-heading{{ $language->id }}" data-parent="#createAccordion">
                  <div class="version-body {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                    <div class="form-group">
                      <label>{{ __('Name') . '*' }}</label>
                      <input type="text" class="form-control" name="{{ $language->code }}_name"
                        placeholder="{{ __('Enter City Name') }}">
                      <p id="err_{{ $language->code }}_name" class="mt-2 mb-0 text-danger em"></p>
                    </div>
                  </div>
                </div>
              </div>
            @endforeach
          </div>

          <div class="form-group">
            <label for="">{{ __('Image') }}</label>
            <br>
            <div class="thumb-preview">
              <img src="{{ asset('assets/img/noimage.jpg') }}" alt="..." class="uploaded-img">
            </div>

            <div class="mt-3">
              <div role="button" class="btn btn-primary btn-sm upload-btn">
                {{ __('Choose Image') }}
                <input type="file" class="img-input" name="feature_image">
              </div>
              <p id="err_feature_image" class="mt-2 mb-0 text-danger em"></p>
            </div>
          </div>
        </form>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">
          {{ __('Close') }}
        </button>
        <button id="submitBtn" type="button" class="btn btn-primary btn-sm">
          {{ __('Save') }}
        </button>
      </div>
    </div>
  </div>
</div>
