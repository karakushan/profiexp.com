@extends('frontend.layout')

@section('pageHeading')
  @if (!empty($pageHeading))
    {{ $pageHeading->blog_page_title }}
  @else
    {{ __('Posts') }}
  @endif
@endsection

@section('metaKeywords')
  @if (!empty($seoInfo))
    {{ $seoInfo->meta_keyword_blog }}
  @endif
@endsection

@section('metaDescription')
  @if (!empty($seoInfo))
    {{ $seoInfo->meta_description_blog }}
  @endif
@endsection

@section('content')
  <!-- Page title start-->
  @includeIf('frontend.partials.breadcrumb', [
      'breadcrumb' => $bgImg->breadcrumb,
      'title' => !empty($pageHeading) ? $pageHeading->blog_page_title : __('Blog'),
  ])
  <!-- Page title end-->
  <!-- Blog-area start -->
  <section class="blog-area ptb-100">
    <div class="container">
      <div class="row">
        <div class="col-12">
          <div class="row justify-content-center">
            @if (count($blogs) == 0)
              <h3 class="text-center">{{ __('NO POST FOUND') . '!' }}</h3>
            @else
              @foreach ($blogs as $blog)
                <div class="col-md-6 col-lg-4" data-aos="fade-up">
                  <article class="card mb-25">
                    <div class="card-img radius-md">
                      <a href="{{ route('blog.details', ['slug' => $blog->slug]) }}"
                        class="lazy-container ratio ratio-16-10">
                        <img class="lazyload" src="assets/images/placeholder.png"
                          data-src="{{ asset('assets/img/blogs/' . $blog->image) }}" alt="Blog Image">
                      </a>
                    </div>
                    <div class="content">
                      <h3 class="card-title">
                        <a href="{{ route('blog.details', ['slug' => $blog->slug]) }}">
                          {{ @$blog->title }}
                        </a>
                      </h3>
                      <p class="card-text">
                        {{ strlen(strip_tags(convertUtf8($blog->content))) > 100 ? substr(strip_tags(convertUtf8($blog->content)), 0, 100) . '...' : strip_tags(convertUtf8($blog->content)) }}
                      </p>
                      <a href="{{ route('blog.details', ['slug' => $blog->slug]) }}"
                        class="card-btn">{{ __('Read More') }}</a>
                    </div>
                  </article>
                </div>
              @endforeach
            @endif
          </div>
        </div>
      </div>
      <div class="pagination mt-20 justify-content-center" data-aos="fade-up">
        {{ $blogs->links() }}
      </div>
    </div>
    @if (!empty(showAd(3)))
      <div class="text-center mt-40">
        {!! showAd(3) !!}
      </div>
    @endif
  </section>
@endsection
