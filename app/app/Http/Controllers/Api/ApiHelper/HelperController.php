<?php

namespace App\Http\Controllers\Api\ApiHelper;

use App\Http\Controllers\Controller;
use App\Models\Admin;
use App\Models\Language;
use App\Models\Location\City;
use App\Models\Location\Country;
use App\Models\Location\State;
use App\Models\Vendor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use stdClass;

class HelperController extends Controller
{
    public static function getLanguage($request)
    {

        $locale = $request->header('Accept-Language');
        $language = $locale ? Language::where('code', $locale)->first() : Language::where('is_default', 1)->first();
        return $language;
    }
    public static function formatListForApi($list, $language)
    {

        $obj = new stdClass();
        $obj->id = $list->id;
        if ($list->vendor_id == null || $list->vendor_id == 0) {
            $admin = Admin::first();
            $obj->vendor_username  = $admin->username;
            $obj->vendor_name =  $admin->first_name . ' ' . $admin->last_name;
            $obj->vendor_image = !empty($admin->image) ? asset('assets/img/admins/' . $admin->image) : asset('assets/img/blank_user.jpg');
            $obj->author_type = 'admin';
        } else {
            $vendor = Vendor::with('vendor_info')->find($list->vendor_id);
            $vendorInfo = $vendor->vendor_info()->where('language_id', $language)->first();
            $obj->vendor_username = !empty($vendor) ? $vendor->username : "";
            $obj->vendor_name =  !empty($vendorInfo) ?  $vendorInfo->name : "";
            $obj->vendor_image = !empty($vendor) ? asset('assets/admin/img/vendor-photo/' . $vendor->photo) : asset('assets/img/blank_user.jpg');
            $obj->author_type = 'vendor';
        }

        if (!empty($list->city_id)) {
            $city = City::find($list->city_id);
        }
        if (!empty($list->state_id)) {
            $state = State::find($list->state_id);
        }
        if (!empty($list->country_id)) {
            $country = Country::find($list->country_id);
        }

        $obj->address =  implode(",", array_filter([
            $city->name ?? null,
            $state->name ?? null,
            $country->name ?? null
        ]));
        $obj->total_review = totalListingReview($list->id);
        $obj->average_review = $list->average_rating;
        $obj->min_price = symbolPrice($list->min_price);
        $obj->max_price = symbolPrice($list->max_price);
        $obj->wishlist_status =  Auth::guard('sanctum')->check() ? checkWishList($list->id, Auth::guard('sanctum')->user()->id) : 0;
        $obj->feature_image = asset('assets/img/listing/' .  $list->feature_image);
        $obj->title = $list->title;
        $obj->slug = $list->slug;
        $obj->category_name = $list->category_name;
        $obj->category_icon = $list->icon;
        $obj->category_slug = $list->category_slug;
        $obj->latitude = $list->latitude;
        $obj->longitude = $list->longitude;

        return $obj;
    }

    public static function getImagePath($path, $image)
    {
        if (!empty($image)) {
            return asset("$path$image");
        }
        return null;
    }

    public static function formatVendorForApi($vendor_id, $language, $type)
    {
        $obj = new stdClass();
        if ($type == 'vendor') {
            $vendor = Vendor::with('vendor_info')->find($vendor_id);
            $vendorInfo = $vendor->vendor_info()->where('language_id', $language)->first();
            $obj->vendor_username = !empty($vendor) ? $vendor->username : "";
            $obj->vendor_email  = $vendor->email;
            $obj->vendor_phone  = $vendor->phone;
            $obj->vendor_name =  !empty($vendorInfo) ?  $vendorInfo->name : "";
            $obj->vendor_image = !empty($vendor) ? asset('assets/admin/img/vendor-photo/' . $vendor->photo) : asset('assets/img/blank_user.jpg');
        } else {
            $admin = Admin::first();
            $obj->vendor_username  = $admin->username;
            $obj->vendor_email  = $admin->email;
            $obj->vendor_phone  = $admin->phone;
            $obj->vendor_name =  $admin->first_name . ' ' . $admin->last_name;
            $obj->vendor_image = !empty($admin->image) ? asset('assets/img/admins/' . $admin->image) : asset('assets/img/blank_user.jpg');
        }
        $obj->auhtor_type = $type;
        return $obj;
    }

    public static function formatWishlistForApi($list, $language_id)
    {

        $obj = new stdClass();
        $obj->id = $list->wishlist_id;
        $obj->listing_id = $list->listing_id;
        $obj->feature_image = asset('assets/img/listing/' .  $list->feature_image);
        $obj->title = $list->title;
        $obj->average_rating = $list->average_rating;
        $obj->min_price = $list->min_price;
        $obj->max_price = $list->max_price;
        return $obj;
    }

    public static function formetProductForApi($product)
    {

        $obj = new stdClass();
        $obj->id = $product->id;
        $obj->title = $product->title;
        $obj->average_rating = $product->average_rating;
        $obj->slug = $product->slug;
        $obj->current_price = $product->current_price;
        $obj->previous_price = $product->previous_price;
        $obj->product_type = $product->product_type;
        $obj->stock = $product->stock;
        $obj->placement_type = $product->placement_type;
        $obj->featured_image = asset('assets/img/products/featured-images/' .  $product->featured_image);
        return $obj;
    }
}
