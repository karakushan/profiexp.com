<?php

namespace App\Jobs;

use App\Models\Aminite;
use App\Models\AminiteContent;
use App\Models\Language;
use App\Services\Ai\AminiteTranslationService;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;

class TranslateAminiteBatchJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public int $tries = 3;

    public function __construct(
        public int $aminiteId,
        public int $sourceLangId,
    ) {
    }

    public function handle(AminiteTranslationService $translator): void
    {
        $aminite = Aminite::find($this->aminiteId);
        if (!$aminite) {
            Log::channel('translate')->warning("TranslateAminiteBatchJob [id={$this->aminiteId}]: aminite not found");
            return;
        }

        $sourceContent = AminiteContent::where('aminite_id', $this->aminiteId)
            ->where('language_id', $this->sourceLangId)
            ->first();

        if (!$sourceContent || empty($sourceContent->title)) {
            $sourceContent = AminiteContent::where('aminite_id', $this->aminiteId)
                ->whereNotNull('title')->where('title', '!=', '')
                ->first();
            if (!$sourceContent) {
                Log::channel('translate')->warning("TranslateAminiteBatchJob [id={$this->aminiteId}]: no filled content found");
                return;
            }
            Log::channel('translate')->info("TranslateAminiteBatchJob [id={$this->aminiteId}]: using lang #{$sourceContent->language_id} as source");
        }

        $targetLanguages = Language::where('id', '!=', $sourceContent->language_id)->get();

        foreach ($targetLanguages as $targetLang) {
            $exists = AminiteContent::where('aminite_id', $this->aminiteId)
                ->where('language_id', $targetLang->id)
                ->whereNotNull('title')->where('title', '!=', '')
                ->exists();
            if ($exists) continue;

            try {
                $translated = $translator->translate(
                    $sourceContent,
                    $targetLang->code,
                    $targetLang->name
                );

                try {
                    AminiteContent::updateOrCreate(
                        ['aminite_id' => $this->aminiteId, 'language_id' => $targetLang->id],
                        [
                            'title' => $translated['title'] ?? '',
                        ]
                    );
                } catch (\Throwable $e2) {
                    Log::channel('translate')->warning("TranslateAminiteBatchJob [id={$this->aminiteId}] create error to {$targetLang->code}: " . $e2->getMessage());
                    continue;
                }

                Log::channel('translate')->info("TranslateAminiteBatchJob [id={$this->aminiteId}]: translated to {$targetLang->code}");
            } catch (\Throwable $e) {
                Log::channel('translate')->error("TranslateAminiteBatchJob [id={$this->aminiteId}] error to {$targetLang->code}: " . $e->getMessage());
            }
        }
    }

    public function failed(\Throwable $e): void
    {
        Log::channel('translate')->error("TranslateAminiteBatchJob [id={$this->aminiteId}] FAILED: " . $e->getMessage());
    }
}
