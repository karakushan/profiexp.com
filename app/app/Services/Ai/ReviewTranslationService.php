<?php

namespace App\Services\Ai;

use App\Services\Ai\Engines\GeminiTextEngine;

class ReviewTranslationService
{
    public function __construct(private readonly GeminiTextEngine $gemini)
    {
    }

    public function translate(string $text, string $targetLangName): string
    {
        $prompt = <<<PROMPT
Translate the following customer review to {$targetLangName}.
Preserve the meaning and tone. Do not add explanations or quotation marks.
Return only the translated review text.

{$text}
PROMPT;

        return trim($this->gemini->generate($prompt));
    }
}
