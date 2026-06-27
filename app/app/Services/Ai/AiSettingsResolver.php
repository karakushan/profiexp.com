<?php

namespace App\Services\Ai;

use Illuminate\Support\Facades\DB;
use Throwable;

class AiSettingsResolver
{
  public function value(string $databaseKey, string $configKey, mixed $default = ''): mixed
  {
    $databaseValue = $this->databaseValue($databaseKey);

    if ($this->hasValue($databaseValue)) {
      return is_string($databaseValue) ? trim($databaseValue) : $databaseValue;
    }

    return config($configKey, $default);
  }

  private function databaseValue(string $key): mixed
  {
    try {
      $settings = DB::table('basic_settings')
        ->where('uniqid', 12345)
        ->select($key)
        ->first();
    } catch (Throwable) {
      return null;
    }

    return $settings->{$key} ?? null;
  }

  private function hasValue(mixed $value): bool
  {
    return $value !== null && (!is_string($value) || trim($value) !== '');
  }
}
