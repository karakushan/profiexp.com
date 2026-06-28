<?php

namespace Tests\Unit\Services\Ai;

use App\Models\ListingCategoryContent;
use App\Services\Ai\CategoryTranslationService;
use App\Services\Ai\Engines\GeminiTextEngine;
use Mockery;
use PHPUnit\Framework\TestCase;

class CategoryTranslationServiceTest extends TestCase
{
    private CategoryTranslationService $service;
    private $mockEngine;

    protected function setUp(): void
    {
        parent::setUp();
        $this->mockEngine = Mockery::mock(GeminiTextEngine::class);
        $this->service = new CategoryTranslationService($this->mockEngine);
    }

    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    private function createSourceContent(): ListingCategoryContent
    {
        $content = Mockery::mock(ListingCategoryContent::class)->makePartial();
        $content->name = 'Beauty Salons';
        $content->slug = 'beauty-salons';
        $content->meta_title = 'Best Beauty Salons';
        $content->meta_description = 'Find the best beauty salons in your city';
        return $content;
    }

    public function test_build_translation_prompt_contains_all_fields(): void
    {
        $source = $this->createSourceContent();
        $prompt = $this->service->buildTranslationPrompt($source, 'Arabic');

        $this->assertStringContainsString('name', $prompt);
        $this->assertStringContainsString('Beauty Salons', $prompt);
        $this->assertStringContainsString('slug', $prompt);
        $this->assertStringContainsString('meta_title', $prompt);
        $this->assertStringContainsString('meta_description', $prompt);
    }

    public function test_build_translation_prompt_has_target_language(): void
    {
        $source = $this->createSourceContent();
        $prompt = $this->service->buildTranslationPrompt($source, 'Arabic');

        $this->assertStringContainsString('Arabic', $prompt);
        $this->assertStringContainsString('Translate the following category content', $prompt);
    }

    public function test_build_translation_prompt_has_slug_instructions(): void
    {
        $source = $this->createSourceContent();
        $prompt = $this->service->buildTranslationPrompt($source, 'Arabic');

        $this->assertStringContainsString('slug', $prompt);
        $this->assertStringContainsString('URL-friendly', $prompt);
    }

    public function test_extract_translation_json_valid_response(): void
    {
        $jsonResponse = json_encode([
            'name' => 'صالونات تجميل',
            'slug' => 'beauty-salons',
            'meta_title' => 'أفضل صالونات التجميل',
            'meta_description' => 'ابحث عن أفضل صالونات التجميل',
        ], JSON_UNESCAPED_UNICODE);

        $result = $this->service->extractTranslationJson($jsonResponse);

        $this->assertIsArray($result);
        $this->assertEquals('صالونات تجميل', $result['name']);
        $this->assertEquals('beauty-salons', $result['slug']);
    }

    public function test_extract_translation_json_with_markdown_block(): void
    {
        $jsonResponse = "```json\n" . json_encode([
            'name' => 'صالونات تجميل',
            'slug' => 'beauty-salons',
        ], JSON_UNESCAPED_UNICODE) . "\n```";

        $result = $this->service->extractTranslationJson($jsonResponse);

        $this->assertIsArray($result);
        $this->assertEquals('صالونات تجميل', $result['name']);
    }

    public function test_extract_translation_json_with_text_before(): void
    {
        $response = "Here is the translation:\n" . json_encode([
            'name' => 'صالونات تجميل',
            'slug' => 'beauty-salons',
        ], JSON_UNESCAPED_UNICODE);

        $result = $this->service->extractTranslationJson($response);

        $this->assertIsArray($result);
        $this->assertEquals('صالونات تجميل', $result['name']);
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
            'name' => 'صالونات تجميل',
            'slug' => 'salonat-tajmil',
            'meta_title' => 'أفضل صالونات',
            'meta_description' => 'وصف عربي',
        ], JSON_UNESCAPED_UNICODE);

        $this->mockEngine->shouldReceive('generate')
            ->once()
            ->andReturn($responseJson);

        $result = $this->service->translate($source, 'ar', 'Arabic');

        $this->assertEquals('صالونات تجميل', $result['name']);
        $this->assertEquals('salonat-tajmil', $result['slug']);
        $this->assertEquals('أفضل صالونات', $result['meta_title']);
        $this->assertEquals('وصف عربي', $result['meta_description']);
    }
}