<?php

namespace App\Http\Middleware;

use App\Models\Language;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;

class ChangeLanguage
{
  /**
   * Handle an incoming request.
   */
  public function handle(Request $request, Closure $next)
  {
    $locale = null;

    // Priority 1: User explicitly switched language (persistent cookie)
    if ($request->cookie('user_locale')) {
      $locale = $request->cookie('user_locale');
    }
    // Priority 2: No explicit choice — detect browser language on every visit
    else {
      $browserLocale = $this->detectBrowserLanguage($request);
      $supportedCodes = Language::query()->pluck('code')->toArray();

      if ($browserLocale && in_array($browserLocale, $supportedCodes)) {
        $locale = $browserLocale;
      } else {
        $locale = Language::query()->where('is_default', '=', 1)
          ->pluck('code')
          ->first();
      }
    }

    $request->session()->put('currentLocaleCode', $locale);
    App::setLocale($locale);

    return $next($request);
  }

  /**
   * Detect preferred language from browser Accept-Language header.
   * Returns a language code like 'ru', 'tr', 'en', 'ar' if supported.
   */
  private function detectBrowserLanguage(Request $request): ?string
  {
    $acceptLanguage = $request->header('Accept-Language');

    if (empty($acceptLanguage)) {
      return null;
    }

    // Parse Accept-Language header
    // Format: ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7
    $locales = [];
    foreach (explode(',', $acceptLanguage) as $part) {
      $part = trim($part);
      if (preg_match('/^([a-z]{2})(?:-[A-Z]{2})?(?:;q=([\d.]+))?$/', $part, $matches)) {
        $code = $matches[1];
        $quality = isset($matches[2]) ? (float) $matches[2] : 1.0;
        $locales[$code] = $quality;
      }
    }

    // Sort by quality, highest first
    arsort($locales);

    return !empty($locales) ? array_key_first($locales) : null;
  }
}
