@extends('frontend.layout')

@section('pageHeading')
  {{ __('Order Details') }}
@endsection


@section('content')


  <!-- Page title start-->
  <div class="page-title-area ptb-100">
    <img class="lazyload blur-up bg-img"
      @if (!empty($bgImg->breadcrumb)) src="{{ asset('assets/img/' . $bgImg->breadcrumb) }}" @else
    src="{{ asset('assets/front/images/page-title-bg.jpg') }}" @endif
      alt="Bg-img">
    <div class="container">
      <div class="content">
        <h3>
          {{ __('Order') . ' #' . $order->order_number }}
        </h3>
        <ul class="list-unstyled">
          <li class="d-inline"><a href="{{ route('index') }}">{{ __('Home') }}</a></li>
          <li class="d-inline">/</li>
          <li class="d-inline active opacity-75">{{ __('Order Details') }}</li>
        </ul>
      </div>
    </div>
  </div>
  <!-- Page title end-->


  <!--====== Start Dashboard Section ======-->
  <div class="user-dashboard pt-100 pb-60">
    <div class="container">
      <div class="row gx-xl-5">
        @includeIf('frontend.user.side-navbar')
        <div class="col-lg-9">
          <div class="user-profile-details mb-40">
            <div class="order-details radius-md">
              <div class="title">
                <h4>{{ __('My order details') }}</h4>
              </div>
              <div class="view-order-page mb-40">
                <div class="order-info-area">
                  <div class="row align-items-center">
                    <div class="col-lg-8">
                      <div class="order-info mb-20">
                        <h6>{{ __('Order') . ' # ' }} {{ $order->order_number }}
                          <span>[{{ __($order->order_status) }}]</span>
                        </h6>
                        <p class="m-0">{{ __('Order Date') . ' : ' }}
                          {{ date('dS F, Y', strtotime($order->created_at)) }}
                      </div>
                    </div>
                    @if (!is_null($order->invoice))
                      <div class="col-lg-4">
                        <div class="prinit mb-20">
                          <a href="{{ asset('assets/file/invoices/product/' . $order->invoice) }}" download
                            class="btn btn-md radius-sm"><i class="fas fa-download"></i>{{ __('Download') }}</a>
                        </div>
                      </div>
                    @endif
                  </div>
                </div>
              </div>
              <div class="billing-add-area mb-10">
                <div class="row">
                  <div class="col-md-4">
                    <div class="main-info mb-30">
                      <h5>{{ __('Billing Address') }}</h5>
                      <ul class="list">
                        <li><b>{{ __('Name') . ':' }}</b>{{ $order->billing_name }}</li>
                        <li><b>{{ __('Email') . ':' }}</b>{{ $order->billing_email }}</li>
                        <li><b>{{ __('Phone') . ':' }}</b>{{ $order->billing_phone }}</li>
                        <li><b>{{ __('City') . ':' }}</b>{{ $order->billing_city }}</li>
                        @if (!empty($order->billing_state))
                          <li><b>{{ __('State') . ':' }}</b>{{ $order->billing_state }}</li>
                        @endif
                        <li><b>{{ __('Country') . ':' }}</b> {{ $order->billing_country }}</li>
                        <li><b>{{ __('Address') . ':' }}</b> {{ $order->billing_address }}</li>
                      </ul>
                    </div>
                  </div>
                  <div class="col-md-4">
                    <div class="main-info mb-30">
                      <h5>{{ __('Shipping Address') }}</h5>
                      <ul class="list">
                        <li><b>{{ __('Name') . ':' }}</b>{{ $order->shipping_name }}</li>
                        <li><b>{{ __('Email') . ':' }}</b>{{ $order->shipping_email }}</li>
                        <li><b>{{ __('Phone') . ':' }}</b>{{ $order->shipping_phone }}</li>
                        <li><b>{{ __('City') . ':' }}</b>{{ $order->shipping_city }}</li>
                        @if (!empty($order->shipping_state))
                          <li><b>{{ __('State') . ':' }}</b>{{ $order->shipping_state }}</li>
                        @endif
                        <li><b>{{ __('Country') . ':' }}</b> {{ $order->shipping_country }}</li>
                        <li><b>{{ __('Address') . ':' }}</b> {{ $order->shipping_address }}</li>
                      </ul>
                    </div>
                  </div>
                  <div class="col-md-4">
                    <div class="payment-information mb-30">
                      <h5>{{ __('Payment Information') }}</h5>
                      @php
                        if ($order->payment_status == 'pending') {
                            $payment_bg = 'bg-warning';
                        } elseif ($order->payment_status = 'completed') {
                            $payment_bg = 'bg-success';
                        } elseif ($order->payment_status = 'rejected') {
                            $payment_bg = 'bg-danger';
                        }
                        $symbol = $order->currency_symbol;
                        $position = $order->currency_symbol_position;
                      @endphp
                      <p><b>{{ __('Cart Total') . ' :' }}</b> <span
                          class="amount">{{ $position == 'left' ? $symbol : '' }}{{ number_format($order->total, 2, '.', ',') }}{{ $position == 'right' ? $symbol : '' }}</span>
                      </p>
                      <p><b>{{ __('Discount') }}</b> (<i class="far fa-minus text-success"></i>) : <span
                          class="amount">{{ $position == 'left' ? $symbol : '' }}{{ number_format($order->discount, 2, '.', ',') }}{{ $position == 'right' ? $symbol : '' }}</span>
                      </p>
                      @php
                        $total = floatval($order->total);
                        $discount = floatval($order->discount);
                        $subtotal = $total - $discount;
                      @endphp
                      <p><b>{{ __('Subtotal') . ' : ' }}</b> <span
                          class="amount">{{ $position == 'left' ? $symbol : '' }}{{ number_format($subtotal, 2, '.', ',') }}{{ $position == 'right' ? $symbol : '' }}</span>
                      </p>
                      @php $shippingMethod = $order->shippingMethod()->first(); @endphp
                      <p><b>{{ __('Shipping Cost') }}</b>
                        (<i class="far fa-plus text-danger"></i>) :
                        @if (is_null($order->shipping_cost))
                          {{ '-' }}
                        @else
                          <span
                            class="amount">{{ $position == 'left' ? $symbol : '' }}{{ number_format($order->shipping_cost, 2, '.', ',') }}{{ $position == 'right' ? $symbol : '' }}(<small>{{ is_null($shippingMethod) ? '-' : $shippingMethod->title }}</small>)</span>
                        @endif
                      </p>
                      <p><b>{{ __('Tax') }}
                          {{ '(' . $tax->product_tax_amount . '%)' }}</b> <span class="text-danger">(<i
                            class="far fa-plus"></i>)</span> :
                        <span
                          class="amount">{{ $position == 'left' ? $symbol : '' }}{{ number_format($order->tax, 2, '.', ',') }}{{ $position == 'right' ? $symbol : '' }}</span>
                      </p>

                      <p><b>{{ __('Paid Amount') . ' : ' }}</b> <span
                          class="amount">{{ $position == 'left' ? $symbol : '' }}{{ number_format($order->grand_total, 2, '.', ',') }}{{ $position == 'right' ? $symbol : '' }}</span>
                      </p>

                      <p><b>{{ __('Payment Method') . ' :' }}</b> {{ __($order->payment_method) }}</p>
                      <p><b>{{ __('Payment Status') }}</b> <span
                          class="badge {{ $payment_bg }}">{{ __($order->payment_status) }}</span></p>
                    </div>
                  </div>
                </div>
              </div>
              <div class="table-responsive product-list">
                <h5>{{ __('Ordered Product') }}</h5>
                <table class="table table-bordered">
                  <thead>
                    <tr>
                      <th>#</th>
                      <th>{{ __('Name') }}</th>
                      <th>{{ __('Quantity') }}</th>
                      <th>{{ __('Price') }}</th>
                      <th>{{ __('Total') }}</th>
                    </tr>
                  </thead>
                  <tbody>
                    @php
                      $iteration = 1;
                    @endphp
                    @foreach ($items as $item)
                      @if ($item->productType == 'digital')
                        @for ($i = 0; $i < $item->quantity; $i++)
                          <tr>
                            <td>{{ $iteration }}</td>
                            <td>
                              @if ($item->slug == '')
                                <p>{{ $item->productTitle }}</p>
                              @else
                                <a href="{{ route('shop.product_details', ['slug' => $item->slug]) }}" target="_blank">
                                  {{ $item->productTitle }}
                                </a>
                              @endif

                              @if ($item->productType == 'digital' && $order->payment_status == 'completed')
                                @if ($item->inputType == 'link')
                                  <div class="mt-1">
                                    <a href="{{ $item->link }}" target="_blank" class="btn btn-primary btn-sm">
                                      {{ __('Click Here') }}
                                    </a>
                                  </div>
                                @else
                                  <form
                                    action="{{ route('user.product_order.product.download', ['id' => $item->product_id]) }}"
                                    method="POST">
                                    @csrf
                                    <button type="submit" class="btn btn-primary btn-sm mt-1">
                                      {{ __('Download') }}
                                    </button>
                                  </form>
                                @endif
                              @endif
                            </td>
                            <td>
                              {{ $item->quantity }}
                            </td>
                            <td>
                              {{ $position == 'left' ? $symbol : '' }}{{ $item->price }}{{ $position == 'right' ? $symbol : '' }}
                            </td>
                            <td>
                              @php
                                $eachItemTotal = floatval($item->price) * $item->quantity;
                              @endphp

                              {{ $position == 'left' ? $symbol : '' }}{{ number_format($eachItemTotal, 2) }}{{ $position == 'right' ? $symbol : '' }}
                            </td>
                          </tr>
                          @php
                            $iteration = $iteration + 1;
                          @endphp
                        @endfor
                      @else
                        <tr>
                          <td>{{ $iteration }}</td>
                          <td>
                            @if ($item->slug == '')
                              <p>{{ $item->productTitle }}</p>
                            @else
                              <a href="{{ route('shop.product_details', ['slug' => $item->slug]) }}" target="_blank">
                                {{ $item->productTitle }}
                              </a>
                            @endif

                            @if ($item->productType == 'digital' && $order->payment_status == 'completed')
                              @if ($item->inputType == 'link')
                                <div class="mt-1">
                                  <a href="{{ $item->link }}" target="_blank" class="btn btn-primary btn-sm">
                                    {{ __('Click Here') }}
                                  </a>
                                </div>
                              @else
                                <form
                                  action="{{ route('user.product_order.product.download', ['id' => $item->product_id]) }}"
                                  method="POST">
                                  @csrf
                                  <button type="submit" class="btn btn-primary btn-sm mt-1">
                                    {{ __('Download') }}
                                  </button>
                                </form>
                              @endif
                            @endif
                          </td>
                          <td>
                            {{ $item->quantity }}
                          </td>
                          <td>
                            {{ $position == 'left' ? $symbol : '' }}{{ $item->price }}{{ $position == 'right' ? $symbol : '' }}
                          </td>
                          <td>
                            @php
                              $eachItemTotal = floatval($item->price) * $item->quantity;
                            @endphp

                            {{ $position == 'left' ? $symbol : '' }}{{ number_format($eachItemTotal, 2) }}{{ $position == 'right' ? $symbol : '' }}
                          </td>
                        </tr>
                        @php
                          $iteration = $iteration + 1;
                        @endphp
                      @endif
                    @endforeach

                  </tbody>
                </table>
              </div>
              <div class="edit-account-info">
                <a href="{{ route('user.order.index') }}" class="btn btn-lg btn-primary">{{ __('Go Back') }}</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--====== End Dashboard Section ======-->
@endsection
