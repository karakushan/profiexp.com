<?php

namespace Tests\Unit;

use App\Models\Language;
use Tests\TestCase;

class HreflangUrlTest extends TestCase
{
    public function test_default_locale_hreflang_url_has_no_language_prefix(): void
    {
        $defaultLanguage = Language::query()->where('is_default', 1)->firstOrFail();
        $secondaryLanguage = Language::query()->where('code', '!=', $defaultLanguage->code)->firstOrFail();

        $this->assertSame(
            url('/listings/example'),
            hreflang_localized_url('/listings/example', $defaultLanguage->code)
        );

        $this->assertSame(
            url('/' . $secondaryLanguage->code . '/listings/example'),
            hreflang_localized_url('/listings/example', $secondaryLanguage->code)
        );
    }

    public function test_homepage_contains_every_supported_language_and_default_link(): void
    {
        $defaultLanguage = Language::query()->where('is_default', 1)->firstOrFail();

        $response = $this->get('/');

        $response->assertOk()
            ->assertSee('hreflang="' . $defaultLanguage->code . '"', false)
            ->assertSee('hreflang="x-default"', false);

        foreach (Language::query()->pluck('code') as $languageCode) {
            $response->assertSee('hreflang="' . $languageCode . '"', false);
        }
    }

    public function test_localized_listing_index_contains_hreflang_links(): void
    {
        $languageCode = Language::query()->where('is_default', 0)->value('code');

        $this->get('/' . $languageCode . '/listings')
            ->assertOk()
            ->assertSee('hreflang="' . $languageCode . '"', false)
            ->assertSee('hreflang="x-default"', false);
    }
}
