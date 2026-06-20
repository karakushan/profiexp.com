<?php

namespace App\Http\Middleware;

use App\Models\Language;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;

class SetApiLocale
{
    public function handle(Request $request, Closure $next)
    {
        $acceptLanguage = $request->header('Accept-Language');

        if ($acceptLanguage) {
            // e.g. "ar", "en-US", "ar,en;q=0.9" — take the first/primary tag
            $primaryCode = strtolower(trim(explode(',', explode(';', $acceptLanguage)[0])[0]));
            // strip region subtag: "en-us" → "en"
            $langCode = explode('-', $primaryCode)[0];

            $exists = Language::where('code', $langCode)->exists();
            if ($exists) {
                App::setLocale($langCode);
                return $next($request);
            }
        }

        // Fall back to the default language
        $default = Language::where('is_default', 1)->value('code');
        App::setLocale($default ?? config('app.locale'));

        return $next($request);
    }
}
