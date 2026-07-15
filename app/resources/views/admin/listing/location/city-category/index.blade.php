@extends('admin.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('City Categories') }}</h4>
    <ul class="breadcrumbs">
      <li class="nav-home"><a href="{{ route('admin.dashboard') }}"><i class="flaticon-home"></i></a></li>
      <li class="separator"><i class="flaticon-right-arrow"></i></li>
      <li class="nav-item"><a href="#">{{ __('Listing Specifications') }}</a></li>
      <li class="separator"><i class="flaticon-right-arrow"></i></li>
      <li class="nav-item"><a href="#">{{ __('Location') }}</a></li>
      <li class="separator"><i class="flaticon-right-arrow"></i></li>
      <li class="nav-item"><a href="#">{{ __('City Categories') }}</a></li>
    </ul>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <div class="row align-items-center">
            <div class="col-lg-7"><div class="card-title">{{ __('City Categories') }}</div></div>
            <div class="col-lg-5 text-right">
              <a href="#" data-toggle="modal" data-target="#createModal" class="btn btn-primary btn-sm">
                <i class="fas fa-plus"></i> {{ __('Add') }}
              </a>
              <button class="btn btn-danger btn-sm ml-2 d-none bulk-delete"
                data-href="{{ route('admin.listing_specification.location.bulk_delete_city_category') }}">
                <i class="flaticon-interface-5"></i> {{ __('Delete') }}
              </button>
            </div>
          </div>
        </div>

        <div class="card-body">
          <form method="get" class="form-inline mb-3">
            <input type="hidden" name="language" value="{{ $language->code }}">
            <label for="translation_status" class="mr-2">{{ __('Translation status') }}</label>
            <select id="translation_status" name="translation_status" class="form-control form-control-sm" onchange="this.form.submit()">
              <option value="all" @selected($translationStatus === 'all')>{{ __('All') }}</option>
              <option value="translated" @selected($translationStatus === 'translated')>{{ __('Translated') }}</option>
              <option value="partial" @selected($translationStatus === 'partial')>{{ __('Partially translated') }}</option>
              <option value="untranslated" @selected($translationStatus === 'untranslated')>{{ __('Not translated') }}</option>
            </select>
          </form>
          @if ($items->isEmpty())
            <h3 class="text-center mt-2">{{ __('NO CITY CATEGORIES FOUND') . '!' }}</h3>
          @else
            <div class="table-responsive">
              <table class="table table-striped mt-3" id="basic-datatables">
                <thead><tr>
                  <th><input type="checkbox" class="bulk-check" data-val="all"></th>
                  <th>{{ __('City') }}</th><th>{{ __('Category') }}</th><th>{{ __('Translations') }}</th><th>{{ __('Actions') }}</th>
                </tr></thead>
                <tbody>
                  @foreach ($items as $item)
                    <tr>
                      <td><input type="checkbox" class="bulk-check" data-val="{{ $item->id }}"></td>
                      <td>{{ $item->city->getName($language->id) }}</td>
                      <td>{{ $item->category->getName($language->id) }}</td>
                      <td>
                        @foreach ($item->contents as $content)
                          @php($isComplete = $content->isComplete())
                          @if ($isComplete || $content->isPartiallyTranslated())
                          <span class="badge {{ $isComplete ? 'badge-success' : 'badge-warning' }} mr-1"
                            title="{{ ($content->language->name ?? '') . ' — ' . ($isComplete ? __('Translated') : __('Partially translated')) }}">
                            {{ strtoupper($content->language->code ?? '—') }}
                          </span>
                          @endif
                        @endforeach
                      </td>
                      <td>
                        @if ($item->getTranslation($language->id)?->slug)
                          <a class="btn btn-primary btn-sm mr-1 mt-1" target="_blank"
                            href="{{ listing_city_category_url($item, $language->code) }}" title="{{ __('View Listings') }}">
                            <i class="fas fa-list"></i>
                          </a>
                        @endif
                        <a class="btn btn-secondary btn-sm mr-1 mt-1 editBtn city-category-edit-btn" href="#" data-toggle="modal" data-target="#editModal"
                          data-id="{{ $item->id }}" data-city_id="{{ $item->city_id }}" data-country_id="{{ $item->city->country_id }}" data-state_id="{{ $item->city->state_id }}" data-listing_category_id="{{ $item->listing_category_id }}"
                          @foreach ($item->contents as $content)
                            data-{{ $content->language->code }}_name="{{ $content->name }}"
                            data-{{ $content->language->code }}_slug="{{ $content->slug }}"
                            data-{{ $content->language->code }}_meta_title="{{ $content->meta_title }}"
                            data-{{ $content->language->code }}_meta_description="{{ $content->meta_description }}"
                            data-{{ $content->language->code }}_seo_text="{{ $content->seo_text }}"
                          @endforeach>
                          <i class="fas fa-edit"></i>
                        </a>
                        <form class="deleteForm d-inline-block" action="{{ route('admin.listing_specification.location.delete_city_category', $item->id) }}" method="post">
                          @csrf
                          <button type="submit" class="btn btn-danger btn-sm mt-1 deleteBtn"><i class="fas fa-trash"></i></button>
                        </form>
                      </td>
                    </tr>
                  @endforeach
                </tbody>
              </table>
            </div>
          @endif
        </div>
      </div>
    </div>
  </div>

  @include('admin.listing.location.city-category.create')
  @include('admin.listing.location.city-category.edit')
@endsection

@section('script')
  <script>
    "use strict";
    const cityCategoryCities = @json($cityCategoryCities);

    function fillCityCategoryCities(select, countryId, stateId) {
      const selected = select.value;
      select.innerHTML = '<option value="">{{ __('Select a city') }}</option>';
      cityCategoryCities.forEach(function (city) {
        if ((!countryId || String(city.country_id) === String(countryId)) && (!stateId || String(city.state_id) === String(stateId))) {
          const option = new Option(city.name, city.id);
          option.selected = String(city.id) === String(selected);
          select.add(option);
        }
      });
    }

    $(document).on('change', '.city-category-country', function () {
      const form = $(this).closest('form');
      fillCityCategoryCities(form.find('.city-category-city')[0], this.value, form.find('.city-category-state').val());
    });
    $(document).on('change', '.city-category-state', function () {
      const form = $(this).closest('form');
      fillCityCategoryCities(form.find('.city-category-city')[0], form.find('.city-category-country').val(), this.value);
    });
    $(document).on('click', '.city-category-edit-btn', function () {
      const data = $(this).data();
      const form = $('#editModal form');
      form.find('#in_country_id').val(data.country_id);
      form.find('#in_state_id').val(data.state_id || '');
      fillCityCategoryCities(form.find('.city-category-city')[0], data.country_id, data.state_id || '');
      form.find('#in_city_id').val(data.city_id);
    });
    $('#createModal').on('shown.bs.modal', function () {
      const form = $(this).find('form');
      fillCityCategoryCities(form.find('.city-category-city')[0], form.find('.city-category-country').val(), form.find('.city-category-state').val());
    });
  </script>
@endsection
