<?php

namespace App\Http\Requests\Shop;

use App\Models\Language;
use App\Rules\ImageMimeTypeRule;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;
use App\Http\Helpers\VendorPermissionHelper;
use App\Models\Shop\Product;
use App\Models\Vendor;

class ProductUpdateRequest extends FormRequest
{
  public function authorize()
  {
    return true;
  }

  public function rules()
  {
    $product = Product::find($this->id);
    $sliderImages = $product ? json_decode($product->slider_images, true) : [];

    $ruleArray = [
      'slider_images' => count($sliderImages) == 0 && empty($this->slider_images) ? 'required' : '',
      'featured_image' => $this->hasFile('featured_image') ? ['nullable', new ImageMimeTypeRule()] : '',
      'status' => 'required',
      'current_price' => 'required|numeric',
    ];

    $placementType = $this->placement_type;
    $productType = $this->product_type;

    if ($placementType != 2) {
      if ($productType == 'digital') {
        $ruleArray['input_type'] = 'required';
        if ($this->input_type == 'upload' && empty($product->file)) {
          $ruleArray['file'] = 'required';
        }
        if ($this->hasFile('file')) {
          $ruleArray['file'] = 'mimes:zip';
        }
        $ruleArray['link'] = 'required_if:input_type,link';
      } elseif ($productType == 'physical') {
        $ruleArray['stock'] = 'required|numeric';
      }
    } else {
      $ruleArray['listing_id'] = 'required|exists:listings,id';
    }

    $languages = Language::all();

    foreach ($languages as $language) {
      $ruleArray[$language->code . '_title'] = [
        'required',
        'max:255',
        Rule::unique('product_contents', 'title')->ignore($this->id, 'product_id'),
      ];
      $ruleArray[$language->code . '_content'] = 'min:30';

      if ($placementType != 2) {
        $ruleArray[$language->code . '_category_id'] = 'required';
        $ruleArray[$language->code . '_summary'] = 'required';
      }
    }

    return $ruleArray;
  }

  public function messages()
  {
    $messageArray = [];

    $placementType = $this->placement_type;
    $productType = $this->product_type;

    if ($placementType != 2 && $productType == 'digital') {
      $messageArray['input_type.required'] = 'The input type field is required for digital products.';
      $messageArray['file.required'] = 'The downloadable file is required when input type is upload.';
      $messageArray['file.mimes'] = 'Only .zip file is allowed for product\'s file.';
      $messageArray['link.required_if'] = 'The file download link is required when input type is link.';
    }

    if ($placementType != 2 && $productType == 'physical') {
      $messageArray['stock.required'] = 'The stock field is required for physical products.';
      $messageArray['stock.numeric'] = 'The stock must be a number.';
    }

    if ($placementType == 2) {
      $messageArray['listing_id.required'] = 'The listing field is required.';
      $messageArray['listing_id.exists'] = 'The selected listing is invalid.';
    }

    $languages = Language::all();

    foreach ($languages as $language) {
      $messageArray[$language->code . '_title.required'] = 'The title field is required for ' . $language->name . ' language.';
      $messageArray[$language->code . '_title.max'] = 'The title field cannot contain more than 255 characters for ' . $language->name . ' language.';
      $messageArray[$language->code . '_title.unique'] = 'The title field must be unique for ' . $language->name . ' language.';
      $messageArray[$language->code . '_content.min'] = 'The content must be at least 30 characters for ' . $language->name . ' language.';

      if ($placementType != 2) {
        $messageArray[$language->code . '_category_id.required'] = 'The category field is required for ' . $language->name . ' language.';
        $messageArray[$language->code . '_summary.required'] = 'The summary field is required for ' . $language->name . ' language.';
      }
    }

    $messageArray['slider_images.limit_exceeded'] = 'Slider image limit exceeded. Your package allows a total of :limit images.';

    return $messageArray;
  }

  /**
   * Run extra validation logic.
   */
  public function withValidator($validator)
  {
    $validator->after(function ($validator) {
      $vendorId = $this->input('vendor_id');
      $vendor = Vendor::find($vendorId);
      $package = $vendor ? VendorPermissionHelper::packagePermission($vendor->id) : null;

      if (!$package) {
        return;
      }

      // Count images
      $incomingSliders = $this->input('slider_images', []);
      $incomingCount = is_array($incomingSliders) ? count($incomingSliders) : 0;
      $maxSliders = $package->number_of_images_per_products ?? 0;

      $existingImagesJson = Product::where('id', $this->id)->value('slider_images');
      $existingImages = json_decode($existingImagesJson, true);
      $existingCount = is_array($existingImages) ? count($existingImages) : 0;

      $totalAfter = $existingCount + $incomingCount;

      if ($maxSliders > 0 && $totalAfter > $maxSliders) {
        $validator->errors()->add(
          'slider_images',
          __('Slider image limit exceeded. Your package allows a total of ') . $maxSliders . '.'
        );
      }
    });
  }
}
