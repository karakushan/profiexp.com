<?php

namespace Tests\Feature;

use Illuminate\Support\Facades\View;
use Tests\TestCase;

class UserSignupPageTest extends TestCase
{
  public function test_unprefixed_user_login_route_renders_login_form(): void
  {
    $this->get('/user/login')
      ->assertOk()
      ->assertDontSee('404 not found')
      ->assertSee('name="username"', false)
      ->assertSee('name="password"', false);
  }

  public function test_unprefixed_user_signup_route_renders_signup_form(): void
  {
    $this->get('/user/signup')
      ->assertOk()
      ->assertDontSee('404 not found')
      ->assertSee('name="username"', false)
      ->assertSee('name="password_confirmation"', false);
  }

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
