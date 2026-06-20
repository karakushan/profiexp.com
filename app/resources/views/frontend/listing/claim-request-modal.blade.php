<div class="modal fade" id="ClaimRequestModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
    aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">{{ __('Claim Request Form') }}</h5>
                <button type="button" class="modal_close" data-bs-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"><i class="fal fa-times"></i></span>
                </button>
            </div>
            @php
                $form = App\Models\Form::where('type', 'claim_request')->first();
            @endphp
    
            <div class="modal-body">
                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <form
                                action="{{ route('frontend.listing.claim.request_info.store') }}"
                                method="POST" enctype="multipart/form-data">
                                @csrf
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="form-group mb-20">
                                            <input type="hidden" name="user_id"
                                                value="{{ Auth::guard('web')->check() ? Auth::guard('web')->user()->id ?? '' : '' }}">

                                            <input type="hidden" name="user_id" value="" id="claim_user_id">
                                            <input type="hidden" name="listing_id" value="" id="claim_listing_id">
                                            <input type="hidden" name="form_id" value="{{ @$form->id}}">
                                            <input type="hidden" name="form_type" value="{{ @$form->type}}">
                                            <input type="hidden" name="vendor_id" value="" id="claim_vendor_id">
                                            <label for="name" class="form-label font-sm">{{ __('Name') }}*</label>
                                            <input id="name" type="text" class="form-control" name="name" placeholder="{{ __('Enter Name') }}" value="">
                                            @error('name')
                                                <p class="mt-2 text-danger">{{ $message }}</p>
                                            @enderror
                                        </div>
                                    </div>

                                    <div class="col-lg-6">
                                        <div class="form-group mb-20">
                                            <label for="email"
                                                class="form-label font-sm">{{ __('Email Address') }}*</label>
                                            <input id="email" type="email" class="form-control"
                                                name="email_address" placeholder="{{ __('Email Address') }}"
                                                value="{{ Auth::check() ? Auth::user()->email_address ?? '' : '' }}">
                                            @error('email_address')
                                                <p class="mt-2 text-danger">{{ $message }}</p>
                                            @enderror
                                        </div>
                                    </div>

                                    @foreach ($inputFields as $inputField)
                                        @if ($inputField->type == 1)
                                            <div class="col-md-6">
                                                <div class="form-group mb-30">
                                                    <label class="form-label">
                                                        {{ __($inputField->label) }}{{ $inputField->is_required == 1 ? '*' : '' }}
                                                    </label>
                                                    <input type="text" class="form-control"
                                                        name="{{ $inputField->name }}"
                                                        placeholder="{{ __($inputField->placeholder) }}"
                                                        value="{{ old($inputField->name) }}">
                                                    @error($inputField->name)
                                                        <p class="mt-2 text-danger">{{ $message }}</p>
                                                    @enderror
                                                </div>
                                            </div>
                                        @elseif ($inputField->type == 2)
                                            <div class="col-md-6">
                                                <div class="form-group mb-30">
                                                    <label class="form-label">
                                                        {{ __($inputField->label) }}{{ $inputField->is_required == 1 ? '*' : '' }}
                                                    </label>
                                                    <input type="number" class="form-control"
                                                        name="{{ $inputField->name }}"
                                                        placeholder="{{ __($inputField->placeholder) }}"
                                                        value="{{ old($inputField->name) }}">
                                                    @error($inputField->name)
                                                        <p class="mt-2 text-danger">{{ $message }}</p>
                                                    @enderror
                                                </div>
                                            </div>
                                        @elseif ($inputField->type == 3)
                                            @php $options = json_decode($inputField->options); @endphp

                                            <div class="col-md-6">
                                                <div class="form-group mb-30">
                                                    <label class="form-label">
                                                        {{ __($inputField->label) }}{{ $inputField->is_required == 1 ? '*' : '' }}
                                                    </label>
                                                    <select class="form-control" name="{{ $inputField->name }}">
                                                        <option selected disabled>{{ __($inputField->placeholder) }}
                                                        </option>

                                                        @foreach ($options as $option)
                                                            <option value="{{ $option }}"
                                                                {{ old($inputField->name) == $option ? 'selected' : '' }}>
                                                                {{ __($option) }}
                                                            </option>
                                                        @endforeach
                                                    </select>
                                                    @error($inputField->name)
                                                        <p class="mt-2 text-danger">{{ $message }}</p>
                                                    @enderror
                                                </div>
                                            </div>
                                        @elseif ($inputField->type == 4)
                                            @php $options = json_decode($inputField->options); @endphp

                                            <div class="col-12">
                                                <div class="form-group mb-30">
                                                    <label class="form-label">
                                                        {{ __($inputField->label) }}{{ $inputField->is_required == 1 ? '*' : '' }}
                                                    </label>
                                                    <br>
                                                    @foreach ($options as $option)
                                                        <div
                                                            class="custom-control custom-checkbox custom-control-inline">
                                                            <input type="checkbox"
                                                                id="{{ 'option-' . $loop->iteration }}"
                                                                name="{{ $inputField->name . '[]' }}"
                                                                class="custom-control-input"
                                                                value="{{ $option }}"
                                                                {{ is_array(old($inputField->name)) && in_array($option, old($inputField->name)) ? 'checked' : '' }}>
                                                            <label for="{{ 'option-' . $loop->iteration }}"
                                                                class="custom-control-label">{{ $option }}</label>
                                                        </div>
                                                    @endforeach
                                                    @error($inputField->name)
                                                        <p class="mt-2 text-danger">{{ $message }}</p>
                                                    @enderror
                                                </div>
                                            </div>
                                        @elseif ($inputField->type == 5)
                                            <div class="col-12">
                                                <div class="form-group mb-30">
                                                    <label class="form-label">
                                                        {{ __($inputField->label) }}{{ $inputField->is_required == 1 ? '*' : '' }}
                                                    </label>
                                                    <textarea class="form-control" name="{{ $inputField->name }}" placeholder="{{ __($inputField->placeholder) }}"
                                                        rows="2">{{ old($inputField->name) }}</textarea>
                                                    @error($inputField->name)
                                                        <p class="mt-2 text-danger">{{ $message }}</p>
                                                    @enderror
                                                </div>
                                            </div>
                                        @elseif ($inputField->type == 6)
                                            <div class="col-md-6">
                                                <div class="form-group mb-30">
                                                    <label class="form-label">
                                                        {{ __($inputField->label) }}{{ $inputField->is_required == 1 ? '*' : '' }}
                                                    </label>
                                                    <input type="date" class="form-control ltr"
                                                        name="{{ $inputField->name }}"
                                                        placeholder="{{ __($inputField->placeholder) }}"
                                                        autocomplete="off" value="{{ old($inputField->name) }}">
                                                    @error($inputField->name)
                                                        <p class="mt-2 text-danger">{{ $message }}</p>
                                                    @enderror
                                                </div>
                                            </div>
                                        @elseif ($inputField->type == 7)
                                            <div class="col-md-6">
                                                <div class="form-group mb-30">
                                                    <label class="form-label">
                                                        {{ __($inputField->label) }}{{ $inputField->is_required == 1 ? '*' : '' }}
                                                    </label>
                                                    <input type="time" class="form-control ltr"
                                                        name="{{ $inputField->name }}"
                                                        placeholder="{{ __($inputField->placeholder) }}"
                                                        autocomplete="off" value="{{ old($inputField->name) }}">
                                                    @error($inputField->name)
                                                        <p class="mt-2 text-danger">{{ $message }}</p>
                                                    @enderror
                                                </div>
                                            </div>
                                        @else
                                            <div class="col-md-6">
                                                <div class="form-group mb-30">
                                                    <label class="form-label">
                                                        {{ __($inputField->label) }}{{ $inputField->is_required == 1 ? '*' : '' }}
                                                        
                                                    </label>
                                                    <input type="file" class="form-control form-control-file "
                                                        name="{{ 'form_builder_' . $inputField->name }}">
                                                    @error("form_builder_$inputField->name")
                                                        <p class="mt-2 mb-0 text-danger">{{ $message }}</p>
                                                    @enderror
                                                    <span class="text-danger d-block mt-1 {{ $currentLanguageInfo->direction == 0 ? 'ms-2' : 'me-2' }}">({{ __('Only .zip file is allowed') . '.' }})
                                                        </span>
                                                </div>
                                            </div>
                                        @endif
                                    @endforeach

                                </div>
                                <div class="col-12 text-center">
                                    <button class="btn btn-lg btn-primary radius-sm w-50" type="submit"
                                        aria-label="button"> {{ __('Submit') }}
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
