<?php

namespace App\Http\Controllers\Admin\Journal;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Helpers\UploadFile;
use App\Http\Requests\Blog\StoreRequest;
use App\Http\Requests\Blog\UpdateRequest;
use App\Models\Journal\Blog;
use App\Models\Journal\BlogInformation;
use App\Models\Language;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Str;
use Mews\Purifier\Facades\Purifier;

class BlogController extends Controller
{
    public function index(Request $request)
    {
        $language = Language::where('code', $request->language)->firstOrFail();

        $information['blogs'] = Blog::query()->join('blog_informations', 'blogs.id', '=', 'blog_informations.blog_id')
            ->join('blog_category_contents', function ($join) use ($language) {
                $join->on('blog_category_contents.blog_category_id', '=', 'blog_informations.blog_category_id')
                    ->where('blog_category_contents.language_id', '=', $language->id);
            })
            ->where('blog_informations.language_id', '=', $language->id)
            ->select('blogs.id', 'blogs.serial_number', 'blogs.created_at', 'blog_informations.title', 'blog_informations.slug', 'blog_category_contents.name AS categoryName')
            ->orderByDesc('blogs.id')
            ->get();

        // The listing is filtered to the selected admin language, but the
        // language badges must reflect all translations of each blog.
        $information['blogs']->load('information.language');
        $information['langs'] = Language::all();

        return view('admin.journal.blog.index', $information);
    }

    public function create()
    {
        $languages = Language::all();

        $languages->map(function ($language) {
            $language['categories'] = $language->blogCategory()->where('status', 1)->orderByDesc('id')->get()
                ->map(function ($cat) use ($language) {
                    $cat->name = $cat->getName($language->id);
                    return $cat;
                });
        });

        $information['languages'] = $languages;
        $information['defaultLang'] = Language::where('is_default', 1)->first();

        return view('admin.journal.blog.create', $information);
    }

    public function store(StoreRequest $request)
    {
        $imgName = UploadFile::store(public_path('assets/img/blogs/'), $request->file('image'));

        $blog = Blog::create([
            'image' => $imgName,
            'serial_number' => $request->serial_number,
            'translated_languages' => '{}',
        ]);

        $languages = Language::all();

        foreach ($languages as $language) {
            $blogInformation = new BlogInformation();
            $blogInformation->language_id = $language->id;
            $blogInformation->blog_category_id = $request->category_id;
            $blogInformation->blog_id = $blog->id;
            $blogInformation->title = $request[$language->code . '_title'];
            $blogInformation->slug = Str::slug($request[$language->code . '_title']);
            $blogInformation->author = $request[$language->code . '_author'];
            $blogInformation->content = Purifier::clean($request[$language->code . '_content'], 'youtube');
            $blogInformation->meta_keywords = $request[$language->code . '_meta_keywords'];
            $blogInformation->meta_description = $request[$language->code . '_meta_description'];
            $blogInformation->save();
        }

        Session::flash('success', __('New blog added successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }

    public function edit($id)
    {
        $blog = Blog::findOrFail($id);
        $information['blog'] = $blog;

        $languages = Language::all();

        $languages->map(function ($language) use ($blog) {
            $language['blogData'] = $language->blogInformation()->where('blog_id', $blog->id)->first();

            $language['categories'] = $language->blogCategory()->where('status', 1)->orderByDesc('id')->get()
                ->map(function ($cat) use ($language) {
                    $cat->name = $cat->getName($language->id);
                    return $cat;
                });
        });

        $information['languages'] = $languages;
        $information['defaultLang'] = Language::where('is_default', 1)->first();

        return view('admin.journal.blog.edit', $information); 
    }

    public function update(UpdateRequest $request, $id)
    {
        $blog = Blog::find($id);

        if ($request->hasFile('image')) {
            $imgName = UploadFile::update(public_path('assets/img/blogs/'), $request->file('image'), $blog->image);
        }

        $blog->update([
            'image' => $request->hasFile('image') ? $imgName : $blog->image,
            'serial_number' => $request->serial_number,
            'translated_languages' => '{}',
        ]);

        $languages = Language::all();

        foreach ($languages as $language) {
            $blogInformation = BlogInformation::where('blog_id', $id)->where('language_id', $language->id)->first();

            $blogInformation->update([
                'blog_category_id' => $request->category_id,
                'title' => $request[$language->code . '_title'],
                'slug' => createSlug($request[$language->code . '_title']),
                'author' => $request[$language->code . '_author'],
                'content' => Purifier::clean($request[$language->code . '_content'], 'youtube'),
                'meta_keywords' => $request[$language->code . '_meta_keywords'],
                'meta_description' => $request[$language->code . '_meta_description']
            ]);
        }

        Session::flash('success', __('Blog updated successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }

    public function destroy($id)
    {
        $blog = Blog::find($id);

        @unlink(public_path('assets/img/blogs/') . $blog->image);

        $blogInformations = $blog->information()->get();

        foreach ($blogInformations as $blogInformation) {
            $blogInformation->delete();
        }

        $blog->delete();

        return redirect()->back()->with('success', __('Blog deleted successfully') . '!');
    }

    public function bulkDestroy(Request $request)
    {
        $ids = $request->ids;

        foreach ($ids as $id) {
            $blog = Blog::find($id);

            @unlink(public_path('assets/img/blogs/') . $blog->image);

            $blogInformations = $blog->information()->get();

            foreach ($blogInformations as $blogInformation) {
                $blogInformation->delete();
            }

            $blog->delete();
        }

        Session::flash('success', __('Blogs deleted successfully') . '!');

        return Response::json(['status' => 'success'], 200);
    }
}
