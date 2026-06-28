"use strict";

// ============ Global slider variables ============
var filterSliders = null;
var o_min = null;
var o_max = null;

console.log(`select_city: ${select_city} ${select_country} ${select_state}`);

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

      $('#countryDropdown').select2({
        placeholder: select_country,
        allowClear: true,
        minimumInputLength: 0,
        ajax: {
          url: countryUrl,
          dataType: 'json',
          delay: 250,
          data: function (params) {
            return {
              search: params.term || '',
              page: params.page || 1
            };
          },
          processResults: function (data) {
            return {
              results: data.results.map(function (item) {
                return { text: item.name, id: item.id };
              }),
              pagination: { more: data.more }
            };
          },
          cache: true
        }
      });

      $('#stateDropdown').select2({
        placeholder: select_state,
        allowClear: true,
        minimumInputLength: 0,
        ajax: {
          url: stateUrl,
          dataType: 'json',
          delay: 250,
          data: function (params) {
            return {
              search: params.term || '',
              page: params.page || 1
            };
          },
          processResults: function (data) {
            return {
              results: data.results.map(function (item) {
                return { text: item.name, id: item.id };
              }),
              pagination: { more: data.more }
            };
          },
          cache: true
        }
      });

      $('#cityDropdown').select2({
        placeholder: select_city,
        allowClear: true,
        minimumInputLength: 0,
        ajax: {
          url: cityUrl,
          dataType: 'json',
          delay: 250,
          data: function (params) {
            return {
              search: params.term || '',
              page: params.page || 1
            };
          },
          processResults: function (data) {
            return {
              results: data.results.map(function (item) {
                return { text: item.name, id: item.id };
              }),
              pagination: { more: data.more }
            };
          },
          cache: true
        }
      });
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

    if (id === null) {
      $('#stateDropdown').empty().select2({
        placeholder: select_state,
        allowClear: true,
        minimumInputLength: 0,
        ajax: {
          url: stateUrl,
          dataType: 'json',
          delay: 250,
          data: function (params) {
            return { search: params.term || '', page: params.page || 1 };
          },
          processResults: function (data, params) {
            return {
              results: data.results.map(function (item) {
                return { text: item.name, id: item.id };
              }),
              pagination: { more: data.more }
            };
          },
          cache: true
        }
      });

      $('#cityDropdown').empty().select2({
        placeholder: select_city,
        allowClear: true,
        minimumInputLength: 0,
        ajax: {
          url: cityUrl,
          dataType: 'json',
          delay: 250,
          data: function (params) {
            return { search: params.term || '', page: params.page || 1 };
          },
          processResults: function (data, params) {
            return {
              results: data.results.map(function (item) {
                return { text: item.name, id: item.id };
              }),
              pagination: { more: data.more }
            };
          },
          cache: true
        }
      });
      $('.hide_state').hide();
    } else {
      $('#country').val(id);
      $('#state').val('');
      $('#city').val('');
      $('#page').val(1);
      updateUrl();

      $('#stateDropdown').empty();
      $('#cityDropdown').empty();
      $('#stateDropdown').removeClass('js-select-state-ajax')
        .select2({ placeholder: select_state, allowClear: true });

      $('#cityDropdown').removeClass('js-select-city-ajax')
        .select2({ placeholder: select_city, allowClear: true });

      $.ajax({
        type: 'GET',
        url: getStateUrl,
        data: { id: id },
        success: function (data) {
          if (Array.isArray(data) ? data.length > 0 : Object.keys(data).length > 0) {
            if (data.states && data.states.length > 0) {
              $('.hide_state').show();

              $('#stateDropdown').append($('<option>', {
                value: '', text: select_state, disabled: true, selected: true
              }));
              $('#stateDropdown').append($('<option>', {
                value: '', text: 'All', disabled: false, selected: false
              }));

              $.each(data.states, function (key, value) {
                $('#stateDropdown').append($('<option></option>').val(value.id).html(value.name));
              });

              $('#cityDropdown').append($('<option>', {
                value: '', text: select_city, disabled: true, selected: true
              }));
            } else {
              $('.hide_state').hide();
              $('#cityDropdown').append($('<option>', {
                value: '', text: select_city, disabled: true, selected: true
              }));
              $.each(data.cities, function (key, value) {
                $('#cityDropdown').append($('<option></option>').val(value.id).html(value.name));
              });
            }
          }
        },
        error: function (xhr, status, error) {
          console.error("AJAX Error: " + status, error);
        },
        async: true,
      });
    }
  });

  $('body').on('change', '.stateDropdown', function () {
    var selectedStateId = $(this).val();
    $('#state').val(selectedStateId);
    $('#city').val('');
    $('#page').val(1);
    updateUrl();

    $('#cityDropdown').empty()
      .removeClass('js-select-city-ajax')
      .select2({ placeholder: select_city, allowClear: true });

    $.ajax({
      type: 'POST',
      url: getCityUrl,
      data: { id: selectedStateId },
      success: function (data) {
        if (data && data.length > 0) {
          $('#cityDropdown').append($('<option>', {
            value: '', text: 'Select Cities', disabled: true, selected: true
          }));
          $('#cityDropdown').append($('<option>', { value: '', text: 'All' }));
          $.each(data, function (key, value) {
            $('#cityDropdown').append($('<option></option>').val(value.id).html(value.name));
          });
        } else {
          $('#cityDropdown').append($('<option>', {
            value: '', text: select_city, disabled: true, selected: true
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

  $('body').on('click', '.input-checkbox:not(#price_not_mentioned)', function () {
    var selectedValues = [];
    $(".input-checkbox:checked:not(#price_not_mentioned)").each(function () {
      selectedValues.push($(this).val());
    });
    var selectedValuesString = selectedValues.join(',');
    $("#amenitie").val(selectedValuesString);
    $('#page').val(1);
    updateUrl();
  });

  // ========== Price Not Mentioned Checkbox Handler ==========
  $('body').on('change', '#price_not_mentioned', function () {
    var isChecked = $(this).is(':checked');
    var value = isChecked ? '1' : '';
    $('#price_not_mentioned_value').val(value);

    if (isChecked) {
      // Reset slider to origin range
      if (filterSliders && filterSliders.noUiSlider && o_min !== null && o_max !== null) {
        try {
          filterSliders.noUiSlider.set([o_min, o_max]);
        } catch (e) {
          console.log('Slider reset error:', e);
        }
      }
      $('#min_val').val('');
      $('#max_val').val('');
    }

    $('#page').val(1);
    updateUrl();
  });

  // Initialize price sliders on page load
  initializePriceSliders();
});

let updateTimeout = null;
function updateUrl() {
  clearTimeout(updateTimeout);
  updateTimeout = setTimeout(function () {
    var $form = $('#searchForm');
    $form.submit();
    $(".request-loader").addClass("show");
  }, 100);
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
      if (listing_view == 0) {
        if (clusters) {
          map.removeLayer(clusters);
          clusters.clearLayers();
        }
        map.off();
        map.remove();
        var search_featured_contents = Object.values(featured_contents);
        let search_listing_contents;
        if (typeof listing_contents.current_page === 'number' && listing_contents.data) {
          search_listing_contents = Object.values(listing_contents.data);
        } else {
          search_listing_contents = Object.values(listing_contents || {});
        }

        var mapId = $(".btn[data-bs-target='#mapModal']").is(":visible") ? "modal-main-map" : "main-map";
        mapInitialize(mapId, search_featured_contents, search_listing_contents);
      }
    },
    error: function (xhr) {
      console.log(xhr);
    }
  });
});

/*============================================
   Price range initialization
   ============================================*/


function initializePriceSliders() {
  var sliders = document.querySelectorAll("[data-range-slider='priceSlider']");
  filterSliders = document.querySelector("[data-range-slider='filterPriceSlider']");

  var input0 = document.getElementById('min');
  var input1 = document.getElementById('max');

  if (!input0 || !input1) {
    console.log('Min/Max input elements not found - price filter may be hidden');
    return;
  }

  var min_val_el = document.getElementById('o_min');
  var max_val_el = document.getElementById('o_max');

  if (!min_val_el || !max_val_el) {
    console.log('Original min/max elements not found');
    return;
  }

  var min = parseFloat(input0.value);
  var max = parseFloat(input1.value);
  o_min = parseFloat(min_val_el.value);
  o_max = parseFloat(max_val_el.value);

  // Validate numeric values
  if (!Number.isFinite(o_min) || !Number.isFinite(o_max)) {
    console.log('Invalid origin range - price filter hidden');
    return;
  }

  if (!Number.isFinite(min)) min = o_min;
  if (!Number.isFinite(max)) max = o_max;

  var inputs = [input0, input1];

  // Home price slider(s)
  for (let i = 0; i < sliders.length; i++) {
    const el = sliders[i];
    noUiSlider.create(el, {
      start: [min, max],
      connect: true,
      step: 10,
      margin: 10,
      range: { min: o_min, max: o_max }
    });

    el.noUiSlider.on("update", function (values) {
      $("[data-range-value='priceSliderValue']").text("$" + values.join(" - " + "$"));
    });
  }

  // Filter price slider
  if (filterSliders) {
    var currencyElement = document.getElementById('currency_symbol');
    var currency_symbol = currencyElement ? currencyElement.value : '$';

    noUiSlider.create(filterSliders, {
      start: [min, max],
      connect: true,
      step: 10,
      margin: 10,
      range: { min: o_min, max: o_max }
    });

    filterSliders.noUiSlider.on("update", function (values, handle) {
      $("[data-range-value='filterPriceSliderValue']").text(
        currency_symbol + values.join(" - " + currency_symbol)
      );
      inputs[handle].value = values[handle];
    });

    filterSliders.noUiSlider.on("change", function (values, handle) {

      $('#min_val').val(values[0]);
      $('#max_val').val(values[1]);

      $('#price_not_mentioned').prop('checked', false);
      $('#price_not_mentioned_value').val('');

      $('#page').val(1);
      updateUrl();
    });

    inputs.forEach(function (input, handle) {
      if (input) {
        input.addEventListener('change', function () {
          filterSliders.noUiSlider.setHandle(handle, this.value);
        });
      }
    });
  }
}


//show more categories
document.querySelectorAll('.loadMoreCategories').forEach(button => {
  button.addEventListener('click', function () {
    $('.request-loader').addClass('show');

    const loadMoreBtn = this;
    const action = loadMoreBtn.getAttribute('data-action');
    const offset = loadMoreBtn.getAttribute('data-offset');
    const initialItemsCount = 10;
    const loadCount = 50;

    if (action === 'more') {
      fetch(`${baseURL}/get-more-categories?offset=${offset}`)
        .then(response => response.json())
        .then(data => {
          $('.request-loader').removeClass('show');

          if (data.categories.length > 0) {
            const categoriesList = document.getElementById('categoriesList');
            data.categories.forEach(category => {
              const li = document.createElement('li');
              li.className = `list-item ${window.location.search.includes(`category_id=${category.slug}`) ? 'open' : ''}`;
              li.innerHTML = `<a href="#" class="category-toggle" id="${category.slug}">${category.translated_name}</a>`;
              categoriesList.appendChild(li);
            });

            if (data.hasMore) {
              if (parseInt(offset) + loadCount > initialItemsCount) {
                $('.show-less-category').show();
              }
              loadMoreBtn.setAttribute('data-offset', parseInt(offset) + loadCount);
            } else {
              $('.loadMoreCategories[data-action="more"]').hide();
              $('.show-less-category').show().attr('data-all-loaded', 'true');
            }
          }
        });
    } else if (action === 'less') {
      const categoriesList = document.getElementById('categoriesList');
      const items = categoriesList.querySelectorAll('li');

      for (let i = items.length - 1; i >= initialItemsCount; i--) {
        categoriesList.removeChild(items[i]);
      }

      $('.request-loader').removeClass('show');

      const showMoreBtn = document.querySelector('.loadMoreCategories[data-action="more"]');
      showMoreBtn.setAttribute('data-offset', initialItemsCount);

      $('.show-less-category').hide();
      $('.loadMoreCategories[data-action="more"]').show();
      loadMoreBtn.removeAttribute('data-all-loaded');
    }
  });
});

$(document).ready(function () {
  $('.js-select-country-ajax').select2({
    placeholder: select_country,
    allowClear: true,
    minimumInputLength: 0,
    ajax: {
      url: countryUrl,
      dataType: 'json',
      delay: 250,
      data: function (params) {
        return { search: params.term || '', page: params.page || 1 };
      },
      processResults: function (data, params) {
        return {
          results: data.results.map(function (item) {
            return { text: item.name, id: item.id };
          }),
          pagination: { more: data.more }
        };
      },
      cache: true
    }
  });

  $('.js-select-city-ajax').select2({
    placeholder: select_city,
    allowClear: true,
    minimumInputLength: 0,
    ajax: {
      url: cityUrl,
      dataType: 'json',
      delay: 250,
      data: function (params) {
        return { search: params.term || '', page: params.page || 1 };
      },
      processResults: function (data, params) {
        return {
          results: data.results.map(function (item) {
            return { text: item.name, id: item.id };
          }),
          pagination: { more: data.more }
        };
      },
      cache: true
    }
  });

  $('.js-select-state-ajax').select2({
    placeholder: select_state,
    allowClear: true,
    minimumInputLength: 0,
    ajax: {
      url: stateUrl,
      dataType: 'json',
      delay: 250,
      data: function (params) {
        return { search: params.term || '', page: params.page || 1 };
      },
      processResults: function (data, params) {
        return {
          results: data.results.map(function (item) {
            return { text: item.name, id: item.id };
          }),
          pagination: { more: data.more }
        };
      },
      cache: true
    }
  });
});

// Handle Claim button click
$(document).ready(function () {
  $('body').on('click', 'a.claim-btn[data-bs-toggle="modal"]', function (e) {
    if (!isLoggedIn) {
      e.preventDefault();
      e.stopPropagation();
      toastr.error(claimErrMsg);
      return;
    }
    var listingId = $(this).data('listing-id');
    var vendorId = $(this).data('vendor-id') || 0;

    $('#claim_user_id').val(currentUser.id);
    $('#claim_listing_id').val(listingId);
    $('#claim_vendor_id').val(vendorId);

    $('#name').val(currentUser.name || '');
    $('#email').val(currentUser.email || '');
  });
});
