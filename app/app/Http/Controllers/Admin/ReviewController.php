<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Language;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingReview;
use App\Models\ReviewTranslation;
use App\Models\User;
use App\Services\ReviewService;
use Illuminate\Http\Request;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Illuminate\Pagination\LengthAwarePaginator;

class ReviewController extends Controller
{
    public function index(Request $request)
    {
        $defaultLanguage = $this->selectedLanguage($request);
        $contentLanguageId = (int) ($request->input('content_language_id') ?: $defaultLanguage?->id);
        $sourceLanguageId = $request->input('source_language_id') ? (int) $request->input('source_language_id') : null;
        $status = $request->input('status');
        $search = trim((string) $request->input('search'));
        $rows = $this->listingRows($status, $search, $contentLanguageId, $sourceLanguageId);

        $rows = $rows->sortByDesc(fn ($row) => $row->created_at)->values();
        $perPage = 15;
        $page = LengthAwarePaginator::resolveCurrentPage();
        $reviews = new LengthAwarePaginator(
            $rows->forPage($page, $perPage),
            $rows->count(),
            $perPage,
            $page,
            ['path' => $request->url(), 'query' => $request->query()]
        );

        return view('admin.reviews.index', [
            'reviews' => $reviews,
            'languages' => Language::query()->orderBy('id')->get(),
            'defaultLanguage' => $defaultLanguage,
            'contentLanguageId' => $contentLanguageId,
            'sourceLanguageId' => $sourceLanguageId,
        ]);
    }

    public function updateStatus(Request $request, int $id)
    {
        $status = $request->validate(['status' => 'required|in:pending,approved,rejected'])['status'];
        $review = ListingReview::query()->findOrFail($id);
        ReviewService::updateStatus($review, $status);

        return redirect()->back()->with('success', __('Review status updated successfully') . '!');
    }

    public function update(Request $request, int $id)
    {
        $data = $request->validate([
            'rating' => 'required|integer|between:1,5',
            'review' => 'required|string|max:5000',
            'translations' => 'nullable|array',
            'translations.*' => 'nullable|string|max:5000',
        ]);

        $review = ListingReview::query()->findOrFail($id);

        DB::transaction(function () use ($review, $data) {
            $review->update(['rating' => $data['rating'], 'review' => $data['review']]);

            if (!empty($data['translations'])) {
                foreach ($data['translations'] as $languageId => $text) {
                    $text = trim((string) $text);
                    if ($text === '') {
                        $review->translations()->where('language_id', $languageId)->delete();
                    } else {
                        ReviewTranslation::updateOrCreate(
                            [
                                'review_type' => ReviewService::TYPE_LISTING,
                                'review_id' => $review->id,
                                'language_id' => $languageId,
                            ],
                            ['text' => $text]
                        );
                    }
                }
            }
        });

        ReviewService::recalculate(ReviewService::TYPE_LISTING, (int) $review->listing_id);

        return redirect()->back()->with('success', __('Review updated successfully') . '!');
    }

    public function create(Request $request)
    {
        $defaultLanguage = $this->selectedLanguage($request);

        return view('admin.reviews.create', [
            'languages' => Language::query()->orderBy('id')->get(),
            'defaultLanguage' => $defaultLanguage,
            'listings' => Listing::query()->with('listing_content')->orderByDesc('id')->get(),
            'users' => User::query()->orderBy('name')->orderBy('username')->get(['id', 'name', 'username', 'email']),
        ]);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'listing_id' => 'required|integer|exists:listings,id',
            'user_id' => 'required|integer|exists:users,id',
            'rating' => 'required|integer|between:1,5',
            'review' => 'required|string|max:5000',
            'language_id' => 'required|integer|exists:languages,id',
            'status' => 'required|in:pending,approved,rejected',
        ]);

        ListingReview::query()->create($data);

        ReviewService::recalculate(ReviewService::TYPE_LISTING, (int) $data['listing_id']);

        return redirect()->route('admin.reviews.index', ['language' => $request->input('language')])
            ->with('success', __('Review added successfully') . '!');
    }

    public function destroy(int $id)
    {
        $review = ListingReview::query()->findOrFail($id);
        $parentId = (int) $review->listing_id;
        $review->translations()->delete();
        $review->delete();
        ReviewService::recalculate(ReviewService::TYPE_LISTING, $parentId);

        return redirect()->back()->with('success', __('Review deleted successfully') . '!');
    }

    public function bulkStatus(Request $request)
    {
        $data = $request->validate([
            'status' => 'required|in:pending,approved,rejected,delete',
            'selected' => 'required|array|min:1',
            'selected.*' => 'required|string',
        ]);

        $deleted = 0;
        foreach ($data['selected'] as $selected) {
            if (!ctype_digit((string) $selected)) {
                continue;
            }

            if ($data['status'] === 'delete') {
                $review = ListingReview::query()->find((int) $selected);
                if (!$review) {
                    continue;
                }
                $parentId = (int) $review->listing_id;
                $review->translations()->delete();
                $review->delete();
                ReviewService::recalculate(ReviewService::TYPE_LISTING, $parentId);
                $deleted++;
            } else {
                ReviewService::updateStatus(ListingReview::query()->findOrFail((int) $selected), $data['status']);
            }
        }

        $message = $data['status'] === 'delete'
            ? __(':count review(s) deleted successfully', ['count' => $deleted])
            : __('Review statuses updated successfully') . '!';

        return redirect()->back()->with('success', $message);
    }

    private function listingRows(?string $status, string $search, int $contentLanguageId, ?int $sourceLanguageId): Collection
    {
        return ListingReview::query()
            ->with(['userInfo', 'language', 'listingInfo.listing_content'])
            ->when($status, fn ($query) => $query->where('status', $status))
            ->when($sourceLanguageId, fn ($query) => $query->where('language_id', $sourceLanguageId))
            ->when($search, function ($query) use ($search) {
                $query->where(function ($query) use ($search) {
                    $query->whereHas('userInfo', fn ($q) => $q->where('name', 'like', "%{$search}%")->orWhere('username', 'like', "%{$search}%"))
                        ->orWhereHas('listingInfo.listing_content', fn ($q) => $q->where('title', 'like', "%{$search}%"));
                });
            })
            ->get()
            ->map(fn (ListingReview $review) => $this->row($review, $contentLanguageId));
    }

    private function selectedLanguage(Request $request): ?Language
    {
        $code = $request->input('language')
            ?: auth('admin')->user()?->code
            ?: str_replace('admin_', '', (string) auth('admin')->user()?->lang_code);

        return Language::query()->where('code', $code)->first()
            ?: Language::query()->where('is_default', 1)->first();
    }

    private function row(ListingReview $review, int $contentLanguageId): object
    {
        $contents = $review->listingInfo?->listing_content;
        $content = $contents?->firstWhere('language_id', $contentLanguageId) ?: $contents?->first();

        return (object) [
            'model' => $review,
            'id' => $review->id,
            'status' => $review->status ?: 'approved',
            'rating' => $review->rating,
            'text' => ReviewService::translatedText($review, $contentLanguageId),
            'source_text' => ReviewService::sourceText($review),
            'author' => $review->userInfo?->name ?: $review->userInfo?->username ?: __('Unknown'),
            'item_title' => $content?->title ?: __('Unknown'),
            'item_url' => $content?->slug
                ? route('frontend.listing.details', ['slug' => $content->slug])
                : null,
            'source_language' => $review->language?->name ?: '-',
            'translations' => ReviewService::translationLanguages($review),
            'created_at' => $review->created_at,
        ];
    }
}
