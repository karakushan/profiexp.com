@extends('vendors.layout')

@section('content')
    <div class="page-header">
        <h4 class="page-title">{{ __('Orders') }}</h4>
        <ul class="breadcrumbs">
            <li class="nav-home">
                <a href="{{ route('vendor.dashboard') }}">
                    <i class="flaticon-home"></i>
                </a>
            </li>
            <li class="separator">
                <i class="flaticon-right-arrow"></i>
            </li>
            <li class="nav-item">
                <a href="#">{{ __('Shop Management') }}</a>
            </li>
            <li class="separator">
                <i class="flaticon-right-arrow"></i>
            </li>
            <li class="nav-item">
                <a href="#">{{ __('Orders') }}</a>
            </li>
        </ul>

    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-lg-10">
                            <form id="searchForm" action="{{ route('vendor.shop_management.orders') }}" method="GET">
                                <div class="row">
                                    <div class="col-lg-2">
                                        <div class="form-group">
                                            <label>{{ __('Order Number') }}</label>
                                            <input name="order_no" type="text" class="form-control"
                                                placeholder="{{ __('Search Here') . '...' }}"
                                                value="{{ !empty(request()->input('order_no')) ? request()->input('order_no') : '' }}">
                                        </div>
                                    </div>

                                    <div class="col-lg-2">
                                        <div class="form-group">
                                            <label>{{ __('Payment') }}</label>
                                            <select class="form-control h-42" name="payment_status"
                                                onchange="document.getElementById('searchForm').submit()">
                                                <option value=""
                                                    {{ empty(request()->input('payment_status')) ? 'selected' : '' }}>
                                                    {{ __('All') }}
                                                </option>
                                                <option value="completed"
                                                    {{ request()->input('payment_status') == 'completed' ? 'selected' : '' }}>
                                                    {{ __('Completed') }}
                                                </option>
                                                <option value="pending"
                                                    {{ request()->input('payment_status') == 'pending' ? 'selected' : '' }}>
                                                    {{ __('Pending') }}
                                                </option>
                                                <option value="rejected"
                                                    {{ request()->input('payment_status') == 'rejected' ? 'selected' : '' }}>
                                                    {{ __('Rejected') }}
                                                </option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-lg-2">
                                        <div class="form-group">
                                            <label>{{ __('Order') }}</label>
                                            <select class="form-control h-42" name="order_status"
                                                onchange="document.getElementById('searchForm').submit()">
                                                <option value=""
                                                    {{ empty(request()->input('order_status')) ? 'selected' : '' }}>
                                                    {{ __('All') }}
                                                </option>
                                                <option value="pending"
                                                    {{ request()->input('order_status') == 'pending' ? 'selected' : '' }}>
                                                    {{ __('Pending') }}
                                                </option>
                                                <option value="processing"
                                                    {{ request()->input('order_status') == 'processing' ? 'selected' : '' }}>
                                                    {{ __('Processing') }}
                                                </option>
                                                <option value="completed"
                                                    {{ request()->input('order_status') == 'completed' ? 'selected' : '' }}>
                                                    {{ __('Completed') }}
                                                </option>
                                                <option value="rejected"
                                                    {{ request()->input('order_status') == 'rejected' ? 'selected' : '' }}>
                                                    {{ __('Rejected') }}
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div class="col-lg-2">
                            <button class="btn btn-danger btn-sm d-none bulk-delete float-lg-right"
                                data-href="{{ route('vendor.shop_management.bulk_delete_order') }}"
                                class="card-header-button">
                                <i class="flaticon-interface-5"></i> {{ __('Delete') }}
                            </button>
                        </div>
                    </div>
                </div>

                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-12">
                            @if (count($orders) == 0)
                                <h3 class="text-center mt-3">{{ __('NO ORDER FOUND') . '!' }}</h3>
                            @else
                                <div class="table-responsive">
                                    <table class="table table-striped mt-2">
                                        <thead>
                                            <tr>
                                                <th scope="col">
                                                    <input type="checkbox" class="bulk-check" data-val="all">
                                                </th>
                                                <th scope="col">{{ __('Order No.') }}</th>
                                                <th scope="col">{{ __('Paid via') }}</th>
                                                <th scope="col">{{ __('Payment Status') }}</th>
                                                <th scope="col">{{ __('Order Status') }}</th>
                                                <th scope="col">{{ __('Actions') }}</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            @foreach ($orders as $order)
                                                <tr>
                                                    <td>
                                                        <input type="checkbox" class="bulk-check"
                                                            data-val="{{ $order->id }}">
                                                    </td>
                                                    <td>{{ '#' . $order->order_number }}</td>
                                                    <td>{{ $order->payment_method }}</td>
                                                    <td>
                                                        @if ($order->gateway_type == 'online')
                                                            <h2 class="d-inline-block">
                                                                <span
                                                                    class="badge badge-{{ $order->payment_status == 'completed' ? 'success' : ($order->payment_status == 'pending' ? 'warning' : 'danger') }}">
                                                                    {{ $order->payment_status == 'completed'
                                                                        ? __('Completed')
                                                                        : ($order->payment_status == 'pending'
                                                                            ? __('Pending')
                                                                            : __('Rejected')) }}
                                                                </span>
                                                            </h2>
                                                        @else
                                                            <h2 class="d-inline-block">
                                                                <span
                                                                    class="badge 
                                                                    @if ($order->payment_status == 'pending') bg-warning text-dark
                                                                    @elseif ($order->payment_status == 'completed') bg-success
                                                                    @else bg-danger @endif">
                                                                    {{ $order->payment_status == 'completed'
                                                                        ? __('Completed')
                                                                        : ($order->payment_status == 'pending'
                                                                            ? __('Pending')
                                                                            : __('Rejected')) }}
                                                                </span>
                                                            </h2>
                                                        @endif
                                                    </td>
                                                    <td>
                                                        @switch($order->order_status)
                                                            @case('pending')
                                                                <span class="badge badge-warning">
                                                                    {{ __('Pending') }}
                                                                </span>
                                                            @break

                                                            @case('processing')
                                                                <span class="badge bg-primary">
                                                                    {{ __('Processing') }}
                                                                </span>
                                                            @break

                                                            @case('completed')
                                                                <span class="badge bg-success">
                                                                    {{ __('Completed') }}
                                                                </span>
                                                            @break

                                                            @case('rejected')
                                                                <span class="badge bg-danger">
                                                                    {{ __('Rejected') }}
                                                                </span>
                                                            @break

                                                            @default
                                                                <span class="badge bg-secondary">
                                                                    {{ $order->order_status }}
                                                                </span>
                                                        @endswitch
                                                    </td>

                                                    <td>
                                                        <a href="{{ route('vendor.shop_management.order.details', ['id' => $order->id]) }}"
                                                            class="btn btn-primary btn-sm">
                                                            {{ __('View Details') }}
                                                        </a>
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

                <div class="card-footer">
                    <div class="mt-3 text-center">
                        <div class="d-inline-block mx-auto">
                            {{ $orders->appends([
                                    'order_no' => request()->input('order_no'),
                                    'payment_status' => request()->input('payment_status'),
                                    'order_status' => request()->input('order_status'),
                                ])->links() }}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
