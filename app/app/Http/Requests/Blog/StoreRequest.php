<?php

namespace App\Http\Requests\Blog;

use App\Models\Language;
use App\Rules\ImageMimeTypeRule;
use Illuminate\Foundation\Http\FormRequest;

class StoreRequest extends FormRequest
{
  public function authorize()
  {
    return true;
  }

  public function rules()
  {
    $ruleArray = [
      'image' => [
        'required',
        new ImageMimeTypeRule()
      ],
      'serial_number' => 'required|numeric',
      'category_id' => 'required|exists:blog_categories,id',
    ];

    $languages = Language::all();

    foreach ($languages as $language) {
      $ruleArray[$language->code . '_title'] = 'required|max:255|unique:blog_informations,title';
      $ruleArray[$language->code . '_author'] = 'required|max:255';
      $ruleArray[$language->code . '_content'] = 'min:30';
    }

    return $ruleArray;
  }

  public function messages()
  {
    $messageArray = [];

    $languages = Language::all();

    foreach ($languages as $language) {
      $messageArray[$language->code . '_title.required'] = 'The title field is required for ' . $language->name . ' language.';
      $messageArray[$language->code . '_title.max'] = 'The title field cannot contain more than 255 characters for ' . $language->name . ' language.';
      $messageArray[$language->code . '_title.unique'] = 'The title field must be unique for ' . $language->name . ' language.';
      $messageArray[$language->code . '_author.required'] = 'The author field is required for ' . $language->name . ' language.';
      $messageArray[$language->code . '_author.max'] = 'The author field cannot contain more than 255 characters for ' . $language->name . ' language.';
      $messageArray[$language->code . '_content.min'] = 'The content must be at least 30 characters for ' . $language->name . ' language.';
    }

    $messageArray['category_id.required'] = 'The category field is required.';
    $messageArray['category_id.exists'] = 'The selected category does not exist.';

    return $messageArray;
  }
}
