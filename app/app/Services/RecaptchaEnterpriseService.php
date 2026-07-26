<?php

namespace App\Services;

use App\Models\BasicSettings\Basic;
use Google\Cloud\RecaptchaEnterprise\V1\Assessment;
use Google\Cloud\RecaptchaEnterprise\V1\Client\RecaptchaEnterpriseServiceClient;
use Google\Cloud\RecaptchaEnterprise\V1\CreateAssessmentRequest;
use Google\Cloud\RecaptchaEnterprise\V1\Event;
use Illuminate\Http\Request;

class RecaptchaEnterpriseService
{
    public function verify(Request $request, string $action): bool
    {
        $settings = Basic::query()
            ->select('google_recaptcha_status', 'google_recaptcha_project_id', 'google_recaptcha_site_key', 'google_recaptcha_api_key')
            ->first();

        if (!$settings || (int) $settings->google_recaptcha_status !== 1) {
            return true;
        }

        $token = trim((string) $request->input('g-recaptcha-response'));
        $projectId = trim((string) (config('services.recaptcha.enterprise.project_id') ?: $settings->google_recaptcha_project_id));
        $apiKey = trim((string) (config('services.recaptcha.enterprise.api_key') ?: $settings->google_recaptcha_api_key));
        $siteKey = trim((string) $settings->google_recaptcha_site_key);

        if ($token === '' || $projectId === '' || $apiKey === '' || $siteKey === '') {
            return false;
        }

        $client = null;

        try {
            $client = new RecaptchaEnterpriseServiceClient(['apiKey' => $apiKey]);
            $assessment = $client->createAssessment(
                (new CreateAssessmentRequest())
                    ->setParent(RecaptchaEnterpriseServiceClient::projectName($projectId))
                    ->setAssessment(
                        (new Assessment())->setEvent(
                            (new Event())
                                ->setToken($token)
                                ->setSiteKey($siteKey)
                                ->setUserAgent((string) $request->userAgent())
                                ->setUserIpAddress((string) $request->ip())
                                ->setExpectedAction($action)
                        )
                    )
            );
        } catch (\Throwable $exception) {
            return false;
        } finally {
            $client?->close();
        }

        $tokenProperties = $assessment->getTokenProperties();
        $riskAnalysis = $assessment->getRiskAnalysis();

        return $tokenProperties
            && $tokenProperties->getValid()
            && $tokenProperties->getAction() === $action
            && $riskAnalysis
            && $riskAnalysis->getScore() >= (float) config('services.recaptcha.enterprise.score_threshold', 0.5);
    }
}
