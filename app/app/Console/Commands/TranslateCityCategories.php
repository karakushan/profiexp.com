<?php

namespace App\Console\Commands;

use App\Jobs\TranslateCityCategoryBatchJob;
use App\Models\Language;
use App\Models\Location\ListingCityCategory;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class TranslateCityCategories extends Command
{
    protected $signature = 'city-categories:translate {--batch=5 : Number of city categories per run}';
    protected $description = 'Translate city category SEO pages to missing languages';

    public function handle(): int
    {
        if (!DB::table('basic_settings')->value('auto_translate_status')) return self::SUCCESS;
        $default = Language::where('is_default', 1)->first();
        if (!$default) return self::FAILURE;

        $total = Language::count();
        $batch = max(1, (int) $this->option('batch'));
        $items = ListingCityCategory::whereHas('contents', fn($q) => $q->whereNotNull('name')->where('name', '!=', ''))
            ->withCount(['contents as filled_count' => fn($q) => $q->whereNotNull('seo_text')->where('seo_text', '!=', '')])
            ->get()->filter(fn($item) => $item->filled_count < $total)->take($batch);

        foreach ($items as $item) {
            $source = $item->contents()->whereNotNull('name')->where('name', '!=', '')->first();
            if ($source) TranslateCityCategoryBatchJob::dispatchSync($item->id, $source->language_id);
        }

        return self::SUCCESS;
    }
}
