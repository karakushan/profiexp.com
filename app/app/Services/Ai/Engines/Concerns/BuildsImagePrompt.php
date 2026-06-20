<?php

namespace App\Services\Ai\Engines\Concerns;

use Illuminate\Support\Str;

trait BuildsImagePrompt
{
  protected function resolveSize(string $size): array
  {
    // Allow custom sizes from UI: custom_{width}_{height}
    if (preg_match('/^custom_(\d{2,4})_(\d{2,4})$/', $size, $m)) {
      return [(int) $m[1], (int) $m[2]];
    }

    return match ($size) {
      'portrait_1024_1536'  => [1024, 1536],
      'landscape_1536_1024' => [1536, 1024],
      default               => [1024, 1024],
    };
  }

  protected function buildPrompt(string $prompt, string $style, string $lighting, string $angle): string
  {
    $chunks = [$prompt];

    $styleMap = [
      'photorealistic'    => 'photorealistic',
      '3d_render'         => '3d render',
      'flat_illustration' => 'flat illustration',
      'minimal'           => 'minimal',
    ];
    $lightingMap = [
      'natural'  => 'natural light',
      'studio'   => 'studio lighting',
      'soft'     => 'soft light',
      'dramatic' => 'dramatic lighting',
    ];
    $angleMap = [
      'eye_level' => 'eye-level',
      'top_down'  => 'top-down',
      'close_up'  => 'close-up',
      'wide'      => 'wide shot',
    ];

    if (isset($styleMap[$style])) $chunks[] = $styleMap[$style];
    if (isset($lightingMap[$lighting])) $chunks[] = $lightingMap[$lighting];
    if (isset($angleMap[$angle])) $chunks[] = $angleMap[$angle];

    $chunks[] = 'high quality, clean background, product thumbnail';

    return implode(', ', $chunks);
  }

  protected function resizeStoredImage(string $storagePath, int $width, int $height): void
  {
    if ($width <= 0 || $height <= 0) {
      return;
    }

    $relative = ltrim($storagePath, '/');
    $absPath = storage_path('app/public/' . $relative);

    if (!file_exists($absPath)) {
      return;
    }

    try {
      $img = \Intervention\Image\Facades\Image::make($absPath);
      if ((int) $img->width() === $width && (int) $img->height() === $height) {
        return;
      }

      $img->resize($width, $height, function ($constraint) {
        $constraint->upsize();
      })->save($absPath);
    } catch (\Throwable $e) {
      // If resize fails, keep the original image.
    }
  }

  protected function storageBase(string $prefix): string
  {
    return 'ai/categories/' . $prefix . now()->format('Ymd_His') . '_' . Str::random(8);
  }
}
