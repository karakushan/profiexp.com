<?php

namespace App\Rules;

use App\Services\RecaptchaEnterpriseService;
use Illuminate\Contracts\Validation\Rule;
use Illuminate\Http\Request;

class RecaptchaEnterpriseRule implements Rule
{
    public function __construct(private string $action, private ?Request $request = null)
    {
    }

    public function passes($attribute, $value): bool
    {
        return app(RecaptchaEnterpriseService::class)->verify($this->request ?: request(), $this->action);
    }

    public function message(): string
    {
        return __('Captcha error! Try again later or contact site admin.');
    }
}
