<?php

namespace App\Http\Controllers\Cron;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Artisan;

class TranslateCategoriesController extends Controller
{
    public function __invoke(Request $request): JsonResponse
    {
        $expectedToken = config('app.translate_cron_token');

        if ($expectedToken && $request->query('token') !== $expectedToken) {
            return response()->json(['status' => 'unauthorized'], 403);
        }

        Artisan::call('categories:translate');

        return response()->json([
            'status' => 'ok',
            'output' => trim(Artisan::output()),
        ]);
    }
}