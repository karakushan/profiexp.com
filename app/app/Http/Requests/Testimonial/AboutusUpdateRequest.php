<?php

namespace App\Http\Requests\Testimonial;

use Illuminate\Foundation\Http\FormRequest;

class AboutusUpdateRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        $ruleArray = [];
        $ruleArray['name'] = 'required|max:255';
        $ruleArray['occupation'] = 'required|max:255';
        $ruleArray['comment'] = 'required';

        return $ruleArray;
    }
}
