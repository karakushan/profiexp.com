<?php

namespace App\Http\Controllers\Vendor\Ai;

use App\Http\Controllers\Controller;
use App\Models\Membership;
use App\Services\Ai\AiContentService;
use App\Services\Ai\AiTextManager;
use App\Services\Ai\AiTokenUsageService;
use App\Services\Ai\ContentGenerator;
use Illuminate\Support\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;

class AiContentController extends Controller
{
    public function generateContent(
        Request $request,
        AiTextManager $aiText,
        AiContentService $contentService,
        AiTokenUsageService $tokenUsage,
        ContentGenerator $generator
    ) {

        // Basic request validation
        $validator = Validator::make($request->all(), [
            'prompt'            => 'required|string|min:2|max:2000',
            'mode'              => 'nullable|string',
            'field'             => 'nullable|string',
            'lang'              => 'nullable|string',
            'category_id'       => 'nullable|integer',
            'category_name'     => 'nullable|string|max:255',
            'subcategory_id'    => 'nullable|integer',
            'subcategory_name'  => 'nullable|string|max:255',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status'  => false,
                'message' => $validator->errors()->first(),
            ], 422);
        }

        // Resolve user and preferred engine
        $user = Auth::guard('vendor')->user();
        $user_id = $user->id;
        $currentMembership = Membership::query()->select([
            'id',
            'status',
            'package_id',
            'vendor_id',
            'start_date',
            'expire_date',
            'ai_engine',
            'ai_token_limit',
            'ai_image_limit',
            'ai_used_tokens',
            'ai_used_images',
            'ai_token_purchased',
            'ai_image_purchased',
        ])->where([
            ['vendor_id', $user_id],
            ['start_date', '<=', Carbon::now()->toDateString()],
            ['expire_date', '>=', Carbon::now()->toDateString()]
        ])->where('status', 1)->whereYear('start_date', '<>', '9999')->first();
        // dd($currentMembership);
        $engine = $currentMembership->ai_engine ?? 'openai';

        // Resolve target languages for the user 
        $targets = $contentService->getTargets((int) $user->id, $request->input('lang'));

        $targetLangCodes = array_map(fn($t) => $t['code'], $targets);

        // Build prompts by mode
        $baseIdea = trim((string) $request->prompt);
        $mode = trim((string) $request->input('mode', ''));

        $homeField = '';
        if ($mode === 'home_page_text') {
            $homeField = $contentService->sanitizeHomeField((string) $request->input('field', ''));
            if ($homeField === '') {
                return response()->json([
                    'status'  => false,
                    'message' => 'Invalid field for home page text.',
                ], 422);
            }
        }
        $mailField = '';
        if ($mode === 'mail') {
            $mailField = $contentService->sanitizeMailField((string) $request->input('field', ''));
            if ($mailField === '') {
                return response()->json([
                    'status'  => false,
                    'message' => 'Invalid field for mail content.',
                ], 422);
            }
        }

        $prompts = $contentService->buildPrompts(
            mode: $mode,
            baseIdea: $baseIdea,
            request: $request,
            targets: $targets,
            targetLangCodes: $targetLangCodes,
            engine: $engine,
            generator: $generator
        );

