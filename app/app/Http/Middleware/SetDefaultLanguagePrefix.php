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
    $path = ltrim($request->path(), '/');

    $supportedCodes = Language::query()->pluck('code')->toArray();
    $defaultCode = Language::query()->where('is_default', 1)->value('code');

    if (!$defaultCode) {
      return $next($request);
    }

    $firstSegment = explode('/', $path)[0] ?? '';

    if (in_array($firstSegment, $supportedCodes)) {
      return $next($request);
    }

    if ($this->shouldSkip($path)) {
      return $next($request);
    }

    $request->server->set('REQUEST_URI', '/' . $defaultCode . '/' . $path);
    $request->server->set('PATH_INFO', '/' . $defaultCode . '/' . $path);

    $request->initialize(
      $request->query->all(),
      $request->request->all(),
      $request->attributes->all(),
      $request->cookies->all(),
      $request->files->all(),
      $request->server->all(),
      $request->getContent()
    );

    return $next($request);
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
