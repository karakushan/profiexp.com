"use strict";
$.ajaxSetup({
  headers: {
    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
  }
});
$("#searchBtn2").on('click', function (e) {
  e.preventDefault();

  var formData = $('#searchForm2').serializeArray();
  var queryParams = [];

  $.each(formData, function (index, input) {
    if (input.value !== '') {
      queryParams.push(encodeURIComponent(input.name) + '=' + encodeURIComponent(input.value));
    }
  });

  var queryString = queryParams.join('&');
  var newUrl = baseURL + '/listings';

  if (queryString !== '') {
    newUrl += '?' + queryString;
  }

  // Update the browser URL without reloading the page
  window.location.href = newUrl;
});


$(document).ready(function () {
  $('.js-example-basic-single1').select2({
    placeholder: categoriesText,
    minimumInputLength: 0,
    ajax: {
      url: getHomeCatUrl,
      dataType: 'json',
      delay: 250,
      data: function (params) {
        return {
          search: params.term || '',
          page: params.page || 1
        };
      },
      processResults: function (data, params) {
        return {
          results: data.results.map(function (item) {
            return {
              text: item.name,
              id: item.id
            };
          }),
          pagination: {
            more: data.more
          }
        };
      },
      cache: true
    }
  });
});
