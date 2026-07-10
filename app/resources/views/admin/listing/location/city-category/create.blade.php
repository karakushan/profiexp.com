<div class="modal fade" id="createModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-centered" role="document"><div class="modal-content">
    <div class="modal-header"><h5 class="modal-title">{{ __('Add City Category') }}</h5><button type="button" class="close" data-dismiss="modal">&times;</button></div>
    <div class="modal-body">
      <form id="ajaxForm" class="modal-form create" action="{{ route('admin.listing_specification.location.store_city_category') }}" method="post">
        @csrf
        <div class="row">
          <div class="col-md-4 form-group"><label>{{ __('Country') }}*</label><select class="form-control city-category-country" name="country_id"><option value="">{{ __('Select a country') }}</option>@foreach ($countries as $country)<option value="{{ $country->id }}">{{ $country->getName($language->id) }}</option>@endforeach</select></div>
          <div class="col-md-4 form-group"><label>{{ __('State') }}</label><select class="form-control city-category-state" name="state_id"><option value="">{{ __('All states') }}</option>@foreach ($states as $state)<option value="{{ $state->id }}" data-country="{{ $state->country_id }}">{{ $state->getName($language->id) }}</option>@endforeach</select></div>
          <div class="col-md-4 form-group"><label>{{ __('City') }}*</label><select class="form-control city-category-city" name="city_id"><option value="">{{ __('Select a city') }}</option></select><p id="err_city_id" class="mt-2 mb-0 text-danger em"></p></div>
          <div class="col-md-6 form-group"><label>{{ __('Category') }}*</label><select class="form-control" name="listing_category_id"><option value="">{{ __('Select a category') }}</option>@foreach ($categories as $category)<option value="{{ $category->id }}">{{ $category->getName($language->id) }}</option>@endforeach</select><p id="err_listing_category_id" class="mt-2 mb-0 text-danger em"></p></div>
        </div>
        <hr>
        <div id="createCityCategoryAccordion" class="mt-3">
          @foreach ($langs as $lang)
            <div class="version">
              <div class="version-header" id="create-city-category-heading{{ $lang->id }}">
                <h5 class="mb-0">
                  <button type="button" class="btn btn-link" data-toggle="collapse"
                    data-target="#create-city-category-collapse{{ $lang->id }}"
                    aria-expanded="{{ $lang->is_default == 1 ? 'true' : 'false' }}"
                    aria-controls="create-city-category-collapse{{ $lang->id }}">
                    {{ $lang->name }}
                    {{ $lang->is_default == 1 ? __('(Default)') : '' }}
                  </button>
                </h5>
              </div>
              <div id="create-city-category-collapse{{ $lang->id }}"
                class="collapse {{ $lang->is_default == 1 ? 'show' : '' }}"
                aria-labelledby="create-city-category-heading{{ $lang->id }}"
                data-parent="#createCityCategoryAccordion">
                <div class="version-body {{ $lang->direction == 1 ? 'rtl text-right' : '' }}">
                  <div class="form-group"><label>{{ __('H1 title') }}</label><input type="text" class="form-control" name="{{ $lang->code }}_name" placeholder="{{ __('Generated from city and category') }}"></div>
                  <div class="form-group"><label>{{ __('Slug') }}</label><input type="text" class="form-control" name="{{ $lang->code }}_slug" placeholder="{{ __('Generated automatically') }}"></div>
                  <div class="form-group"><label>{{ __('Meta title') }}</label><input type="text" class="form-control" name="{{ $lang->code }}_meta_title"></div>
                  <div class="form-group"><label>{{ __('Meta description') }}</label><textarea class="form-control" name="{{ $lang->code }}_meta_description" rows="2"></textarea></div>
                  <div class="form-group mb-0"><label>{{ __('SEO text') }}</label><textarea class="form-control" name="{{ $lang->code }}_seo_text" rows="4"></textarea></div>
                </div>
              </div>
            </div>
          @endforeach
        </div>
      </form>
    </div>
    <div class="modal-footer"><button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">{{ __('Close') }}</button><button id="submitBtn" type="button" class="btn btn-primary btn-sm">{{ __('Save') }}</button></div>
  </div></div>
</div>
