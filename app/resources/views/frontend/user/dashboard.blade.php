@extends('frontend.layout')

@section('pageHeading')
  {{ __('Dashboard') }}
@endsection

@section('content')
  @includeIf('frontend.partials.breadcrumb', [
      'breadcrumb' => !empty($bgImg) ? $bgImg->breadcrumb : '',
      'title' => !empty($pageHeading) ? $pageHeading->dashboard_page_title : __('Dashboard'),
  ])
  <!--====== Start Dashboard Section ======-->
  <div class="user-dashboard pt-100 pb-60">
    <div class="container">
      <div class="row gx-xl-5">
        @includeIf('frontend.user.side-navbar')
        <div class="col-lg-9">
          <div class="user-profile-details mb-30">
            <div class="account-info radius-md">
              <div class="title">
                <h4>{{ __('Account Information') }}</h4>
              </div>
              <div class="main-info">
                <ul class="list">
                  <li><span>{{ __('Name') . ':' }}</span> <span>{{ $authUser->name }}</span></li>
                  <li><span>{{ __('Username') . ':' }}</span> <span>{{ $authUser->username }}</span></li>
                  <li><span>{{ __('Email') . ':' }}</span> <span>{{ $authUser->email }}</span></li>
                  <li><span>{{ __('Phone') . ':' }}</span> <span>{{ $authUser->phone }}</span></li>
                  <li><span>{{ __('City') . ':' }}</span> <span>{{ $authUser->city }}</span></li>
                  <li><span>{{ __('Country') . ':' }}</span> <span>{{ $authUser->country }}</span></li>
                  <li><span>{{ __('State') . ':' }}</span> <span>{{ $authUser->state }}</span></li>
                  <li><span>{{ __('Zip Code') . ':' }}</span> <span>{{ $authUser->zip_code }}</span></li>
                  <li><span>{{ __('Address') . ':' }}</span> <span>{{ $authUser->address }}</span></li>
                </ul>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-md-6">
              <a href="{{ route('user.wishlist') }}">
                <div class="card card-box radius-md mb-30 color-1">
                  <div class="card-icon mb-15">
                    <i class="ico-grid"></i>
                  </div>
                  <div class="card-info">
                    <h3 class="mb-0">{{ count($wishlists) }}</h3>
                    <p class="mb-0">{{ __('Wishlist Items') }}</p>
                  </div>
                </div>
              </a>
            </div>
            @if ($basicInfo->shop_status == 1)
              <div class="col-md-6">
                <a href="{{ route('user.order.index') }}">
                  <div class="card card-box radius-md mb-30 color-2">
                    <div class="card-icon mb-15">
                      <i class="ico-grid"></i>
                    </div>
                    <div class="card-info">
                      <h3 class="mb-0">{{ count($orders) }}</h3>
                      <p class="mb-0">{{ __('Total Orders') }}</p>
                    </div>
                  </div>
                </a>
              </div>
            @endif
          </div>

          <div class="account-info radius-md mb-40">
            <div class="title">
              <h4>{{ __('Wishlists') }}</h4>
            </div>
            <div class="main-info">
              @if (count($wishlists) == 0)
                <h3 class="text-center">{{ __('NO WISHLIST ITEM FOUND') . '!' }}</h3>
              @else
                <div class="main-table">
                  <div class="table-responsive">
                    <table id="myTable" class="table table-striped w-100">
                      <thead>
                        <tr>
                          <th>{{ __('Serial') }}</th>
                          <th>{{ __('Listing title') }}</th>
                          <th>{{ __('Action') }}</th>
                        </tr>
                      </thead>
                      <tbody>
                        @php
                          $i = 1;
                        @endphp
                        @foreach ($wishlists as $item)
                          @php
                            $content = DB::table('listing_contents')
                                ->where([['listing_id', $item->listing_id], ['language_id', $language->id]])
                                ->select('title', 'slug')
                                ->first();
                          @endphp
                          @if (!is_null($content))
                            <tr>
                              <td>#{{ $loop->iteration }}</td>
                              <td>
                                <a href="{{ route('frontend.listing.details', ['slug' => $content->slug, 'id' => $item->listing_id]) }}"
                                  target="_blank">
                                  {{ strlen(@$content->title) > 50 ? mb_substr(@$content->title, 0, 50, 'utf-8') . '...' : @$content->title }}
                                </a>
                              </td>
                              <td>
                                <a href="{{ route('frontend.listing.details', [$content->slug, $item->listing_id]) }}"
                                  class="btn"target="_blank"><i class="fas fa-eye"></i> {{ __('View') }}</a>
                                <a href="{{ route('remove.wishlist', $item->listing_id) }}" class="btn btn-danger"><i
                                    class="fas fa-times"></i>{{ __('Remove') }}</a>
                              </td>
                            </tr>
                          @endif
                        @endforeach
                      </tbody>
                    </table>
                  </div>
                </div>
              @endif
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--====== End Dashboard Section ======-->
@endsection
