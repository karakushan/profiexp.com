<div class="modal fade" id="detailsModal_{{ $order->id }}" tabindex="-1" role="dialog"
  aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"><b>{{ __('Details') }}</b>
        </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      @php
        $vendorInfo = App\Models\VendorInfo::Where([['vendor_id', $order->vendor_id]])->first();
        $vendor = App\Models\Vendor::Where([['id', $order->vendor_id]])->first();
      @endphp
      <div class="modal-body">
        <h3 class="text-warning mt-2">{{ __('Member details') }}</h3>
        <b>{{ __('Name') }}</b>
        @if ($vendorInfo)
          <p class="mb-0">{{ $vendorInfo->name }}</p>
        @else
          <p class="mb-0">{{ __('Admin') }}</p>
        @endif

        <b>{{ __('Email') }}</b>
        <p class="mb-0">
          @if (@$vendor->to_mail)
            {{ $vendor->to_mail }}
          @else
            {{ @$vendor->email }}
          @endif
        </p>
        <b>{{ __('Phone') }}</b>
        <p class="mb-0">{{ @$vendor->phone }}</p>
        <h3 class="text-warning mt-2">{{ __('Payment details') }}</h3>
        <p class="mb-0"><strong>{{ __('Package Price') }}: </strong>
          {{ symbolPrice($order->total) }}
        </p>
        <p class="mb-0"><strong>{{ __('Method') }}: </strong>
          {{ $order->payment_method }}
        </p>
        <h3 class="text-warning mt-2">{{ __('Feature Details') }}</h3>
        <p class="mb-0"><strong>{{ __('Listing Title') }}:

          </strong>{{ strlen(@$listing_content->title) > 35 ? mb_substr(@$listing_content->title, 0, 35, 'utf-8') . '...' : @$listing_content->title }}

        </p>
        <p class="mb-0"><strong>{{ __('Total Days') }}:
          </strong>{{ !empty($order->days) ? $order->days : '' }}
        </p>
        <p class="mb-0"><strong>{{ __('Start Date') }}: </strong>
          @if ($order->order_status == 'completed')
            {{ \Illuminate\Support\Carbon::parse($order->start_date)->format('M-d-Y') }}
          @else
            <span
              class="badge @if ($order->order_status == 'pending') badge-warning   @else  badge-danger @endif">{{ $order->order_status }}</span>
          @endif
        </p>
        <p class="mb-0"><strong>{{ __('Expire Date') }}: </strong>
          @if ($order->order_status == 'completed')
            {{ \Illuminate\Support\Carbon::parse($order->end_date)->format('M-d-Y') }}
          @else
            <span
              class="badge @if ($order->order_status == 'pending') badge-warning   @else  badge-danger @endif">{{ $order->order_status }}</span>
          @endif
        </p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">
          {{ __('Close') }}
        </button>
      </div>
    </div>
  </div>
</div>
