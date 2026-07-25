<?php

namespace App\Services\Ai;

use App\Models\Listing\ListingFaq;
use App\Services\Ai\Engines\GeminiTextEngine;

class ListingFaqTranslationService
{
    public function __construct(
        private readonly GeminiTextEngine $gemini,
    ) {
    }

    public function translate(ListingFaq $source, string $targetLangCode, string $targetLangName): array
    {
        $prompt = $this->buildTranslationPrompt($source, $targetLangName);
        $response = $this->gemini->generate($prompt);

        return $this->extractTranslationJson($response);
    }

    public function buildTranslationPrompt(ListingFaq $source, string $targetLangName): string
    {
        $fields = [
            'question' => $source->question ?? '',
            'answer' => $source->answer ?? '',
        ];

        $json = json_encode($fields, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);

        return <<<PROMPT
Translate the following listing FAQ to {$targetLangName}.
Preserve HTML tags in the answer field.
Return ONLY a valid JSON object with the same keys. No markdown. No explanation.
Return JSON:

{$json}
PROMPT;
    }

    public function extractTranslationJson(string $response): array
    {
        $response = trim($response);

        $json = $response;
        if (str_starts_with($json, '```')) {
            $json = preg_replace('/^```(?:json)?\s*/', '', $json);
            $json = preg_replace('/\s*```$/', '', $json);
            $json = trim($json);
        }

        $decoded = json_decode($json, true);

        if (is_array($decoded)) {
            return $decoded;
        }

        if (preg_match('/\{.*\}/s', $response, $matches)) {
            $inner = json_decode($matches[0], true);
            if (is_array($inner)) {
                return $inner;
            }
        }

        throw new \RuntimeException('Failed to parse FAQ translation JSON: ' . mb_substr($response, 0, 200));
    }
}
