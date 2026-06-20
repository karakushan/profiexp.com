@extends('admin.layout')

@section('content')
<div class="page-header">
    <h4 class="page-title">{{ __('Claim Request Details') }}</h4>
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
            <a href="{{ route('claim-listings.index') }}">{{ __('Claim Requests') }}</a>
        </li>
        <li class="separator">
            <i class="flaticon-right-arrow"></i>
        </li>
        <li class="nav-item">
            <a href="#">{{ __('Details') }}</a>
        </li>
    </ul>
</div>

<div class="row">
    <div class="col-md-12">
        <div class="card">
            <div class="card-header">
                <div class="d-flex justify-content-between align-items-center">
                    <h4 class="card-title mb-0">{{ __('Claim Request Information') }}</h4>
                    <a href="{{ route('claim-listings.index') }}" class="btn btn-sm btn-primary">
                        <i class="fas fa-arrow-left"></i> {{ __('Back') }}
                    </a>
                </div>
            </div>

            <div class="card-body">
                <div class="row">
                    {{-- Left Column: Customer Information with Additional Fields --}}
                    <div class="col-md-6">
                        <div class="card mb-3">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0">{{ __('Customer Information') }}</h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-borderless">
                                    {{-- Basic Customer Info --}}
                                    <tr>
                                        <th width="40%">{{ __('Name') }}:</th>
                                        <td>{{ $claim->customer_name ?? '-' }}</td>
                                    </tr>
                                    <tr>
                                        <th>{{ __('Email') }}:</th>
                                        <td>{{ $claim->customer_email ?? '-' }}</td>
                                    </tr>
                                    <tr>
                                        <th>{{ __('Phone') }}:</th>
                                        <td>{{ $claim->customer_phone ?? '-' }}</td>
                                    </tr>
                                    <tr>
                                        <th>{{ __('User Account') }}:</th>
                                        <td>
                                            @if($claim->user)
                                                <a href="{{ route('admin.user_management.user.secret-login', ['id' => $claim->user->id]) }}" 
                                                   target="_blank" class="btn btn-sm btn-info">
                                                    {{ $claim->user->name }}
                                                </a>
                                            @else
                                                -
                                            @endif
                                        </td>
                                    </tr>

                                    {{-- Additional Information from Form --}}
                                    @if(!empty($information))
                                        
                                        @foreach($information as $fieldName => $fieldData)
                                            <tr>
                                                <th width="40%">{{ ucwords(str_replace('_', ' ', $fieldName)) }}:</th>
                                                <td>
                                                    @php
                                                        $type = $fieldData['type'] ?? 0;
                                                        $value = $fieldData['value'] ?? '';
                                                    @endphp

                                                    {{-- Type 8 = File (ZIP) --}}
                                                    @if($type == 8)
                                                        @php
                                                            $originalName = $fieldData['originalName'] ?? 'download.zip';
                                                            $filePath = './assets/file/zip-files/' . $value;
                                                        @endphp
                                                        
                                                        @if(file_exists(public_path($filePath)))
                                                            <div class="d-flex align-items-center">
                                                                <i class="fas fa-file-archive text-primary mr-2"></i>
                                                                <div>
                                                                    <small class="d-block mb-1">{{ $originalName }}</small>
                                                                    <a href="{{ asset($filePath) }}" 
                                                                       download="{{ $originalName }}"
                                                                       class="btn btn-xs btn-success">
                                                                        <i class="fas fa-download"></i> {{ __('Download') }}
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        @else
                                                            <span class="text-danger">{{ __('File not found') }}</span>
                                                        @endif

                                                    {{-- Type 4 = Checkbox (Array) --}}
                                                    @elseif($type == 4 && is_array($value))
                                                        <ul class="mb-0 pl-3">
                                                            @foreach($value as $item)
                                                                <li><small>{{ $item }}</small></li>
                                                            @endforeach
                                                        </ul>

                                                    {{-- Type 6 = Date --}}
                                                    @elseif($type == 6)
                                                        {{ \Carbon\Carbon::parse($value)->format('d M Y') }}

                                                    {{-- Type 7 = Time --}}
                                                    @elseif($type == 7)
                                                        {{ \Carbon\Carbon::parse($value)->format('h:i A') }}

                                                    {{-- Type 5 = Textarea (preserve line breaks) --}}
                                                    @elseif($type == 5)
                                                        <small>{!! nl2br(e($value)) !!}</small>

                                                    {{-- Default: Show as text --}}
                                                    @else
                                                        {{ $value }}
                                                    @endif
                                                </td>
                                            </tr>
                                        @endforeach
                                    @endif
                                </table>
                            </div>
                        </div>
                    </div>

                    {{-- Right Column: Claim Status Information --}}
                    <div class="col-md-6">
                        <div class="card mb-3">
                            <div class="card-header bg-success text-white">
                                <h5 class="mb-0">{{ __('Claim Status') }}</h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-borderless">
                                    <tr>
                                        <th width="40%">{{ __('Status') }}:</th>
                                        <td>
                                            @php
                                                $statusClasses = [
                                                    'pending' => 'badge-warning',
                                                    'approved' => 'badge-success',
                                                    'rejected' => 'badge-danger',
                                                    'fulfilled' => 'badge-info'
                                                ];
                                                $badgeClass = $statusClasses[$claim->status] ?? 'badge-secondary';
                                            @endphp
                                            <span class="badge {{ $badgeClass }}">{{ ucfirst($claim->status) }}</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>{{ __('Listing') }}:</th>
                                        <td>
                                            @php
                                                $content = optional($claim->listing->listing_content)->first();
                                            @endphp
                                            @if($content)
                                                <a href="{{ route('frontend.listing.details', ['slug' => $content->slug, 'id' => $claim->listing->id]) }}" 
                                                   target="_blank">
                                                    {{ $content->title }}
                                                </a>
                                            @else
                                                -
                                            @endif
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>{{ __('Submitted At') }}:</th>
                                        <td>{{ $claim->created_at->format('d M Y, h:i A') }}</td>
                                    </tr>
                                    @if($claim->approved_at)
                                    <tr>
                                        <th>{{ __('Approved At') }}:</th>
                                        <td>{{ \Carbon\Carbon::parse($claim->approved_at)->format('d M Y, h:i A') }}</td>
                                    </tr>
                                    @endif
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
