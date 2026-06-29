<?php

namespace App\Services\Ai;

use App\Models\Location\CityContent;
use App\Models\Location\CountryContent;
use App\Models\Location\StateContent;
use App\Services\Ai\Engines\GeminiTextEngine;

class LocationTranslationService
{
    public function __construct(
        private readonly GeminiTextEngine $gemini,
    ) {
    }

    public function translateCountry(
        CountryContent $source,
        string $targetLangName,
    ): array {
        $fields = [
            'name' => $source->name ?? '',
        ];

        return $this->doTranslate($fields, $targetLangName);
    }

    public function translateState(
        StateContent $source,
        string $targetLangName,
    ): array {
        $fields = [
            'name' => $source->name ?? '',
        ];

        return $this->doTranslate($fields, $targetLangName);
    }

    public function translateCity(
        CityContent $source,
        string $targetLangName,
    ): array {
        $fields = [
            'name' => $source->name ?? '',
            'slug' => $source->slug ?? '',
        ];

        $result = $this->doTranslate($fields, $targetLangName);

        if (!empty($result['name'])) {
            $result['slug'] = createSlug($result['name']);
        }

        return $result;
    }

    private function doTranslate(array $fields, string $targetLangName): array
    {
        $json = json_encode($fields, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);

        $prompt = <<<PROMPT
Translate the following location content to {$targetLangName}.
Return ONLY valid JSON object with the same keys. No markdown. No explanation.
Return JSON:

{$json}
PROMPT;

        $response = $this->gemini->generate($prompt);

        return $this->extractTranslationJson($response);
    }

    private function extractTranslationJson(string $response): array
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
