@extends('frontend.layout')

@section('pageHeading')
  {{ __('Wishlist') }}
@endsection


@section('content')
  @includeIf('frontend.partials.breadcrumb', [
      'breadcrumb' => $bgImg->breadcrumb,
      'title' => !empty($pageHeading) ? $pageHeading->wishlist_page_title : __('Wishlist'),
  ])


  <!--====== Start Dashboard Section ======-->
  <div class="user-dashboard pt-100 pb-60">
    <div class="container">
      <div class="row gx-xl-5">
        @includeIf('frontend.user.side-navbar')
        <div class="col-lg-9">
          <div class="account-info radius-md mb-40">
            <div class="title">
              <h4>{{ __('Wishlist') }}</h4>
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
                              <td class="title"><a
                                  href="{{ route('frontend.listing.details', ['slug' => $content->slug, 'id' => $item->listing_id]) }}"
                                  target="_blank">
                                  {{ strlen(@$content->title) > 50 ? mb_substr(@$content->title, 0, 50, 'utf-8') . '...' : @$content->title }}
                                </a>
                              </td>
                              <td>
                                <a href="{{ route('frontend.listing.details', [$content->slug, $item->listing_id]) }}"
                                  class="btn icon-start"target="_blank">
                                  <i class="fas fa-eye"></i>
                                  {{ __('View') }}
                                </a>
                                <a href="{{ route('remove.wishlist', $item->listing_id) }}" class="btn icon-start">
                                  <i class="fas fa-times"></i>
                                  {{ __('Remove') }}
                                </a>
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
