<?php

namespace Tests\Feature\Services\Ai;

use App\Services\Ai\Engines\GeminiTextEngine;
use Illuminate\Http\Client\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use Tests\TestCase;

class GeminiTextEngineSettingsTest extends TestCase
{
  public function test_uses_gemini_settings_from_database_before_config(): void
  {
    config([
      'ai.gemini_api_key' => 'config-key',
      'ai.gemini_text_model' => 'config-model',
    ]);

    DB::table('basic_settings')->updateOrInsert(
      ['uniqid' => 12345],
      [
        'gemini_api_key' => 'db-key',
        'gemini_text_model' => 'db-model',
      ]
    );

    Http::fake(function (Request $request) {
      $this->assertStringContainsString('/models/db-model:generateContent', $request->url());
      $this->assertSame(['db-key'], $request->header('x-goog-api-key'));

      return Http::response([
        'candidates' => [
          ['content' => ['parts' => [['text' => 'Generated from database settings']]]],
        ],
        'usageMetadata' => ['totalTokenCount' => 3],
      ]);
    });

    $result = app(GeminiTextEngine::class)->generateWithMeta('Hello');

    $this->assertSame('Generated from database settings', $result['text']);
  }

  public function test_falls_back_to_config_when_database_settings_are_empty(): void
  {
    config([
      'ai.gemini_api_key' => 'config-key',
      'ai.gemini_text_model' => 'config-model',
    ]);

    DB::table('basic_settings')->updateOrInsert(
      ['uniqid' => 12345],
      [
        'gemini_api_key' => '',
        'gemini_text_model' => '',
      ]
    );

    Http::fake(function (Request $request) {
      $this->assertStringContainsString('/models/config-model:generateContent', $request->url());
      $this->assertSame(['config-key'], $request->header('x-goog-api-key'));

      return Http::response([
        'candidates' => [
          ['content' => ['parts' => [['text' => 'Generated from config settings']]]],
        ],
      ]);
    });

    $result = app(GeminiTextEngine::class)->generateWithMeta('Hello');

    $this->assertSame('Generated from config settings', $result['text']);
  }
}
