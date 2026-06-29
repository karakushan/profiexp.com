<?php

namespace App\Services\Ai;

use App\Models\Journal\BlogInformation;
use App\Services\Ai\Engines\GeminiTextEngine;

class BlogTranslationService
{
    public function __construct(
        private readonly GeminiTextEngine $gemini,
    ) {
    }

    public function translate(BlogInformation $source, string $targetLangCode, string $targetLangName): array
    {
        $prompt = $this->buildTranslationPrompt($source, $targetLangName);
        $response = $this->gemini->generate($prompt);

        return $this->extractTranslationJson($response);
    }

    public function buildTranslationPrompt(BlogInformation $source, string $targetLangName): string
    {
        $fields = [
            'title' => $source->title ?? '',
            'content' => $source->content ?? '',
            'author' => $source->author ?? '',
            'meta_keywords' => $source->meta_keywords ?? '',
            'meta_description' => $source->meta_description ?? '',
        ];

        $json = json_encode($fields, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);

        return <<<PROMPT
Translate the following blog post content to {$targetLangName}.
Preserve HTML tags in content field.
Return ONLY valid JSON object with the same keys. No markdown. No explanation.
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

        throw new \RuntimeException('Failed to parse translation JSON: ' . mb_substr($response, 0, 200));
    }
}
