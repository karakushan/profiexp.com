@extends('admin.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Amenities') }}</h4>
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
        <a href="#">{{ __('Listing Specifications') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Amenities') }}</a>
      </li>
    </ul>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <div class="row align-items-center">
            <div class="col-lg-7">
              <div class="card-title">{{ __('Amenities') }}</div>
            </div>

            <div class="col-sm-6 col-lg-4 offset-lg-1 mt-2 mt-lg-0">
              <div class="text-right">
                <a href="#" data-toggle="modal" data-target="#createModal" class="btn btn-primary btn-sm"><i
                    class="fas fa-plus"></i>
                  {{ __('Add') }}</a>

                <button class="btn btn-danger btn-sm ml-2 d-none bulk-delete"
                  data-href="{{ route('admin.listing_specification.bulk_delete_aminite') }}">
                  <i class="flaticon-interface-5"></i> {{ __('Delete') }}
                </button>
              </div>
            </div>
          </div>
        </div>

        <div class="card-body">
          <div class="row">
            <div class="col">
              @if (count($aminites) == 0)
                <h3 class="text-center mt-2">{{ __('NO AMENITIE FOUND') . '!' }}</h3>
              @else
                <div class="table-responsive">
                  <table class="table table-striped mt-3" id="basic-datatables">
                    <thead>
                      <tr>
                        <th scope="col">
                          <input type="checkbox" class="bulk-check" data-val="all">
                        </th>
                        <th scope="col">ID</th>
                        <th scope="col">{{ __('Title') }}</th>
                        <th scope="col">{{ __('Icon') }}</th>
                        <th scope="col">{{ __('Actions') }}</th>
                      </tr>
                    </thead>
                    <tbody>
                      @foreach ($aminites as $aminite)
                        <tr>
                          <td>
                            <input type="checkbox" class="bulk-check" data-val="{{ $aminite->id }}">
                          </td>
                          <td><strong>{{ $aminite->id }}</strong></td>
                          <td>
                            @php
                              $firstContent = $aminite->contents->first();
                              $displayTitle = $firstContent ? $firstContent->title : '—';
                              $displayTitle = mb_strlen($displayTitle) > 50 ? mb_substr($displayTitle, 0, 50, 'UTF-8') . '...' : $displayTitle;
                            @endphp
                            {{ $displayTitle }}
                            @if ($aminite->contents->count() > 0)
                              <div class="mt-1">
                                @foreach ($aminite->contents as $content)
                                  <span class="badge badge-secondary mr-1" title="{{ $content->language->name ?? '' }}">
                                    {{ strtoupper($content->language->code ?? '—') }}
                                  </span>
                                @endforeach
                              </div>
                            @endif
                          </td>
                          <td><i class="{{ $aminite->icon }}"></i></td>
                          <td>
                            <a class="btn btn-secondary btn-sm mr-1 mt-1 editBtn" href="#" data-toggle="modal"
                              data-target="#editModal" data-id="{{ $aminite->id }}"
                              data-icon="{{ $aminite->icon }}"
                              @foreach ($aminite->contents as $content)
                              data-{{ $content->language->code }}_title="{{ $content->title }}"
                              @endforeach>
                              <span class="btn-label">
                                <i class="fas fa-edit"></i>
                              </span>
                            </a>

                            <form class="deleteForm d-inline-block"
                              action="{{ route('admin.listing_specification.delete_aminite', ['id' => $aminite->id]) }}"
                              method="post">
                              @csrf
                              <button type="submit" class="btn btn-danger btn-sm mt-1 deleteBtn">
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
            {{ $aminites->links() }}
          </div>
        </div>
      </div>
    </div>
  </div>

  {{-- create modal --}}
  @include('admin.amenitie.create')

  {{-- edit modal --}}
  @include('admin.amenitie.edit')
@endsection
