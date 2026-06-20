<?php

namespace App\Http\Helpers;

use App\Models\BasicSettings\Basic;
use App\Models\Language;
use App\Models\Listing\Listing;
use App\Models\Listing\ListingContent;
use App\Models\Listing\ListingProductContent;
use App\Models\Membership;
use App\Models\Package;
use Carbon\Carbon;
use Exception;
use Illuminate\Support\Facades\Config;

class VendorPermissionHelper
{

  public static function packagePermission(int $vendor_id)
  {
    $bs = Basic::first();
    Config::set('app.timezone', $bs->timezone);

    $currentPackage = Membership::query()->where([
      ['vendor_id', '=', $vendor_id],
      ['status', '=', 1],
      ['start_date', '<=', Carbon::now()->format('Y-m-d')],
      ['expire_date', '>=', Carbon::now()->format('Y-m-d')]
    ])->first();
    $package = isset($currentPackage) ? Package::query()->find($currentPackage->package_id) : null;
    return $package ? $package : collect([]);
  }

  public static function uniqidReal($lenght = 13)
  {
    $bs = Basic::first();
    // uniqid gives 13 chars, but you could adjust it to your needs.
    if (function_exists("random_bytes")) {
      $bytes = random_bytes(ceil($lenght / 2));
    } elseif (function_exists("openssl_random_pseudo_bytes")) {
      $bytes = openssl_random_pseudo_bytes(ceil($lenght / 2));
    } else {
      throw new Exception("no cryptographically secure random function available");
    }
    return substr(bin2hex($bytes), 0, $lenght);
  }

  public static function currentPackagePermission(int $userId)
  {
    $bs = Basic::first();
    Config::set('app.timezone', $bs->timezone);
    $currentPackage = Membership::query()->where([
      ['vendor_id', '=', $userId],
      ['status', '=', 1],
      ['start_date', '<=', Carbon::now()->format('Y-m-d')],
      ['expire_date', '>=', Carbon::now()->format('Y-m-d')]
    ])->first();
    return isset($currentPackage) ? Package::query()->findOrFail($currentPackage->package_id) : null;
  }
  public static function userPackage(int $userId)
  {
    $bs = Basic::first();
    Config::set('app.timezone', $bs->timezone);

    return Membership::query()->where([
      ['vendor_id', '=', $userId],
      ['status', '=', 1],
      ['start_date', '<=', Carbon::now()->format('Y-m-d')],
      ['expire_date', '>=', Carbon::now()->format('Y-m-d')]
    ])->first();
  }

  public static function currPackageOrPending($userId)
  {

    $currentPackage = Self::currentPackagePermission($userId);
    if (!$currentPackage) {
      $currentPackage = Membership::query()->where([
        ['vendor_id', '=', $userId],
        ['status', 0]
      ])->whereYear('start_date', '<>', '9999')->orderBy('id', 'DESC')->first();
      $currentPackage = isset($currentPackage) ? Package::query()->findOrFail($currentPackage->package_id) : null;
    }
    return isset($currentPackage) ? $currentPackage : null;
  }

  public static function currMembOrPending($userId)
  {
    $currMemb = Self::userPackage($userId);
    if (!$currMemb) {
      $currMemb = Membership::query()->where([
        ['vendor_id', '=', $userId],
        ['status', 0],
      ])->whereYear('start_date', '<>', '9999')->orderBy('id', 'DESC')->first();
    }
    return isset($currMemb) ? $currMemb : null;
  }

  public static function hasPendingMembership($userId)
  {
    $count = Membership::query()->where([
      ['vendor_id', '=', $userId],
      ['status', 0]
    ])->whereYear('start_date', '<>', '9999')->count();
    return $count > 0 ? true : false;
  }

