"use strict";
$(document).ready(function () {
  var data = {
    listing_id: listing_id
  }
  $.get(visitor_store_url, data, function () { });
})
