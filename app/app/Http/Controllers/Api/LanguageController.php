<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class LanguageController extends Controller
{
  public function getLang(Request $request)
  {
    $code = $request->input('code');
    if(!$code){
      return response()->json([
        'status' => 'error',
        'message' => 'Language code is required',
      ], 422);
    }

    $path = resource_path('lang/' . $code . '.json');
    $langData = json_decode(file_get_contents($path), true);    
    return $langData;
  }

    public function panelLang($code)
  {
    return $this->getLangFile("admin_{$code}.json", $code);
  }


  private function getLangFile($fileName, $code)
  {
    if (!preg_match('/^[a-zA-Z0-9_-]+$/', $code)) {
      return response()->json(['status' => false, 'message' => 'Invalid code'], 400);
    }

    $filePath = resource_path("lang/{$fileName}");

    if (!file_exists($filePath)) {
      return response()->json(['status' => false, 'message' => 'File not found'], 404);
    }

    return response()->json([
      'status' => true,
      'code' => $code,
      'data' => json_decode(file_get_contents($filePath), true)
    ]);
  }
}
