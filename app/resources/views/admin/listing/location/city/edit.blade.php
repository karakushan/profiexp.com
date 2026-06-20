<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
  aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">{{ __('Edit City') }}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <div class="modal-body">
        <form id="ajaxEditForm" class="modal-form {{ $language->direction == 1 ? 'rtl text-right' : '' }}"
          action="{{ route('admin.listing_specification.location.update_city') }}" method="post">
          @csrf
          <input type="hidden" name="id" id="in_id">
          <input type="hidden" name="language_id" id="in_language_id">

          <div class="form-group">
            <label for="">{{ __('Country') . '*' }}</label>
            <select name="country_id" class="form-control" id="in_country_id">
              <option selected disabled>{{ __('Select a Country') }}</option>
              @foreach ($countries as $country)
                <option value="{{ $country->id }}">{{ $country->name }}</option>
              @endforeach
            </select>
            <p id="editErr_country_id" class="mt-2 mb-0 text-danger em"></p>
          </div>

          <div class="form-group d-none" id="e_hide_state">
            <label for="">{{ __('State') . '*' }}</label>
            <select name="state_id" class="form-control state_id" id="in_state_id">
              <option selected disabled>{{ __('Select a State') }}</option>
              @foreach ($states as $state)
                <option value="{{ $state->id }}">{{ $state->name }}</option>
              @endforeach
            </select>
            <p id="editErr_state_id" class="mt-2 mb-0 text-danger em"></p>
          </div>

          <div class="form-group">
            <label for="">{{ __('Name') . '*' }}</label>
            <input type="text" class="form-control" name="name" placeholder="{{ __('Enter City Name') }}"
              id="in_name">
            <p id="editErr_name" class="mt-2 mb-0 text-danger em"></p>
          </div>

          <div class="form-group">
            <label for="">{{ __('Image') }}</label>
            <br>
            @php
              $display = 'none';
            @endphp
            <div class="thumb-preview">
              <img src="{{ asset('assets/img/noimage.jpg') }}" alt="..." class="uploaded-img2 in_image">
              <button class="remove-img2 btn btn-remove" type="button" style="display:{{ $display }};">
                <i class="fal fa-times"></i>
              </button>
              <button class="cityimagermvbtndb btn btn-remove" type="button" data-indb="in_id">
                <i class="fal fa-times"></i>
              </button>
            </div>

            <div class="mt-3">
              <div role="button" class="btn btn-primary btn-sm upload-btn">
                {{ __('Choose Image') }}
                <input type="file" class="video-img-input" name="image">
              </div>
            </div>
            <p id="editErr_image" class="mb-0 text-danger em"></p>
          </div>
        </form>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">
          {{ __('Close') }}
        </button>
        <button id="updateBtn" type="button" class="btn btn-primary btn-sm">
          {{ __('Update') }}
        </button>
      </div>
    </div>
  </div>
</div>
