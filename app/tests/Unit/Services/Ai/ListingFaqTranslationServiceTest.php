<?php

namespace Tests\Unit\Services\Ai;

use App\Models\Listing\ListingFaq;
use App\Services\Ai\Engines\GeminiTextEngine;
use App\Services\Ai\ListingFaqTranslationService;
use Mockery;
use PHPUnit\Framework\TestCase;

class ListingFaqTranslationServiceTest extends TestCase
{
    private ListingFaqTranslationService $service;
    private $mockEngine;

    protected function setUp(): void
    {
        parent::setUp();

        $this->mockEngine = Mockery::mock(GeminiTextEngine::class);
        $this->service = new ListingFaqTranslationService($this->mockEngine);
    }

    protected function tearDown(): void
    {
        Mockery::close();
        parent::tearDown();
    }

    private function sourceFaq(): ListingFaq
    {
        $faq = Mockery::mock(ListingFaq::class)->makePartial();
        $faq->question = 'Is parking available?';
        $faq->answer = '<p>Yes, parking is available.</p>';

        return $faq;
    }

    public function test_prompt_contains_faq_fields_target_language_and_html_instruction(): void
    {
        $prompt = $this->service->buildTranslationPrompt($this->sourceFaq(), 'Spanish');

        $this->assertStringContainsString('question', $prompt);
        $this->assertStringContainsString('Is parking available?', $prompt);
        $this->assertStringContainsString('answer', $prompt);
        $this->assertStringContainsString('Spanish', $prompt);
        $this->assertStringContainsString('Preserve HTML tags', $prompt);
    }

    public function test_parser_accepts_json_code_block_and_rejects_invalid_response(): void
    {
        $result = $this->service->extractTranslationJson("```json\n{\"question\":\"¿Hay aparcamiento?\",\"answer\":\"Sí\"}\n```");

        $this->assertSame('¿Hay aparcamiento?', $result['question']);
        $this->assertSame('Sí', $result['answer']);

        $this->expectException(\RuntimeException::class);
        $this->service->extractTranslationJson('not json');
    }

    public function test_translate_returns_question_and_answer(): void
    {
        $this->mockEngine->shouldReceive('generate')
            ->once()
            ->andReturn('{"question":"¿Hay aparcamiento?","answer":"<p>Sí</p>"}');

        $result = $this->service->translate($this->sourceFaq(), 'es', 'Spanish');

        $this->assertSame('¿Hay aparcamiento?', $result['question']);
        $this->assertSame('<p>Sí</p>', $result['answer']);
    }
}
