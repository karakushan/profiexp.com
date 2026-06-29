@extends('admin.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Categories') }}</h4>
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
        <a href="#">{{ __('Blog Management') }}</a>
      </li>
      <li class="separator">
        <i class="flaticon-right-arrow"></i>
      </li>
      <li class="nav-item">
        <a href="#">{{ __('Categories') }}</a>
      </li>
    </ul>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <div class="row">
            <div class="col-lg-4">
              <div class="card-title d-inline-block">{{ __('Categories') }}</div>
            </div>

            <div class="col-lg-4 offset-lg-4 mt-2 mt-lg-0">
              <a href="#" data-toggle="modal" data-target="#createModal"
                class="btn btn-primary btn-sm float-lg-right float-left"><i class="fas fa-plus"></i>
                {{ __('Add') }}</a>

              <button class="btn btn-danger btn-sm float-right mr-2 d-none bulk-delete"
                data-href="{{ route('admin.blog_management.bulk_delete_category') }}">
                <i class="flaticon-interface-5"></i> {{ __('Delete') }}
              </button>
            </div>
          </div>
        </div>

        <div class="card-body">
          <div class="row">
            <div class="col-lg-12">
              @if (count($categories) == 0)
                <h3 class="text-center mt-2">{{ __('NO BLOG CATEGORY FOUND') . '!' }}</h3>
              @else
                <div class="table-responsive">
                  <table class="table table-striped mt-3" id="basic-datatables">
                    <thead>
                      <tr>
                        <th scope="col">
                          <input type="checkbox" class="bulk-check" data-val="all">
                        </th>
                        <th scope="col">{{ __('Name') }}</th>
                        <th scope="col">{{ __('Status') }}</th>
                        <th scope="col">{{ __('Serial Number') }}</th>
                        <th scope="col">{{ __('Actions') }}</th>
                      </tr>
                    </thead>
                    <tbody>
                      @foreach ($categories as $category)
                        @php
                          $defaultContent = $category->contents->firstWhere('language_id', $adminLanguageId ?? 0);
                          if (!$defaultContent) {
                              $defaultContent = $category->contents->first();
                          }
                          $name = $defaultContent ? $defaultContent->name : '—';
                          $displayName = mb_strlen($name) > 50 ? mb_substr($name, 0, 50, 'UTF-8') . '...' : $name;
                        @endphp
                        <tr>
                          <td>
                            <input type="checkbox" class="bulk-check" data-val="{{ $category->id }}">
                          </td>
                          <td>
                            {{ $displayName }}
                            @if ($category->contents->count() > 0)
                              <div class="mt-1">
                                @foreach ($category->contents as $content)
                                  <span class="badge badge-secondary mr-1" title="{{ $content->language->name ?? '' }}">
                                    {{ strtoupper($content->language->code ?? '—') }}
                                  </span>
                                @endforeach
                              </div>
                            @endif
                          </td>
                          <td>
                            @if ($category->status == 1)
                              <h2 class="d-inline-block"><span class="badge badge-success">{{ __('Active') }}</span></h2>
                            @else
                              <h2 class="d-inline-block"><span class="badge badge-danger">{{ __('Deactive') }}</span></h2>
                            @endif
                          </td>
                          <td>{{ $category->serial_number }}</td>
                          <td>
                            <a class="btn btn-secondary btn-sm mr-1 mb-1 editBtn" href="#" data-toggle="modal"
                              data-target="#editModal" data-id="{{ $category->id }}"
                              data-status="{{ $category->status }}"
                              data-serial_number="{{ $category->serial_number }}"
                              @foreach ($category->contents as $content)
                                data-{{ $content->language->code }}_name="{{ $content->name }}"
                                data-{{ $content->language->code }}_meta_title="{{ $content->meta_title }}"
                                data-{{ $content->language->code }}_meta_description="{{ $content->meta_description }}"
                                data-{{ $content->language->code }}_seo_text="{{ $content->seo_text }}" @endforeach>
                              <span class="btn-label">
                                <i class="fas fa-edit"></i>
                              </span>
                            </a>

                            <form class="deleteForm d-inline-block"
                              action="{{ route('admin.blog_management.delete_category', ['id' => $category->id]) }}"
                              method="post">
                              @csrf
                              <button type="submit" class="btn btn-danger btn-sm deleteBtn mb-1 mr-1">
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
          <div class="row">
            <div class="d-inline-block mx-auto">
              {{ $categories->links() }}
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  {{-- create modal --}}
  @include('admin.journal.category.create')

  {{-- edit modal --}}
  @include('admin.journal.category.edit')
@endsection
