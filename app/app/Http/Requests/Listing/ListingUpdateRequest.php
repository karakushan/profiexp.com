<?php

namespace App\Http\Requests\Listing;

use Illuminate\Foundation\Http\FormRequest;

use App\Models\Language;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingImage;
use App\Models\Location\Country;
use App\Models\Location\State;
use App\Rules\ImageMimeTypeRule;
use Illuminate\Http\Request;

class ListingUpdateRequest extends FormRequest
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

    public function rules(Request $request)
    {
        if ($request->vendor_id == null || $request->vendor_id == 0) {
            if ($request->video_url) {
                $video = true;
            } else {
                $video = false;
            }
            $videoImage = Listing::findorfail($request->listing_id)->video_background_image;
            if ($videoImage) {
                $videohave = false;
            } else {
                $videohave = true;
            }
            $rules = [
                'video_background_image' => [
                    $video ? ($videohave ? 'required' : '') : '',
                    new ImageMimeTypeRule(),
                ],
                'thumbnail' => [
                    'dimensions:width=600,height=400',
                    new ImageMimeTypeRule(),
                ],
                'mail' => 'required',
                'phone' => 'required',
                'status' => 'required',
                'max_price' => 'nullable|numeric|required_with:min_price|gt:min_price',
                'min_price' => 'nullable|numeric|required_with:max_price|lt:max_price',
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

                $isDefault = $language->is_default == 1;
                $titleRule = $isDefault ? 'required|max:255' : 'nullable|max:255';
                $requiredOrNullable = $isDefault ? 'required' : 'nullable';
                $descriptionRule = $isDefault ? 'required|min:15' : 'nullable|min:15';
                $stateRule = $State ? $requiredOrNullable : '';
                $countryRule = $country ? $requiredOrNullable : '';

                $rules[$language->code . '_title'] = $titleRule;
                $rules[$language->code . '_address'] = $requiredOrNullable;
                $rules[$language->code . '_category_id'] = $requiredOrNullable;
                $rules[$language->code . '_city_id'] = $requiredOrNullable;
                $rules[$language->code . '_state_id'] = $stateRule;
                $rules[$language->code . '_country_id'] = $countryRule;
                $rules[$language->code . '_description'] = $descriptionRule;
                $rules[$language->code . '_aminities'] = $requiredOrNullable;
            }

            return $rules;
        } else {
            if ($request->video_url) {
                $video = true;
            } else {
                $video = false;
            }
            $videoImage = Listing::findorfail($request->listing_id)->video_background_image;
            if ($videoImage) {
                $videohave = false;
            } else {
                $videohave = true;
            }
            $vendorId = $request->vendor_id;
            $listingImageLimit = packageTotalListingImage($vendorId);
            $siderImageCount = ListingImage::where('listing_id', $request->listing_id)->count();
            $siders = $listingImageLimit - $siderImageCount;
            $additionalFeatureLimit = packageTotalAdditionalSpecification($vendorId);
            $aminitiesLimit = packageTotalAminities($vendorId);
            $SocialLinkLimit = packageTotalSocialLink($vendorId);


            $permissions = currentPackageFeatures($vendorId);

            if (!empty(currentPackageFeatures($vendorId))) {
                $permissions = json_decode($permissions, true);
            }

            if (is_array($permissions) && in_array('Amenities', $permissions)) {
                $Amenities = true;
            } else {
                $Amenities = false;
            }

            $rules = [
                'slider_images' => 'sometimes|array|max:' . $siders,
                'video_background_image' => [
                    $video ? ($videohave ? 'required' : '') : '',
                    new ImageMimeTypeRule(),
                ],
                'thumbnail' => [
                    'dimensions:width=600,height=400',
                    new ImageMimeTypeRule(),
                ],

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

                $isDefault = $language->is_default == 1;
                $titleRule = $isDefault ? 'required|max:255' : 'nullable|max:255';
                $requiredOrNullable = $isDefault ? 'required' : 'nullable';
                $descriptionRule = $isDefault ? 'required|min:15' : 'nullable|min:15';
                $stateRule = $State ? $requiredOrNullable : '';
                $countryRule = $country ? $requiredOrNullable : '';

                $rules[$language->code . '_title'] = $titleRule;
                $rules[$language->code . '_address'] = $requiredOrNullable;
                $rules[$language->code . '_category_id'] = $requiredOrNullable;
                $rules[$language->code . '_state_id'] = $stateRule;
                $rules[$language->code . '_country_id'] = $countryRule;
                $rules[$language->code . '_city_id'] = $requiredOrNullable;
                $rules[$language->code . '_description'] = $descriptionRule;
                $rules[$language->code . '_aminities'] = $Amenities ? ($isDefault ? 'required' : 'nullable') . '|array|max:' . $aminitiesLimit : '';
                $rules[$language->code . '_feature_heading'] = 'sometimes|array|max:' . $additionalFeatureLimit;
            }

            return $rules;
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
