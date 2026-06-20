"use strict";
$(document).ready(function () {

  $('body').on('keypress', '#searchBytTitle', function (event) {
    if (event.which === 13) {
      $('#title').val($(this).val());
      $('#page').val(1);
      updateUrl();
    }
  });
  if (googleApiStatus === 0) {
    $('body').on('keypress', '#location', function (event) {
      if (event.which === 13) {
        $('#location_val').val($(this).val());
        $('#page').val(1);
        updateUrl();
      }
    });
  }

  $('body').on('click', '.page-link', function () {
    var page = $(this).data('page');
    $('#page').val(page);
    updateUrl();
  });

  $('.category-toggle').on('click', function () {
    $('#category_id').val($(this).attr('id'));
    $('#title').val('');
    $('#searchBytTitle').val('');
    $('#location').val('');
    $('#location_val').val('');
    $('#ratings').val('');
    $('#amenitie').val('');
    $('#vendor').val('');
    $('#country').val('');
    $('#state').val('');
    $('#city').val('');
    $('#page').val(1);
    $('#vendorDropdown').val('');

    $("#amenities-div").load(location.href + " #amenities-div", function () {

      $('[data-toggle-list="amenitiesToggle"]').each(function () {
        var $toggleList = $(this);
        var showCount = $toggleList.data('toggle-show');
        var $listItems = $toggleList.children('li');
        var $showMoreBtn = $('[data-toggle-btn="toggleListBtn"]');
        var $showLessBtn = $('<span class="show-more font-sm" data-toggle-btn="toggleListBtnLess">' +
          show_less + '</span>').hide();
        $toggleList.after($showLessBtn);

        $listItems.slice(showCount).hide();

        $showMoreBtn.on('click', function () {
          $listItems.filter(':hidden').slice(0, showCount).slideDown();
          $showMoreBtn.hide();
          $showLessBtn.show();
        });

        $showLessBtn.on('click', function () {
          $listItems.slice(showCount).slideUp();
          $showMoreBtn.show();
          $(this).hide();
        });
      });
    });

    $("#rating-div").load(location.href + " #rating-div");
    $("#filter-div").load(location.href + " #filter-div", function () {
      $('#vendorDropdown').select2();
      $('#countryDropdown').select2();
      $('#stateDropdown').select2();
      $('#cityDropdown').select2();
    });

    updateUrl();
  });

  $('body').on('change', '.vendorDropdown', function () {
    var selectedVendorId = $(this).val();
    $('#vendor').val(selectedVendorId);
    $('#page').val(1);
    updateUrl();
  });

  $('body').on('change', '.countryDropdown', function () {
    var id = $(this).val();
    $('#country').val(id);
    $('#state').val('');
    $('#city').val('');
    $('#page').val(1);
    updateUrl();

    $('#stateDropdown option').remove();
    $('#cityDropdown   option').remove();

    $.ajax({
      type: 'POST',
      url: getStateUrl,
      data: {
        id: id,
      },
      success: function (data) {

        if (data) {
          if (data.states && data.states.length > 0) {

            $('.hide_state').show();

            $('#stateDropdown').append($('<option>', {
              value: '',
              text: 'Select State',
              disabled: true,
              selected: true
            }));
            $('#stateDropdown').append($('<option>', {
              value: '',
              text: 'All',
              disabled: false,
              selected: false
            }));

            $.each(data.states, function (key, value) {
              $('#stateDropdown').append($('<option></option>').val(value.id).html(value
                .name));
            });
            $('#cityDropdown').append($('<option>', {
              value: '',
              text: 'Select City',
              disabled: true,
              selected: true
            }));
          } else {
            $('.hide_state').hide();

            $('#cityDropdown').append($('<option>', {
              value: '',
              text: 'Select City',
              disabled: true,
              selected: true
            }));
            $.each(data.cities, function (key, value) {
              $('#cityDropdown').append($('<option></option>').val(value.id).html(value
                .name));
            });
          }
        } else {
        }
      },
      error: function (xhr, status, error) {
        console.error("AJAX Error: " + status, error);
      },
      async: true,
    });
  });

  $('body').on('change', '.stateDropdown', function () {
    var selectedStateId = $(this).val();
    $('#state').val(selectedStateId);
    $('#city').val('');
    $('#page').val(1);
    updateUrl();

    $('#cityDropdown  option').remove();
    $.ajax({
      type: 'POST',
      url: getCityUrl,
      data: {
        id: selectedStateId,
      },
      success: function (data) {
        if (data && data.length > 0) {
          $('#cityDropdown').append($('<option>', {
            value: '',
            text: 'Select Cities',
            disabled: true,
            selected: true
          }));
          $('#cityDropdown').append($('<option>', {
            value: '',
            text: 'All'
          }));
          $.each(data, function (key, value) {
            $('#cityDropdown').append($('<option></option>').val(value.id).html(value.name));
          });
        } else {
          $('#cityDropdown').append($('<option>', {
            value: '',
            text: 'Select City',
            disabled: true,
            selected: true
          }));
        }
      },
      error: function (xhr, status, error) {
        console.error("AJAX Error: " + status, error);
      },
      async: true,
    });
  });

  $('body').on('change', '.cityDropdown', function () {
    var selectedCityId = $(this).val();
    $('#city').val(selectedCityId);
    $('#page').val(1);
    updateUrl();
  });

  $('body').on('click', '.input-radio', function () {
    $('#ratings').val(($(this).val()));
    $('#page').val(1);
    updateUrl();
  });

  $('body').on('change', '#select_sort', function () {
    $('#sort').val($(this).val());
    $('#page').val(1);
    updateUrl();
  });

  $('body').on('click', '.input-checkbox', function () {
    var selectedValues = [];

    $(".input-checkbox:checked").each(function () {
      selectedValues.push($(this).val());
    });

    var selectedValuesString = selectedValues.join(',');

    $("#amenitie").val(selectedValuesString);
    $('#page').val(1);
    updateUrl();
  });
});