  public static function nextPackage(int $userId)
  {
    $bs = Basic::first();
    Config::set('app.timezone', $bs->timezone);
    $currMemb = Membership::query()->where([
      ['vendor_id', $userId],
      ['start_date', '<=', Carbon::now()->toDateString()],
      ['expire_date', '>=', Carbon::now()->toDateString()]
    ])->where('status', '<>', 2)->whereYear('start_date', '<>', '9999');
    $nextPackage = null;
    if ($currMemb->first()) {
      $countCurrMem = $currMemb->count();
      if ($countCurrMem > 1) {
        $nextMemb = $currMemb->orderBy('id', 'DESC')->first();
      } else {
        $nextMemb = Membership::query()->where([
          ['vendor_id', $userId],
          ['start_date', '>', $currMemb->first()->expire_date]
        ])->whereYear('start_date', '<>', '9999')->where('status', '<>', 2)->first();
      }
      $nextPackage = $nextMemb ? Package::query()->where('id', $nextMemb->package_id)->first() : null;
    }
    return $nextPackage;
  }

  public static function nextMembership(int $userId)
  {
    $bs = Basic::first();
    Config::set('app.timezone', $bs->timezone);
    $currMemb = Membership::query()->where([
      ['vendor_id', $userId],
      ['start_date', '<=', Carbon::now()->toDateString()],
      ['expire_date', '>=', Carbon::now()->toDateString()]
    ])->where('status', '<>', 2)->whereYear('start_date', '<>', '9999');
    $nextMemb = null;
    if ($currMemb->first()) {
      $countCurrMem = $currMemb->count();
      if ($countCurrMem > 1) {
        $nextMemb = $currMemb->orderBy('id', 'DESC')->first();
      } else {
        $nextMemb = Membership::query()->where([
          ['vendor_id', $userId],
          ['start_date', '>', $currMemb->first()->expire_date]
        ])->whereYear('start_date', '<>', '9999')->where('status', '<>', 2)->first();
      }
    }
    return $nextMemb;
  }

