<?php

namespace App\Http\Controllers\Vendor\Ai;

use App\Http\Helpers\UploadFile;
use App\Http\Controllers\Controller;
use App\Models\Membership;
use App\Services\Ai\AiImageManager;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Carbon;

class AiImageController extends Controller
{
    private function normalizePublicImageUrl(?string $url): ?string
    {
        $url = is_string($url) ? trim($url) : '';

        if ($url === '') {
            return null;
        }

        $copiedName = UploadFile::storeFromSource(
            public_path('assets/img/ai/generated/'),
            $url
        );

        if ($copiedName) {
            return asset('assets/img/ai/generated/' . $copiedName);
        }

        return $url;
    }

    private function getCurrentMembership(int $userId): ?Membership
    {
        $today = Carbon::now()->toDateString();

        return Membership::query()->select([
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
            ['vendor_id', $userId],
            ['start_date', '<=', $today],
            ['expire_date', '>=', $today],
        ])->where('status', 1)->whereYear('start_date', '<>', '9999')->first();
    }

    private function incrementUsedImages(?Membership $membership, int $count): void
    {
        if (!$membership || $count <= 0) {
            return;
        }

        Membership::query()
            ->where('id', $membership->id)
            ->where('vendor_id', $membership->vendor_id)
            ->increment('ai_used_images', $count);
    }

    public function generateImage(Request $request, AiImageManager $manager)
    {

        $validator = Validator::make($request->all(), [
            'prompt'   => 'required|string|min:3|max:800',
            'style'    => 'nullable|string|max:50',
            'lighting' => 'nullable|string|max:50',
            'angle'    => 'nullable|string|max:50',
            'size'     => 'nullable|string|max:50',
            'engine'   => 'nullable|in:pollinations,openai,gemini',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'message' => $validator->errors()->first()
            ], 422);
        }

        try {
            $user = Auth::guard('vendor')->user();

            $currentMembership = $this->getCurrentMembership($user->id);

            $engine = $currentMembership->ai_engine;

            $url = $manager->generateAndStore(
                $request->only('prompt', 'style', 'lighting', 'angle', 'size'),
                $engine
            );
            $url = $this->normalizePublicImageUrl($url);

            if (!empty($url)) {
                $this->incrementUsedImages($currentMembership, 1);
            }

            return response()->json([
                'status' => true,
                'image_url' => $url
            ]);
        } catch (\Throwable $e) {
            return response()->json([
                'status' => false,
                'message' => 'Image generation failed. Please try again.'
            ], 500);
        }
    }

    public function generateSliderImages(Request $request, AiImageManager $manager)
    {
        $validator = Validator::make($request->all(), [
            'prompt'   => 'required|string|min:3|max:800',
            'count'    => 'required|integer|min:1|max:10',

            'style'    => 'nullable|string|max:50',
            'lighting' => 'nullable|string|max:50',
            'angle'    => 'nullable|string|max:50',
            'size'     => 'nullable|string|max:50',
            'engine'   => 'nullable|in:pollinations,openai,gemini',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status'  => false,
                'message' => $validator->errors()->first()
            ], 422);
        }

        try {
            $user = Auth::guard('vendor')->user();

            $currentMembership = $this->getCurrentMembership($user->id);

            $engine = $currentMembership->ai_engine;

            $payload = $request->only('prompt', 'style', 'lighting', 'angle', 'size');

            $count = (int) $request->count;
            $images = [];
            $fails = 0;

            for ($i = 0; $i < $count; $i++) {
                try {

                    $url = $manager->generateAndStore($payload, $engine);
                    $url = $this->normalizePublicImageUrl($url);

                    if (!empty($url)) {
                        $images[] = $url;
                    } else {
                        $fails++;
                    }
                } catch (\Throwable $e) {
                    $fails++;
                }
            }

            if (count($images) === 0) {
                return response()->json([
                    'status'  => false,
                    'message' => 'Image generation failed. Please try again.'
                ], 500);
            }

            $this->incrementUsedImages($currentMembership, count($images));

            return response()->json([
                'status' => true,
                'images' => $images,
                'failed' => $fails
            ]);
        } catch (\Throwable $e) {
            return response()->json([
                'status'  => false,
                'message' => 'Image generation failed. Please try again.'
            ], 500);
        }
    }
}
