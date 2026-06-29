<?php

namespace Tests\Unit\Services\Ai;

use App\Models\Journal\BlogCategoryContent;
use App\Services\Ai\BlogCategoryTranslationService;
use App\Services\Ai\Engines\GeminiTextEngine;
use Mockery;
use PHPUnit\Framework\TestCase;

class BlogCategoryTranslationServiceTest extends TestCase
{
    private BlogCategoryTranslationService $service;
    private $mockEngine;

    protected function setUp(): void
    {
        parent::setUp();
        $this->mockEngine = Mockery::mock(GeminiTextEngine::class);
        $this->service = new BlogCategoryTranslationService($this->mockEngine);
    }

    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    private function createSourceContent(): BlogCategoryContent
    {
        $content = Mockery::mock(BlogCategoryContent::class)->makePartial();
        $content->name = 'Business Tips';
        $content->slug = 'business-tips';
        $content->meta_title = 'Business Tips - Blog';
        $content->meta_description = 'Best business tips';
        $content->seo_text = 'SEO text for business tips category';
        return $content;
    }

    public function test_build_translation_prompt_contains_all_fields(): void
    {
        $source = $this->createSourceContent();
        $prompt = $this->service->buildTranslationPrompt($source, 'Arabic');

        $this->assertStringContainsString('name', $prompt);
        $this->assertStringContainsString('Business Tips', $prompt);
        $this->assertStringContainsString('slug', $prompt);
        $this->assertStringContainsString('meta_title', $prompt);
        $this->assertStringContainsString('meta_description', $prompt);
        $this->assertStringContainsString('seo_text', $prompt);
    }

    public function test_build_translation_prompt_has_target_language(): void
    {
        $source = $this->createSourceContent();
        $prompt = $this->service->buildTranslationPrompt($source, 'Arabic');

        $this->assertStringContainsString('Arabic', $prompt);
    }

    public function test_extract_translation_json_valid_response(): void
    {
        $jsonResponse = json_encode([
            'name' => 'نصائح الأعمال',
            'slug' => 'نصائح-الأعمال',
        ], JSON_UNESCAPED_UNICODE);

        $result = $this->service->extractTranslationJson($jsonResponse);

        $this->assertIsArray($result);
        $this->assertEquals('نصائح الأعمال', $result['name']);
    }

    public function test_extract_translation_json_with_markdown_block(): void
    {
        $jsonResponse = "```json\n" . json_encode([
            'name' => 'نصائح الأعمال',
        ], JSON_UNESCAPED_UNICODE) . "\n```";

        $result = $this->service->extractTranslationJson($jsonResponse);

        $this->assertIsArray($result);
        $this->assertEquals('نصائح الأعمال', $result['name']);
    }

    public function test_extract_translation_json_throws_on_invalid(): void
    {
        $this->expectException(\RuntimeException::class);
        $this->service->extractTranslationJson('not valid json at all');
    }

    public function test_translate_returns_translated_fields(): void
    {
        $source = $this->createSourceContent();

        $responseJson = json_encode([
            'name' => 'نصائح الأعمال',
            'slug' => 'نصائح-الأعمال',
            'meta_title' => 'نصائح الأعمال - المدونة',
            'meta_description' => 'أفضل نصائح الأعمال',
            'seo_text' => 'نص تحسين محركات البحث لفئة نصائح الأعمال',
        ], JSON_UNESCAPED_UNICODE);

        $this->mockEngine->shouldReceive('generate')
            ->once()
            ->andReturn($responseJson);

        $result = $this->service->translate($source, 'ar', 'Arabic');

        $this->assertEquals('نصائح الأعمال', $result['name']);
        $this->assertEquals('نصائح-الأعمال', $result['slug']);
        $this->assertEquals('نصائح الأعمال - المدونة', $result['meta_title']);
    }
}