  public static function packagesDowngraded($vendorId)
  {
    $userCurrentPackage =  VendorPermissionHelper::currentPackagePermission($vendorId);
    $defLanguage = Language::query()->where('is_default', '=', 1)->first();

    $listingImgDown = $listingProductDown = $listingFaqDown = $featureDown = $socialLinkDown = $amenitieDown = $listingProductImgDown = false;
    $listingImgListingContents = $listingProductListingContents = $listingFaqListingContents = $listingFeaturesListingContents = $socialListingContents = $amenitieListingContents = $ProductImgContents = null;
    $projectSpeciCount = 0;
    if ($userCurrentPackage) {


      $features = json_decode($userCurrentPackage->features);

      $listingImage = Listing::with(['galleries'])->where('vendor_id', $vendorId)->get();
      if ($listingImage) {
        foreach ($listingImage as $listing) {
          $pimages = $listing->galleries;


          if ($userCurrentPackage->number_of_images_per_listing < count($pimages)) {
            $listingImgDown = true;
            break;
          }
        }

        $listingImgIds = [];
        foreach ($listingImage as $listing) {
          $pimages = $listing->galleries;

          if ($userCurrentPackage->number_of_images_per_listing < count($pimages)) {

            if (!in_array($listing->id, $listingImgIds)) {
              array_push($listingImgIds, $listing->id);
            }
          }
        }
        $image = "ok";
        $listingImgListingContents = ListingContent::join('listings', 'listings.id', '=', 'listing_contents.listing_id')
          ->where('listing_contents.language_id', $defLanguage->id)
          ->when($image, function ($query) use ($listingImgIds) {
            return $query->whereIn('listings.id', $listingImgIds);
          })
          ->select('listings.id', 'listing_contents.title')
          ->orderBy('listings.id', 'asc')
          ->get();
      }

      if ($features && in_array('Products', $features)) {

        //products image check 
        $listingProductImages = Listing::with(['listingProducts'])->where('vendor_id', $vendorId)->get();
        if ($listingProductImages) {
          foreach ($listingProductImages as $listingProductImage) {
            $listingProductss = $listingProductImage->listingProducts;

            foreach ($listingProductss as $listingProduct) {

              $ProductImages = $listingProduct->galleries;

              if ($userCurrentPackage->number_of_images_per_products < count($ProductImages)) {
                $listingProductImgDown = true;
                break;
              }
            }
          }
          $listingProductImgIds = [];
          foreach ($listingProductImages as $listingProductImage) {
            $listingProductss = $listingProductImage->listingProducts;

            foreach ($listingProductss as $listingProduct) {

              $ProductImages = $listingProduct->galleries;

              if ($userCurrentPackage->number_of_images_per_products < count($ProductImages)) {
                if (!in_array($listingProduct->id, $listingProductImgIds)) {
                  array_push($listingProductImgIds, $listingProduct->id);
                }
              }
            }
          }

          $productImage = "ok";
          $ProductImgContents = ListingProductContent::join('listing_products', 'listing_products.id', '=', 'listing_product_contents.listing_product_id')
            ->where('listing_product_contents.language_id', $defLanguage->id)
            ->when($productImage, function ($query) use ($listingProductImgIds) {
              return $query->whereIn('listing_products.id', $listingProductImgIds);
            })
            ->select('listing_products.id', 'listing_product_contents.title')
            ->orderBy('listing_products.id', 'asc')
            ->get();
        }
        //end product image check 
      }



      //check Products limit
      if ($features && in_array('Products', $features)) {
        $listingProducts = Listing::with(['listingProducts'])->where('vendor_id', $vendorId)->get();
        if ($listingProducts) {

          foreach ($listingProducts as $product) {
            $products = $product->listingProducts;

            if ($userCurrentPackage->number_of_products < count($products)) {
              $listingProductDown = true;
              break;
            }
          }

          $listingProductIds = [];
          foreach ($listingProducts as $product) {
            $products = $product->listingProducts;

            if ($userCurrentPackage->number_of_products < count($products)) {

              if (!in_array($product->id, $listingProductIds)) {
                array_push($listingProductIds, $product->id);
              }
            }
          }
          $prouct = "ok";
          $listingProductListingContents = ListingContent::join('listings', 'listings.id', '=', 'listing_contents.listing_id')
            ->where('listing_contents.language_id', $defLanguage->id)
            ->when($prouct, function ($query) use ($listingProductIds) {
              return $query->whereIn('listings.id', $listingProductIds);
            })
            ->select('listings.id', 'listing_contents.title')
            ->orderBy('listings.id', 'asc')
            ->get();
        }
      }
      //check faqs limit

      if ($features && in_array('FAQ', $features)) {

        $languages  = Language::all();
        foreach ($languages as $language) {
          $language_id = $language->id;
          $listingFaqs = Listing::with(['listingFaqs' => function ($q) use ($language_id) {
            $q->where('language_id', $language_id);
          }])
            ->where('listings.vendor_id', $vendorId)
            ->orderBy('listings.id', 'desc')
            ->get();



          if ($listingFaqs) {

            foreach ($listingFaqs as $faq) {
              $faqs = $faq->listingFaqs;

              if ($userCurrentPackage->number_of_faq < count($faqs)) {
                $listingFaqDown = true;
                break;
              }
            }
            $listingFaqIds = [];
            foreach ($listingFaqs as $faq) {
              $faqs = $faq->listingFaqs;

              if ($userCurrentPackage->number_of_faq < count($faqs)) {

                if (!in_array($faq->id, $listingFaqIds)) {
                  array_push($listingFaqIds, $faq->id);
                }
              }
            }
            $faqstatus = "ok";
            $listingFaqListingContents = ListingContent::join('listings', 'listings.id', '=', 'listing_contents.listing_id')
              ->where('listing_contents.language_id', $defLanguage->id)
              ->when($faqstatus, function ($query) use ($listingFaqIds) {
                return $query->whereIn('listings.id', $listingFaqIds);
              })
              ->select('listings.id', 'listing_contents.title')
              ->orderBy('listings.id', 'asc')
              ->get();
          }
        }
      }
      if ($features && in_array('Feature', $features)) {
        $ListingFeatures = Listing::with('specifications')->where('vendor_id', $vendorId)->select('id')->get();
        if ($ListingFeatures) {
          foreach ($ListingFeatures as $Feature) {

            $projectSpeciCount =  $Feature->specifications->count();

            if ($userCurrentPackage->number_of_additional_specification < $projectSpeciCount) {
              $featureDown = true;
              break;
            }
          }
          $listingFeatureIds = [];
          foreach ($ListingFeatures as $Feature) {
            $projectSpeciCount =  $Feature->specifications->count();

            if ($userCurrentPackage->number_of_additional_specification < $projectSpeciCount) {

              if (!in_array($Feature->id, $listingFeatureIds)) {
                array_push($listingFeatureIds, $Feature->id);
              }
            }
          }
          $feature = "ok";
          $listingFeaturesListingContents = ListingContent::join('listings', 'listings.id', '=', 'listing_contents.listing_id')
            ->where('listing_contents.language_id', $defLanguage->id)
            ->when($feature, function ($query) use ($listingFeatureIds) {
              return $query->whereIn('listings.id', $listingFeatureIds);
            })
            ->select('listings.id', 'listing_contents.title')
            ->orderBy('listings.id', 'asc')
            ->get();
        }
      }

      if ($features && in_array('Social Links', $features)) {
        $ListingSocialLinks = Listing::with('sociallinks')->where('vendor_id', $vendorId)->select('id')->get();

        if ($ListingSocialLinks) {
          foreach ($ListingSocialLinks as $socail) {

            $socialCount =  $socail->sociallinks->count();

            if ($userCurrentPackage->number_of_social_links < $socialCount) {
              $socialLinkDown = true;
              break;
            }
          }
          $listingsocialIds = [];
          foreach ($ListingSocialLinks as $socail) {
            $socialCount =  $socail->sociallinks->count();

            if ($userCurrentPackage->number_of_social_links < $socialCount) {

              if (!in_array($socail->id, $listingsocialIds)) {
                array_push($listingsocialIds, $socail->id);
              }
            }
          }
          $social = "ok";
          $socialListingContents = ListingContent::join('listings', 'listings.id', '=', 'listing_contents.listing_id')
            ->where('listing_contents.language_id', $defLanguage->id)
            ->when($social, function ($query) use ($listingsocialIds) {
              return $query->whereIn('listings.id', $listingsocialIds);
            })
            ->select('listings.id', 'listing_contents.title')
            ->orderBy('listings.id', 'asc')
            ->get();
        }
      }

      // // check listing amenities are down graded
      if ($features && in_array('Amenities', $features)) {
        $ListingAmenities = Listing::with('listing_content')->where('vendor_id', $vendorId)->select('id')->get();
        if ($ListingAmenities) {
          foreach ($ListingAmenities as $ListingAmenitie) {

            foreach ($ListingAmenitie->listing_content as $content) {
              if ($content->aminities) {
                $amenities = json_decode($content->aminities);

                if ($userCurrentPackage->number_of_amenities_per_listing < count($amenities)) {
                  $amenitieDown = true;
                  break;
                }
              }
            }
          }

          $listingaminitiesIds = [];
          foreach ($ListingAmenities as $ListingAmenitie) {

            foreach ($ListingAmenitie->listing_content as $content) {
              if ($content->aminities) {
                $amenities = json_decode($content->aminities);

                if ($userCurrentPackage->number_of_amenities_per_listing < count($amenities)) {
                  if (!in_array($ListingAmenitie->id, $listingaminitiesIds)) {
                    array_push($listingaminitiesIds, $ListingAmenitie->id);
                  }
                }
              }
            }
          }

          $amenitie = "ok";
          $amenitieListingContents = ListingContent::join('listings', 'listings.id', '=', 'listing_contents.listing_id')
            ->where('listing_contents.language_id', $defLanguage->id)
            ->when($amenitie, function ($query) use ($listingaminitiesIds) {
              return $query->whereIn('listings.id', $listingaminitiesIds);
            })
            ->select('listings.id', 'listing_contents.title')
            ->orderBy('listings.id', 'asc')
            ->get();
        }
      }
    }

    return [
      'listingImgDown' => $listingImgDown,
      'listingImgListingContents' => $listingImgListingContents,
      'listingProductDown' => $listingProductDown,
      'listingProductListingContents' => $listingProductListingContents,
      'listingFaqDown' => $listingFaqDown,
      'listingFaqListingContents' => $listingFaqListingContents,
      'featureDown' => $featureDown,
      'listingFeaturesListingContents' => $listingFeaturesListingContents,
      'socialLinkDown' => $socialLinkDown,
      'socialListingContents' => $socialListingContents,
      'amenitieDown' => $amenitieDown,
      'amenitieListingContents' => $amenitieListingContents,
      'listingProductImgDown' => $listingProductImgDown,
      'ProductImgContents' => $ProductImgContents,
    ];
  }
}
