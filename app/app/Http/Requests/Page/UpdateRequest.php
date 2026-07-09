<?php

namespace App\Http\Requests\Page;

use App\Models\Language;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UpdateRequest extends FormRequest
{
  public function authorize()
  {
    return true;
  }

  public function rules()
  {
    $ruleArray = [
      'status' => 'required'
    ];

    foreach (Language::all() as $language) {
      $code = $language->code;

      if (!$this->hasTranslationInput($code)) {
        continue;
      }

      $ruleArray[$code . '_title'] = [
        'required',
        'max:255',
        Rule::unique('page_contents', 'title')->ignore($this->id, 'page_id')
      ];

      $ruleArray[$code . '_slug'] = [
        'nullable',
        'max:255',
        Rule::unique('page_contents', 'slug')->ignore($this->id, 'page_id')
      ];

      $ruleArray[$code . '_content'] = 'required|min:15';
    }

    return $ruleArray;
  }

  public function messages()
  {
    $messageArray = [];

    foreach (Language::all() as $language) {
      $code = $language->code;

      if (!$this->hasTranslationInput($code)) {
        continue;
      }

      $messageArray[$code . '_title.required'] = 'The title field is required for ' . $language->name . ' language.';
      $messageArray[$code . '_title.max'] = 'The title field cannot contain more than 255 characters for ' . $language->name . ' language.';
      $messageArray[$code . '_title.unique'] = 'The title field must be unique for ' . $language->name . ' language.';
      $messageArray[$code . '_content.min'] = 'The content field atleast have 15 characters for ' . $language->name . ' language.';
      $messageArray[$code . '_content.required'] = 'The content field is required for ' . $language->name . ' language.';
    }

    return $messageArray;
  }

  private function hasTranslationInput(string $code): bool
  {
    $fields = [
      $code . '_title',
      $code . '_slug',
      $code . '_content',
      $code . '_meta_keywords',
      $code . '_meta_description',
    ];

    foreach ($fields as $field) {
      if (trim((string) $this->input($field, '')) !== '') {
        return true;
      }
    }

    return false;
  }
}
