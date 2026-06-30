@extends('admin.layout')

@includeIf('admin.partials.rtl-style')

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
                <a href="#">{{ __('Listing Specifications') }}</a>
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
                        <div class="col-lg-7">
                            <div class="card-title d-inline-block">{{ __('Categories') }}</div>
                        </div>

                        <div class="col-lg-4 offset-lg-1 mt-2 mt-lg-0">
                            <a href="#" data-toggle="modal" data-target="#createModal"
                                class="btn btn-primary btn-sm float-lg-right float-left"><i class="fas fa-plus"></i>
                                {{ __('Add') }}</a>

                            <button class="btn btn-danger btn-sm float-right mr-2 d-none bulk-delete"
                                data-href="{{ route('admin.listing_specification.bulk_delete_category') }}">
                                <i class="flaticon-interface-5"></i> {{ __('Delete') }}
                            </button>
                        </div>
                    </div>
                </div>

                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-12">
                            @if (count($rootCategories) == 0)
                                <h3 class="text-center mt-2">{{ __('NO CATEGORY FOUND') . '!' }}</h3>
                            @else
                                <div class="table-responsive">
                                    <table class="table table-striped mt-3">
                                        <thead>
                                            <tr>
                                                <th scope="col">
                                                    <input type="checkbox" class="bulk-check" data-val="all">
                                                </th>
                                                <th scope="col">ID</th>
                                                <th scope="col">{{ __('Name') }}</th>
                                                <th scope="col">{{ __('Icon') }}</th>
                                                <th scope="col">{{ __('Status') }}</th>
                                                <th scope="col">{{ __('Serial Number') }}</th>
                                                <th scope="col">{{ __('Actions') }}</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            @foreach ($rootCategories as $category)
                                                @include('admin.listing.category._category_row', ['category' => $category, 'level' => 0])
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
                        {{ $rootCategories->appends([
                                'vendor_id' => request()->input('vendor_id'),
                                'title' => request()->input('title'),
                                'status' => request()->input('status'),
                                'category' => request()->input('category'),
                                'language' => request()->input('language'),
                                'featured' => request()->input('featured'),
                            ])->links() }}
                    </div>
                </div>
            </div>
        </div>
    </div>

    @include('admin.listing.category.create')
    @include('admin.listing.category.edit')
@endsection

@section('script')
@include('admin.listing.category.edit-seo-script')
@endsection