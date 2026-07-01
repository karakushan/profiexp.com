<div class="modal fade" id="createModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
  aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">{{ __('Add Amenitie') }}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <div class="modal-body">
        <form id="ajaxForm" class="modal-form create"
          action="{{ route('admin.listing_specification.store_aminites') }}"
          method="post">
          @csrf

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
                <div id="create-collapse{{ $language->id }}"
                  class="collapse {{ $language->is_default == 1 ? 'show' : '' }}"
                  aria-labelledby="create-heading{{ $language->id }}" data-parent="#createAccordion">
                  <div class="version-body {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                    <div class="form-group">
                      <label>{{ __('Title') . '*' }}</label>
                      <input type="text" class="form-control"
                        name="{{ $language->code }}_title"
                        placeholder="{{ __('Enter Amenity Title') }}">
                      <p id="err_{{ $language->code }}_title" class="mt-2 mb-0 text-danger em"></p>
                    </div>
                  </div>
                </div>
              </div>
            @endforeach
          </div>

          <div class="form-group mt-3">
            <label for="">{{ __('Icon') . '*' }}</label>
            <div class="btn-group d-block">
              <button type="button" class="btn btn-primary iconpicker-component">
                <i class="fa fa-fw fa-heart"></i>
              </button>
              <button type="button" class="icp icp-dd btn btn-primary dropdown-toggle" data-selected="fa-car"
                data-toggle="dropdown"></button>
              <div class="dropdown-menu"></div>
            </div>
            <div class="text-warning mt-2">
              <small>{{ __('Click on the dropdown icon to select an icon') . '.' }}</small>
            </div>
          </div>
          <input type="hidden" id="inputIcon" name="icon">
          <p id="err_icon" class="mt-2 mb-0 text-danger em"></p>
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
