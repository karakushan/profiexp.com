<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
  aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">{{ __('Edit Blog Category') }}</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <div class="modal-body">
        <form id="ajaxEditForm" class="modal-form" action="{{ route('admin.blog_management.update_category') }}"
          method="post">
          @csrf
          <input type="hidden" id="in_id" name="id">

          <div id="editAccordion" class="mt-3">
            @foreach ($langs as $language)
              <div class="version">
                <div class="version-header" id="edit-heading{{ $language->id }}">
                  <h5 class="mb-0">
                    <button type="button" class="btn btn-link" data-toggle="collapse"
                      data-target="#edit-collapse{{ $language->id }}"
                      aria-expanded="{{ $language->is_default == 1 ? 'true' : 'false' }}"
                      aria-controls="edit-collapse{{ $language->id }}">
                      {{ $language->name }}
                      {{ $language->is_default == 1 ? __('(Default)') : '' }}
                    </button>
                  </h5>
                </div>
                <div id="edit-collapse{{ $language->id }}"
                  class="collapse {{ $language->is_default == 1 ? 'show' : '' }}"
                  aria-labelledby="edit-heading{{ $language->id }}" data-parent="#editAccordion">
                  <div class="version-body {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                    <div class="form-group">
                      <label>{{ __('Category Name') . '*' }}</label>
                      <input type="text" id="in_{{ $language->code }}_name" class="form-control"
                        name="{{ $language->code }}_name"
                        placeholder="{{ __('Enter Category Name') }}">
                      <p id="editErr_{{ $language->code }}_name" class="mt-2 mb-0 text-danger em"></p>
                    </div>
                    <div class="form-group">
                      <label>{{ __('Meta Title') }}</label>
                      <input type="text" id="in_{{ $language->code }}_meta_title" class="form-control"
                        name="{{ $language->code }}_meta_title"
                        placeholder="{{ __('Enter Meta Title') }}">
                      <p id="editErr_{{ $language->code }}_meta_title" class="mt-2 mb-0 text-danger em"></p>
                    </div>
                    <div class="form-group">
                      <label>{{ __('Meta Description') }}</label>
                      <textarea id="in_{{ $language->code }}_meta_description" class="form-control"
                        name="{{ $language->code }}_meta_description" rows="3"
                        placeholder="{{ __('Enter Meta Description') }}"></textarea>
                      <p id="editErr_{{ $language->code }}_meta_description" class="mt-2 mb-0 text-danger em"></p>
                    </div>
                    <div class="form-group">
                      <label>{{ __('SEO Text') }}</label>
                      <textarea id="in_{{ $language->code }}_seo_text" class="form-control"
                        name="{{ $language->code }}_seo_text" rows="4"
                        placeholder="{{ __('Enter SEO Text') }}"></textarea>
                      <p id="editErr_{{ $language->code }}_seo_text" class="mt-2 mb-0 text-danger em"></p>
                    </div>
                  </div>
                </div>
              </div>
            @endforeach
          </div>

          <div class="form-group">
            <label for="">{{ __('Category Status') . '*' }}</label>
            <select name="status" id="in_status" class="form-control">
              <option disabled>{{ __('Select a Status') }}</option>
              <option value="1">{{ __('Active') }}</option>
              <option value="0">{{ __('Deactive') }}</option>
            </select>
            <p id="editErr_status" class="mt-2 mb-0 text-danger em"></p>
          </div>

          <div class="form-group">
            <label for="">{{ __('Category Serial Number') . '*' }}</label>
            <input type="number" id="in_serial_number" class="form-control ltr" name="serial_number"
              placeholder="{{ __('Enter Category Serial Number') }}">
            <p id="editErr_serial_number" class="mt-2 mb-0 text-danger em"></p>
            <p class="text-warning mt-2 mb-0">
              <small>{{ __('The higher the serial number is, the later the category will be shown.') }}</small>
            </p>
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
