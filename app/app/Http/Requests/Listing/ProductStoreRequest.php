<?php

namespace App\Http\Requests\Listing;

use Illuminate\Foundation\Http\FormRequest;
use App\Models\Language;
use App\Rules\ImageMimeTypeRule;
use Illuminate\Http\Request;

class ProductStoreRequest extends FormRequest
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
     * @return array<string, mixed>
     */
    public function rules(Request  $request)
    {
        $productImageLimit = packageTotalProductImage($request->listing_id);

        $rules = [

            'slider_images' => 'required|array|max:' . $productImageLimit,
            'feature_image' => [
                'required',
                new ImageMimeTypeRule()
            ],
            'status' => 'required',
            'current_price' => 'required',

        ];

        $languages = Language::all();

        foreach ($languages as $language) {
            $rules[$language->code . '_title'] = 'required|max:255';
            $rules[$language->code . '_content'] = 'required|min:15';
        }

        return $rules;
    }

    public function messages()
    {
        $messageArray = [];

        $languages = Language::all();

        foreach ($languages as $language) {
            $messageArray[$language->code . '_title.required'] = 'The title field is required for ' . $language->name . ' language';
            $messageArray[$language->code . '_title.max'] = 'The title field cannot contain more than 255 characters for ' . $language->name . ' language';
            $messageArray[$language->code . '_content.required'] = 'The content field is required for ' . $language->name . ' language';
            $messageArray[$language->code . '_content.min'] = 'The content field at least have 15 characters for ' . $language->name . ' language';
        }

        return $messageArray;
    }
}
