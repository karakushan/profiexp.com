@php
    $indent = str_repeat('— ', $level);

    $defaultContent = null;
    foreach ($category->contents ?? [] as $c) {
        if ($c->language_id == ($adminLanguageId ?? 0)) {
            $defaultContent = $c;
            break;
        }
    }
    if (!$defaultContent && ($category->contents->count() ?? 0) > 0) {
        $defaultContent = $category->contents->first();
    }
    $name = $defaultContent ? $defaultContent->name : ($category->name ?? '—');
    $displayName = mb_strlen($name) > 50 ? mb_substr($name, 0, 50, 'UTF-8') . '...' : $name;
@endphp
<tr>
    <td>
        <input type="checkbox" class="bulk-check" data-val="{{ $category->id }}">
    </td>
    <td>
        <span style="padding-left: {{ $level * 24 }}px;">{{ $indent }}{{ $displayName }}</span>
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
    <td><i class="{{ $category->icon }}"></i></td>
    <td>
        @if ($category->status == 1)
            <h2 class="d-inline-block"><span class="badge badge-success">{{ __('Active') }}</span></h2>
        @else
            <h2 class="d-inline-block"><span class="badge badge-danger">{{ __('Deactive') }}</span></h2>
        @endif
    </td>
    <td>{{ $category->serial_number }}</td>
    <td>
        @if ($defaultContent)
            <a class="btn btn-primary btn-sm mr-1 mt-1" href="{{ route('frontend.listings', ['category_id' => $defaultContent->slug]) }}" target="_blank" title="{{ __('View') }}">
                <span class="btn-label">
                    <i class="fas fa-eye"></i>
                </span>
            </a>
        @endif
        <a class="btn btn-secondary btn-sm mr-1 mt-1 editBtn" href="#" data-toggle="modal" data-target="#editModal"
            data-id="{{ $category->id }}"
            data-status="{{ $category->status }}"
            data-icon="{{ $category->icon }}"
            data-parent_id="{{ $category->parent_id }}"
            data-mobile_image="{{ $category->mobile_image ? asset('assets/img/listing/category/' . $category->mobile_image) : asset('assets/img/noimage.jpg') }}"
            data-serial_number="{{ $category->serial_number }}"
            @foreach ($category->contents as $content)
            data-{{ $content->language->code }}_name="{{ $content->name }}"
            data-{{ $content->language->code }}_meta_title="{{ $content->meta_title }}"
            data-{{ $content->language->code }}_meta_description="{{ $content->meta_description }}"
            @endforeach>
            <span class="btn-label">
                <i class="fas fa-edit"></i>
            </span>
        </a>
        <form class="deleteForm d-inline-block"
            action="{{ route('admin.listing_specification.delete_category', ['id' => $category->id]) }}" method="post">
            @csrf
            <button type="submit" class="btn btn-danger mt-1 btn-sm deleteBtn">
                <span class="btn-label">
                    <i class="fas fa-trash"></i>
                </span>
            </button>
        </form>
    </td>
</tr>
@if ($category->allChildren && $category->allChildren->count())
    @foreach ($category->allChildren as $child)
        @include('admin.listing.category._category_row', ['category' => $child, 'level' => $level + 1])
    @endforeach
@endif