function updateUrl() {
  $('#searchForm').submit();
  $(".request-loader").addClass("show");
}

$('#searchForm').on('submit', function (e) {
  e.preventDefault();
  var fd = $(this).serialize();
  $('.search-container').html('');
  $.ajax({
    url: searchUrl,
    method: "get",
    data: fd,
    contentType: false,
    processData: false,
    success: function (response) {
      $('.request-loader').removeClass('show');
      $('.search-container').html(response);

      if (clusters) {
        map.removeLayer(clusters);
        clusters.clearLayers();
      }
      map.off();
      map.remove();

      var featured_content = featured_contents;
      var listing_content = listing_contents;
      var mapId = $(".btn[data-bs-target='#mapModal']").is(":visible") ? "modal-main-map" : "main-map";

      mapInitialize(mapId, featured_content, listing_content);
    },
    error: function (xhr) {
      console.log(xhr);
    }
  });
});

/*============================================
   Price range
   ============================================*/
var sliders = document.querySelectorAll("[data-range-slider='priceSlider']");
var filterSliders = document.querySelector("[data-range-slider='filterPriceSlider']");
var input0 = document.getElementById('min');
var input1 = document.getElementById('max');
var min = document.getElementById('min').value;
var max = document.getElementById('max').value;

var o_min = document.getElementById('o_min').value;
var o_max = document.getElementById('o_max').value;

var min = parseFloat(min);
var max = parseFloat(max);

var o_min = parseFloat(o_min);
var o_max = parseFloat(o_max);

