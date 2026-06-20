<?php

namespace App\Http\Requests\Listing;

use App\Http\Helpers\VendorPermissionHelper;
use Illuminate\Foundation\Http\FormRequest;
use App\Models\Language;
use App\Models\Location\Country;
use App\Models\Location\State;
use App\Rules\ImageMimeTypeRule;
use Illuminate\Http\Request;


class ListingStoreRequest extends FormRequest
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
        $featureImageRules = [
            'required',
            new ImageMimeTypeRule(),
            'dimensions:width=600,height=400'
        ];

        if ($this->hasFile('feature_image')) {
            $featureImageRules = [
                new ImageMimeTypeRule(),
                'dimensions:width=600,height=400'
            ];
        } elseif ($this->filled('ai_feature_image')) {
            $featureImageRules = ['nullable'];
        }

        $video = !empty($request->video_url);

        $videoImageRules = [
            $video ? 'required' : 'nullable',
            new ImageMimeTypeRule(),
        ];

        if ($this->hasFile('video_background_image')) {
            $videoImageRules = [new ImageMimeTypeRule()];
        } elseif ($this->filled('ai_video_background_image')) {
            $videoImageRules = ['nullable'];
        }

        if ($request->vendor_id == null || $request->vendor_id == 0) {
            $rules = [
                'slider_images' => 'required',
                'feature_image' => $featureImageRules,
                'ai_feature_image' => 'nullable|string',
                'video_background_image' => $videoImageRules,
                'ai_video_background_image' => 'nullable|string',

                'mail' => 'required',
                'phone' => 'required',
                'max_price' => 'nullable|numeric|required_with:min_price|gt:min_price',
                'min_price' => 'nullable|numeric|required_with:max_price|lt:max_price',
                'status' => 'required',
                'latitude' => ['required', 'numeric', 'between:-90,90'],
                'longitude' => ['required', 'numeric', 'between:-180,180'],

            ];

            $languages = Language::all();

            foreach ($languages as $language) {

                $property = $language->code . '_country_id';

                if ($request->$property) {
                    $Statess = State::where('country_id', $property)->count();
                    if ($Statess != 0) {
                        $State = true;
                    } else {
                        $State = false;
                    }
                } else {
                    $States = State::where('language_id', $language->id)->count();
                    if ($States != 0) {
                        $State = true;
                    } else {
                        $State = false;
                    }
                }

                $countries = Country::where('language_id', $language->id)->count();
                if ($countries != 0) {
                    $country = true;
                } else {
                    $country = false;
                }

                $rules[$language->code . '_title'] = 'required|max:255';
                $rules[$language->code . '_address'] = 'required';
                $rules[$language->code . '_category_id'] = 'required';
                $rules[$language->code . '_state_id'] = $State ? 'required' : '';
                $rules[$language->code . '_country_id'] = $country ? 'required' : '';
                $rules[$language->code . '_city_id'] = 'required';
                $rules[$language->code . '_description'] = 'required|min:15';
                $rules[$language->code . '_aminities'] = 'required';
            }

            return $rules;
        } else {
            $vendorId = $request->vendor_id;

            $packagePermission = VendorPermissionHelper::packagePermission($vendorId);
            if ($packagePermission != []) {

                $listingImageLimit = packageTotalListingImage($vendorId);
                $permissions = currentPackageFeatures($vendorId);
                $additionalFeatureLimit = packageTotalAdditionalSpecification($vendorId);
                $aminitiesLimit = packageTotalAminities($vendorId);
                $SocialLinkLimit = packageTotalSocialLink($vendorId);


                if (!empty(currentPackageFeatures($vendorId))) {
                    $permissions = json_decode($permissions, true);
                }

                if (is_array($permissions) && in_array('Amenities', $permissions)) {

                    $Amenities = true;
                } else {
                    $Amenities = false;
                }

                $rules = [
                    'slider_images' => 'required|array|max:' . $listingImageLimit,
                    'feature_image' => $featureImageRules,
                    'ai_feature_image' => 'nullable|string',
                    'video_background_image' => $videoImageRules,
                    'ai_video_background_image' => 'nullable|string',

                    'mail' => 'required',
                    'phone' => 'required',
                    'max_price' => 'nullable|numeric|required_with:min_price|gt:min_price',
                    'min_price' => 'nullable|numeric|required_with:max_price|lt:max_price',
                    'status' => 'required',
                    'latitude' => ['required', 'numeric', 'between:-90,90'],
                    'longitude' => ['required', 'numeric', 'between:-180,180'],

                ];

                $languages = Language::all();

                foreach ($languages as $language) {
                    $property = $language->code . '_country_id';

                    if ($request->$property) {
                        $Statess = State::where('country_id', $property)->count();
                        if ($Statess != 0) {
                            $State = true;
                        } else {
                            $State = false;
                        }
                    } else {
                        $States = State::where('language_id', $language->id)->count();
                        if ($States != 0) {
                            $State = true;
                        } else {
                            $State = false;
                        }
                    }

                    $countries = Country::where('language_id', $language->id)->count();
                    if ($countries != 0) {
                        $country = true;
                    } else {
                        $country = false;
                    }

                    $rules[$language->code . '_title'] = 'required|max:255';
                    $rules[$language->code . '_address'] = 'required';
                    $rules[$language->code . '_category_id'] = 'required';
                    $rules[$language->code . '_city_id'] = 'required';
                    $rules[$language->code . '_state_id'] = $State ? 'required' : '';
                    $rules[$language->code . '_country_id'] = $country ? 'required' : '';
                    $rules[$language->code . '_description'] = 'required|min:15';
                    $rules[$language->code . '_aminities'] = $Amenities ? 'required|array|max:' . $aminitiesLimit : '';
                    $rules[$language->code . '_feature_heading'] = 'sometimes|array|max:' . $additionalFeatureLimit;
                }

                return $rules;
            }
        }
    }

    public function messages()
    {
        $messageArray = [];

        $messageArray['slider_images.required'] = __('The gallery images field is required.');

        $languages = Language::all();

        foreach ($languages as $language) {
            $code = $language->code;

            $messageArray[$code . '_title.required'] = __('The title field is required for') . ' ' . $language->name . ' ' . __('language') . '.';
            $messageArray[$code . '_title.max'] = __('The title field cannot contain more than 255 characters for') . ' ' . $language->name . ' ' . __('language') . '.';
            $messageArray[$code . '_address.required'] = __('The address field is required for') . ' ' . $language->name . ' ' . __('language') . '.';
            $messageArray[$code . '_category_id.required'] = __('The category field is required for') . ' ' . $language->name . ' ' . __('language') . '.';
            $messageArray[$code . '_city_id.required'] = __('The city field is required for') . ' ' . $language->name . ' ' . __('language') . '.';
            $messageArray[$code . '_state_id.required'] = __('The state field is required for') . ' ' . $language->name . ' ' . __('language') . '.';
            $messageArray[$code . '_country_id.required'] = __('The Country field is required for') . ' ' . $language->name . ' ' . __('language') . '.';
            $messageArray[$code . '_description.required'] = __('The description field is required for') . ' ' . $language->name . ' ' . __('language') . '.';
            $messageArray[$code . '_description.min'] = __('The description field must have at least 15 characters for') . ' ' . $language->name . ' ' . __('language') . '.';
            $messageArray[$code . '_aminities.required'] = __('The Amenities field is required for') . ' ' . $language->name . ' ' . __('language') . '.';
            $messageArray[$code . '_aminities.max'] = __('Maximum') . ' ' . $this->aminitiesLimit() . ' ' . __('aminities can be added per listing for') . ' ' . $language->name .
                ' ' . __('language') . '.';
        }

        return $messageArray;
    }
    private function aminitiesLimit()
    {
        $vendorId = $this->vendor_id;
        if ($vendorId == 0) {
            return PHP_INT_MAX;
        } else {
            return  packageTotalAminities($vendorId);
        }
    }
}
