<?php

namespace App\Http\Helpers;

use Illuminate\Support\Str;

class UploadFile
{
  public static function store($directory, $file)
  {
    $extension = $file->getClientOriginalExtension();
    $fileName = uniqid() . '.' . $extension;
    @mkdir($directory, 0775, true);
    $file->move($directory, $fileName);

    return $fileName;
  }

  public static function update($directory, $newFile, $oldFile)
  {
    @unlink($directory . $oldFile);
    $extension = $newFile->getClientOriginalExtension();
    $fileName = uniqid() . '.' . $extension;
    @mkdir($directory, 0775, true);
    $newFile->move($directory, $fileName);

    return $fileName;
  }

  public static function storeFromSource($directory, string $source, ?string $extension = null): ?string
  {
    $resolvedPath = static::resolveLocalSourcePath($source);

    if (!$resolvedPath || !is_file($resolvedPath)) {
      return null;
    }

    $detectedExtension = strtolower((string) pathinfo($resolvedPath, PATHINFO_EXTENSION));
    $finalExtension = $extension ?: ($detectedExtension ?: 'png');
    $fileName = uniqid() . '.' . $finalExtension;

    @mkdir($directory, 0775, true);

    return @copy($resolvedPath, $directory . $fileName) ? $fileName : null;
  }

  public static function resolveLocalSourcePath(string $source): ?string
  {
    $source = trim($source);

    if ($source === '') {
      return null;
    }

    if (is_file($source)) {
      return $source;
    }

    if (Str::startsWith($source, ['http://', 'https://'])) {
      $path = parse_url($source, PHP_URL_PATH);
      if (is_string($path) && $path !== '') {
        $source = $path;
      }
    }

    $relativePath = ltrim($source, '/\\');
    if ($relativePath === '') {
      return null;
    }

    $publicPath = public_path(str_replace(['/', '\\'], DIRECTORY_SEPARATOR, $relativePath));
    if (is_file($publicPath)) {
      return $publicPath;
    }

    if (Str::startsWith(str_replace('\\', '/', $relativePath), 'storage/')) {
      $storageRelative = Str::after(str_replace('\\', '/', $relativePath), 'storage/');
      $storagePath = storage_path('app/public/' . str_replace('/', DIRECTORY_SEPARATOR, $storageRelative));

      if (is_file($storagePath)) {
        return $storagePath;
      }
    }

    return null;
  }
}
