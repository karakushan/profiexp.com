<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\ApiHelper\HelperController;
use App\Http\Controllers\Controller;
use App\Models\BasicSettings\Basic;
use App\Models\BasicSettings\PageHeading;
use App\Models\Car\Wishlist;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class WishlistController extends Controller
{

  public function index(Request $request)
  {

    $language = HelperController::getLanguage($request);
    $information['page_title'] = PageHeading::where('language_id', $language->id)->pluck('wishlist_page_title')->first();

    $basic_settings = Basic::query()->select('breadcrumb')->first();
    $information['breadcrumb'] = asset('assets/img/' . $basic_settings->breadcrumb);

    $user = Auth::guard('sanctum')->user();
    $user_id = $user->id;
    $wishlists = Wishlist::where('user_id', $user_id)
      ->join('listings', 'listings.id', '=', 'wishlists.listing_id')
      ->leftjoin('listing_contents', function ($join) use ($language) {
        $join->on('listing_contents.listing_id', '=', 'listings.id')
          ->where('listing_contents.language_id', $language->id);
      })
      ->when('listings.vendor_id' != "0", function ($query) {
        return $query->leftJoin('memberships', 'listings.vendor_id', '=', 'memberships.vendor_id')
          ->where(function ($query) {
            $query->where([
              ['memberships.status', '=', 1],
              ['memberships.start_date', '<=', now()->format('Y-m-d')],
              ['memberships.expire_date', '>=', now()->format('Y-m-d')],
            ])->orWhere('listings.vendor_id', '=', 0);
          });
      })
      ->when('listings.vendor_id' != "0", function ($query) {
        return $query->leftJoin('vendors', 'listings.vendor_id', '=', 'vendors.id')
          ->where(function ($query) {
            $query->where([
              ['vendors.status', '=', 1],
            ])->orWhere('listings.vendor_id', '=', 0);
          });
      })
      ->select('listings.*', 'listing_contents.title', 'wishlists.listing_id', 'wishlists.id as wishlist_id')
      ->get()
      ->map(function ($item) use ($language) {
        return HelperController::formatWishlistForApi($item, $language->id);
      });
    $information['wishlists'] = $wishlists;
    return response()->json([
      'success' => true,
      'data'    => $information
    ],200);
  }

  public function store(Request $request)
  {
   $user =  Auth::guard('sanctum')->user();

    if (!$user) {
      return response()->json([
        'success' => false,
        'message' => 'Unauthenticated.'
      ], 401);
    }
    $rules = [
      'listing_id' => 'required'
    ];

    $validator = Validator::make($request->all(), $rules);
    if ($validator->fails()) {
      return response()->json([
        'status' => 'validation_error',
        'errors' => $validator->errors()
      ], 422);
    }

      $user_id = $user->id;
      $listing_id = $request->listing_id;

      $check = Wishlist::where('listing_id', $listing_id)
      ->where('user_id', $user_id)
      ->first();
      if (!empty($check)) {
        return response()->json([
          'status' => false,
          'message' => __('This list is already in your wishlist.')
        ]);
      } else {
        $add = new Wishlist;
        $add->listing_id = $listing_id;
        $add->user_id = $user_id;
        $add->save();

        return response()->json([
          'status' => true,
          'message' => __('Added to your wishlist successfully')
        ],200);

      }
  }

  public function delete(Request $request)
  {
    $rules = [
      'listing_id' => 'required'
    ];
    $validator = Validator::make($request->all(), $rules);
    if ($validator->fails()) {
      return response()->json([
        'status' => 'validation_error',
        'errors' => $validator->errors()
      ], 422);
    }

    $listing_id = $request->listing_id;

    if (Auth::guard('sanctum')->user()) {
      $remove = Wishlist::where('listing_id', $listing_id)->first();
      if ($remove) {
        $remove->delete();
        return response()->json([
          'success' => true,
          'message' => __('Removed From wishlist successfully'),
        ]);
      } else {
        return response()->json([
          'success' => false,
          'message' => __('List item not found!'),
        ]);
      }
    } else {
      return response()->json([
        'success' => false,
        'message' => __('Unauthenticated. please login then remove wishlist'),
      ]);
    }
  }

}
