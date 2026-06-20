<?php

namespace App\Http\Requests\Shop;

use App\Models\Language;
use App\Rules\ImageMimeTypeRule;
use Illuminate\Foundation\Http\FormRequest;

use App\Http\Helpers\VendorPermissionHelper;
use App\Models\Shop\Product;
use App\Models\Vendor;
use Illuminate\Validation\ValidationException; 
use Illuminate\Contracts\Validation\Validator; 

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
   * @return array
   */

  public function rules()
  {
    $featuredImageRules = ['required', new ImageMimeTypeRule()];

    if ($this->hasFile('featured_image')) {
      $featuredImageRules = [new ImageMimeTypeRule()];
    } elseif ($this->filled('ai_featured_image')) {
      $featuredImageRules = ['nullable'];
    }

    $ruleArray = [
      'slider_images' => 'required',
      'featured_image' => $featuredImageRules,
      'ai_featured_image' => 'nullable|string',
      'status' => 'required',
      'current_price' => 'required|numeric'
    ];

    $placementType = $this->placement_type;
    $productType = $this->product_type;

    // Apply rules when placement_type is not 2
    if ($placementType != 2) {
      if ($productType == 'digital') {
        $ruleArray['input_type'] = 'required';
        $ruleArray['file'] = 'required_if:input_type,upload|mimes:zip';
        $ruleArray['link'] = 'required_if:input_type,link';
      } elseif ($productType == 'physical') {
        $ruleArray['stock'] = 'required|numeric';
      }
    } else {
      // When placement_type is 2, listing_id is required
      $ruleArray['listing_id'] = 'required|exists:listings,id';
    }

    $languages = Language::all();

    foreach ($languages as $language) {
      $ruleArray[$language->code . '_title'] = 'required|max:255|unique:product_contents,title';
      $ruleArray[$language->code . '_content'] = 'min:30';

      // Only require category_id and summary when placement_type is not 2
      if ($placementType != 2) {
        $ruleArray[$language->code . '_category_id'] = 'required';
        $ruleArray[$language->code . '_summary'] = 'required';
      }
    }

    return $ruleArray;
  }

  /**
   * Get the validation messages that apply to the request.
   *
   * @return array
   */
  public function messages()
  {
    $messageArray = [];

    $placementType = $this->placement_type;
    $productType = $this->product_type;

    // Messages for digital product type when placement_type is not 2
    if ($placementType != 2 && $productType == 'digital') {
      $messageArray['input_type.required'] = 'The input type field is required for digital products.';
      $messageArray['file.required_if'] = 'The downloadable file is required when input type is upload.';
      $messageArray['file.mimes'] = 'Only .zip file is allowed for product\'s file.';
      $messageArray['link.required_if'] = 'The file download link is required when input type is link.';
    }

    // Message for stock when placement_type is not 2 and product_type is physical
    if ($placementType != 2 && $productType == 'physical') {
      $messageArray['stock.required'] = 'The stock field is required for physical products.';
      $messageArray['stock.numeric'] = 'The stock must be a number.';
    }

    // Message for listing_id when placement_type is 2
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

      // Only add messages for category_id and summary when placement_type is not 2
      if ($placementType != 2) {
        $messageArray[$language->code . '_category_id.required'] = 'The category field is required for ' . $language->name . ' language.';
        $messageArray[$language->code . '_summary.required'] = 'The summary field is required for ' . $language->name . ' language.';
      }
    }

    return $messageArray;
  }

  protected function failedValidation(Validator $validator)
  {
    $this->customPackageChecks(); 
    parent::failedValidation($validator); 
  }

  private function customPackageChecks()
  {
    $vendorId = $this->input('vendor_id');
    if ($vendorId == 'admin' || empty($vendorId)) {
      return;
    }

    $vendorId = (int)$vendorId;
    $errors = [];

    $vendor = Vendor::find($vendorId);
    if (!$vendor) {
      $errors['vendor_id'] = __('Invalid vendor selected'). '.';
    } else {
      $package = VendorPermissionHelper::currentPackagePermission($vendor->id);
      if (!$package) {
        $errors['vendor_id'] = __('No package assigned to this vendor') . '.';
      } else {
        
        // 1. Products limit check
        $totalProduct = Product::where('vendor_id', $vendor->id)->count();
        $maxProducts = $package->number_of_products ?? 0;
        if ($maxProducts > 0 && $totalProduct >= $maxProducts) {
          $errors['vendor_id'] =
            __('Product limit exceeded. Your package allows only'). ' ' . " {$maxProducts}" . ' (' . __('currently') ." {$totalProduct}).";
        }

        // 2. Slider images limit check
        $incomingSliders = $this->input('slider_images', []);
        $incomingCount = is_array($incomingSliders) ? count($incomingSliders) : 0;
        $maxSliders = $package->number_of_images_per_products ?? 0;
        if ($maxSliders > 0 && $incomingCount > $maxSliders) {
          $errors['slider_images'] = __("Slider image limit exceeded. Your package allows a total of") . ' '. 
            "{$maxSliders}.";
        }
      }
    }

    // Throw all errors at once
    if (!empty($errors)) {
      throw ValidationException::withMessages($errors);
    }
  }
}
