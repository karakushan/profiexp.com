@extends('vendors.layout')

{{-- RTL style --}}
@includeIf('admin.partials.rtl-style')

@section('content')
    <div class="page-header">
        <h4 class="page-title">{{ __('Forms') }}</h4>
        <ul class="breadcrumbs">
            <li class="nav-home">
                <a href="{{ route('vendor.dashboard', ['language' => $language->code]) }}">
                    <i class="flaticon-home"></i>
                </a>
            </li>
            <li class="separator">
                <i class="flaticon-right-arrow"></i>
            </li>
            <li class="nav-item">
                <a href="#">{{ __('My Forms') }}</a>
            </li>
        </ul>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="card-title d-inline-block">{{ __('All Forms') }}</div>
                        </div>
                        <div class="col-lg-3">
                            <form action="" method="GET">
                                <input type="hidden" name="language" value="{{ $language->code }}">
                                <div class="input-group">
                                    <input type="text" name="name" class="form-control"
                                        placeholder="{{ __('Search by name') . '...' }}"
                                        value="{{ request()->input('name') }}"
                                        onkeypress="if(event.keyCode == 13) this.form.submit()">
                                </div>
                            </form>
                        </div>
                        <div class="col-lg-3 mt-2 mt-lg-0">
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

                    @if (session()->has('error'))
                        <div class="alert alert-warning alert-block">
                            <strong class="text-dark">{{ session()->get('error') }}</strong>
                            <button type="button" class="close" data-dismiss="alert">×</button>
                        </div>
                    @endif

                    @if ($forms->isEmpty())
                        <h3 class="text-center mt-2">{{ __('NO FORM FOUND') . '!' }}</h3>
                    @else
                        <div class="table-responsive">
                            <table class="table table-striped mt-3">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">{{ __('Name') }}</th>
                                        <th scope="col">{{ __('Type') }}</th>
                                        <th scope="col">{{ __('Form Inputs') }}</th>
                                        <th scope="col">{{ __('Status') }}</th>
                                        <th scope="col">{{ __('Actions') }}</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach ($forms as $form)
                                        <tr>
                                            <td>{{ $loop->iteration }}</td>
                                            <td>{{ $form->name }}</td>
                                            <td>{{ __(ucwords(str_replace('_', ' ', $form->type))) }}</td>
                                            <td>
                                                <a href="{{ route('vendor.listings-management.form.input', ['id' => $form->id, 'language' => $language->code]) }}"
                                                    class="btn btn-sm btn-info">
                                                    {{ __('Manage') }}
                                                </a>
                                            </td>
                                            <td>
                                                @if ($form->status == 'active')
                                                    <span class="badge badge-success">{{ __('Active') }}</span>
                                                @else
                                                    <span class="badge badge-danger">{{ __('Deactive') }}</span>
                                                @endif
                                            </td>
                                            <td>
                                                <a class="btn btn-secondary btn-sm editFormTrigger mb-1" href="#"
                                                    data-toggle="modal" data-target="#editModal"
                                                    data-id="{{ $form->id }}" data-name="{{ $form->name }}"
                                                    data-type="{{ $form->type }}" data-status="{{ $form->status }}">
                                                    <span class="btn-label">
                                                        <i class="fas fa-edit"></i>
                                                    </span>
                                                </a>
                                                <form class="deleteForm d-inline-block"
                                                    action="{{ route('vendor.listings-management.delete_form', ['id' => $form->id]) }}"
                                                    method="post">
                                                    @csrf
                                                    <button type="submit" class="btn btn-danger btn-sm deleteBtn mb-1">
                                                        <span class="btn-label">
                                                            <i class="fas fa-trash"></i>
                                                        </span>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    @endif
                </div>
                <div class="card-footer">
                    <div class="pl-3 pr-3 text-center">
                        <div class="d-inline-block mx-auto">
                            {{ $forms->appends(['language' => $language->code])->links() }}
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
                                    <span class="badge badge-primary badge-lg rk-9">
                                        <i class="fas fa-question-circle"></i>
                                    </span>
                                </div>
                                <div class="content-box flex-grow-1">
                                    <h5 class="font-weight-bold text-primary mb-3">
                                        <i class="fas fa-envelope"></i> {{ __('Quote Request Form') }}
                                    </h5>

                                    <div class="alert alert-light border-left-primary p-3 mb-3 rk-10"
                                        >
                                        <p class="mb-0">
                                            {{__('This form allows customers to send inquiries about your listing products') . '. ' .  __('When customers submit queries through this form, you can view and respond to them') }}
                                        </p>
                                    </div>

                                    <div class="card border-info mb-3">
                                        <div class="card-body p-3">
                                            <h6 class="font-weight-bold text-info mb-2">
                                                <i class="fas fa-cog"></i> {{ __('Configuration') . ':' }}
                                            </h6>
                                            <ul class="mb-0 pl-3">
                                                <li class="mb-2">
                                                    <strong>{{ __('One Form Per Language') . ':' }}</strong>
                                                    {{ __('Create one quote request form for each language you support') }}
                                                </li>
                                                <li class="mb-2">
                                                    <strong>{{ __('Custom Fields') . ':' }}</strong>
                                                    {{ __('Add your own fields after creating the form using the Manage button') }}
                                                </li>
                                                <li>
                                                    <strong>{{ __('Language Specific') . ':' }}</strong>
                                                    {{ __('Each language form will have its own fields') }}
                                                </li>
                                            </ul>
                                        </div>
                                    </div>

                                    {{-- Where to Find Messages --}}
                                    <div class="card border-success mb-2">
                                        <div class="card-body p-3 bg-light">
                                            <h6 class="font-weight-bold text-success mb-2">
                                                <i class="fas fa-inbox"></i> {{ __('Where to find customer inquiries') . '?' }}
                                            </h6>
                                            <p class="mb-2">
                                                {{ __('When customers submit this form, you can view all messages from') . ':' }}
                                            </p>
                                            <div class="d-flex align-items-center">
                                                <div class="flex-grow-1">
                                                    <p class="mb-0">
                                                        <i class="fas fa-arrow-right text-success"></i>
                                                        <strong>{{ __('Messages') }}</strong>
                                                        <i class="fas fa-angle-right"></i>
                                                        <strong>{{ __('Product Messages') }}</strong>
                                                    </p>
                                                </div>
                                                <a href="{{ route('vendor.product.messages', ['language' => $defaultLang->code]) }}"
                                                    target="_blank" class="btn btn-sm btn-success">
                                                    <i class="fas fa-external-link-alt"></i> {{ __('Go to Messages') }}
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
    @includeIf('vendors.shop.form.create')
    {{-- edit modal --}}
    @includeIf('vendors.shop.form.edit')
@endsection
