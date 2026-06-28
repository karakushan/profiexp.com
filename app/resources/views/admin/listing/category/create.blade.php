<div class="modal fade" id="createModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
    aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">{{ __('Add Listing Category') }}</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body">
                <form id="ajaxForm" class="modal-form create"
                    action="{{ route('admin.listing_specification.store_category') }}" method="post"
                    enctype="multipart/form-data">
                    @csrf

                    <div class="form-group">
                        <label for="">{{ __('Parent Category') }}</label>
                        <select name="parent_id" class="form-control">
                            <option value="">{{ __('None (Root Category)') }}</option>
                            @foreach (\App\Models\ListingCategory::root()->with('allChildren')->orderBy('serial_number')->get() as $parentCat)
                                @include('admin.listing.category._parent_option', ['category' => $parentCat, 'level' => 0])
                            @endforeach
                        </select>
                        <p id="err_parent_id" class="mt-2 mb-0 text-danger em"></p>
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
                                <div id="create-collapse{{ $language->id }}"
                                    class="collapse {{ $language->is_default == 1 ? 'show' : '' }}"
                                    aria-labelledby="create-heading{{ $language->id }}" data-parent="#createAccordion">
                                    <div class="version-body {{ $language->direction == 1 ? 'rtl text-right' : '' }}">
                                        <div class="form-group">
                                            <label>{{ __('Name') . '*' }}</label>
                                            <input type="text" class="form-control"
                                                name="{{ $language->code }}_name"
                                                placeholder="{{ __('Enter Category Name') }}">
                                            <p id="err_{{ $language->code }}_name" class="mt-2 mb-0 text-danger em"></p>
                                        </div>
                                        <div class="form-group">
                                            <label>{{ __('Meta Title') }}</label>
                                            <input type="text" class="form-control"
                                                name="{{ $language->code }}_meta_title"
                                                placeholder="{{ __('Enter Meta Title') }}">
                                            <p id="err_{{ $language->code }}_meta_title" class="mt-2 mb-0 text-danger em"></p>
                                        </div>
                                        <div class="form-group">
                                            <label>{{ __('Meta Description') }}</label>
                                            <textarea class="form-control" name="{{ $language->code }}_meta_description" rows="3"
                                                placeholder="{{ __('Enter Meta Description') }}"></textarea>
                                            <p id="err_{{ $language->code }}_meta_description" class="mt-2 mb-0 text-danger em"></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        @endforeach
                    </div>

                    <div class="form-group">
                        <label for="">{{ __('Icon') . '*' }}</label>
                        <div class="btn-group d-block">
                            <button type="button" class="btn btn-primary iconpicker-component">
                                <i class="fas fa-shopping-cart"></i>
                            </button>
                            <button type="button" class="icp icp-dd btn btn-primary dropdown-toggle"
                                data-selected="fa-car" data-toggle="dropdown"></button>
                            <div class="dropdown-menu"></div>
                        </div>

                        <input type="hidden" id="inputIcon" name="icon">
                        <p id="err_icon" class="mt-2 mb-0 text-danger em"></p>

                        <div class="text-warning mt-2">
                            <small>{{ __('Click on the dropdown icon to select an icon') . '.' }}</small>
                        </div>
                    </div>
                    <!--image for mobile app-->
                    <div class="form-group">
                        <label>{{ __('Featured Image') . '*' }} <span
                                class="text-muted">({{ __('For mobile app display') }})</span></label>
                        <br>
                        <div class="thumb-preview">
                            <img src="{{ asset('assets/img/noimage.jpg') }}" alt="..." class="uploaded-img">
                        </div>

                        <div class="mt-3">
                            <div role="button" class="btn btn-primary btn-sm upload-btn">
                                {{ __('Choose Image') }}
                                <input type="file" class="img-input" name="mobile_image">
                            </div>
                        </div>
                        <p id="err_mobile_image" class="mt-2 mb-0 text-danger em"></p>
                        <span class="text-warning">
                            <strong>{{ __('Note') . ' : ' }}</strong>
                            <small>{{ __('This image will be used in the mobile app interface.') }}</small>
                            <br>
                            <small>{{ __('The category icon will not appear in the app, so please upload an image for app display.') }}</small>
                        </span>
                    </div>

                    <div class="form-group">
                        <label for="">{{ __('Status') . '*' }}</label>
                        <select name="status" class="form-control">
                            <option selected disabled>{{ __('Select Category Status') }}</option>
                            <option value="1">{{ __('Active') }}</option>
                            <option value="0">{{ __('Deactive') }}</option>
                        </select>
                        <p id="err_status" class="mt-2 mb-0 text-danger em"></p>
                    </div>

                    <div class="form-group">
                        <label for="">{{ __('Serial Number') . '*' }}</label>
                        <input type="number" class="form-control ltr" name="serial_number"
                            placeholder="{{ __('Enter Category Serial Number') }}">
                        <p id="err_serial_number" class="mt-2 mb-0 text-danger em"></p>
                        <p class="text-warning mt-2 mb-0">
                            <small>{{ __('The higher the serial number is, the later the category will be shown') . '.' }}</small>
                        </p>
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