<?php

namespace App\Jobs;

use App\Models\Journal\Blog;
use App\Models\Journal\BlogInformation;
use App\Models\Language;
use App\Services\Ai\BlogTranslationService;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;

class TranslateBlogJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public int $tries = 2;

    public function __construct(
        public int $blogId,
        public int $sourceLangId,
        public int $targetLangId,
        public string $targetLangCode,
        public string $targetLangName,
    ) {
    }

    public function handle(BlogTranslationService $translator): void
    {
        try {
            $sourceContent = BlogInformation::where('blog_id', $this->blogId)
                ->where('language_id', $this->sourceLangId)
                ->first();

            if (!$sourceContent || empty($sourceContent->title)) {
                Log::channel('translate')->warning("TranslateBlogJob [blog_id={$this->blogId}]: source content not found for lang #{$this->sourceLangId}");
                return;
            }

            $targetContent = BlogInformation::where('blog_id', $this->blogId)
                ->where('language_id', $this->targetLangId)
                ->first();

            if ($targetContent && !empty($targetContent->title)) {
                Log::channel('translate')->info("TranslateBlogJob [blog_id={$this->blogId}]: already translated to {$this->targetLangCode}");
                return;
            }

            Log::channel('translate')->info("TranslateBlogJob [blog_id={$this->blogId}]: calling translate from ru to {$this->targetLangCode}");

            $translated = $translator->translate(
                $sourceContent,
                $this->targetLangCode,
                $this->targetLangName
            );

            Log::channel('translate')->info("TranslateBlogJob [blog_id={$this->blogId}]: translate response to {$this->targetLangCode}: " . json_encode($translated, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));

            if (!$targetContent) {
                $targetContent = new BlogInformation();
                $targetContent->blog_id = $this->blogId;
                $targetContent->language_id = $this->targetLangId;
                $targetContent->blog_category_id = $sourceContent->blog_category_id;
            }

            $targetContent->title = $translated['title'] ?? '';

            $slugTitle = $translated['title'] ?? '';
            if ($this->targetLangCode !== 'en') {
                $enLanguage = Language::where('code', 'en')->first();
                if ($enLanguage) {
                    $enContent = BlogInformation::where('blog_id', $this->blogId)
                        ->where('language_id', $enLanguage->id)
                        ->first();
                    if ($enContent && !empty($enContent->title)) {
                        $slugTitle = $enContent->title;
                    }
                }
            }
            $targetContent->slug = createSlug($slugTitle);
            $targetContent->author = $translated['author'] ?? ($sourceContent->author ?? '');
            $targetContent->content = $translated['content'] ?? ($sourceContent->content ?? '');
            $targetContent->meta_keywords = $translated['meta_keywords'] ?? '';
            $targetContent->meta_description = $translated['meta_description'] ?? '';

            $targetContent->save();

            $currentTranslations = DB::table('blogs')
                ->where('id', $this->blogId)
                ->value('translated_languages');

            $currentTranslations = $currentTranslations ? json_decode($currentTranslations, true) : [];
            if (!is_array($currentTranslations)) {
                $currentTranslations = [];
            }

            $currentTranslations[$this->targetLangCode] = true;

            DB::table('blogs')
                ->where('id', $this->blogId)
                ->update(['translated_languages' => json_encode($currentTranslations)]);

            Log::channel('translate')->info("TranslateBlogJob [blog_id={$this->blogId}]: successfully translated to {$this->targetLangCode}");
        } catch (\Throwable $e) {
            Log::channel('translate')->error("TranslateBlogJob [blog_id={$this->blogId}] error to {$this->targetLangCode}: " . $e->getMessage() . "\n" . $e->getTraceAsString());
            throw $e;
        }
    }

    public function failed(\Throwable $e): void
    {
        Log::channel('translate')->error("TranslateBlogJob [blog_id={$this->blogId}] FAILED to {$this->targetLangCode}: " . $e->getMessage());
    }
}
