<?php

namespace App\Services\Ai;

use App\Models\Location\ListingCityCategoryContent;
use App\Services\Ai\Engines\GeminiTextEngine;

class CityCategoryTranslationService
{
    public function __construct(private readonly GeminiTextEngine $gemini)
    {
    }

    public function translate(ListingCityCategoryContent $source, string $targetLangName): array
    {
        $fields = [
            'page_name' => $source->name ?? '',
            'meta_title' => $source->meta_title ?? '',
            'meta_description' => $source->meta_description ?? '',
            'seo_text' => $source->seo_text ?? '',
        ];
        $json = json_encode($fields, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
        $prompt = "Translate or generate SEO content for the following city-category page in {$targetLangName}.\n"
            . "Use page_name as context. If an SEO field is empty, generate a suitable value for it.\n"
            . "The seo_text value must be valid HTML, not Markdown. Use semantic tags such as <p>, <h2>, <h3>, <ul>, <ol>, <li>, <strong> and <em>; do not use Markdown syntax or HTML document wrappers.\n"
            . "Return ONLY valid JSON with meta_title, meta_description and seo_text keys. No code fences. No explanation.\n\n{$json}";

        return $this->extract($this->gemini->generate($prompt));
    }

    private function extract(string $response): array
    {
        $response = trim($response);
        $json = preg_replace('/^```(?:json)?\s*/', '', $response);
        $json = preg_replace('/\s*```$/', '', (string) $json);
        $decoded = json_decode(trim((string) $json), true);

        if (is_array($decoded)) return $decoded;
        if (preg_match('/\{.*\}/s', $response, $matches)) {
            $decoded = json_decode($matches[0], true);
            if (is_array($decoded)) return $decoded;
        }

        throw new \RuntimeException('Failed to parse city category translation JSON.');
    }
}
