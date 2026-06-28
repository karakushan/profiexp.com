<div id="zx">
    <div class="widget-offcanvas offcanvas-xl offcanvas-start" tabindex="-1" id="widgetOffcanvas"
        aria-labelledby="widgetOffcanvas">
        <div class="offcanvas-header px-20">
            <h4 class="offcanvas-title">Filter</h4>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-target="#widgetOffcanvas"
                aria-label="Close"></button>
        </div>
        <div class="offcanvas-body p-3 p-xl-0" id="xx">
            <aside class="widget-area pb-10">
                <div class="widget widget-categories radius-md mb-30">
                    <h5 class="title">
                        <button class="accordion-button" type="button" data-bs-toggle="collapse"
                            data-bs-target="#categories" aria-expanded="true" aria-controls="categories">
                            {{ __('Categories') }}
                        </button>
                    </h5>
                    <div id="categories" class="collapse show">
                        <div class="accordion-body">
                            <ul class="list-group" id="categoriesList" data-toggle-list="categoriesToggle">
                                <li class="list-item open">
                                    <a href="#" class="category-toggle open" id="">
                                        {{ __('All') }}
                                    </a>
                                </li>
                                @foreach ($categories as $categorie)
                                    @php $catSlug = $categorie->getSlug($language->id); @endphp
                                    <li class="list-item @if (request()->input('category_id') == $catSlug) open @endif">
                                        <a href="#" class="category-toggle" id="{{ $catSlug }}">
                                            {{ $categorie->getName($language->id) }}
                                        </a>
                                    </li>
                                @endforeach
                                @if ($childCategories->isNotEmpty())
                                    @foreach ($childCategories as $child)
                                        @php $childSlug = $child->getSlug($language->id); @endphp
                                        <li class="list-item @if (request()->input('category_id') == $childSlug) open @endif">
                                            <a href="#" class="category-toggle" id="{{ $childSlug }}">
                                                &nbsp;&nbsp;&nbsp;{{ $child->getName($language->id) }}
                                            </a>
                                        </li>
                                    @endforeach
                                @endif
                            </ul>
                            @if ($hasMore)
                                <div class="load-more-btn-group">
                                    <span class="show-more font-sm loadMoreCategories" data-offset="10"
                                        data-action="more">
                                        {{ __('Show More') }} +
                                    </span>
                                    <span class="show-more show-less-category font-sm loadMoreCategories"
                                        data-offset="10" style="display: none" data-action="less">
                                        {{ __('Show Less') }} -
                                    </span>
                                </div>
                            @endif
                        </div>
                    </div>
                </div>
                <div id="filter-div">
                    <div class="widget radius-md mb-30">
                        <h5 class="title">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                data-bs-target="#options" aria-expanded="true" aria-controls="options">
                                {{ __('Filters') }}
                            </button>
                        </h5>
                        <div id="options" class="collapse show">
                            <div class="accordion-body">
                                <div class="form-group icon-end mb-20 ">
                                    <input type="text" class="form-control" value="{{ request()->input('title') }}"
                                        id="searchBytTitle" name="title" placeholder="{{ __('Enter Title') }}">
                                    <label class="mb-0 color-primary"><i class="fal fa-search"></i></label>
                                </div>
                                <div class="form-group icon-end mb-20">
                                    <input type="text" class="form-control"id="location"
                                        value="{{ request()->input('location') }}" name="location"
                                        placeholder="{{ __('Enter Location') }} ">
                                    @if ($basicInfo->google_map_api_key_status == 1)
                                        <button type="button" class="btn btn-sm current-location"
                                            onclick="getCurrentLocation()">
                                            <i class="fas fa-crosshairs"></i>
                                        </button>
                                    @endif
                                </div>

                                <div class="form-group mb-20">
                                    <select class="form-control select2 vendorDropdown" id="vendorDropdown"
                                        aria-labelledby="vendorLabel">
                                        <option value="" selected disabled>{{ __('Select Vendor') }}</option>
                                        <option value="">{{ __('All') }}</option>
                                        <option value="admin">{{ __('Admin') }}</option>
                                        @foreach ($vendors as $vendor)
                                            <option value="{{ $vendor->vendor_id }}">{{ $vendor->username }}</option>
                                        @endforeach
                                    </select>
                                </div>

                                @if ($countries->count() > 0)
                                    <div class="form-group mb-20">
                                        <select class="form-control js-select-country-ajax countryDropdown"
                                            id="countryDropdown">
                                        </select>
                                    </div>
                                @endif

                                @if ($states->count() > 0)
                                    <div class="form-group mb-20 hide_state">
                                        <select class="form-control js-select-state-ajax stateDropdown"
                                            id="stateDropdown">
                                        </select>
                                    </div>
                                @endif

                                @if (request()->input('city'))
                                    <div class="form-group">
                                        <select class="form-control js-select-city-ajax cityDropdown" id="cityDropdown">
                                            <option selected value="{{ $searchCity }}">
                                                {{ $searchCity }}
                                            </option>
                                        </select>
                                    </div>
                                @else
                                    <div class="form-group">
                                        <select class="form-control cityDropdown js-select-city-ajax"
                                            id="cityDropdown"></select>
                                    </div>
                                @endif
                            </div>
                        </div>
                    </div>
                </div>

                <div id="amenities-div">
                    <div class="widget widget-amenities radius-md mb-30">
                        <h5 class="title">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                data-bs-target="#amenities" aria-expanded="true" aria-controls="amenities">
                                {{ __('Amenities') }}

                            </button>
                        </h5>
                        <div id="amenities" class="collapse show">
                            <div class="accordion-body">
                                <ul class="list-group custom-checkbox toggle-list" data-toggle-list="amenitiesToggle"
                                    data-toggle-show="5">
                                    @php
                                        $aminities = App\Models\Aminite::where('language_id', $language->id)->get();
                                        $vv = request()->input('amenitie');
                                        $hasaminitie = explode(',', $vv);
                                    @endphp

                                    @foreach ($aminities as $aminitie)
                                        @if (in_array($aminitie->id, $hasaminitie))
                                            <li>
                                                <input class="input-checkbox" type="checkbox" name="checkbox"
                                                    id="checkbox_{{ $aminitie->id }}" value="{{ $aminitie->id }}"
                                                    checked>
                                                <label class="form-check-label"
                                                    for="checkbox_{{ $aminitie->id }}"><span>{{ $aminitie->title }}</label>
                                            </li>
                                        @else
                                            <li>
                                                <input class="input-checkbox" type="checkbox" name="checkbox"
                                                    id="checkbox_{{ $aminitie->id }}" value="{{ $aminitie->id }}">
                                                <label class="form-check-label"
                                                    for="checkbox_{{ $aminitie->id }}"><span>{{ $aminitie->title }}</span></label>
                                            </li>
                                        @endif
                                    @endforeach
                                </ul>
                                <span class="show-more font-sm" data-toggle-btn="toggleListBtn">
                                    {{ __('Show More') }} +
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                @php
                    $oMin = $o_min ?? null;
                    $oMax = $o_max ?? null;
                    $minV = $min ?? null;
                    $maxV = $max ?? null;

                    $allPriceNull = is_null($oMin) && is_null($oMax) && is_null($minV) && is_null($maxV);
                @endphp
                @if (!$allPriceNull)
                    <div class="widget widget-price radius-md mb-30">
                        <h5 class="title">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                data-bs-target="#price" aria-expanded="true" aria-controls="price">
                                {{ __('Pricing Filter') }}
                            </button>
                        </h5>
                        <div id="price" class="collapse show">
                            <div class="accordion-body">
                                <input class="form-control" type="hidden"
                                    value="{{ request()->filled('min_val') ? request()->input('min_val') : $min ?? '' }}"
                                    name="min" id="min">
                                <input class="form-control" type="hidden" value="{{ $min ?? '' }}"
                                    id="o_min">
                                <input class="form-control" type="hidden" value="{{ $max ?? '' }}"
                                    id="o_max">
                                <input class="form-control"
                                    value="{{ request()->filled('max_val') ? request()->input('max_val') : $max ?? '' }}"
                                    type="hidden" name="max" id="max">
                                <input type="hidden" id="currency_symbol"
                                    value="{{ $basicInfo->base_currency_symbol }}">
                                <div class="price-item">
                                    <div class="price-slider" data-range-slider='filterPriceSlider'></div>
                                    <div class="price-value">
                                        <span class="color-dark">{{ __('Price') }}:
                                            <span class="filter-price-range"
                                                data-range-value='filterPriceSliderValue'></span>
                                        </span>
                                    </div>
                                </div>
                                {{-- Price Not Mentioned Checkbox --}}
                                <div class="price-option  mt-20 pt-20 border-top">
                                    <div class="custom-checkbox">
                                        <input class="input-checkbox" type="checkbox" id="price_not_mentioned"
                                            value="1" {{ request('price_not_mentioned') ? 'checked' : '' }}>
                                        <label class="form-check-label" for="price_not_mentioned">
                                            {{-- <i class="fas fa-tag me-1 text-primary"></i> --}}
                                            <span>{{ __('Price Not Mentioned') }}</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                @endif
                <div id="rating-div">
                    <div class="widget widget-rating radius-md mb-30">
                        <h5 class="title">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                data-bs-target="#rating" aria-expanded="true" aria-controls="rating">
                                {{ __('Rating') }}
                            </button>
                        </h5>
                        <div id="rating" class="collapse fade show">
                            <div class="accordion-body">
                                <ul class="list-group custom-radio">
                                    <li>
                                        <input class="input-radio" type="radio" name="radio" id="radio6"
                                            value="0"@if (request()->input('ratings') == '') checked @endif>
                                        <label class="form-radio-label" for="radio6">
                                            <div class="product-ratings text-xsm">
                                                <span>{{ __('All') }}</span>
                                            </div>
                                        </label>
                                    </li>
                                    <li>
                                        <input class="input-radio" type="radio" name="radio" id="radio1"
                                            value="5" @if (request()->input('ratings') == '5') checked @endif>
                                        <label class="form-radio-label" for="radio1">
                                            <div class="product-ratings text-xsm">
                                                <span>{{ __('5 stars') }}</span>
                                            </div>
                                        </label>
                                    </li>
                                    <li>
                                        <input class="input-radio" type="radio" name="radio" id="radio2"
                                            value="4"@if (request()->input('ratings') == '4') checked @endif>
                                        <label class="form-radio-label" for="radio2">
                                            <div class="product-ratings text-xsm">
                                                <span>{{ __('4 stars and above') }}</span>
                                            </div>
                                        </label>
                                    </li>
                                    <li>
                                        <input class="input-radio" type="radio" name="radio" id="radio3"
                                            value="3"@if (request()->input('ratings') == '3') checked @endif>
                                        <label class="form-radio-label" for="radio3">
                                            <div class="product-ratings text-xsm">
                                                <span>{{ __('3 stars and above') }}</span>
                                            </div>
                                        </label>
                                    </li>
                                    <li>
                                        <input class="input-radio" type="radio" name="radio" id="radio4"
                                            value="2"@if (request()->input('ratings') == '2') checked @endif>
                                        <label class="form-radio-label" for="radio4">
                                            <div class="product-ratings text-xsm">
                                                <span>{{ __('2 stars and above') }}</span>
                                            </div>
                                        </label>
                                    </li>
                                    <li>
                                        <input class="input-radio" type="radio" name="radio" id="radio5"
                                            value="1"@if (request()->input('ratings') == '1') checked @endif>
                                        <label class="form-radio-label" for="radio5">
                                            <div class="product-ratings text-xsm">
                                                <span>{{ __('1 star and above') }}</span>
                                            </div>
                                        </label>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="cta mb-30">
                    <a href="{{ route('frontend.listings') }}" class="btn btn-lg btn-primary icon-start w-100"><i
                            class="fal fa-sync-alt"></i>{{ __('Reset All') }}</a>
                </div>
            </aside>
        </div>
    </div>
</div>
