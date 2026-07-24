"use strict";
let geocoder;
let isSubmitting = false;

window.initMap = function () {
  geocoder = new google.maps.Geocoder();
}


// Function to update URL and submit form
function updateLocationUrl(data) {

  let newUrl = new URL(window.location);
  if (data === "location_val") {
    const location = String($('#location_val').val() || '').trim();
    if (!location || location === 'undefined') {
      return;
    }
    newUrl.searchParams.set('location', location);
  } else {
    newUrl.searchParams.delete('location');
  }
  window.history.replaceState({}, '', newUrl);

  // Submit the form and prevent multiple submissions
  if (!isSubmitting) {
    isSubmitting = true;
    $('#searchForm').submit();
    $(".request-loader").addClass("show");
  }
}

// Function to handle the search process
function handleSearch(typedLocation = null) {
  const locationValue = String(typedLocation || $('#location').val() || '').trim();

  // Check if the form is already submitting
  if (isSubmitting) {
    return;
  }

  if ((!locationValue || locationValue === 'undefined') && !isSubmitting) {
    $('#location_val').val('');
    updateLocationUrl(); // Reset URL if location is blank
    isSubmitting = true;
  } else if (locationValue && !isSubmitting) {
    window.lastLocationSearchValue = locationValue;
    document.getElementById('location_val').value = locationValue;
    updateLocationUrl("location_val");
  }
}

// Geocode latitude and longitude to get the address
function geocodeLatLng(latLng) {
  geocoder.geocode({ location: latLng }, function (results, status) {
    if (status === 'OK') {
      if (results[0]) {

        $('#location').val(results[0].formatted_address);
        $('#location_val').val(results[0].formatted_address);
        updateLocationUrl("location_val");

      } else {
        console.log('No results found');
      }
    } else {
      console.log('Geocoder failed due to: ' + status);
    }
  });
}

// Get the user's current location
function getCurrentLocation() {
  const $sortSelect = $('#select_sort');

  // Prepend new options
  $sortSelect.prepend(`
    <option value="close-by" selected>
      ${$sortSelect.data('close-text') || 'Distance: Closest first'}
    </option>
    <option value="distance-away">
      ${$sortSelect.data('far-text') || 'Distance: Farthest first'}
    </option>
  `);

  $sortSelect.niceSelect('destroy');
  $sortSelect.niceSelect();
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function (position) {
      const latLng = { lat: position.coords.latitude, lng: position.coords.longitude };
      console.log(latLng);
      geocodeLatLng(latLng);
    }, function (error) {
      alert("Unable to retrieve your location. Error: " + error.message);
    });
  } else {
    alert("Geolocation is not supported by this browser.");
  }
}

// Reset the isSubmitting flag when the form submission is completed
$('#searchForm').on('submit', function () {
  setTimeout(() => {
    isSubmitting = false
  }, 300);
});
if (typeof google !== "undefined" && google.maps) {
  if (typeof initMap === "function") {
    initMap();
  } else {
    // Retry after a slight delay
    setTimeout(() => initMap && initMap(), 100);
  }
}
