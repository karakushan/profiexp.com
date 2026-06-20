"use strict";
$.ajaxSetup({
  headers: {
    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
  }
});
$(document).ready(function () {
  $('.js-example-basic-single1').select2();
  $('.js-example-basic-single6').select2();
  $('.js-example-basic-single7').select2();
});

$('body').on('change', '.js-country-basic', function () {
  $('.request-loader').addClass('show');
  var id = $(this).val();
  var lang = $(this).attr('data-code');
  var added = lang + "_country_state_id";
  var hh = lang + "_hide_state";
  var added2 = lang + "_state_city_id";

  if (id === null) {
    $('.request-loader').removeClass('show');

    $(`.${added2}`).empty().select2({
      placeholder: 'Select City',
      allowClear: true,
      minimumInputLength: 0,
      ajax: {
        url: cityUrl,
        dataType: 'json',
        delay: 250,
        data: function (params) {
          return {
            search: params.term || '',
            page: params.page || 1,
            lang: lang
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
    $(`.${added}`).empty().select2({
      placeholder: 'Select State',
      allowClear: true,
      minimumInputLength: 0,
      ajax: {
        url: stateUrl,
        dataType: 'json',
        delay: 250,
        data: function (params) {
          return {
            search: params.term || '',
            page: params.page || 1,
            lang: lang
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
  } else {

    $('.' + added + ' option').remove();
    $('.' + added2 + ' option').remove();

    $(`.${added2}`).removeClass('js-select-city-ajax')
      .select2({ placeholder: 'Select City', allowClear: true });
    $(`.${added}`).removeClass('js-state-basic')
      .select2({ placeholder: 'Select State', allowClear: true });

    $.ajax({
      type: 'POST',
      url: getStateUrl,
      data: {
        id: id,
        lang: lang
      },
      success: function (data) {
        $('.request-loader').removeClass('show');
        if (data) {
          if (data.states && data.states.length > 0) {

            $('.' + hh).removeClass('d-none');

            $('.' + added).append($('<option>', {
              value: '',
              text: Selectastate,
              disabled: true,
              selected: true
            }));

            $.each(data.states, function (key, value) {
              $('.' + added).append($('<option></option>').val(value.id).html(value
                .name));
            });
            $('.' + added2).append($('<option>', {
              value: '',
              text: Selectacountry,
              disabled: true,
              selected: true
            }));
          } else {
            $('.' + hh).addClass('d-none');

            $('.' + added2).append($('<option>', {
              value: '',
              text: Selectacountry,
              disabled: true,
              selected: true
            }));
            $.each(data.cities, function (key, value) {
              $('.' + added2).append($('<option></option>').val(value.id).html(value
                .name));
            });
          }
        } else {

        }
      }
    });
  }
});

$('body').on('change', '.stateDropDown', function () {
  $('.request-loader').addClass('show');
  var id = $(this).val();
  var lang = $(this).attr('data-code');
  var added = lang + "_state_city_id";

  if (id === null) {
    $('.request-loader').removeClass('show');
    $(`.${added}`).empty().select2({
      placeholder: 'Select City',
      allowClear: true,
      minimumInputLength: 0,
      ajax: {
        url: cityUrl,
        dataType: 'json',
        delay: 250,
        data: function (params) {
          return {
            search: params.term || '',
            page: params.page || 1,
            lang: lang
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
  } else {
    $('.' + added + ' option').remove();
    $(`.${added}`).removeClass('js-select-city-ajax')
      .select2({ placeholder: 'Select City', allowClear: true });
    $.ajax({
      type: 'POST',
      url: getCityUrl,
      data: {
        id: id,
        lang: lang
      },
      success: function (data) {
        $('.request-loader').removeClass('show');

        if (data && data.length > 0) {

          $('.' + added).append($('<option>', {
            value: '',
            text: Selectacountry,
            disabled: true,
            selected: true
          }));

          $.each(data, function (key, value) {
            $('.' + added).append($('<option></option>').val(value.id).html(value
              .name));
          });
        } else {
          $('.' + added).append($('<option>', {
            value: '',
            text: 'No cities available',
            disabled: true,
            selected: true
          }));
        }
      }
    });
  }
});


$(document).ready(function () {
  $('.js-example-basic-single2').select2({
    placeholder: 'Select Category',
    minimumInputLength: 0,
    ajax: {
      url: getHomeCatUrl,
      dataType: 'json',
      delay: 250,
      data: function (params) {
        var dataCode = $(this).data('code');
        return {
          search: params.term || '',
          page: params.page || 1,
          lang: dataCode
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

  $('.js-select-city-ajax').select2({
    placeholder: 'Select City',
    allowClear: true,
    minimumInputLength: 0,
    ajax: {
      url: cityUrl,
      dataType: 'json',
      delay: 250,
      data: function (params) {
        var dataCode = $(this).data('code');
        return {
          search: params.term || '',
          page: params.page || 1,
          lang: dataCode
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

  $('.js-state-basic').select2({
    placeholder: 'Select State',
    allowClear: true,
    minimumInputLength: 0,
    ajax: {
      url: stateUrl,
      dataType: 'json',
      delay: 250,
      data: function (params) {
        var dataCode = $(this).data('code');
        return {
          search: params.term || '',
          page: params.page || 1,
          lang: dataCode
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

  $('.js-country-basic').select2({
    placeholder: 'Select Country',
    allowClear: true,
    minimumInputLength: 0,
    ajax: {
      url: countryUrl,
      dataType: 'json',
      delay: 250,
      data: function (params) {
        var dataCode = $(this).data('code');
        return {
          search: params.term || '',
          page: params.page || 1,
          lang: dataCode
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




function bootnotify(message, title, type) {
  var content = {};

  content.message = message;
  content.title = title;
  content.icon = 'fa fa-bell';

  $.notify(content, {
    type: type,
    placement: {
      from: 'top',
      align: 'right'
    },
    showProgressbar: true,
    time: 1000,
    allow_dismiss: true,
    delay: 4000
  });
}

$('#listingForm').on('submit', function (e) {

  e.preventDefault();
  let can_listing_add = $('button[type=submit]').data('can_listing_add');

  if (can_listing_add == 0) {
    bootnotify(PleaseBuyaplantoaddalisting, Alert, 'warning');
    return false;
  } else if (can_listing_add == 2) {

    $("#checkLimitModal").modal('show');

    bootnotify(Listingslimitreachedorexceeded, Alert, 'warning');
    return false;
  }
  $('.request-loader').addClass('show');

  let action = $(this).attr('action');
  let fd = new FormData($(this)[0]);

  //if iconpecker

  if ($(".aaa").length > 0) {
    var textarea = $("<textarea></textarea>");

    // You can set attributes or properties for the textarea if needed
    textarea.attr("name", "icons");
    textarea.attr("id", "icons");
    textarea.attr("class", "form-control d-none");
    // textarea.attr("type", "hidden");

    // Append the textarea to the form with the id "myForm"
    $(this).append(textarea);
    var iconArray = [];
    $('.aaa').each(function () {
      var icon = $(this).find('i').attr('class');
      iconArray.push(icon);
    })
    $("#icons").html(iconArray);
    fd.delete($('#icons').attr('name'));
    fd.append($('#icons').attr('name'), iconArray);
  }


  //if summernote has then get summernote content
  $('.form-control').each(function (i) {
    let index = i;

    let $toInput = $('.form-control').eq(index);

    if ($(this).hasClass('summernote')) {
      let tmcId = $toInput.attr('id');
      let content = tinyMCE.get(tmcId).getContent();
      fd.delete($(this).attr('name'));
      fd.append($(this).attr('name'), content);
    }
  });

  $.ajax({
    url: action,
    method: 'POST',
    data: fd,
    contentType: false,
    processData: false,
    success: function (data) {
      if (data.limit_error == true) {
        location.reload();
      }

      $('.request-loader').removeClass('show');

      if (data.status == 'success') {
        location.reload();
      } else if (data.status == 'error') {

        location.reload();
      }

      if (data == "downgrade") {
        $('.modal').modal('hide');

        var content = {};
        content.message = YourPackagelimitreachedorexceeded
        content.title = "Warning";
        content.icon = 'fa fa-bell';

        $.notify(content, {
          type: 'warning',
          placement: {
            from: 'top',
            align: 'right'
          },
          showProgressbar: true,
          time: 1000,
          delay: 4000,
        });
        $("#checkLimitModal").modal('show');
      }

    },
    error: function (error) {
      let errors = ``;

      for (let x in error.responseJSON.errors) {
        errors += `<li>
                <p class="text-danger mb-0">${error.responseJSON.errors[x][0]}</p>
              </li>`;
      }

      $('#listingErrors ul').html(errors);
      $('#listingErrors').show();

      $('.request-loader').removeClass('show');

      $('html, body').animate({
        scrollTop: $('#listingErrors').offset().top - 100
      }, 1000);
    }
  });
});
$('body').on('click', '.deleteFeature', function () {
  let feature = $(this).data('feature');
  $('.request-loader').addClass('show');
  $(this).parent().parent().remove();
  $.ajax({
    url: featureRmvUrl,
    method: 'POST',
    data: {
      spacificationId: feature,
    },

    success: function (data) {

      if (data.status == 'success') {

        $('.request-loader').removeClass('show');
        location.reload();
      }
    },
    error: function (error) {
      if (data.status == 'success') {

        var content = {};

        content.message = 'Something went worng!';
        content.title = "Warning";
        content.icon = 'fa fa-bell';

        $.notify(content, {
          type: 'warning',
          placement: {
            from: 'top',
            align: 'right'
          },
          showProgressbar: true,
          time: 1000,
          delay: 4000,
        });
      }
    }
  });
});
$('body').on('click', '.deleteSocialLink', function () {
  let socialID = $(this).data('social_link');
  $('.request-loader').addClass('show');
  $(this).parent().parent().remove();
  $.ajax({
    url: socialRmvUrl,
    method: 'POST',
    data: {
      socialID: socialID,
    },
    success: function (data) {

      if (data.status == 'success') {

        $('.request-loader').removeClass('show');
        location.reload();
      }
    },
    error: function (error) {
      if (data.status == 'success') {

        var content = {};

        content.message = 'Something went worng!';
        content.title = "Warning";
        content.icon = 'fa fa-bell';

        $.notify(content, {
          type: 'warning',
          placement: {
            from: 'top',
            align: 'right'
          },
          showProgressbar: true,
          time: 1000,
          delay: 4000,
        });
      }
    }
  });
});

$('body').on('click', '.input-checkbox', function () {

  var selectedValues = [];

  let code = $(this).data('code');
  let languageId = $(this).data('language_id');
  let listingId = $(this).data('listing_id');
  var checkboxClass = code + "_input-checkbox";

  $("." + checkboxClass + ":checked").each(function () {
    selectedValues.push($(this).val());
  });

  var selectedValuesString = selectedValues.join(',');

  $.ajax({
    url: updateAminitie,
    method: 'POST',
    data: {
      aminities: selectedValuesString,
      languageId: languageId,
      listingId: listingId,
    },

    success: function (data) {

      if (data.status == 'success') {

        $('.request-loader').removeClass('show');
        location.reload();
      }
    },
    error: function (error) {
      if (data.status == 'success') {

        var content = {};

        content.message = 'Something went worng!';
        content.title = "Warning";
        content.icon = 'fa fa-bell';

        $.notify(content, {
          type: 'warning',
          placement: {
            from: 'top',
            align: 'right'
          },
          showProgressbar: true,
          time: 1000,
          delay: 4000,
        });
      }
    }
  });
});

//remove existing images
$(document).on('click', '.videoimagermvbtndb', function () {
  let indb = $(this).data('indb');
  $(".request-loader").addClass("show");
  $.ajax({
    url: videormvdbUrl,
    type: 'POST',
    data: {
      fileid: indb
    },
    success: function (data) {
      if (data.status == 'success') {
        $('.request-loader').removeClass('show');

        location.reload();

      }
    }
  });
});

//video image preview and remove
$('.video-img-input').on('change', function (event) {
  let file = event.target.files[0];
  let reader = new FileReader();

  reader.onload = function (e) {
    $('.uploaded-img2').attr('src', e.target.result);
    $('.remove-img2').show();
  };

  reader.readAsDataURL(file);
});

$('.remove-img2').on('click', function () {
  $('.video-img-input').val('');
  $('.uploaded-img2').attr('src', baseURL + '/assets/img/noimage.jpg');
  $(this).hide();
});


