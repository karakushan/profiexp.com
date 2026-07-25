@extends('admin.layout')

@section('content')
  <div class="page-header">
    <h4 class="page-title">{{ __('Add Review') }}</h4>
    <ul class="breadcrumbs">
      <li class="nav-home"><a href="{{ route('admin.dashboard') }}"><i class="flaticon-home"></i></a></li>
      <li class="separator"><i class="flaticon-right-arrow"></i></li>
      <li class="nav-item"><a href="{{ route('admin.reviews.index') }}">{{ __('Reviews Management') }}</a></li>
      <li class="separator"><i class="flaticon-right-arrow"></i></li>
      <li class="nav-item"><a href="#">{{ __('Add Review') }}</a></li>
    </ul>
  </div>

  <div class="row">
    <div class="col-md-8">
      <div class="card">
        <form method="post" action="{{ route('admin.reviews.store') }}">
          @csrf
          <input type="hidden" name="language" value="{{ request('language') }}">
          <div class="card-header"><div class="card-title">{{ __('Add Review') }}</div></div>
          <div class="card-body">
            <div class="form-row">
              <div class="form-group col-md-6">
                <label for="listing_id">{{ __('Select Listing') }} *</label>
                <select id="listing_id" class="form-control @error('listing_id') is-invalid @enderror" name="listing_id" required>
                  <option value="">{{ __('Select Listing') }}</option>
                  @foreach ($listings as $listing)
                    @php $content = $listing->listing_content->firstWhere('language_id', $defaultLanguage?->id) ?: $listing->listing_content->first(); @endphp
                    <option value="{{ $listing->id }}" @selected((string) old('listing_id') === (string) $listing->id)>
                      #{{ $listing->id }} — {{ $content?->title ?: __('Untitled') }}
                    </option>
                  @endforeach
                </select>
                @error('listing_id')<div class="invalid-feedback">{{ $message }}</div>@enderror
              </div>

              <div class="form-group col-md-6">
                <label for="user_id">{{ __('Author') }} *</label>
                <select id="user_id" class="form-control @error('user_id') is-invalid @enderror" name="user_id" required>
                  <option value="">{{ __('Select User') }}</option>
                  @foreach ($users as $user)
                    <option value="{{ $user->id }}" @selected((string) old('user_id') === (string) $user->id)>
                      {{ $user->name ?: $user->username ?: $user->email }}
                    </option>
                  @endforeach
                </select>
                @error('user_id')<div class="invalid-feedback">{{ $message }}</div>@enderror
              </div>
            </div>

            <div class="form-row">
              <div class="form-group col-md-4">
                <label for="rating">{{ __('Rating') }} *</label>
                <select id="rating" class="form-control @error('rating') is-invalid @enderror" name="rating" required>
                  <option value="">{{ __('Rating') }}</option>
                  @for ($rating = 5; $rating >= 1; $rating--)
                    <option value="{{ $rating }}" @selected((string) old('rating') === (string) $rating)>{{ $rating }}/5</option>
                  @endfor
                </select>
                @error('rating')<div class="invalid-feedback">{{ $message }}</div>@enderror
              </div>
              <div class="form-group col-md-4">
                <label for="language_id">{{ __('Source language') }} *</label>
                <select id="language_id" class="form-control @error('language_id') is-invalid @enderror" name="language_id" required>
                  @foreach ($languages as $language)
                    <option value="{{ $language->id }}" @selected((string) old('language_id', $defaultLanguage?->id) === (string) $language->id)>{{ $language->name }}</option>
                  @endforeach
                </select>
                @error('language_id')<div class="invalid-feedback">{{ $message }}</div>@enderror
              </div>
              <div class="form-group col-md-4">
                <label for="status">{{ __('Approve Status') }} *</label>
                <select id="status" class="form-control @error('status') is-invalid @enderror" name="status" required>
                  <option value="approved" @selected(old('status', 'approved') === 'approved')>{{ __('Approved') }}</option>
                  <option value="pending" @selected(old('status') === 'pending')>{{ __('Pending') }}</option>
                  <option value="rejected" @selected(old('status') === 'rejected')>{{ __('Rejected') }}</option>
                </select>
                @error('status')<div class="invalid-feedback">{{ $message }}</div>@enderror
              </div>
            </div>

            <div class="form-group">
              <label for="review">{{ __('Review') }} *</label>
              <textarea id="review" class="form-control @error('review') is-invalid @enderror" name="review" rows="6" required>{{ old('review') }}</textarea>
              @error('review')<div class="invalid-feedback">{{ $message }}</div>@enderror
            </div>
          </div>
          <div class="card-footer text-right">
            <a href="{{ route('admin.reviews.index') }}" class="btn btn-secondary">{{ __('Cancel') }}</a>
            <button type="submit" class="btn btn-primary">{{ __('Save') }}</button>
          </div>
        </form>
      </div>
    </div>
  </div>
@endsection
