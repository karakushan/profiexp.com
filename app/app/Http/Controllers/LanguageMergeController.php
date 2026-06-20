<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use Symfony\Component\HttpFoundation\Response;

class LanguageMergeController extends Controller
{
    public function merge(Request $request)
    {

        $basePath = resource_path('lang');
        $adminKeywordsPath = $basePath . DIRECTORY_SEPARATOR . 'admin_keywords.json';
        $frontendKeywordsPath = $basePath . DIRECTORY_SEPARATOR . 'frontend_keywords.json';

        $adminKeywords = $this->loadJsonAssoc($adminKeywordsPath, true);
        $frontendKeywords = $this->loadJsonAssoc($frontendKeywordsPath, true);

        if ($adminKeywords === null && $frontendKeywords === null) {
            return response()->json([
                'message' => 'No keyword source files found. Nothing to merge.',
                'updated' => 0
            ]);
        }

        $files = collect(File::files($basePath))
            ->filter(fn($f) => strtolower($f->getExtension()) === 'json')
            ->values();

        if ($files->isEmpty()) {
            return response()->json([
                'message' => 'No JSON language files found in resources/lang.',
                'updated' => 0
            ]);
        }

        $updated = [];
        foreach ($files as $file) {
            $filename = $file->getFilename();
            $isAdminFile = str_starts_with($filename, 'admin_');
            $keywords = $isAdminFile ? $adminKeywords : $frontendKeywords;

            if (empty($keywords)) {
                continue; 
            }

            $target = $this->loadJsonAssoc($file->getPathname(), false);
            if (!is_array($target)) {
                continue; // invalid JSON skip
            }

            // Merge: source wins
            $merged = array_merge($target, $keywords);

            // Sort for stable diffs
            ksort($merged, SORT_NATURAL | SORT_FLAG_CASE);

            // Pretty print
            $json = json_encode($merged, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
            if ($json === false) {
                continue;
            }

            File::put($file->getPathname(), $json . PHP_EOL);
            $updated[] = $filename;
        }

        return response()->json([
            'message' => 'Merge completed',
            'updated_files' => $updated,
            'updated_count' => count($updated),
        ]);
    }

    private function loadJsonAssoc(string $path, bool $optional): ?array
    {
        if (!File::exists($path)) {
            return $optional ? null : [];
        }
        $content = File::get($path);
        $data = json_decode($content, true);
        if (json_last_error() !== JSON_ERROR_NONE || !is_array($data)) {
            return null;
        }
        return $data;
    }
}
