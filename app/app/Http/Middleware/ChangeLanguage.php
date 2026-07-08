<?php

namespace App\Http\Middleware;

use App\Models\Language;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\URL;

class ChangeLanguage
{
  /**
   * Handle an incoming request.
   */
  public function handle(Request $request, Closure $next)
  {
    $supportedCodes = Language::query()->pluck('code')->toArray();
    $defaultLocale = Language::query()->where('is_default', '=', 1)->value('code') ?? config('app.locale');
    $locale = $request->route('lang');

    if (!empty($locale) && in_array($locale, $supportedCodes, true)) {
      if ($locale === $defaultLocale) {
        return redirect()->to($this->stripDefaultLanguagePrefix($request, $defaultLocale), 301);
      }

      $request->session()->put('currentLocaleCode', $locale);
    } else {
      $locale = $defaultLocale;
      $request->session()->put('currentLocaleCode', $locale);
    }

    App::setLocale($locale);
    URL::defaults($locale === $defaultLocale ? [] : ['lang' => $locale]);

    return $next($request);
  }

  private function stripDefaultLanguagePrefix(Request $request, string $defaultLocale): string
  {
    $path = ltrim($request->path(), '/');
    $prefix = $defaultLocale . '/';

    if ($path === $defaultLocale) {
      $target = '/';
    } elseif (str_starts_with($path, $prefix)) {
      $target = '/' . substr($path, strlen($prefix));
    } else {
      $target = '/' . $path;
    }

    if ($request->getQueryString()) {
      $target .= '?' . $request->getQueryString();
    }

    return url($target);
  }
}
