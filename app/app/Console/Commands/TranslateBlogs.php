<?php

namespace App\Console\Commands;

use App\Jobs\TranslateBlogJob;
use App\Models\Journal\Blog;
use App\Models\Language;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class TranslateBlogs extends Command
{
    protected $signature = 'blogs:translate {--batch=1 : Number of blogs per language per run}';
    protected $description = 'Dispatch translation jobs for pending blog posts';

    public function handle(): int
    {
        $autoTranslateEnabled = DB::table('basic_settings')->value('auto_translate_status');

        if (!$autoTranslateEnabled) {
            $this->info('Auto-translate is disabled in settings.');
            return self::SUCCESS;
        }

        $defaultLang = Language::where('is_default', 1)->first();
        if (!$defaultLang) {
            Log::channel('translate')->warning('TranslateBlogs: no default language found');
            return self::FAILURE;
        }

        $targetLanguages = Language::where('id', '!=', $defaultLang->id)->get();
        if ($targetLanguages->isEmpty()) {
            return self::SUCCESS;
        }

        $batchSize = max(1, (int) $this->option('batch'));

        foreach ($targetLanguages as $targetLang) {
            $this->dispatchBatch($defaultLang->id, $targetLang, $batchSize);
        }

        return self::SUCCESS;
    }

    private function dispatchBatch(int $defaultLangId, Language $targetLang, int $batchSize): void
    {
        $pendingBlogs = Blog::query()
            ->where(function ($query) use ($targetLang) {
                $query->whereNull('translated_languages')
                    ->orWhereRaw('JSON_CONTAINS_PATH(translated_languages, \'one\', ?) = 0', [
                        '$."' . $targetLang->code . '"',
                    ]);
            })
            ->whereHas('information', function ($query) use ($defaultLangId) {
                $query->where('language_id', $defaultLangId)
                    ->whereNotNull('title')
                    ->where('title', '!=', '');
            })
            ->where(function ($query) use ($targetLang) {
                $query->whereDoesntHave('information', function ($q) use ($targetLang) {
                    $q->where('language_id', $targetLang->id);
                })->orWhereHas('information', function ($q) use ($targetLang) {
                    $q->where('language_id', $targetLang->id)
                        ->where(function ($sq) {
                            $sq->whereNull('title')->orWhere('title', '');
                        });
                });
            })
            ->limit($batchSize)
            ->get();

        $count = 0;
        foreach ($pendingBlogs as $blog) {
            TranslateBlogJob::dispatchSync(
                blogId: $blog->id,
                sourceLangId: $defaultLangId,
                targetLangId: $targetLang->id,
                targetLangCode: $targetLang->code,
                targetLangName: $targetLang->name,
            );
            $count++;
        }

        if ($count > 0) {
            Log::channel('translate')->info("Dispatched {$count} blog translation jobs for {$targetLang->code}");
            $this->info("Dispatched {$count} blog translation jobs for {$targetLang->code}");
        }
    }
}
