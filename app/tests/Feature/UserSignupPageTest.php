<?php

namespace Tests\Feature;

use Illuminate\Support\Facades\View;
use Tests\TestCase;

class UserSignupPageTest extends TestCase
{
  public function test_frontend_scripts_skip_invalid_tawkto_script(): void
  {
    $html = View::make('frontend.partials.scripts', [
      'basicInfo' => (object) [
        'google_map_api_key_status' => 0,
        'whatsapp_status' => 0,
        'whatsapp_popup_status' => 0,
        'whatsapp_number' => null,
        'whatsapp_header_title' => null,
        'whatsapp_popup_message' => null,
        'tawkto_status' => 1,
        'tawkto_direct_chat_link' => 'xxxxx',
      ],
    ])->render();

    $this->assertStringNotContainsString('s1.src = "xxxxx"', $html);
  }

  public function test_signup_password_fields_have_new_password_autocomplete(): void
  {
    $signupView = file_get_contents(resource_path('views/frontend/user/signup.blade.php'));

    $this->assertStringContainsString('name="password"', $signupView);
    $this->assertStringContainsString('name="password_confirmation"', $signupView);
    $this->assertSame(2, substr_count($signupView, 'autocomplete="new-password"'));
  }
}