        try {
            // Run prompts and merge JSON responses.
            $json = $contentService->runPrompts(
                $prompts,
                $aiText,
                $engine,
                $generator,
                $currentMembership,
                $tokenUsage
            );

            if (!is_array($json) || $json === []) {
                return response()->json([
                    'status'  => false,
                    'message' => 'AI did not return valid JSON.',
                ], 422);
            }

            if ($mode === 'home_page_text') {
                $value = isset($json[$homeField]) ? trim((string) $json[$homeField]) : '';
                if ($value === '') {
                    return response()->json([
                        'status'  => false,
                        'message' => 'AI did not return valid JSON for the requested field.',
                    ], 422);
                }

                return response()->json([
                    'status' => true,
                    'names' => [$homeField => $value],
                ]);
            }

            if ($mode === 'mail') {
                $value = isset($json[$mailField]) ? trim((string) $json[$mailField]) : '';
                if ($value === '') {
                    return response()->json([
                        'status'  => false,
                        'message' => 'AI did not return valid JSON for the requested field.',
                    ], 422);
                }

                return response()->json([
                    'status' => true,
                    'names' => [$mailField => $value],
                ]);
            }

            if ($mode === 'additional_section') {
                if (!is_array($json) || $json === []) {
                    return response()->json([
                        'status'  => false,
                        'message' => 'AI did not return valid JSON for the requested field(s).',
                    ], 422);
                }

                $requestedField = trim((string) $request->input('field', ''));
                if ($requestedField !== '' && empty($json[$requestedField])) {
                    return response()->json([
                        'status'  => false,
                        'message' => 'AI did not return valid JSON for the requested field.',
                    ], 422);
                }

                $hasAny = false;
                foreach ($json as $value) {
                    if (trim((string) $value) !== '') {
                        $hasAny = true;
                        break;
                    }
                }

                if (!$hasAny) {
                    return response()->json([
                        'status'  => false,
                        'message' => 'AI did not return valid JSON for the requested field(s).',
                    ], 422);
                }

                return response()->json([
                    'status' => true,
                    'names' => $json,
                ]);
            }

            if ($mode === 'faq') {
                $question = isset($json['question']) ? trim((string) $json['question']) : '';
                $answer = isset($json['answer']) ? trim((string) $json['answer']) : '';

                if ($question === '' || $answer === '') {
                    return response()->json([
                        'status'  => false,
                        'message' => 'AI did not return valid FAQ JSON.',
                    ], 422);
                }

                return response()->json([
                    'status' => true,
                    'names' => [
                        'question' => $question,
                        'answer' => $answer,
                    ],
                ]);
            }

            if ($mode === 'page') {
                $requestedField = trim((string) $request->input('field', ''));
                if ($requestedField !== '') {
                    $value = isset($json[$requestedField]) ? trim((string) $json[$requestedField]) : '';

                    if ($value === '') {
                        if (str_ends_with($requestedField, '_title') && !empty($json['title'])) {
                            $value = trim((string) $json['title']);
                        } elseif (str_ends_with($requestedField, '_body') && !empty($json['body'])) {
                            $value = trim((string) $json['body']);
                        }
                    }

                    if ($value === '') {
                        return response()->json([
                            'status'  => false,
                            'message' => 'AI did not return valid Page JSON.',
                        ], 422);
                    }

                    return response()->json([
                        'status' => true,
                        'names' => [
                            $requestedField => $value,
                        ],
                    ]);
                }

                $out = [];
                foreach ($targetLangCodes as $code) {
                    $tKey = "{$code}_title";
                    $bKey = "{$code}_body";
                    $out[$tKey] = isset($json[$tKey]) ? trim((string) $json[$tKey]) : '';
                    $out[$bKey] = isset($json[$bKey]) ? trim((string) $json[$bKey]) : '';
                }

                if (!array_filter($out)) {
                    return response()->json([
                        'status'  => false,
                        'message' => 'AI did not return valid Page JSON.',
                    ], 422);
                }

                return response()->json([
                    'status' => true,
                    'names' => $out,
                ]);
            }

            if ($mode === 'item_seo') {
                // Return a flat {lang_field => value} map for item SEO mode.
                $requestedField = (string) $request->input('field', '');
                $requestedLang  = (string) $request->input('lang', '');

                $fields = in_array($requestedField, AiContentService::ALLOWED_FIELDS, true)
                    ? [$requestedField]
                    : AiContentService::ALLOWED_FIELDS;

                $langCodes = (is_string($requestedLang) && in_array($requestedLang, $targetLangCodes, true))
                    ? [$requestedLang]
                    : $targetLangCodes;

                $out = [];
                foreach ($langCodes as $code) {
                    foreach ($fields as $f) {
                        $key = "{$code}_{$f}";
                        $out[$key] = isset($json[$key]) ? trim((string) $json[$key]) : '';
                    }
                }

                $hasAny = false;
                foreach ($out as $value) {
                    if ($value !== '') {
                        $hasAny = true;
                        break;
                    }
                }

                if (!$hasAny) {
                    return response()->json([
                        'status'  => false,
                        'message' => 'AI did not return valid SEO JSON for the requested field(s)/language(s).',
                    ], 422);
                }

                return response()->json(['status' => true, 'names' => $out]);
            }

            // Default modes: map each language code to its generated text
            $out = [];
            foreach ($targets as $t) {
                $out[$t['code']] = isset($json[$t['code']]) ? trim((string) $json[$t['code']]) : '';
            }

            if (!array_filter($out)) {
                return response()->json([
                    'status'  => false,
                    'message' => 'AI did not return valid JSON for the required languages.',
                ], 422);
            }

            return response()->json(['status' => true, 'names' => $out]);
        } catch (\Throwable $e) {
            // Log and return a generic error 
            Log::error('AI failed', [
                'engine' => $engine,
                'mode' => $mode,
                'message' => $e->getMessage(),
            ]);
            return response()->json([
                'status'  => false,
                'message' => 'AI failed',
            ], 500);
        }
    }
}
