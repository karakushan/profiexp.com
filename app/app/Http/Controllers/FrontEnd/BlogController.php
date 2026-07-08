<?php

namespace App\Http\Controllers\FrontEnd;

use App\Http\Controllers\Controller;
use App\Http\Controllers\FrontEnd\MiscellaneousController;
use App\Models\BasicSettings\Basic;
use App\Models\Journal\Blog;
use App\Models\Journal\BlogInformation;
use Illuminate\Http\Request;

class BlogController extends Controller
{
  public function category(Request $request, $slug)
  {
    $request->merge(['category' => $slug]);

    return $this->index($request);
  }

  public function index(Request $request)
  {
    $misc = new MiscellaneousController();

    $language = $misc->getLanguage();

    $information['seoInfo'] = $language->seoInfo()->select('meta_title_blog', 'meta_keyword_blog', 'meta_description_blog')->first();

    $information['pageHeading'] = $misc->getPageHeading($language);

    $information['bgImg'] = $misc->getBreadcrumb();

    $blogTitle = $blogCategory = null;

    if ($request->filled('title')) {
      $blogTitle = $request['title'];
    }
    if ($request->filled('category')) {
      $blogCategory = $request['category'];
    }

    $information['blogs'] = Blog::join('blog_informations', 'blogs.id', '=', 'blog_informations.blog_id')
      ->join('blog_category_contents', function ($join) use ($language) {
        $join->on('blog_category_contents.blog_category_id', '=', 'blog_informations.blog_category_id')
          ->where('blog_category_contents.language_id', '=', $language->id);
      })
      ->where('blog_informations.language_id', '=', $language->id)
      ->when($blogTitle, function ($query, $blogTitle) {
        return $query->where('blog_informations.title', 'like', '%' . $blogTitle . '%');
      })
      ->when($blogCategory, function ($query, $blogCategory) {
        return $query->where('blog_category_contents.slug', 'like', '%' . $blogCategory . '%');
      })
      ->select('blogs.image', 'blogs.id', 'blog_category_contents.name as categoryName', 'blog_category_contents.slug AS categorySlug', 'blog_informations.title', 'blog_informations.slug', 'blog_informations.author', 'blogs.created_at', 'blog_informations.content')
      ->orderBy('blogs.serial_number', 'asc')
      ->paginate(6);

    $information['allBlogs'] = $language->blogInformation()->count();

    return view('frontend.journal.blog', $information);
  }

  public function details($slug)
  {
    $misc = new MiscellaneousController();
    $language = $misc->getLanguage();
    $id = BlogInformation::where('language_id', $language->id)
      ->where('slug', $slug)
      ->firstOrFail()
      ->blog_id;

    $information['pageHeading'] = $misc->getPageHeading($language);

    $information['bgImg'] = $misc->getBreadcrumb();

    $details = Blog::join('blog_informations', 'blogs.id', '=', 'blog_informations.blog_id')
      ->join('blog_category_contents', function ($join) use ($language) {
        $join->on('blog_category_contents.blog_category_id', '=', 'blog_informations.blog_category_id')
          ->where('blog_category_contents.language_id', '=', $language->id);
      })
      ->where('blog_informations.language_id', '=', $language->id)
      ->where('blog_informations.blog_id', '=', $id)
      ->select('blogs.id', 'blogs.image', 'blogs.created_at', 'blog_informations.title', 'blog_informations.content', 'blog_informations.meta_keywords', 'blog_informations.meta_description', 'blog_category_contents.name as categoryName', 'blog_category_contents.slug as categorySlug')
      ->firstOrFail();

    $information['details'] = $details;

    $information['recent_blogs'] = Blog::join('blog_informations', 'blogs.id', '=', 'blog_informations.blog_id')
      ->where('blog_informations.language_id', '=', $language->id)
      ->where('blogs.id', '!=', $details->id)
      ->select('blogs.image', 'blogs.id',  'blog_informations.title', 'blog_informations.slug', 'blog_informations.author', 'blogs.created_at', 'blog_informations.content')
      ->orderBy('blogs.serial_number', 'asc')
      ->limit(3)->get();

    $information['disqusInfo'] = Basic::select('disqus_status', 'disqus_short_name')->firstOrFail();

    $information['categories'] = $this->getCategories($language);

    $information['allBlogs'] = $language->blogInformation()->count();

    return view('frontend.journal.blog-details', $information);
  }
  public function getCategories($language)
  {
    $categories = $language->blogCategory()->where('status', 1)->orderBy('serial_number', 'asc')->get();

    $categories->map(function ($category) use ($language) {
      $category->name = $category->getName($language->id);
      $category->slug = $category->getSlug($language->id);
      $category['blogCount'] = $category->blogInfo()->count();
      return $category;
    });

    return $categories;
  }
}
