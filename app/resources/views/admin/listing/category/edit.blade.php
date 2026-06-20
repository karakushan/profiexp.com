<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
    aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">{{ __('Edit Listing Category') }}</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body">
                <form id="ajaxEditForm" class="modal-form {{ $language->direction == 1 ? 'rtl text-right' : '' }}"
                    action="{{ route('admin.listing_specification.update_category') }}" method="post"
                    enctype="multipart/form-data">
                    @csrf
                    <input type="hidden" id="in_id" name="id">
                    <input type="hidden" id="in_language_id" name="language_id">

                    <div class="form-group">
                        <label for="">{{ __('Name') . '*' }}</label>
                        <input type="text" id="in_name" class="form-control" name="name"
                            placeholder="{{ __('Enter Category Name') }}">
                        <p id="editErr_name" class="mt-2 mb-0 text-danger em"></p>
                    </div>
                    <div class="form-group">
                        <label for="">{{ __('Icon') . '*' }}</label>
                        <div class="btn-group d-block">
                            <button type="button"
                                class="btn btn-primary iconpicker-component edit-iconpicker-component">
                                <i class="" id="in_icon"></i>
                            </button>
                            <button type="button" class="icp icp-dd btn btn-primary dropdown-toggle"
                                data-selected="fa-car" data-toggle="dropdown"></button>
                            <div class="dropdown-menu"></div>
                        </div>

                        <input type="hidden" id="editInputIcon" name="icon">
                        <p id="editErr_icon" class="mt-2 mb-0 text-danger em"></p>

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
                            <img src="" alt="..." class="uploaded-img in_mobile_image">
                        </div>

                        <div class="mt-3">
                            <div role="button" class="btn btn-primary btn-sm upload-btn">
                                {{ __('Choose Image') }}
                                <input type="file" class="img-input" name="mobile_image">
                            </div>
                        </div>
                        <p id="editErr_mobile_image" class="mt-2 mb-0 text-danger em"></p>
                        <span class="text-warning">
                            <strong>{{ __('Note') . ' : ' }}</strong>
                            <small>{{ __('This image will be used in the mobile app interface.') }}</small>
                            <br>
                            <small>{{ __('The category icon will not appear in the app, so please upload an image for app display.') }}</small>
                        </span>

                    </div>

                    <div class="form-group">
                        <label for="">{{ __('Status') . '*' }}</label>
                        <select name="status" id="in_status" class="form-control">
                            <option disabled>{{ __('Select Category Status') }}</option>
                            <option value="1">{{ __('Active') }}</option>
                            <option value="0">{{ __('Deactive') }}</option>
                        </select>
                        <p id="editErr_status" class="mt-2 mb-0 text-danger em"></p>
                    </div>

                    <div class="form-group">
                        <label for="">{{ __('Serial Number') . '*' }}</label>
                        <input type="number" id="in_serial_number" class="form-control ltr" name="serial_number"
                            placeholder="{{ __('Enter Category Serial Number') }}">
                        <p id="editErr_serial_number" class="mt-2 mb-0 text-danger em"></p>
                        <p class="text-warning mt-2 mb-0">
                            <small>{{ __('The higher the serial number is, the later the category will be shown'), '.' }}</small>
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
