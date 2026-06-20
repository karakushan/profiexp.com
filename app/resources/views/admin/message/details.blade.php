@extends('admin.layout')

@section('content')
    <div class="page-header">
        <h4 class="page-title">{{ __('Product Message Details') }}</h4>
        <ul class="breadcrumbs">
            <li class="nav-home">
                <a href="{{ route('admin.dashboard') }}">
                    <i class="flaticon-home"></i>
                </a>
            </li>
            <li class="separator"><i class="flaticon-right-arrow"></i></li>
            <li class="nav-item"><a href="#">{{ __('Messages') }}</a></li>
            <li class="separator"><i class="flaticon-right-arrow"></i></li>
            <li class="nav-item"><a href="#">{{ __('Product Messages') }}</a></li>
            <li class="separator"><i class="flaticon-right-arrow"></i></li>
            <li class="nav-item"><a href="#">{{ __('Details') }}</a></li>
        </ul>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="card">

                {{-- Header with title + breadcrumbs (left) and Back button (right) --}}
                <div class="card-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="d-flex flex-column">
                            <h4 class="card-title mb-1">{{ __('Message Information') }}</h4>

                        </div>
                        <a href="{{ route('admin.product.messages', ['language' => $defaultLang->code]) }}"
                           class="btn btn-sm btn-primary">
                            <i class="fas fa-arrow-left"></i> {{ __('Back') }}
                        </a>
                    </div>
                </div>

                <div class="card-body">
                    @if (!empty($message->message))
                        @php
                            $messages = json_decode($message->message, true) ?? [];
                        @endphp

                        <div class="row">
                            {{-- Left: Customer Information --}}
                            <div class="col-md-6">
                                <div class="card mb-3">
                                    <div class="card-header bg-primary text-white">
                                        <h5 class="mb-0">{{ __('Customer Information') }}</h5>
                                    </div>
                                    <div class="card-body">
                                        <table class="table table-borderless">
                                            <tr>
                                                <th width="40%">{{ __('Name') }}</th>
                                                <td>{{ $message->name ?? '-' }}</td>
                                            </tr>
                                            <tr>
                                                <th>{{ __('Email') }}</th>
                                                <td>
                                                    @if ($message->email)
                                                        <a href="mailto:{{ $message->email }}">{{ $message->email }}</a>
                                                    @else
                                                        -
                                                    @endif
                                                </td>
                                            </tr>

                                            @foreach ($messages as $fieldName => $fieldData)
                                                @php
                                                    $type = $fieldData['type'] ?? 0;
                                                    $value = $fieldData['value'] ?? '';
                                                @endphp
                                                <tr>
                                                    <td><strong>{{ ucwords(str_replace('_', ' ', $fieldName)) }}</strong></td>
                                                    <td>
                                                        {{-- File (ZIP) --}}
                                                        @if ($type == 8)
                                                            @php
                                                                $originalName = $fieldData['originalName'] ?? 'download.zip';
                                                                $filePath = './assets/file/zip-files/' . $value;
                                                            @endphp
                                                            @if (file_exists(public_path($filePath)))
                                                                <a href="{{ asset($filePath) }}"
                                                                   download="{{ $originalName }}"
                                                                   class="btn btn-sm btn-success">
                                                                    <i class="fas fa-download"></i> {{ __('Download File') }}
                                                                </a>
                                                            @else
                                                                <span class="text-danger">{{ __('File not found') }}</span>
                                                            @endif

                                                        {{-- Checkbox (Array) --}}
                                                        @elseif ($type == 4 && is_array($value))
                                                            <ul class="mb-0">
                                                                @foreach ($value as $item)
                                                                    <li>{{ $item }}</li>
                                                                @endforeach
                                                            </ul>

                                                        {{-- Date --}}
                                                        @elseif ($type == 6)
                                                            {{ \Carbon\Carbon::parse($value)->format('d M Y') }}

                                                        {{-- Time --}}
                                                        @elseif ($type == 7)
                                                            {{ \Carbon\Carbon::parse($value)->format('h:i A') }}

                                                        {{-- Textarea --}}
                                                        @elseif ($type == 5)
                                                            {!! nl2br(e($value)) !!}

                                                        {{-- Default --}}
                                                        @else
                                                            {{ $value }}
                                                        @endif
                                                    </td>
                                                </tr>
                                            @endforeach
                                        </table>
                                    </div>
                                </div>
                            </div>

                            {{-- Right: Product & Listing --}}
                            <div class="col-md-6">
                                <div class="card mb-3">
                                    <div class="card-header bg-success text-white">
                                        <h5 class="mb-0">{{ __('Product & Listing') }}</h5>
                                    </div>
                                    <div class="card-body">
                                        @php
                                            $product_content = optional($message->product)->content
                                                ? optional($message->product->content)->where('language_id', $language->id)->first()
                                                : null;
                                            $listing = $message->product ? $message->product->listing : null;
                                            $listing_content = $listing
                                                ? $listing->listing_content->where('language_id', $language->id)->first()
                                                : null;
                                        @endphp
                                        <table class="table table-borderless">
                                            <tr>
                                                <th width="40%">{{ __('Listing Title') }}:</th>
                                                <td>
                                                    @if ($listing_content)
                                                        <a href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $listing_content->listing_id]) }}"
                                                           target="_blank">
                                                            {{ $listing_content->title }}
                                                        </a>
                                                    @else
                                                        -
                                                    @endif
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>{{ __('Product Title') }}:</th>
                                                <td>
                                                    @if ($product_content)
                                                        <a href="{{ route('shop.product_details', ['slug' => $product_content->slug]) }}"
                                                           target="_blank">
                                                            {{ $product_content->title }}
                                                        </a>
                                                    @else
                                                        -
                                                    @endif
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>{{ __('Message Submitted At') }}:</th>
                                                <td>{{ $message->created_at ? $message->created_at->format('d M Y, h:i A') : '-' }}</td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div> 
                    @endif
                </div>
            </div>
        </div>
    </div>
@endsection