var inputs = [input0, input1];
// Home price slider
for (let i = 0; i < sliders.length; i++) {
  const el = sliders[i];

  noUiSlider.create(el, {
    start: [min, max],
    connect: !0,
    step: 10,
    margin: 10,
    range: {
      min: o_min,
      max: o_max
    }
  }), el.noUiSlider.on("update", function (values) {
    $("[data-range-value='priceSliderValue']").text("$" + values.join(" - " + "$"));
  })
}
// Filter frice slider
if (filterSliders) {
  var currency_symbol = document.getElementById('currency_symbol').value;
  noUiSlider.create(filterSliders, {
    start: [min, max],
    connect: !0,
    step: 10,
    margin: 10,
    range: {
      min: o_min,
      max: o_max
    }
  }), filterSliders.noUiSlider.on("update", function (values, handle) {
    $("[data-range-value='filterPriceSliderValue']").text(currency_symbol + values.join(" - " + currency_symbol));

    $('#min_val').val(values[0]);
    $('#max_val').val(values[1]);

    inputs[handle].value = values[handle];
  }), filterSliders.noUiSlider.on("change", function (values, handle) {
    $('#page').val(1);
    updateUrl();
  })

  inputs.forEach(function (input, handle) {
    if (input) {
      input.addEventListener('change', function () {
        filterSliders.noUiSlider.setHandle(handle, this.value);
      });
    }
  });
}

//show more categories
document.querySelectorAll('.loadMoreCategories').forEach(button => {
  button.addEventListener('click', function () {
    $('.request-loader').addClass('show');

    const loadMoreBtn = this;
    const action = loadMoreBtn.getAttribute('data-action');
    const offset = loadMoreBtn.getAttribute('data-offset');
    const initialItemsCount = 10;
    const loadCount = 50; // number of items to load/hide

    if (action === 'more') {
      // show more functionality
      fetch(`${baseURL}/get-more-categories?offset=${offset}`)
        .then(response => response.json())
        .then(data => {
          $('.request-loader').removeClass('show');

          if (data.categories.length > 0) {
            // append new categories
            const categoriesList = document.getElementById('categoriesList');
            data.categories.forEach(category => {
              const li = document.createElement('li');
              li.className = `list-item ${window.location.search.includes(`category_id=${category.slug}`) ? 'open' : ''}`;
              li.innerHTML = `<a href="#" class="category-toggle" id="${category.slug}">${category.name}</a>`;
              categoriesList.appendChild(li);
            });

            // update button for show less and show more
            if (data.hasMore) {
              if (parseInt(offset) + loadCount > initialItemsCount) {
                $('.show-less-category').show();
              }
              loadMoreBtn.setAttribute('data-offset', parseInt(offset) + loadCount);
            } else {
              //change the show less button when all categories are loaded
              $('.loadMoreCategories[data-action="more"]').hide();
              $('.show-less-category').show().attr('data-all-loaded', 'true');
            }
          }
        });
    } else if (action === 'less') {
      // show less functionality
      const categoriesList = document.getElementById('categoriesList');
      const items = categoriesList.querySelectorAll('li');

      //remove all items beyond initial count
      for (let i = items.length - 1; i >= initialItemsCount; i--) {
        categoriesList.removeChild(items[i]);
      }

      $('.request-loader').removeClass('show');

      // reset the show more button to initial offset
      const showMoreBtn = document.querySelector('.loadMoreCategories[data-action="more"]');
      showMoreBtn.setAttribute('data-offset', initialItemsCount);


      // show "show more" button if it was hidden
      $('.show-less-category').hide();
      $('.loadMoreCategories[data-action="more"]').show();
      loadMoreBtn.removeAttribute('data-all-loaded');

    }
  });
});



$(document).ready(function () {
  $('.js-select-country-ajax').select2({
    placeholder: 'Select Country',
    minimumInputLength: 1,
    ajax: {
      url: countryUrl,
      dataType: 'json',
      delay: 250,
      data: function (params) {
        return {
          search: params.term
        };
      },
      processResults: function (data) {
        return {
          results: $.map(data, function (item) {
            return {
              text: item.name,
              id: item.id
            }
          })
        };
      },
      cache: true
    }
  });
  $('.js-select-city-ajax').select2({
    placeholder: 'Select City',
    minimumInputLength: 1,
    ajax: {
      url: cityUrl,
      dataType: 'json',
      delay: 250,
      data: function (params) {
        return {
          search: params.term,
          country_id: $('#countryDropdown').val()
        };
      },
      processResults: function (data) {
        return {
          results: $.map(data, function (item) {
            return {
              text: item.name,
              id: item.id
            }
          })
        };
      },
      cache: true
    }
  });
});
