<?php

namespace Tests\Feature\Controllers\Cron;

use Illuminate\Support\Facades\Bus;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class TranslateBlogsControllerTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        Bus::fake();

        DB::table('basic_settings')->updateOrInsert(
            ['uniqid' => 12345],
            ['auto_translate_status' => 1]
        );
    }

    public function test_endpoint_rejects_without_token(): void
    {
        config(['app.translate_cron_token' => 'secret123']);

        $response = $this->get('/translate-blogs');

        $response->assertStatus(403);
        $response->assertJson(['status' => 'unauthorized']);
    }

    public function test_endpoint_rejects_with_wrong_token(): void
    {
        config(['app.translate_cron_token' => 'secret123']);

        $response = $this->get('/translate-blogs?token=wrong_token');

        $response->assertStatus(403);
        $response->assertJson(['status' => 'unauthorized']);
    }

    public function test_endpoint_accepts_with_valid_token(): void
    {
        config(['app.translate_cron_token' => 'secret123']);

        $response = $this->get('/translate-blogs?token=secret123');

        $response->assertStatus(200);
        $response->assertJson(['status' => 'ok']);
    }

    public function test_endpoint_allows_without_token_when_env_not_set(): void
    {
        config(['app.translate_cron_token' => '']);

        $response = $this->get('/translate-blogs');

        $response->assertStatus(200);
        $response->assertJson(['status' => 'ok']);
    }
}
