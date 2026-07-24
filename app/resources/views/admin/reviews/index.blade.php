@extends('admin.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Reviews Management') }}</h4>
    <ul class="breadcrumbs">
      <li class="nav-home"><a href="{{ route('admin.dashboard') }}"><i class="flaticon-home"></i></a></li>
      <li class="separator"><i class="flaticon-right-arrow"></i></li>
      <li class="nav-item"><a href="#">{{ __('Reviews Management') }}</a></li>
    </ul>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header">
          <form method="get" action="{{ route('admin.reviews.index') }}">
            <div class="row align-items-end">
              <div class="col-lg-3">
                <label>{{ __('Search') }}</label>
                <input class="form-control" name="search" value="{{ request('search') }}" placeholder="{{ __('Search by author or item') }}">
              </div>
              <div class="col-lg-2">
                <label>{{ __('Status') }}</label>
                <select class="form-control" name="status">
                  <option value="">{{ __('All statuses') }}</option>
                  @foreach (['pending', 'approved', 'rejected'] as $status)
                    <option value="{{ $status }}" @selected(request('status') === $status)>{{ __(ucfirst($status)) }}</option>
                  @endforeach
                </select>
              </div>
              <div class="col-lg-2">
                <label>{{ __('Content language') }}</label>
                <select class="form-control" name="content_language_id">
                  @foreach ($languages as $language)
                    <option value="{{ $language->id }}" @selected($contentLanguageId === $language->id)>{{ $language->name }}</option>
                  @endforeach
                </select>
              </div>
              <div class="col-lg-2">
                <label>{{ __('Source language') }}</label>
                <select class="form-control" name="source_language_id">
                  <option value="">{{ __('All languages') }}</option>
                  @foreach ($languages as $language)
                    <option value="{{ $language->id }}" @selected($sourceLanguageId === $language->id)>{{ $language->name }}</option>
                  @endforeach
                </select>
              </div>
              <div class="col-lg-1">
                <button class="btn btn-primary w-100" type="submit">{{ __('Filter') }}</button>
              </div>
            </div>
          </form>
        </div>

        <form method="post" action="{{ route('admin.reviews.bulk_status') }}">
          @csrf
          <div class="card-body">
            <div class="row mb-3 align-items-center">
              <div class="col-md-6"><h4 class="card-title mb-0">{{ __('Customer Reviews') }}</h4></div>
              <div class="col-md-6 text-md-right mt-2 mt-md-0">
                <a href="{{ route('admin.reviews.create', ['language' => request('language')]) }}" class="btn btn-primary mr-2">
                  <i class="fas fa-plus"></i> {{ __('Add Review') }}
                </a>
                <select class="form-control d-inline-block w-auto" name="status" required>
                  <option value="">{{ __('Bulk action') }}</option>
                  <option value="approved">{{ __('Approve') }}</option>
                  <option value="rejected">{{ __('Reject') }}</option>
                  <option value="pending">{{ __('Set pending') }}</option>
                </select>
                <button class="btn btn-success" type="submit">{{ __('Apply') }}</button>
              </div>
            </div>

            @if ($reviews->isEmpty())
              <h3 class="text-center mt-4">{{ __('NO REVIEW FOUND') . '!' }}</h3>
            @else
              <div class="table-responsive">
                <table class="table table-striped mt-3">
                  <thead>
                    <tr>
                      <th><input type="checkbox" id="selectAllReviews"></th>
                      <th>{{ __('Listing') }}</th><th>{{ __('Author') }}</th>
                      <th>{{ __('Rating') }}</th><th>{{ __('Review') }}</th><th>{{ __('Source language') }}</th>
                      <th>{{ __('Approve Status') }}</th><th>{{ __('Date') }}</th><th>{{ __('Actions') }}</th>
                    </tr>
                  </thead>
                  <tbody>
                    @foreach ($reviews as $review)
                      <tr>
                        <td><input type="checkbox" name="selected[]" value="{{ $review->id }}"></td>
                        <td>{{ $review->item_title }}</td><td>{{ $review->author }}</td>
                        <td>{{ $review->rating }}/5</td>
                        <td style="min-width:220px;max-width:320px;">{{ \Illuminate\Support\Str::limit($review->text, 120) }}</td>
                        <td>{{ $review->source_language }}</td>
                        <td>
                          <form id="reviewStatusForm{{ $review->id }}" class="d-inline-block" method="post"
                            action="{{ route('admin.reviews.update_status', $review->id) }}">
                            @csrf
                            <select
                              class="form-control form-control-sm review-approval-status {{ $review->status === 'approved' ? 'bg-success' : ($review->status === 'rejected' ? 'bg-danger' : 'bg-warning') }}"
                              name="status"
                              onchange="document.getElementById('reviewStatusForm{{ $review->id }}').submit();">
                              @foreach (['approved', 'pending', 'rejected'] as $status)
                                <option value="{{ $status }}" @selected($review->status === $status)>{{ __(ucfirst($status)) }}</option>
                              @endforeach
                            </select>
                          </form>
                        </td>
                        <td>{{ optional($review->created_at)->format('Y-m-d H:i') }}</td>
                        <td>
                          <div class="dropdown">
                            <button class="btn btn-secondary btn-sm dropdown-toggle" type="button"
                              id="reviewActions{{ $review->id }}" data-toggle="dropdown" aria-haspopup="true"
                              aria-expanded="false">
                              {{ __('Select') }}
                            </button>
                            <div class="dropdown-menu" aria-labelledby="reviewActions{{ $review->id }}">
                              <button type="button" class="dropdown-item" data-toggle="modal"
                                data-target="#reviewEditModal{{ $review->id }}">{{ __('Edit') }}</button>
                              <button type="button" class="dropdown-item" data-toggle="modal"
                                data-target="#reviewModal{{ $review->id }}">{{ __('Detail') }}</button>
                              @if ($review->item_url)
                                <a href="{{ $review->item_url }}" class="dropdown-item" target="_blank" rel="noopener">{{ __('Preview') }}</a>
                              @endif
                              <form method="post" action="{{ route('admin.reviews.delete', $review->id) }}"
                                onsubmit="return confirm('{{ __('Are you sure?') }}')">
                                @csrf
                                <button class="dropdown-item text-danger" type="submit">{{ __('Delete') }}</button>
                              </form>
                            </div>
                          </div>
                        </td>
                      </tr>
                      <div class="modal fade" id="reviewModal{{ $review->id }}" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog modal-lg" role="document"><div class="modal-content">
                          <div class="modal-header"><h5 class="modal-title">{{ __('Review details') }}</h5><button type="button" class="close" data-dismiss="modal"><span>&times;</span></button></div>
                          <div class="modal-body">
                            <p><strong>{{ __('Item') }}:</strong> {{ $review->item_title }}</p>
                            <p><strong>{{ __('Author') }}:</strong> {{ $review->author }}</p>
                            <p><strong>{{ __('Rating') }}:</strong> {{ $review->rating }}/5</p>
                            <p><strong>{{ __('Original review') }}:</strong></p><div class="border rounded p-3 mb-3">{{ $review->source_text }}</div>
                            <p><strong>{{ __('Displayed translation') }}:</strong></p><div class="border rounded p-3">{{ $review->text }}</div>
                            <hr><p class="mb-1"><strong>{{ __('Available translations') }}:</strong></p>
                            @forelse ($review->translations as $translation)
                              <div class="mb-2"><strong>{{ $translation->language?->name }}:</strong> {{ $translation->text }}</div>
                            @empty
                              <span class="text-muted">{{ __('No translations yet') }}</span>
                            @endforelse
                          </div>
                        </div></div>
                      </div>
                      <div class="modal fade" id="reviewEditModal{{ $review->id }}" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog" role="document"><div class="modal-content">
                          <form method="post" action="{{ route('admin.reviews.update', $review->id) }}">
                            @csrf
                            <div class="modal-header"><h5 class="modal-title">{{ __('Edit Review') }}</h5><button type="button" class="close" data-dismiss="modal"><span>&times;</span></button></div>
                            <div class="modal-body">
                              <div class="form-group">
                                <label for="rating{{ $review->id }}">{{ __('Rating') }}</label>
                                <select id="rating{{ $review->id }}" class="form-control" name="rating" required>
                                  @for ($rating = 5; $rating >= 1; $rating--)
                                    <option value="{{ $rating }}" @selected((int) $review->rating === $rating)>{{ $rating }}/5</option>
                                  @endfor
                                </select>
                              </div>
                              <div class="form-group mb-0">
                                <label for="reviewText{{ $review->id }}">{{ __('Review') }}</label>
                                <textarea id="reviewText{{ $review->id }}" class="form-control" name="review" rows="6" required>{{ $review->source_text }}</textarea>
                              </div>
                            </div>
                            <div class="modal-footer">
                              <button type="button" class="btn btn-secondary" data-dismiss="modal">{{ __('Cancel') }}</button>
                              <button type="submit" class="btn btn-primary">{{ __('Save') }}</button>
                            </div>
                          </form>
                        </div></div>
                      </div>
                    @endforeach
                  </tbody>
                </table>
              </div>
            @endif
          </div>
        </form>
        <div class="card-footer"><div class="d-inline-block mx-auto">{{ $reviews->links() }}</div></div>
      </div>
    </div>
  </div>
@endsection

@push('styles')
  <style>
    .review-approval-status {
      width: 145px !important;
      min-width: 145px !important;
      height: calc(1.5em + .5rem + 2px) !important;
      min-height: calc(1.5em + .5rem + 2px) !important;
    }
  </style>
@endpush

@push('scripts')
  <script>
    document.getElementById('selectAllReviews')?.addEventListener('change', function () {
      document.querySelectorAll('input[name="selected[]"]').forEach((checkbox) => checkbox.checked = this.checked);
    });
  </script>
@endpush
