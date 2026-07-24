<?php

namespace Database\Seeders;

use App\Models\Language;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingReview;
use App\Models\User;
use Illuminate\Database\Seeder;

class ReviewSeeder extends Seeder
{
    public function run(): void
    {
        $russian = Language::query()->where('code', 'ru')->firstOrFail();
        $author = User::query()->where('username', 'demo0')->firstOrFail();
        $listingIds = Listing::query()
            ->whereHas('listing_content', fn ($query) => $query->where('language_id', $russian->id))
            ->orderBy('id')
            ->limit(5)
            ->pluck('id');

        if ($listingIds->count() < 5) {
            $this->command?->warn('ReviewSeeder skipped: fewer than 5 Russian listings found.');

            return;
        }

        $reviews = [
            ['rating' => 5, 'review' => 'Отличный сервис, всё прошло быстро и профессионально.'],
            ['rating' => 4, 'review' => 'Хорошее обслуживание и внимательное отношение к клиенту.'],
            ['rating' => 5, 'review' => 'Результат полностью соответствует ожиданиям. Рекомендую.'],
            ['rating' => 3, 'review' => 'В целом всё хорошо, но можно немного улучшить коммуникацию.'],
            ['rating' => 4, 'review' => 'Заказ выполнен вовремя, спасибо за качественную работу.'],
        ];

        foreach ($listingIds->values() as $index => $listingId) {
            $payload = [
                'user_id' => $author->id,
                'listing_id' => $listingId,
                'language_id' => $russian->id,
            ];

            ListingReview::query()->updateOrCreate(
                $payload,
                [
                    'rating' => $reviews[$index]['rating'],
                    'review' => $reviews[$index]['review'],
                    'status' => 'approved',
                ]
            );
        }
    }
}
