<?php

namespace Tests\Unit\Services\Ai;

use App\Models\Listing\ListingContent;
use App\Services\Ai\Engines\GeminiTextEngine;
use App\Services\Ai\ListingTranslationService;
use Mockery;
use PHPUnit\Framework\TestCase;

class ListingTranslationServiceTest extends TestCase
{
    private ListingTranslationService $service;
    private $mockEngine;

    protected function setUp(): void
    {
        parent::setUp();
        $this->mockEngine = Mockery::mock(GeminiTextEngine::class);
        $this->service = new ListingTranslationService($this->mockEngine);
    }

    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    private function createSourceContent(): ListingContent
    {
        $content = Mockery::mock(ListingContent::class)->makePartial();
        $content->title = 'Best Hotel in Dubai';
        $content->description = '<p>Luxury hotel with sea view</p>';
        $content->summary = 'A wonderful hotel experience';
        $content->address = '123 Palm Jumeirah, Dubai';
        $content->meta_keyword = 'hotel, dubai, luxury';
        $content->meta_description = 'Experience luxury at the best hotel in Dubai';
        return $content;
    }

    public function test_build_translation_prompt_contains_all_fields(): void
    {
        $source = $this->createSourceContent();
        $prompt = $this->service->buildTranslationPrompt($source, 'Arabic');

        $this->assertStringContainsString('title', $prompt);
        $this->assertStringContainsString('Best Hotel in Dubai', $prompt);
        $this->assertStringContainsString('description', $prompt);
        $this->assertStringContainsString('summary', $prompt);
        $this->assertStringContainsString('address', $prompt);
        $this->assertStringContainsString('meta_keyword', $prompt);
        $this->assertStringContainsString('meta_description', $prompt);
    }

    public function test_build_translation_prompt_has_target_language(): void
    {
        $source = $this->createSourceContent();
        $prompt = $this->service->buildTranslationPrompt($source, 'Arabic');

        $this->assertStringContainsString('Arabic', $prompt);
        $this->assertStringContainsString('Translate the following listing content', $prompt);
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
            'title' => 'أفضل فندق في دبي',
            'description' => '<p>فندق فاخر مع إطلالة على البحر</p>',
        ], JSON_UNESCAPED_UNICODE);

        $result = $this->service->extractTranslationJson($jsonResponse);

        $this->assertIsArray($result);
        $this->assertEquals('أفضل فندق في دبي', $result['title']);
    }

    public function test_extract_translation_json_with_markdown_block(): void
    {
        $jsonResponse = "```json\n" . json_encode([
            'title' => 'أفضل فندق في دبي',
        ], JSON_UNESCAPED_UNICODE) . "\n```";

        $result = $this->service->extractTranslationJson($jsonResponse);

        $this->assertIsArray($result);
        $this->assertEquals('أفضل فندق في دبي', $result['title']);
    }

    public function test_extract_translation_json_with_text_before(): void
    {
        $response = "Here is the translation:\n" . json_encode([
            'title' => 'أفضل فندق في دبي',
        ], JSON_UNESCAPED_UNICODE);

        $result = $this->service->extractTranslationJson($response);

        $this->assertIsArray($result);
        $this->assertEquals('أفضل فندق في دبي', $result['title']);
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
            'title' => 'أفضل فندق في دبي',
            'description' => '<p>فندق فاخر</p>',
            'summary' => 'ملخص',
            'address' => 'دبي',
            'meta_keyword' => 'فندق',
            'meta_description' => 'وصف',
        ], JSON_UNESCAPED_UNICODE);

        $this->mockEngine->shouldReceive('generate')
            ->once()
            ->andReturn($responseJson);

        $result = $this->service->translate($source, 'ar', 'Arabic');

        $this->assertEquals('أفضل فندق في دبي', $result['title']);
        $this->assertEquals('<p>فندق فاخر</p>', $result['description']);
        $this->assertEquals('ملخص', $result['summary']);
        $this->assertEquals('دبي', $result['address']);
    }

    public function test_translate_passes_empty_strings_for_null_fields(): void
    {
        $source = Mockery::mock(ListingContent::class)->makePartial();
        $source->title = 'Only Title';
        $source->description = null;
        $source->summary = null;
        $source->address = null;
        $source->meta_keyword = null;
        $source->meta_description = null;

        $responseJson = json_encode(['title' => 'فقط عنوان'], JSON_UNESCAPED_UNICODE);

        $this->mockEngine->shouldReceive('generate')
            ->once()
            ->andReturn($responseJson);

        $result = $this->service->translate($source, 'ar', 'Arabic');
        $this->assertEquals('فقط عنوان', $result['title']);
    }
}
