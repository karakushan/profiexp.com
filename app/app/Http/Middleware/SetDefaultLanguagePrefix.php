<?php

namespace App\Http\Middleware;

use App\Models\Language;
use Closure;
use Illuminate\Http\Request;

class SetDefaultLanguagePrefix
{
  private array $except = [
    'change-language',
    'push-notification/*',
    'subcheck',
    'translate-*',
    'store-subscriber',
    'myfatoorah/*',
    'midtrans/*',
    'admin*',
    'sitemap*.xml',
    'service-unavailable',
    'api/*',
  ];

  public function handle(Request $request, Closure $next)
  {
    if (!$request->isMethod('GET') && !$request->isMethod('HEAD')) {
      return $next($request);
    }

    $path = ltrim($request->path(), '/');

    $supportedCodes = Language::query()->pluck('code')
      ->map(fn ($code) => strtolower($code))
      ->all();

    if (empty($supportedCodes) || $this->shouldSkip($path)) {
      return $next($request);
    }

    // Only the entry page is language-negotiated. Existing public URLs must
    // remain shareable and must not be rewritten from browser preferences.
    if ($path !== '') {
      return $next($request);
    }

    $firstSegment = explode('/', $path)[0] ?? '';

    if (in_array($firstSegment, $supportedCodes)) {
      return $next($request);
    }

    $selectedLocale = $request->session()->get('currentLocaleCode');
    if (in_array($selectedLocale, $supportedCodes, true)) {
      return $next($request);
    }

    $locale = $this->preferredLocale($request->header('Accept-Language'), $supportedCodes);
    if ($locale === null && !$request->header('Accept-Language')) {
      return $next($request);
    }

    $locale ??= in_array('en', $supportedCodes, true)
      ? 'en'
      : Language::query()->where('is_default', 1)->value('code');

    if (!$locale) {
      return $next($request);
    }

    $target = '/' . $locale . ($path === '' ? '' : '/' . $path);
    if ($request->getQueryString()) {
      $target .= '?' . $request->getQueryString();
    }

    return redirect()->to($target, 302);

  }

  private function preferredLocale(?string $acceptLanguage, array $supportedCodes): ?string
  {
    if (empty($acceptLanguage)) {
      return null;
    }

    $languages = collect(explode(',', $acceptLanguage))
      ->map(function (string $language) {
        [$tag, $parameters] = array_pad(explode(';', $language, 2), 2, '');
        preg_match('/q=([0-9.]+)/i', $parameters, $matches);

        return [
          'code' => strtolower(explode('-', trim($tag))[0]),
          'quality' => isset($matches[1]) ? (float) $matches[1] : 1.0,
        ];
      })
      ->sortByDesc('quality');

    foreach ($languages as $language) {
      if (in_array($language['code'], $supportedCodes, true)) {
        return $language['code'];
      }
    }

    return null;
  }

  private function shouldSkip(string $path): bool
  {
    foreach ($this->except as $pattern) {
      if (fnmatch($pattern, $path)) {
        return true;
      }
    }

    return false;
  }
}
