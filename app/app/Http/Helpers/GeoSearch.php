<?php

namespace App\Http\Helpers;

use App\Models\Listing\Listing;
use App\Models\Listing\ListingContent;
use App\Models\Location\CityContent;
use App\Models\Location\CountryContent;
use App\Models\Location\StateContent;

class GeoSearch
{
  public static function getCoordinates($address, $apiKey, ?string $languageCode = null)
  {
    $query = [
      'address' => $address,
      'key' => $apiKey,
    ];

    if ($languageCode) {
      $query['language'] = $languageCode;
    }

    $url = 'https://maps.googleapis.com/maps/api/geocode/json?' . http_build_query($query);

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    $response = curl_exec($ch);
    curl_close($ch);

    $data = json_decode($response, true);

    if (is_array($data) && ($data['status'] ?? null) === 'OK') {
      $location = $data['results'][0]['geometry']['location'];
      return [
        'lat' => $location['lat'],
        'lng' => $location['lng']
      ];
    } else {
      return [
        'error' => $data['status'] ?? 'UNKNOWN_ERROR'
      ];
    }
  }

  /**
   * Resolve a user-facing location into listing IDs without comparing a
   * localized full address with the source-language address.
   */
  public static function findListingIds(
    string $location,
    int $languageId,
    string $languageCode,
    bool $googleMapsEnabled,
    ?string $apiKey,
    int|float $radius
  ): array {
    if ($googleMapsEnabled && !empty($apiKey)) {
      $geoResult = self::getCoordinates($location, $apiKey, $languageCode);

      if (isset($geoResult['lat'], $geoResult['lng'])) {
        $coordinates = [
          'lat' => $geoResult['lat'],
          'lng' => $geoResult['lng'],
        ];

        $ids = Listing::query()
          ->where('status', 1)
          ->where('visibility', 1)
          ->whereNotNull('latitude')
          ->whereNotNull('longitude')
          ->whereRaw(
            '(6371000 * acos(cos(radians(?)) * cos(radians(latitude)) * cos(radians(longitude) - radians(?)) + sin(radians(?)) * sin(radians(latitude)))) <= ?',
            [$coordinates['lat'], $coordinates['lng'], $coordinates['lat'], $radius]
          )
          ->pluck('id')
          ->all();

        return ['ids' => $ids, 'coordinates' => $coordinates];
      }

      return ['ids' => [], 'coordinates' => []];
    }

    $seedIds = self::findListingIdsByLocationNames($location, $languageId);
    if (empty($seedIds)) {
      return ['ids' => [], 'coordinates' => []];
    }

    $firstListing = Listing::query()
      ->whereIn('id', $seedIds)
      ->whereNotNull('latitude')
      ->whereNotNull('longitude')
      ->first(['latitude', 'longitude']);

    if (!$firstListing) {
      return ['ids' => $seedIds, 'coordinates' => []];
    }

    $coordinates = [
      'lat' => $firstListing->latitude,
      'lng' => $firstListing->longitude,
    ];

    $ids = Listing::query()
      ->where('status', 1)
      ->where('visibility', 1)
      ->whereNotNull('latitude')
      ->whereNotNull('longitude')
      ->whereRaw(
        '(6371000 * acos(cos(radians(?)) * cos(radians(latitude)) * cos(radians(longitude) - radians(?)) + sin(radians(?)) * sin(radians(latitude)))) <= ?',
        [$coordinates['lat'], $coordinates['lng'], $coordinates['lat'], $radius]
      )
      ->pluck('id')
      ->all();

    return ['ids' => $ids, 'coordinates' => $coordinates];
  }

  private static function findListingIdsByLocationNames(string $location, int $languageId): array
  {
    $needle = mb_strtolower($location);
    $cityIds = self::findLocationIds($needle, CityContent::query()->where('language_id', $languageId)->get(['city_id', 'name']), 'city_id');
    $stateIds = self::findLocationIds($needle, StateContent::query()->where('language_id', $languageId)->get(['state_id', 'name']), 'state_id');
    $countryIds = self::findLocationIds($needle, CountryContent::query()->where('language_id', $languageId)->get(['country_id', 'name']), 'country_id');

    if (empty($cityIds) && empty($stateIds) && empty($countryIds)) {
      return [];
    }

    return ListingContent::query()
      ->where(function ($query) use ($cityIds, $stateIds, $countryIds) {
        if (!empty($cityIds)) {
          $query->whereIn('city_id', $cityIds);
        }
        if (!empty($stateIds)) {
          $query->orWhereIn('state_id', $stateIds);
        }
        if (!empty($countryIds)) {
          $query->orWhereIn('country_id', $countryIds);
        }
      })
      ->pluck('listing_id')
      ->unique()
      ->values()
      ->all();
  }

  private static function findLocationIds(string $needle, $contents, string $idColumn): array
  {
    return $contents
      ->filter(function ($content) use ($needle) {
        $name = trim((string) $content->name);

        return mb_strlen($name) >= 2 && str_contains($needle, mb_strtolower($name));
      })
      ->pluck($idColumn)
      ->all();
  }

  public static function getDistance($lat1, $lon1, $lat2, $lon2)
  {
    $earthRadius = 6371; // Radius of Earth in kilometers

    $dLat = deg2rad($lat2 - $lat1);
    $dLon = deg2rad($lon2 - $lon1);

    $a = sin($dLat / 2) * sin($dLat / 2) +
      cos(deg2rad($lat1)) * cos(deg2rad($lat2)) *
      sin($dLon / 2) * sin($dLon / 2);

    $c = 2 * atan2(sqrt($a), sqrt(1 - $a));

    $distance = $earthRadius * $c;
    return floatval($distance); // in kilometers
  }
}
