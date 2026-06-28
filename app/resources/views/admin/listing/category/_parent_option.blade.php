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
    $name = $defaultContent ? $defaultContent->name : '—';
@endphp
<option value="{{ $category->id }}" {{ isset($excludeId) && $category->id == $excludeId ? 'disabled' : '' }}>
    {{ $indent }}{{ $name }}
</option>
@if ($category->allChildren && $category->allChildren->count())
    @foreach ($category->allChildren as $child)
        @include('admin.listing.category._parent_option', ['category' => $child, 'level' => $level + 1, 'excludeId' => $excludeId ?? null])
    @endforeach
@endif