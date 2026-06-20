@extends('admin.layout')

{{-- this style will be applied when the direction of language is right-to-left --}}
@includeIf('admin.partials.rtl-style')

@section('content')
    <div class="page-header">
        <h4 class="page-title">{{ __('Forms') }}</h4>
        <ul class="breadcrumbs">
            <li class="nav-home">
                <a href="{{ route('admin.dashboard', ['language' => $defaultLang->code]) }}">
                    <i class="flaticon-home"></i>
                </a>
            </li>
            <li class="separator">
                <i class="flaticon-right-arrow"></i>
            </li>
            <li class="nav-item">
                <a href="#">{{ __('Listings Management') }}</a>
            </li>
            <li class="separator">
                <i class="flaticon-right-arrow"></i>
            </li>
            <li class="nav-item">
                <a href="#">{{ __('Forms') }}</a>
            </li>
        </ul>
    </div>

    

    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-lg-4">
                            <div class="card-title d-inline-block">{{ __('All Forms') }}</div>
                        </div>

                        <div class="col-lg-2">
                            <form action="" method="GET">
                                <input type="hidden" name="language" value="{{ $defaultLang->code }} ">
                                <select name="seller" id="" class="form-control select2"
                                    onchange="this.form.submit()">
                                    <option value="" selected>{{ __('All') }}</option>
                                    <option value="admin" @selected(request()->input('seller') == 'admin')>{{ __('Admin') }}
                                    </option>
                                    @if (isset($sellers) && $sellers->isNotEmpty())
                                        @foreach ($sellers as $seller)
                                            <option @selected($seller->id == request()->input('seller')) value="{{ $seller->id }}">
                                                {{ $seller->username }}</option>
                                        @endforeach
                                    @endif
                                </select>
                            </form>
                        </div>

                        <!-- Added search by name field -->
                        <div class="col-lg-3">
                            <form action="" method="GET">
                                <input type="hidden" name="language" value="{{ $defaultLang->code }}">
                                <input type="hidden" name="seller" value="{{ request()->input('seller') }}">
                                <div class="input-group">
                                    <input type="text" name="name" class="form-control"
                                        placeholder="{{ __('Search by name') . '...' }}"
                                        value="{{ request()->input('name') }}"
                                        onkeypress="if(event.keyCode == 13) document.getElementById('searchForm').submit()">
                                </div>
                            </form>
                        </div>

                        <div class="col-lg-3 offset-lg-0 mt-2 mt-lg-0">
                            {{-- Alert Note Button --}}
                            <button type="button" class="btn btn-info btn-sm float-left mr-2" data-toggle="modal"
                                data-target="#formGuideModal">
                                <i class="fas fa-info-circle"></i> {{ __('Form Guide') }}
                            </button>
                            <a href="#" data-toggle="modal" data-target="#createModal"
                                class="btn btn-primary btn-sm float-lg-right float-left">
                                <i class="fas fa-plus"></i> {{ __('Add') }}
                            </a>
                        </div>
                    </div>
                </div>

                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-12">
                            @if (session()->has('error'))
                                <div class="alert alert-warning alert-block">
                                    <strong class="text-dark">{{ session()->get('error') }}</strong>
                                    <button type="button" class="close" data-dismiss="alert">×</button>
                                </div>
                            @endif

                            @if (count($forms) == 0)
                                <h3 class="text-center mt-2">{{ __('NO FORM FOUND') . '!' }}</h3>
                            @else
                                <div class="table-responsive">
                                    <table class="table table-striped mt-3" id="basic-datatables">
                                        <thead>
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">{{ __('Name') }}</th>
                                                <th scope="col">{{ __('Vendor') }}</th>
                                                <th scope="col">{{ __('Type') }}</th>
                                                <th scope="col">{{ __('Form Inputs') }}</th>
                                                <th scope="col">{{ __('Status') }}</th>
                                                <th scope="col">{{ __('Actions') }}</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            @if (isset($forms) && $forms->isNotEmpty())
                                                @foreach ($forms as $form)
                                                    <tr>
                                                        <td>{{ $loop->iteration }}</td>
                                                        <td>{{ $form->name }}</td>
                                                        <td>
                                                            @if (!is_null($form->vendor_id))
                                                                <a target="_blank"
                                                                    href="{{ route('admin.vendor_management.vendor_details', ['id' => $form->vendor_id, 'language' => $defaultLang->code]) }}">{{ @$form->vendor->username }}</a>
                                                            @else
                                                                {{ __('Admin') }}
                                                            @endif
                                                        </td>

                                                        <td>{{ __(ucwords(str_replace('_', ' ', $form->type))) }}</td>

                                                        <td>
                                                            <a href="{{ route('admin.listings-management.form.input', ['id' => $form->id, 'language' => $defaultLang->code]) }}"
                                                                class="btn btn-sm btn-info">
                                                                {{ __('Manage') }}
                                                            </a>
                                                        </td>
                                                        <td>
                                                            @if ($form->status == 'active')
                                                                <h2 class="d-inline-block"><span
                                                                        class="badge badge-success">{{ __('Active') }}</span>
                                                                </h2>
                                                            @else
                                                                <h2 class="d-inline-block"><span
                                                                        class="badge badge-danger">{{ __('Deactive') }}</span>
                                                                </h2>
                                                            @endif
                                                        </td>
                                                        <td>
                                                            <a class="btn btn-secondary btn-sm editFormTrigger mb-1"
                                                                href="#" data-toggle="modal" data-target="#editModal"
                                                                data-id="{{ $form->id }}"
                                                                data-name="{{ $form->name }}"
                                                                data-type="{{ $form->type }}"
                                                                data-status="{{ $form->status }}"
                                                                data-vendor_id="{{ $form->vendor_id }}">
                                                                <span class="btn-label">
                                                                    <i class="fas fa-edit"></i>
                                                                </span>
                                                            </a>

                                                            <form class="deleteForm d-inline-block"
                                                                action="{{ route('admin.listings-management.delete_form', ['id' => $form->id]) }}"
                                                                method="post">
                                                                @csrf
                                                                <button type="submit"
                                                                    class="btn btn-danger btn-sm deleteBtn mb-1">
                                                                    <span class="btn-label">
                                                                        <i class="fas fa-trash"></i>
                                                                    </span>
                                                                </button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                @endforeach
                                            @endif
                                        </tbody>
                                    </table>
                                </div>
                            @endif
                        </div>
                    </div>
                </div>

                <div class="card-footer">
                    <div class="pl-3 pr-3 text-center">
                        <div class="d-inline-block mx-auto">
                            {{ $forms->appends([
                                    'language' => $defaultLang->code,
                                ])->links() }}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    {{-- Form Guide Modal --}}
    <div class="modal fade" id="formGuideModal" tabindex="-1" role="dialog" aria-labelledby="formGuideModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header bg-info text-white">
                    <h5 class="modal-title" id="formGuideModalLabel">
                        <i class="fas fa-book"></i> {{ __('Form Types Guide') }}
                    </h5>
                    <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-guide-content">

                        {{-- Quote Request Form --}}
                        <div class="form-type-section mb-4">
                            <div class="d-flex align-items-start">
                                <div class="icon-box mr-3">
                                    <span class="badge badge-primary badge-lg rk-6" >
                                        <i class="fas fa-question-circle"></i>
                                    </span>
                                </div>
                                <div class="content-box flex-grow-1">
                                    <h5 class="font-weight-bold text-primary mb-2">
                                        <i class="fas fa-envelope"></i> {{ __('Quote Request Form') }}
                                    </h5>

                                    <div class="alert alert-light border-left-primary p-3 mb-2 rk-5">
                                        <h6 class="font-weight-bold mb-2">
                                            <i class="fas fa-bullseye"></i> {{ __('Purpose') . ':' }}
                                        </h6>
                                        <p class="mb-0">
                                            {{__('This form is used to collect inquiries from customers about listing products') . '. ' .  __('Customers can submit queries through this form') . '.' }}
                                        </p>
                                    </div>

                                    <div class="card border-info mb-3">
                                        <div class="card-body p-3">
                                            <h6 class="font-weight-bold text-info mb-2">
                                                <i class="fas fa-cog"></i> {{ __('Configuration Rules') . ':' }}
                                            </h6>
                                            <ul class="mb-0 pl-3">
                                                <li class="mb-2">
                                                    <strong>{{ __('Per Language') . ':' }}</strong>
                                                    {{ __('You can create one form for each language') }}
                                                </li>
                                                <li class="mb-2">
                                                    <strong>{{ __('Per Vendor') . ':' }}</strong>
                                                    {{ __('Each vendor can have only one quote request form per language') }}
                                                </li>
                                                <li>
                                                    <strong>{{ __('Admin Forms') . ':' }}</strong>
                                                    {{ __('Admin can also create quote request forms for each language') }}
                                                </li>
                                            </ul>
                                        </div>
                                    </div>

                                    {{-- Product Messages Link Card --}}
                                    <div class="alert alert-success mb-0 p-0 rk-7">
                                        <div class="d-flex align-items-center">
                                            <div class="p-3 bg-success text-white rk-8">
                                                <i class="fas fa-3x fa-comments"></i>
                                            </div>
                                            <div class="flex-grow-1 p-3">
                                                <h6 class="font-weight-bold mb-1">
                                                    {{ __('View Customer Inquiries') }}
                                                </h6>
                                                <p class="mb-0 small text-muted">
                                                    <i class="fas fa-arrow-right"></i>
                                                    {{ __('Messages') }}
                                                    <i class="fas fa-angle-right"></i>
                                                    {{ __('Product Messages') }}
                                                </p>
                                            </div>
                                            <div class="p-3">
                                                <a href="{{ route('admin.product.messages', ['language' => $defaultLang->code]) }}"
                                                    target="_blank" class="btn btn-success">
                                                    <i class="fas fa-eye"></i> {{ __('View Messages') }}
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <hr class="my-4">

                        {{-- Claim Request Form --}}
                        <div class="form-type-section">
                            <div class="d-flex align-items-start">
                                <div class="icon-box mr-3">
                                    <span class="badge badge-warning badge-lg rk-1">
                                        <i class="fas fa-hand-holding"></i>
                                    </span>
                                </div>
                                <div class="content-box flex-grow-1">
                                    <h5 class="font-weight-bold text-warning mb-2">
                                        <i class="fas fa-flag"></i> {{ __('Claim Request Form') }}
                                    </h5>

                                    <div class="alert alert-light border-left-warning p-3 mb-2 rk-2">
                                        <h6 class="font-weight-bold mb-2">
                                            <i class="fas fa-bullseye"></i> {{ __('Purpose') . ':' }}
                                        </h6>
                                        <p class="mb-0">
                                            {{__('This form is used when users want to claim ownership of a listing') . '. '. __('Users submit proof and information through this form to claim a listing as their own') . '.' }}
                                        </p>
                                    </div>

                                    <div class="card border-warning mb-3">
                                        <div class="card-body p-3">
                                            <h6 class="font-weight-bold text-warning mb-2">
                                                <i class="fas fa-cog"></i> {{ __('Configuration Rules') . ':' }}
                                            </h6>
                                            <ul class="mb-0 pl-3">
                                                <li class="mb-2">
                                                    <strong>{{ __('Admin Only') . ':' }}</strong>
                                                    {{ __('Only admin can create claim request forms') }}
                                                </li>
                                                <li class="mb-2">
                                                    <strong>{{ __('Per Language') . ':' }}</strong>
                                                    {{ __('You can create one claim form for each language') }}
                                                </li>
                                                <li>
                                                    <strong>{{ __('Single Form') . ':' }}</strong>
                                                    {{ __('Each language should have only one claim request form') }}
                                                </li>
                                            </ul>
                                        </div>
                                    </div>

                                    {{-- Claim Requests Link Card --}}
                                    <div class="alert alert-success mb-0 p-0 rk-3">
                                        <div class="d-flex align-items-center">
                                            <div class="p-3 bg-success text-white rk-4">
                                                <i class="fas fa-3x fa-clipboard-list"></i>
                                            </div>
                                            <div class="flex-grow-1 p-3">
                                                <h6 class="font-weight-bold mb-1">
                                                    {{ __('View Submitted Claim Requests') }}
                                                </h6>
                                                <p class="mb-0 small text-muted">
                                                    <i class="fas fa-arrow-right"></i>
                                                    {{ __('Listings Management') }}
                                                    <i class="fas fa-angle-right"></i>
                                                    {{ __('Claim Requests') }}
                                                </p>
                                            </div>
                                            <div class="p-3">
                                                <a href="{{ route('claim-listings.index', ['language' => $defaultLang->code]) }}"
                                                    target="_blank" class="btn btn-success">
                                                    <i class="fas fa-eye"></i> {{ __('View All Claims') }}
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">
                        <i class="fas fa-times"></i> {{ __('Close') }}
                    </button>
                </div>
            </div>
        </div>
    </div>

    {{-- create modal --}}
    @includeIf('admin.listing.form.create')

    {{-- edit modal --}}
    @includeIf('admin.listing.form.edit')
@endsection
