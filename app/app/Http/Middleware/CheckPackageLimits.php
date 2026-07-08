<?php

namespace App\Http\Middleware;

use App\Http\Helpers\VendorPermissionHelper;
use App\Models\Language;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingFaq;
use App\Models\Listing\ListingProduct;
use App\Models\Shop\Product;
use App\Models\Vendor;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CheckPackageLimits
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next, $feature, $method)
    {
        if (Auth::check()) {

            if (Auth::guard('vendor')->user()) {
                $vendor = Vendor::find(Auth::guard('vendor')->user()->id);
            } elseif (Auth::guard('agent')->user()) {
                return redirect()->route('index');
            }

            $package = VendorPermissionHelper::currentPackagePermission($vendor->id);

            if (empty($package)) {
                return redirect()->route('vendor.dashboard');
            }
            $vendorTotalListing = vendorTotalListing($vendor->id);
            $totalFaq = ListingFaq::where('listing_id', $request->listing_id)
                ->where('language_id', $request->language_id)
                ->count();
            // $totalProduct = ListingProduct::join('listing_product_contents', 'listing_products.id', '=', 'listing_product_contents.listing_product_id')
            //     ->where('listing_products.listing_id', $request->listing_id)
            //     ->where('listing_product_contents.language_id', $request->language_id)
            //     ->count();
            $totalProduct = Product::where('vendor_id', $vendor->id)->count();

            $features = json_decode($package->features);

            if ($features) {
                if ($method == 'store') {

                    if ($feature == 'listing') {

                        if (($package->number_of_listing > $vendorTotalListing) && $this->checkFeaturesNotDowngraded($vendor->id, $feature, $package, $vendorTotalListing)) {
                            return $next($request);
                        } else {
                            return response()->json('downgrade');
                        }
                    }

                    if ($feature == 'faq') {

                        if (($package->number_of_faq > $totalFaq) && $this->checkFeaturesNotDowngraded($vendor->id, $feature, $package, $totalFaq)) {
                            return $next($request);
                        } else {
                            return response()->json('downgrade');
                        }
                    }
                    if ($feature == 'product') {

                        if (($package->number_of_products > $totalProduct) && $this->checkFeaturesNotDowngraded($vendor->id, $feature, $package, $totalProduct)) {
                            return $next($request);
                        } else {
                            return response()->json('downgrade');
                        }
                    }
                }

                if ($method == 'update') {
                    if ($feature == 'listing') {

                        if (($package->number_of_listing >= $vendorTotalListing) && $this->checkFeaturesNotDowngraded($vendor->id, $feature, $package, $vendorTotalListing)) {
                            return $next($request);
                        } else {
                            return response()->json('downgrade');
                        }
                    }
                }
            } else {
                if ($this->checkFeaturesNotDowngraded($vendor->id, $feature, $package, $vendorTotalListing)) {
                    return $next($request);
                } else {
                    return response()->json('downgrade');
                }
            }
        }
    }
    private function checkFeaturesNotDowngraded($vendorId, $feature, $package, $userFeaturesCount)
    {
        $return = true;
        $vendor = Vendor::find(Auth::guard('vendor')->user()->id);
        $vendorTotalListing = vendorTotalListing($vendor->id);

        $features = json_decode($package->features);


        if ($feature != 'listing') {
            if ($package->number_of_listing != 999999 && $package->number_of_listing < $vendorTotalListing) {
                return  $return = false;
            }
        }

        // images and additional specofication check 
        $listingImage = Listing::with(['galleries'])->where('vendor_id', $vendorId)->get();
        if ($listingImage) {
            foreach ($listingImage as $listing) {
                $listingImgCount = $listing->galleries()->count();

                if ($package->number_of_images_per_listing != 999999 && ($package->number_of_images_per_listing < $listingImgCount)) {
                    return  $return = false;
                }
            }
        }

        // if ($features && in_array('Products', $features)) {
        //     $listingProducts = Listing::with(['listingProducts'])->where('vendor_id', $vendorId)->get();
        //     if ($listingProducts) {
        //         foreach ($listingProducts as $product) {
        //             $products = $product->listingProducts;

        //             if ($package->number_of_products < count($products)) {
        //                 return  $return = false;
        //             }
        //         }
        //     }
        // }

        if ($features && in_array('Products', $features)) {
            $products = Product::where('vendor_id', $vendorId)->count();
            if ($products) {
                    if ($package->number_of_products != 999999 && $package->number_of_products < $products) {
                        return  $return = false;
                    }
            }
        }

        if ($features && in_array('Feature', $features)) {
            $ListingFeatures = Listing::with('specifications')->where('vendor_id', $vendorId)->select('id')->get();

            if ($ListingFeatures) {
                foreach ($ListingFeatures as $Feature) {

                    $projectSpeciCount =  $Feature->specifications->count();

                    if ($package->number_of_additional_specification < count($Feature->specifications)) {
                        return  $return = false;
                    }
                }
            }
        }

        if ($features && in_array('Social Links', $features)) {
            $ListingSocialLinks = Listing::with('sociallinks')->where('vendor_id', $vendorId)->select('id')->get();
            if ($ListingSocialLinks) {
                foreach ($ListingSocialLinks as $socail) {

                    $socialCount =  $socail->sociallinks->count();

                    if ($package->number_of_social_links < $socialCount) {
                        return  $return = false;
                    }
                }
            }
        }

        if ($features && in_array('Amenities', $features)) {
            $ListingAmenities = Listing::with('listing_content')->where('vendor_id', $vendorId)->select('id')->get();
            if ($ListingAmenities) {
                foreach ($ListingAmenities as $ListingAmenitie) {

                    foreach ($ListingAmenitie->listing_content as $content) {
                        if ($content->aminities) {
                            $amenities = json_decode($content->aminities);

                            if ($package->number_of_amenities_per_listing < count($amenities)) {
                                return  $return = false;
                            }
                        }
                    }
                }
            }
        }
        if ($features && in_array('FAQ', $features)) {
            $languages  = Language::all();
            foreach ($languages as $language) {
                $language_id = $language->id;
                $listingFaqs = Listing::with(['listingFaqs' => function ($q) use ($language_id) {
                    $q->where('language_id', $language_id);
                }])
                    ->where('vendor_id', $vendorId)
                    ->orderBy('listings.id', 'desc')
                    ->paginate(10);

                if ($listingFaqs) {
                    foreach ($listingFaqs as $faq) {
                        $faqs = $faq->listingFaqs;

                        if ($package->number_of_faq < count($faqs)) {
                            return  $return = false;
                        }
                    }
                }
            }
        }

        // if ($features && in_array('Products', $features)) {
        //     $listingProductImages = Listing::with(['listingProducts'])->where('vendor_id', $vendorId)->get();
        //     if ($listingProductImages) {
        //         foreach ($listingProductImages as $listingProductImage) {
        //             $listingProductss = $listingProductImage->listingProducts;

        //             foreach ($listingProductss as $listingProduct) {

        //                 $ProductImages = $listingProduct->galleries;

        //                 if ($package->number_of_images_per_products < count($ProductImages)) {
        //                     return  $return = false;
        //                 }
        //             }
        //         }
        //     }
        // }

        if ($features && in_array('Products', $features)) {
            $productImages = Product::where('vendor_id', $vendorId)->get();

            if ($productImages) {                
                foreach ($productImages as $productImage) {
                    $sliderImages = $productImage->slider_images ? json_decode($productImage->slider_images, true) : [];

                    $imageCount = is_array($sliderImages) ? count($sliderImages) : 0;

                        if ($package->number_of_images_per_products > 0 && $package->number_of_images_per_products < $imageCount) {
                            return  $return = false;
                        }
                }
            }
        }

        return $return;
    }
}
