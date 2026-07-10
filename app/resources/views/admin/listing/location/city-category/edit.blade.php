<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-centered" role="document"><div class="modal-content">
    <div class="modal-header"><h5 class="modal-title">{{ __('Edit City Category') }}</h5><button type="button" class="close" data-dismiss="modal">&times;</button></div>
    <div class="modal-body">
      <form id="ajaxEditForm" class="modal-form" action="{{ route('admin.listing_specification.location.update_city_category') }}" method="post">
        @csrf<input type="hidden" name="id" id="in_id">
        <div class="row">
          <div class="col-md-4 form-group"><label>{{ __('Country') }}*</label><select class="form-control city-category-country" id="in_country_id"><option value="">{{ __('Select a country') }}</option>@foreach ($countries as $country)<option value="{{ $country->id }}">{{ $country->getName($language->id) }}</option>@endforeach</select></div>
          <div class="col-md-4 form-group"><label>{{ __('State') }}</label><select class="form-control city-category-state" id="in_state_id"><option value="">{{ __('All states') }}</option>@foreach ($states as $state)<option value="{{ $state->id }}">{{ $state->getName($language->id) }}</option>@endforeach</select></div>
          <div class="col-md-4 form-group"><label>{{ __('City') }}*</label><select class="form-control city-category-city" name="city_id" id="in_city_id"><option value="">{{ __('Select a city') }}</option></select></div>
          <div class="col-md-6 form-group"><label>{{ __('Category') }}*</label><select class="form-control" name="listing_category_id" id="in_listing_category_id"><option value="">{{ __('Select a category') }}</option>@foreach ($categoryOptions as $option)<option value="{{ $option['id'] }}">{{ str_repeat('— ', $option['level']) }}{{ $option['name'] }}</option>@endforeach</select></div>
        </div>
        <div id="editCityCategoryAccordion" class="mt-3">
          @foreach ($langs as $lang)
            <div class="version">
              <div class="version-header" id="edit-city-category-heading{{ $lang->id }}">
                <h5 class="mb-0">
                  <button type="button" class="btn btn-link" data-toggle="collapse"
                    data-target="#edit-city-category-collapse{{ $lang->id }}"
                    aria-expanded="{{ $lang->is_default == 1 ? 'true' : 'false' }}"
                    aria-controls="edit-city-category-collapse{{ $lang->id }}">
                    {{ $lang->name }}
                    {{ $lang->is_default == 1 ? __('(Default)') : '' }}
                  </button>
                </h5>
              </div>
              <div id="edit-city-category-collapse{{ $lang->id }}"
                class="collapse {{ $lang->is_default == 1 ? 'show' : '' }}"
                aria-labelledby="edit-city-category-heading{{ $lang->id }}"
                data-parent="#editCityCategoryAccordion">
                <div class="version-body {{ $lang->direction == 1 ? 'rtl text-right' : '' }}">
                  <div class="form-group"><label>{{ __('H1 title') }}</label><input type="text" id="in_{{ $lang->code }}_name" class="form-control" name="{{ $lang->code }}_name" placeholder="{{ __('Generated from city and category') }}"></div>
                  <div class="form-group"><label>{{ __('Slug') }}</label><input type="text" id="in_{{ $lang->code }}_slug" class="form-control" name="{{ $lang->code }}_slug"></div>
                  <div class="form-group"><label>{{ __('Meta title') }}</label><input type="text" id="in_{{ $lang->code }}_meta_title" class="form-control" name="{{ $lang->code }}_meta_title"></div>
                  <div class="form-group"><label>{{ __('Meta description') }}</label><textarea id="in_{{ $lang->code }}_meta_description" class="form-control" name="{{ $lang->code }}_meta_description" rows="2"></textarea></div>
                  <div class="form-group mb-0"><label>{{ __('SEO text') }}</label><textarea id="in_{{ $lang->code }}_seo_text" class="form-control" name="{{ $lang->code }}_seo_text" rows="4"></textarea></div>
                </div>
              </div>
            </div>
          @endforeach
        </div>
      </form>
    </div>
    <div class="modal-footer"><button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">{{ __('Close') }}</button><button id="updateBtn" type="button" class="btn btn-primary btn-sm">{{ __('Update') }}</button></div>
  </div></div>
</div>
