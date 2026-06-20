@extends('admin.layout')

@section('content')
    <div class="page-header">
        <h4 class="page-title">{{ __('Claim Requests') }}</h4>
        <ul class="breadcrumbs">
            <li class="nav-home">
                <a href="{{ route('admin.dashboard') }}">
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
                <a href="#">{{ __('Claim Requests') }}</a>
            </li>
        </ul>

    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-lg-10">
                            <form id="searchForm" action="{{ route('claim-listings.index') }}" method="GET">
                                <div class="row">
                                    <div class="col-lg-2">
                                        <div class="form-group">
                                            <label>{{ __('Listing') }}</label>
                                            <input name="listing_title" type="text" class="form-control"
                                                placeholder="{{ __('Search by listing title') . '...' }}"
                                                value="{{ !empty(request()->input('listing_title')) ? request()->input('listing_title') : '' }}">
                                        </div>
                                    </div>

                                    <div class="col-lg-2">
                                        <div class="form-group">
                                            <label>{{ __('Status') }}</label>
                                            <select class="form-control h-42" name="status"
                                                onchange="document.getElementById('searchForm').submit()">
                                                <option value=""
                                                    {{ empty(request()->input('status')) ? 'selected' : '' }}>
                                                    {{ __('All') }}
                                                </option>
                                                <option value="pending"
                                                    {{ request()->input('status') == 'pending' ? 'selected' : '' }}>
                                                    {{ __('Pending') }}
                                                </option>
                                                <option value="approved"
                                                    {{ request()->input('status') == 'approved' ? 'selected' : '' }}>
                                                    {{ __('Approved') }}
                                                </option>
                                                <option value="rejected"
                                                    {{ request()->input('status') == 'rejected' ? 'selected' : '' }}>
                                                    {{ __('Rejected') }}
                                                </option>
                                                <option value="fulfilled"
                                                    {{ request()->input('status') == 'fulfilled' ? 'selected' : '' }}>
                                                    {{ __('Fulfilled') }}</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div class="col-lg-2">
                            <button type="button" class="btn btn-info btn-sm float-right mr-2" data-toggle="modal"
                                data-target="#workflowModal">
                                <i class="fas fa-question-circle"></i> {{ __('How It Works') }}
                            </button>

                            <button class="btn btn-danger btn-sm d-none bulk-delete float-lg-right"
                                data-href="{{ route('admin.claim_listings.bulk_delete') }}" class="card-header-button">
                                <i class="flaticon-interface-5"></i> {{ __('Delete') }}
                            </button>
                        </div>
                    </div>
                </div>

                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-12">
                            @if (count($claimListings) == 0)
                                <h3 class="text-center mt-3">{{ __('NO REQUEST FOUND') . '!' }}</h3>
                            @else
                                <div class="table-responsive">
                                    <table class="table table-striped mt-2">
                                        <thead>
                                            <tr>
                                                <th scope="col">
                                                    <input type="checkbox" class="bulk-check" data-val="all">
                                                </th>
                                                <th scope="col">{{ __('Listing') }}</th>
                                                <th scope="col">{{ __('User') }}</th>
                                                <th scope="col">{{ __('Status') }}</th>
                                                <th scope="col">{{ __('Claim Link') }}</th>
                                                <th scope="col">{{ __('Actions') }}</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            @foreach ($claimListings as $index => $claim)
                                                <tr>
                                                    <td>
                                                        <input type="checkbox" class="bulk-check"
                                                            data-val="{{ $claim->id }}">
                                                    </td>
                                                    @php
                                                        $content = optional($claim->listing->listing_content)->first();
                                                    @endphp

                                                    <td>
                                                        <a target="_blank"
                                                            href="{{ route('frontend.listing.details', [
                                                                'slug' => optional($content)->slug,
                                                                'id' => $claim->listing->id,
                                                            ]) }}">
                                                            {{ optional($content)->title ?? '-' }}
                                                        </a>
                                                    </td>
                                                    <td>
                                                        <a href="{{ route('admin.user_management.user.secret-login', ['id' => optional($claim->user)->id]) }}"
                                                            target="_blank">{{ optional($claim->user)->name ?? '-' }}</a>
                                                    </td>
                                                    <td>
                                                        <form id="orderStatusForm-{{ $claim->id }}"
                                                            class="d-inline-block"
                                                            action="{{ route('claim-listings.updated_status', ['id' => $claim->id]) }}"
                                                            method="post">
                                                            @csrf

                                                            @php
                                                                $status = $claim->status;
                                                                $bgClass =
                                                                    [
                                                                        'pending' => 'bg-warning text-dark',
                                                                        'approved' => 'bg-success',
                                                                        'rejected' => 'bg-danger',
                                                                        'fulfilled' => 'bg-info text-dark',
                                                                    ][$status] ?? 'bg-secondary';
                                                            @endphp

                                                            <select name="status"
                                                                class="form-control form-control-sm {{ $bgClass }}"
                                                                onchange="document.getElementById('orderStatusForm-{{ $claim->id }}').submit()">
                                                                <option value="pending" @selected($status === 'pending')>
                                                                    {{ __('Pending') }}</option>
                                                                <option value="approved" @selected($status === 'approved')>
                                                                    {{ __('Approved') }}</option>
                                                                <option value="rejected" @selected($status === 'rejected')>
                                                                    {{ __('Rejected') }}</option>
                                                                <option value="fulfilled" @selected($status === 'fulfilled')>
                                                                    {{ __('Fulfilled') }}</option>
                                                            </select>
                                                        </form>
                                                    </td>
                                                    {{-- claim Link Column --}}
                                                    <td>
                                                        @if ($claim->status === 'approved' && $claim->redemption_token)
                                                            @php
                                                                // Generate the claim URL
                                                                $rawToken = $claim->redemption_token;
                                                                $redeemUrl = route('claims.redeem', [
                                                                    'claim' => $claim->id,
                                                                    't' => $claim->raw_redemption_token,
                                                                ]);
                                                            @endphp

                                                            <div class="d-flex align-items-center">
                                                                <input type="text"
                                                                    class="form-control rk-11 form-control-sm mr-2"
                                                                    id="redeemUrl-{{ $claim->id }}"
                                                                    value="{{ $redeemUrl }}" readonly>

                                                                <button type="button"
                                                                    class="btn btn-sm btn-info copy-link-btn"
                                                                    data-url="{{ $redeemUrl }}"
                                                                    data-id="{{ $claim->id }}"
                                                                    title="{{ __('Copy Link') }}">
                                                                    <i class="fas fa-copy"></i>
                                                                </button>
                                                            </div>

                                                            @if ($claim->redemption_expires_at)
                                                                <small class="text-muted d-block mt-1 text-warning">
                                                                    {{ __('Expires') }}:
                                                                    {{ \Carbon\Carbon::parse($claim->redemption_expires_at)->format('d M Y, h:i A') }}
                                                                </small>
                                                            @endif
                                                        @else
                                                            <span
                                                                class="badge badge-secondary">{{ __('Not Available') }}</span>
                                                        @endif
                                                    </td>

                                                    <td>
                                                        <div class="dropdown">
                                                            <button class="btn btn-sm btn-secondary dropdown-toggle"
                                                                type="button" id="dropdownMenuButton"
                                                                data-toggle="dropdown" aria-haspopup="true"
                                                                aria-expanded="false">
                                                                {{ __('Select') }}
                                                            </button>

                                                            <div class="dropdown-menu"
                                                                aria-labelledby="dropdownMenuButton">
                                                                <a href="{{ route('admin.claim_listings.details', ['id' => $claim->id]) }}"
                                                                    class="dropdown-item">
                                                                    {{ __('Details') }}
                                                                </a>

                                                                <form class="deleteForm d-block"
                                                                    action="{{ route('admin.claim_listings.delete', ['id' => $claim->id]) }}"
                                                                    method="post">
                                                                    @csrf
                                                                    <button type="submit" class="deleteBtn">
                                                                        {{ __('Delete') }}
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                {{-- @includeIf('admin.shop.order.show-receipt') --}}
                                            @endforeach
                                        </tbody>
                                    </table>
                                </div>
                            @endif
                        </div>
                    </div>
                </div>

                <div class="card-footer">
                    <div class="mt-3 text-center">
                        <div class="d-inline-block mx-auto">
                            {{ $claimListings->appends([
                                    'status' => request()->input('status'),
                                    'listing_title' => request()->input('listing_title'),
                                ])->links() }}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    {{-- Workflow Modal --}}
    <div class="modal fade" id="workflowModal" tabindex="-1" role="dialog" aria-labelledby="workflowModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header bg-info text-white">
                    <h5 class="modal-title" id="workflowModalLabel">
                        <i class="fas fa-info-circle"></i> {{ __('Claim Request Workflow') }}
                    </h5>
                    <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="workflow-steps">
                        {{-- Step 1 --}}
                        <div class="workflow-step mb-4">
                            <div class="d-flex align-items-start">
                                <div class="step-number">
                                    <span class="badge badge-warning badge-lg">1</span>
                                </div>
                                <div class="step-content ml-3">
                                    <h6 class="font-weight-bold">
                                        <i class="fas fa-clock text-warning"></i> {{ __('Pending Status') }}
                                    </h6>
                                    <p class="mb-0">
                                        {{__('New claim requests start with pending status') . '. '. __('Review the claim details and user information before taking action') . '.' }}
                                    </p>
                                </div>
                            </div>
                        </div>

                        {{-- Step 2 - Approve --}}
                        <div class="workflow-step mb-4">
                            <div class="d-flex align-items-start">
                                <div class="step-number">
                                    <span class="badge badge-success badge-lg">2</span>
                                </div>
                                <div class="step-content ml-3">
                                    <h6 class="font-weight-bold">
                                        <i class="fas fa-check-circle text-success"></i> {{ __('Approve Claim') }}
                                    </h6>
                                    <p class="mb-2">
                                        {{ __("When you change the status to 'Approved'") . ':' }}
                                    </p>
                                    <ul class="pl-3 mb-0">
                                        <li>{{ __('A unique claim link is automatically generated') }}</li>
                                        <li>{{ __('The link is sent to the user via email') }}</li>
                                        <li>{{ __("The link will be visible in the 'Claim Link' column") }}</li>
                                        <li>{{ __('Link has a configurable expiration time') }}</li>
                                    </ul>

                                    {{-- Quick Settings Access --}}
                                    <div class="mt-3 p-2 bg-warning-light rounded border-left-warning rk-12">
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-info-circle text-warning mr-2"></i>
                                            <small class="flex-grow-1">
                                                <strong>{{ __('Configure Expiration') . ':' }}</strong>
                                                {{ __('Go to') }}
                                                <strong>{{ __('Listings Management') }}</strong>
                                                <i class="fas fa-angle-right"></i>
                                                <strong>{{ __('Settings') }}</strong>
                                            </small>
                                            <a href="{{ route('admin.listing_management.settings') }}" target="_blank"
                                                class="btn btn-sm btn-warning ml-2">
                                                <i class="fas fa-cog"></i> {{ __('Settings') }}
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        {{-- Step 3 - User Claim --}}
                        <div class="workflow-step mb-4">
                            <div class="d-flex align-items-start">
                                <div class="step-number">
                                    <span class="badge badge-info badge-lg">3</span>
                                </div>
                                <div class="step-content ml-3">
                                    <h6 class="font-weight-bold">
                                        <i class="fas fa-user-check text-info"></i> {{ __('User Claim Process') }}
                                    </h6>
                                    <p class="mb-2">
                                        {{ __('After receiving the email, the user must') . ':' }}
                                    </p>
                                    <ul class="pl-3">
                                        <li>{{ __('Click the claim link') }}</li>
                                        <li>{{ __('Complete their profile setup') }}</li>
                                        <li>{{ __('Verify required information') }}</li>
                                        <li>{{ __('Set up payment details (if required)') }}</li>
                                        <li>{{ __('Complete all mandatory setup steps') }}</li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        {{-- Step 3.5 - Payment Processing (NEW) --}}
                        <div class="workflow-step mb-4">
                            <div class="d-flex align-items-start">
                                <div class="step-number">
                                    <span class="badge badge-purple badge-lg rk-13">3.5</span>
                                </div>
                                <div class="step-content ml-3">
                                    <h6 class="font-weight-bold">
                                        <i class="fas fa-money-check-alt text-purple"></i> {{ __('Payment Processing') }}
                                    </h6>
                                    <p class="mb-2">
                                        {{ __('Two payment methods are available') . ':' }}
                                    </p>

                                    {{-- Online Payment --}}
                                    <div class="card border-success mb-2">
                                        <div class="card-body p-2">
                                            <h6 class="mb-1">
                                                <i class="fas fa-credit-card text-success"></i>
                                                <strong>{{ __('Online Payment') }}</strong>
                                            </h6>
                                            <p class="mb-0 small text-muted">
                                                {{__('User pays online through payment gateway') . '. ' .__('Status automatically changes to Fulfilled after successful payment') . '.' }}
                                            </p>
                                        </div>
                                    </div>

                                    {{-- Offline Payment --}}
                                    <div class="card border-warning mb-2">
                                        <div class="card-body p-2">
                                            <h6 class="mb-1">
                                                <i class="fas fa-money-bill-wave text-warning"></i>
                                                <strong>{{ __('Offline Payment') }}</strong>
                                            </h6>
                                            <p class="mb-2 small">
                                                {{__('User submits payment proof through the claim process') . '. '. __('Admin action required') . ':' }}
                                            </p>
                                            <ol class="mb-0 small pl-3">
                                                <li>{{ __('Go to') }}
                                                    <a href="{{ route('admin.payment-log.index') }}" target="_blank"
                                                        class="font-weight-bold">
                                                        {{ __('Subscription Log') }} <i
                                                            class="fas fa-external-link-alt"></i>
                                                    </a>
                                                </li>
                                                <li>{{ __('Find the payment record') }}</li>
                                                <li>{{ __('Change payment status to Success') }}</li>
                                                <li>{{ __('Claim status will automatically update to Fulfilled') }}</li>
                                            </ol>
                                        </div>
                                    </div>

                                    {{-- Important Note --}}
                                    <div class="alert alert-warning alert-sm mb-0 p-2" role="alert">
                                        <small>
                                            <i class="fas fa-exclamation-triangle"></i>
                                            <strong>{{ __('Important') . ':' }}</strong>
                                            {{ __('For offline payments, you must manually verify and approve the payment from Subscription Log') . '.' }}
                                        </small>
                                    </div>
                                </div>
                            </div>
                        </div>

                        {{-- Step 4 - Fulfilled --}}
                        <div class="workflow-step mb-4">
                            <div class="d-flex align-items-start">
                                <div class="step-number">
                                    <span class="badge badge-primary badge-lg">4</span>
                                </div>
                                <div class="step-content ml-3">
                                    <h6 class="font-weight-bold">
                                        <i class="fas fa-trophy text-primary"></i> {{ __('Fulfilled Status') }}
                                    </h6>
                                    <p class="mb-2">
                                        {{ __('Once payment is successful (online or approved offline)') . ':' }}
                                    </p>
                                    <ul class="pl-3">
                                        <li>{{ __("The claimed listing is transferred to user's account") }}</li>
                                        <li>{{ __('User gains access to the vendor dashboard') }}</li>
                                        <li>{{ __('Status automatically changes to Fulfilled') }}</li>
                                        <li>{{ __('User can now manage their listing') }}</li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        {{-- Step 5 --}}
                        <div class="workflow-step">
                            <div class="d-flex align-items-start">
                                <div class="step-number">
                                    <span class="badge badge-danger badge-lg">5</span>
                                </div>
                                <div class="step-content ml-3">
                                    <h6 class="font-weight-bold">
                                        <i class="fas fa-times-circle text-danger"></i> {{ __('Rejected Status') }}
                                    </h6>
                                    <p class="mb-0">
                                        {{__('Use this status if the claim is invalid, fraudulent, or does not meet requirements') . '. '. __('The user will be notified via email of the rejection') . '.' }}
                                    </p>
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
@endsection
