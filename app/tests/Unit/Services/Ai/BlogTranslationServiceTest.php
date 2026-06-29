<?php

namespace Tests\Unit\Services\Ai;

use App\Models\Journal\BlogInformation;
use App\Services\Ai\BlogTranslationService;
use App\Services\Ai\Engines\GeminiTextEngine;
use Mockery;
use PHPUnit\Framework\TestCase;

class BlogTranslationServiceTest extends TestCase
{
    private BlogTranslationService $service;
    private $mockEngine;

    protected function setUp(): void
    {
        parent::setUp();
        $this->mockEngine = Mockery::mock(GeminiTextEngine::class);
        $this->service = new BlogTranslationService($this->mockEngine);
    }

    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    private function createSourceContent(): BlogInformation
    {
        $content = Mockery::mock(BlogInformation::class)->makePartial();
        $content->title = '10 Tips for Business Success';
        $content->content = '<p>Here are the top 10 tips for success.</p>';
        $content->author = 'John Doe';
        $content->meta_keywords = 'business, success, tips';
        $content->meta_description = 'Learn the top 10 tips for business success';
        return $content;
    }

    public function test_build_translation_prompt_contains_all_fields(): void
    {
        $source = $this->createSourceContent();
        $prompt = $this->service->buildTranslationPrompt($source, 'Arabic');

        $this->assertStringContainsString('title', $prompt);
        $this->assertStringContainsString('10 Tips for Business Success', $prompt);
        $this->assertStringContainsString('content', $prompt);
        $this->assertStringContainsString('author', $prompt);
        $this->assertStringContainsString('meta_keywords', $prompt);
        $this->assertStringContainsString('meta_description', $prompt);
    }

    public function test_build_translation_prompt_has_target_language(): void
    {
        $source = $this->createSourceContent();
        $prompt = $this->service->buildTranslationPrompt($source, 'Arabic');

        $this->assertStringContainsString('Arabic', $prompt);
    }

    public function test_build_translation_prompt_contains_html_hint(): void
    {
        $source = $this->createSourceContent();
        $prompt = $this->service->buildTranslationPrompt($source, 'Arabic');

        $this->assertStringContainsString('Preserve HTML tags', $prompt);
    }

    public function test_extract_translation_json_valid_response(): void
    {
        $jsonResponse = json_encode([
            'title' => '10 نصائح لنجاح الأعمال',
            'content' => '<p>إليك أفضل 10 نصائح للنجاح</p>',
        ], JSON_UNESCAPED_UNICODE);

        $result = $this->service->extractTranslationJson($jsonResponse);

        $this->assertIsArray($result);
        $this->assertEquals('10 نصائح لنجاح الأعمال', $result['title']);
    }

    public function test_translate_returns_translated_fields(): void
    {
        $source = $this->createSourceContent();

        $responseJson = json_encode([
            'title' => '10 نصائح لنجاح الأعمال',
            'content' => '<p>إليك أفضل 10 نصائح للنجاح</p>',
            'author' => 'جون دو',
            'meta_keywords' => 'أعمال, نجاح, نصائح',
            'meta_description' => 'تعلم أفضل 10 نصائح لنجاح الأعمال',
        ], JSON_UNESCAPED_UNICODE);

        $this->mockEngine->shouldReceive('generate')
            ->once()
            ->andReturn($responseJson);

        $result = $this->service->translate($source, 'ar', 'Arabic');

        $this->assertEquals('10 نصائح لنجاح الأعمال', $result['title']);
        $this->assertEquals('<p>إليك أفضل 10 نصائح للنجاح</p>', $result['content']);
        $this->assertEquals('جون دو', $result['author']);
    }
}
