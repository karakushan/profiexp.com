@extends('vendors.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Messages') }}</h4>
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
        <a href="#">{{ __('Messages') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Listing Messages') }}</a>
      </li>
    </ul>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <div class="row">
            <div class="col-lg-4">
              <div class="card-title d-inline-block">{{ __('Messages') }}</div>
            </div>
            <div class="col-lg-3">
              @includeIf('admin.partials.languages')
            </div>
            <div class="col-lg-4 offset-lg-1 mt-2 mt-lg-0">

              <button class="btn btn-danger btn-sm float-right mr-2 d-none bulk-delete"
                data-href="{{ route('vendor.listing.message.bulk_delete.message') }}"><i class="flaticon-interface-5"></i>
                {{ __('Delete') }}</button>
            </div>

          </div>
        </div>

        <div class="card-body">
          <div class="row">
            <div class="col-lg-12">
              @if (count($messages) == 0)
                <h3 class="text-center mt-2">{{ __('NO MESSAGE FOUND') . '!' }}</h3>
              @else
                <div class="table-responsive">
                  <table class="table table-striped mt-3" id="basic-datatables">
                    <thead>
                      <tr>
                        <th scope="col">
                          <input type="checkbox" class="bulk-check" data-val="all">
                        </th>
                        <th scope="col">{{ __('Listing Title') }}</th>
                        <th scope="col">{{ __('Name') }}</th>
                        <th scope="col">{{ __('Email ID') }}</th>
                        <th scope="col">{{ __('Phone') }}</th>
                        <th scope="col">{{ __('Actions') }}</th>
                      </tr>
                    </thead>
                    <tbody>
                      @foreach ($messages as $message)
                        <tr>
                          <td>
                            <input type="checkbox" class="bulk-check" data-val="{{ $message->id }}">
                          </td>
                          @php
                            $listing_content = App\Models\Listing\ListingContent::where([
                                ['listing_id', $message->listing_id],
                                ['language_id', $language->id],
                            ])->first();
                          @endphp

                          <td class="title">
                            @if (!empty($listing_content))
                              <a href="{{ route('frontend.listing.details', ['slug' => $listing_content->slug, 'id' => $message->listing_id]) }}"
                                target="_blank">
                                {{ strlen($listing_content->title) > 40 ? mb_substr($listing_content->title, 0, 40, 'utf-8') . '...' : $listing_content->title }}
                              </a>
                            @endif
                          </td>


                          <td>{{ $message->name }}</td>
                          <td><a href="mailto:{{ $message->email }}">{{ $message->email }}</a>
                          </td>
                          <td> <a href="tel:{{ $message->phone }}">{{ $message->phone }}</a>
                          </td>
                          <td>
                            <a class="btn btn-secondary btn-sm  mt-1 mr-1 editBtn" href="#" data-toggle="modal"
                              data-target="#editModal" data-id="{{ $message->id }}" data-name="{{ $message->name }}"
                              data-phone="{{ $message->phone }}" data-message="{{ $message->message }}"
                              data-email="{{ $message->email }}">
                              <span class="btn-label">
                                <i class="fas fa-eye"></i>
                              </span>
                            </a>

                            <form class="deleteForm d-inline-block"
                              action="{{ route('vendor.listing.message.delete_message') }}"method="post">
                              @csrf
                              <input type="hidden" name="message_id" value="{{ $message->id }}">

                              <button type="submit" class="btn btn-danger mt-1 btn-sm deleteBtn">
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
          </div>
        </div>

        <div class="card-footer">
          <div class="center">
            {{ $messages->appends([
                    'language' => request()->input('language'),
                ])->links() }}
          </div>
        </div>
      </div>
    </div>
  </div>

  @include('vendors.message.message')
@endsection
