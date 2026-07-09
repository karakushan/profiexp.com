<?php

namespace Tests\Feature\Admin;

use App\Http\Controllers\Admin\CustomPageController;
use App\Http\Requests\Page\UpdateRequest;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class CustomPageControllerTest extends TestCase
{
    public function test_update_creates_missing_translation_record_for_selected_language(): void
    {
        $defaultLanguage = DB::table('languages')
            ->select('id', 'code')
            ->where('is_default', 1)
            ->first();

        $secondaryLanguage = DB::table('languages')
            ->select('id', 'code')
            ->where('id', '<>', $defaultLanguage->id)
            ->orderByRaw("case when code = 'uk' then 0 else 1 end")
            ->orderBy('id')
            ->first();

        $now = Carbon::now();
        $pageId = DB::table('pages')->insertGetId([
            'status' => 1,
            'created_at' => $now,
            'updated_at' => $now,
        ]);

        DB::table('page_contents')->insert([
            'language_id' => $defaultLanguage->id,
            'page_id' => $pageId,
            'title' => 'Default page title',
            'slug' => 'default-page-title-' . $pageId,
            'content' => str_repeat('Default content ', 3),
            'meta_keywords' => 'default',
            'meta_description' => 'default description',
            'created_at' => $now,
            'updated_at' => $now,
        ]);

        $request = UpdateRequest::create('/admin/custom-pages/update-page/' . $pageId, 'POST', [
            'status' => 1,
            'language' => $secondaryLanguage->code,
            $secondaryLanguage->code . '_title' => 'Ukrainian page title',
            $secondaryLanguage->code . '_slug' => '',
            $secondaryLanguage->code . '_content' => str_repeat('Ukrainian content ', 3),
            $secondaryLanguage->code . '_meta_keywords' => 'uk',
            $secondaryLanguage->code . '_meta_description' => 'uk description',
        ]);

        app(CustomPageController::class)->update($request, $pageId);

        $pageContent = DB::table('page_contents')
            ->where('page_id', $pageId)
            ->where('language_id', $secondaryLanguage->id)
            ->first();

        $this->assertNotNull($pageContent);
        $this->assertSame('Ukrainian page title', $pageContent->title);
        $this->assertSame('ukrainian-page-title', $pageContent->slug);
        $this->assertStringContainsString('Ukrainian content', $pageContent->content);
    }

    public function test_update_saves_secondary_language_fields_even_when_current_language_differs(): void
    {
        $defaultLanguage = DB::table('languages')
            ->select('id', 'code')
            ->where('is_default', 1)
            ->first();

        $secondaryLanguage = DB::table('languages')
            ->select('id', 'code')
            ->where('id', '<>', $defaultLanguage->id)
            ->orderByRaw("case when code = 'uk' then 0 else 1 end")
            ->orderBy('id')
            ->first();

        $now = Carbon::now();
        $pageId = DB::table('pages')->insertGetId([
            'status' => 1,
            'created_at' => $now,
            'updated_at' => $now,
        ]);

        DB::table('page_contents')->insert([
            'language_id' => $defaultLanguage->id,
            'page_id' => $pageId,
            'title' => 'Default page title',
            'slug' => 'default-page-title-' . $pageId,
            'content' => str_repeat('Default content ', 3),
            'meta_keywords' => 'default',
            'meta_description' => 'default description',
            'created_at' => $now,
            'updated_at' => $now,
        ]);

        $request = UpdateRequest::create('/admin/custom-pages/update-page/' . $pageId, 'POST', [
            'status' => 1,
            'language' => $defaultLanguage->code,
            $defaultLanguage->code . '_title' => 'Default page title updated',
            $defaultLanguage->code . '_slug' => '',
            $defaultLanguage->code . '_content' => str_repeat('Default content updated ', 3),
            $defaultLanguage->code . '_meta_keywords' => 'default updated',
            $defaultLanguage->code . '_meta_description' => 'default description updated',
            $secondaryLanguage->code . '_title' => 'Ukrainian page title',
            $secondaryLanguage->code . '_slug' => '',
            $secondaryLanguage->code . '_content' => str_repeat('Ukrainian content ', 3),
            $secondaryLanguage->code . '_meta_keywords' => 'uk',
            $secondaryLanguage->code . '_meta_description' => 'uk description',
        ]);

        app(CustomPageController::class)->update($request, $pageId);

        $secondaryPageContent = DB::table('page_contents')
            ->where('page_id', $pageId)
            ->where('language_id', $secondaryLanguage->id)
            ->first();

        $this->assertNotNull($secondaryPageContent);
        $this->assertSame('Ukrainian page title', $secondaryPageContent->title);
        $this->assertSame('ukrainian-page-title', $secondaryPageContent->slug);
        $this->assertStringContainsString('Ukrainian content', $secondaryPageContent->content);
    }
}
