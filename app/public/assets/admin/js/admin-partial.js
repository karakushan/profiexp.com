$(document).ready(function () {
  'use strict';

  function initAiCardTooltips() {
    var $cards = $('.card-tooltip-trigger');

    if (!$cards.length || !$.ui || !$.ui.tooltip) {
      return;
    }

    function decodeTooltipHtml(encodedHtml) {
      return $('<textarea>').html(encodedHtml || '').text();
    }

    $cards.each(function () {
      var $card = $(this);

      if ($card.data('ui-tooltip')) {
        $card.tooltip('destroy');
      }
    });

    $cards.tooltip({
      content: function () {
        return decodeTooltipHtml($(this).attr('data-card-tooltip'));
      },
      items: '.card-tooltip-trigger',
      track: false,
      show: {
        delay: 120,
        duration: 140
      },
      hide: {
        duration: 100
      },
      classes: {
        'ui-tooltip': 'custom-ai-tooltip'
      },
      position: {
        my: 'left top+16',
        at: 'left bottom',
        collision: 'flipfit'
      },
      open: function (event, ui) {
        ui.tooltip.addClass('custom-ai-tooltip');
      }
    });
  }

  initAiCardTooltips();

  // blog form
  $('#blogForm').on('submit', function (e) {
    $('.request-loader').addClass('show');
    e.preventDefault();

    let action = $(this).attr('action');
    let fd = new FormData($(this)[0]);

    $.ajax({
      url: action,
      method: 'POST',
      data: fd,
      contentType: false,
      processData: false,
      success: function (data) {
        $('.request-loader').removeClass('show');

        if (data.status == 'success') {
          location.reload();
        }
      },
      error: function (error) {
        let errors = ``;

        for (let x in error.responseJSON.errors) {
          errors += `<li>
                <p class="text-danger mb-0">${error.responseJSON.errors[x][0]}</p>
              </li>`;
        }

        $('#blogErrors ul').html(errors);
        $('#blogErrors').show();

        $('.request-loader').removeClass('show');

        $('html, body').animate({
          scrollTop: $('#blogErrors').offset().top - 100
        }, 1000);
      }
    });
  });


  // custom page form
  $('#pageForm').on('submit', function (e) {
    $('.request-loader').addClass('show');
    e.preventDefault();

    let action = $(this).attr('action');
    let fd = new FormData($(this)[0]);

    $.ajax({
      url: action,
      method: 'POST',
      data: fd,
      contentType: false,
      processData: false,
      success: function (data) {
        $('.request-loader').removeClass('show');

        if (data.status == 'success') {
          location.reload();
        }
      },
      error: function (error) {
        let errors = ``;

        for (let x in error.responseJSON.errors) {
          errors += `<li>
                <p class="text-danger mb-0">${error.responseJSON.errors[x][0]}</p>
              </li>`;
        }

        $('#pageErrors ul').html(errors);
        $('#pageErrors').show();

        $('.request-loader').removeClass('show');

        $('html, body').animate({
          scrollTop: $('#pageErrors').offset().top - 100
        }, 1000);
      }
    });
  });


  // show or hide input field according to selected ad type
  $('#ad_type').on('change', function () {
    let adType = $(this).val();

    if (adType == 'banner') {
      if (!$('#slot-input').hasClass('d-none')) {
        $('#slot-input').addClass('d-none');
      }

      $('#image-input').removeClass('d-none');
      $('#url-input').removeClass('d-none');
    } else {
      if (!$('#image-input').hasClass('d-none') && !$('#url-input').hasClass('d-none')) {
        $('#image-input').addClass('d-none');
        $('#url-input').addClass('d-none');
      }

      $('#slot-input').removeClass('d-none');
    }
  });

  $('#in_ad_type').on('change', function () {
    let adType = $(this).val();

    if (adType == 'banner') {
      if (!$('#edit-slot-input').hasClass('d-none')) {
        $('#edit-slot-input').addClass('d-none');
      }

      $('#edit-image-input').removeClass('d-none');
      $('#edit-url-input').removeClass('d-none');
    } else {
      if (!$('#edit-image-input').hasClass('d-none') && !$('#edit-url-input').hasClass('d-none')) {
        $('#edit-image-input').addClass('d-none');
        $('#edit-url-input').addClass('d-none');
      }

      $('#edit-slot-input').removeClass('d-none');
    }
  });


  // show different input field according to input type for digital product
  $('select[name="input_type"]').on('change', function () {
    let optionVal = $(this).val();

    if (optionVal == 'upload') {
      $('#file-input').removeClass('d-none');

      if (!$('#link-input').hasClass('d-none')) {
        $('#link-input').addClass('d-none');
      }
    } else if (optionVal == 'link') {
      $('#link-input').removeClass('d-none');

      if (!$('#file-input').hasClass('d-none')) {
        $('#file-input').addClass('d-none');
      }
    }
  });

  // product form
  $('#productForm').on('submit', function (e) {

    e.preventDefault();

    let can_product_add = $('button[type=submit]').data('can_product_add');

    if (can_product_add == 0) {
      bootnotify('Please Buy a plan to add a product.!', 'Alert', 'warning');
      return false;
    } else if (can_product_add == 2) {
      $("#checkLimitModal").modal('show');
      bootnotify("Products limit reached or exceeded", 'Alert', 'warning');
      return false;
    }


    // Ensure select fields have valid values
    let vendorId = $('#vendor_id').val();
     if (!vendorId) {
      $('#vendor_id').val('admin'); 
    }


    $('.request-loader').addClass('show');
    let action = $(this).attr('action');
    let fd = new FormData($(this)[0]);

    $.ajax({
      url: action,
      method: 'POST',
      data: fd,
      contentType: false,
      processData: false,
      success: function (data) {
        $('.request-loader').removeClass('show');

        if (data.status == 'success') {
          location.reload();
        }
        if (data == "downgrade") {
          $('.modal').modal('hide');

          "use strict";
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

        $('#productErrors ul').html(errors);
        $('#productErrors').show();

        $('.request-loader').removeClass('show');

        $('html, body').animate({
          scrollTop: $('#productErrors').offset().top - 100
        }, 1000);
      }
    });
  });


  // show or hide price input fields by toggling the 'Request Price Button'
  $('input[name="price_btn_status"]').on('change', function () {
    let radioBtnVal = $('input[name="price_btn_status"]:checked').val();

    if (parseInt(radioBtnVal) === 1) {
      $('#equipment-price-input').addClass('d-none');
    } else {
      $('#equipment-price-input').removeClass('d-none');
    }
  });

  // equipment form
  $('#equipmentForm').on('submit', function (e) {
    $('.request-loader').addClass('show');
    e.preventDefault();

    let action = $(this).attr('action');
    let fd = new FormData($(this)[0]);

    $.ajax({
      url: action,
      method: 'POST',
      data: fd,
      contentType: false,
      processData: false,
      success: function (data) {
        $('.request-loader').removeClass('show');

        if (data.status == 'success') {
          location.reload();
        }
      },
      error: function (error) {
        let errors = ``;

        for (let x in error.responseJSON.errors) {
          errors += `<li>
                <p class="text-danger mb-0">${error.responseJSON.errors[x][0]}</p>
              </li>`;
        }

        $('#equipmentErrors ul').html(errors);
        $('#equipmentErrors').show();

        $('.request-loader').removeClass('show');

        $('html, body').animate({
          scrollTop: $('#equipmentErrors').offset().top - 100
        }, 1000);
      }
    });
  });

  $('thead').on('click', '.addRow', function (e) {
    e.preventDefault();
    var tr = `<tr>
              <td>
                <div class="form-group">
                  <input type="text" name="custom_feature_names[]" class="form-control">
                </div>
              </td>
              <td>
                <div class="form-group">
                  <input type="text" name="custom_feature_values[]" class="form-control">
                </div>
              </td>
              <td><a href="" class="btn btn-danger btn-sm deleteRow">-</a></td>
            </tr>`;
    $('tbody.append').append(tr);
  });

  $('tbody').on('click', '.deleteRow', function (e) {
    e.preventDefault();
    $(this).parent().parent().remove();
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


  // Form Submit with AJAX Request Start
  $("#CarSubmit").on('click', function (e) {
    //check package permision
    let can_car_add = $(this).attr('data-can_car_add');
    if (can_car_add == 0) {
      bootnotify('Please Buy a plan to add a car.!', 'Alert', 'warning');
      return false;
    } else if (can_car_add == 2) {
      bootnotify("You can't add more car. Please buy a plan to add car", 'Alert', 'warning');
      return false;
    }
    $(e.target).attr('disabled', true);
    $(".request-loader").addClass("show");

    if ($(".iconpicker-component").length > 0) {
      $("#inputIcon").val($(".iconpicker-component").find('i').attr('class'));
    }

    let carForm = document.getElementById('carForm');
    let fd = new FormData(carForm);
    let url = $("#carForm").attr('action');
    let method = $("#carForm").attr('method');

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
      url: url,
      method: method,
      data: fd,
      contentType: false,
      processData: false,
      success: function (data) {
        $(e.target).attr('disabled', false);
        $('.request-loader').removeClass('show');

        $('.em').each(function () {
          $(this).html('');
        });

        if (data.status == 'success') {
          location.reload();
        }
      },
      error: function (error) {
        let errors = ``;

        for (let x in error.responseJSON.errors) {
          errors += `<li>
                <p class="text-danger mb-0">${error.responseJSON.errors[x][0]}</p>
              </li>`;
        }

        $('#carErrors ul').html(errors);
        $('#carErrors').show();

        $('.request-loader').removeClass('show');

        $('html, body').animate({
          scrollTop: $('#carErrors').offset().top - 100
        }, 1000);
      }

    });
    $(e.target).attr('disabled', false);
  });
  // Form Submit with AJAX Request End

});

// show or hide input fields according to selected placement type and input type

$(document).ready(function () {
  var placementSelect = $('select[name="placement_type"]');
  var inputTypeSelect = $('select[name="input_type"]');

  function toggleFields() {
    var placementValue = placementSelect.val();
    var inputTypeValue = inputTypeSelect.val();
    
    var listingDiv = $('select[name="listing_id"]').closest('.col-lg-12, .col-lg-6');
    var categoryCols = $('select[name$="_category_id"]').closest('.col-lg-6');
    var titleDiv = categoryCols.prev();
    var summaryFields = $('textarea[name$="_summary"]');
    var stockField = $('input[name="stock"]').closest('.form-group');
    var inputTypeField = $('select[name="input_type"]').closest('.form-group');
    var fileInput = $('#file-input');
    var linkInput = $('#link-input');

    // Handle listing div visibility
    if (placementValue == '1') {
      listingDiv.addClass('d-none').removeClass('col-lg-6').addClass('col-lg-12');
    } else if (placementValue == '2') {
      listingDiv.removeClass('d-none').removeClass('col-lg-12').addClass('col-lg-6');
    } else {
      listingDiv.removeClass('d-none').removeClass('col-lg-6').addClass('col-lg-12');
    }

    // Hide fields when placement_type is 2
    if (placementValue == '2') {
      categoryCols.addClass('d-none');
      titleDiv.removeClass('col-lg-6').addClass('col-lg-12');
      summaryFields.closest('.form-group').addClass('d-none');
      stockField.addClass('d-none');
      inputTypeField.addClass('d-none');
      fileInput.addClass('d-none');
      linkInput.addClass('d-none');

    } else {
      categoryCols.removeClass('d-none');
      titleDiv.removeClass('col-lg-12').addClass('col-lg-6');
      summaryFields.closest('.form-group').removeClass('d-none');
      stockField.removeClass('d-none');
      inputTypeField.removeClass('d-none');

      // For digital products, toggle file-input and link-input based on input_type
      if ($('input[name="product_type"]').val() === 'digital') {
        if (inputTypeValue === 'upload') {
          fileInput.removeClass('d-none');
          linkInput.addClass('d-none');
        } else if (inputTypeValue === 'link') {
          fileInput.addClass('d-none');
          linkInput.removeClass('d-none');
        } else {
          fileInput.addClass('d-none');
          linkInput.addClass('d-none');
        }
      } else {
        fileInput.addClass('d-none');
        linkInput.addClass('d-none');
      }
    }
  }

  placementSelect.on('change', toggleFields);
  inputTypeSelect.on('change', toggleFields);
  toggleFields(); 
});



$(document).ready(function () {
  $('#vendor_id').on('change', function () {
    
    var vendorId = $(this).val();
    var listingSelect = $('#listing_id');

    // Clear existing options except the default
    listingSelect.find('option:not(:first)').remove();

    if (vendorId) {
      $.ajax({
        url: listingUrl,
        type: 'GET',
        data: { vendor_id: vendorId },
        success: function (data) {
          if (data.length > 0) {
            $.each(data, function (index, listing) {
              if (listing.listing_content && listing.listing_content.length > 0) {
                listingSelect.append(
                  $('<option>', {
                    value: listing.id,
                    text: listing.listing_content[0].title
                  })
                );
              }
            });
          } else {
            listingSelect.append(
              $('<option>', {
                value: '',
                text: listingNotFound
              })
            );
          }
        },
        error: function (xhr, status, error) {
          console.error('Error fetching listings:', error);
          listingSelect.append(
            $('<option>', {
              value: '',
              text: "Error fetching listings"
            })
          );
        }
      });
    }
  });
});

// this function for edit form select the value and hide necessary input field

$(function () {
  $(document).on('click', '.editFormTrigger', function () {
    var $btn = $(this);

    // Read data attributes
    var id = $btn.data('id') || '';
    var name = $btn.data('name') || '';
    var type = $btn.data('type') || '';
    var status = $btn.data('status') || '';
    var vendor = $btn.data('vendor_id') || '';

    // Set hidden id
    $('#in_id').val(id);

    $('#in_name').val(name); 

    $('#in_status').val(status).trigger('change'); 

    $('#in_type').val(type).trigger('change');     
    $('#in_type option').each(function () {
      var val = $(this).val();
      if (!val) return;                  
      $(this).toggle(val === type);      
    });
    if ($('#in_type').hasClass('select2-hidden-accessible')) {
      $('#in_type').trigger('change.select2');     
    }


    if (type == 'claim_request') {
      $('#editVendorGroup').hide();
      $('#in_vendor_id').next('.select2-container').hide();
      $('#in_vendor_id').val(null).trigger('change'); 
    } else {
      $('#editVendorGroup').show();
      $('#in_vendor_id').next('.select2-container').show();
      $('#in_vendor_id').val(vendor).trigger('change'); 
    }
  });

  // Restore type options after closing the modal for next edit
  $('#editModal').on('hidden.bs.modal', function () {
    $('#in_type option').show();
  });
});

// this function for hide vendor field according to form type
(function () {
  function toggleVendorByType() {
    var type = document.getElementById('formType')?.value || '';
    var vendorGroup = document.getElementById('vendorGroup');
    if (!vendorGroup) return;

    if (type == 'claim_request') {
      vendorGroup.style.display = 'none'; 
    } else {
      vendorGroup.style.display = ''; 
    }
  }

  // On DOM ready
  document.addEventListener('DOMContentLoaded', function () {
    var typeSelect = document.getElementById('formType');
    if (typeSelect) {
      typeSelect.addEventListener('change', toggleVendorByType);
    }

    // If using Bootstrap modal, ensure correct state when modal opens
    var createModal = document.getElementById('createModal');
    if (createModal) {
      // Bootstrap 4 uses 'shown.bs.modal'
      $(createModal).on('shown.bs.modal', function () {
        toggleVendorByType();
      });
    }

    // Initial state (in case form is visible without opening modal)
    toggleVendorByType();
  });
})();


// Copy link functionality for cliam listing
$(document).ready(function () {
  
  $('.copy-link-btn').on('click', function () {
    var url = $(this).data('url');
    var claimId = $(this).data('id');
    var button = $(this);
    var originalHtml = button.html();

    // Create temporary input element
    var tempInput = $('<input>');
    $('body').append(tempInput);
    tempInput.val(url).select();

    try {
      // Copy to clipboard
      document.execCommand('copy');

      // Change button appearance for feedback
      button.html('<i class="fas fa-check"></i>').removeClass('btn-info').addClass('btn-success');
      setTimeout(function () {
        button.html(originalHtml).removeClass('btn-success').addClass('btn-info');
      }, 2000);

    } catch (err) {
      console.error('Failed to copy: ', err);
      alert('{{ __("Failed to copy link") }}');
    }

    tempInput.remove();
  });

});

$(document).ready(function () {
  $('.editBtnForFormBuilderInfo').on('click', function () {
    var name = $(this).data('name');
    var phone = $(this).data('phone');
    var email = $(this).data('email');
    var information = $(this).data('information');

    $('#modalName').text(name);
    $('#modalPhone').text(phone || 'N/A');
    $('#modalEmail').text(email);

    $('#dynamicFields').empty();
    console.log(information);

    if (information) {
      $.each(information, function (key, val) {
        var html = '<div><strong>' + key + ': </strong>';

        if (val.type === 8 && val.value) {
          // Adjust URL path if needed to match your file storage path
          html += '<a href="/' + val.value + '" target="_blank" download>Download File</a>';
        } else {
          var displayVal = val.value;

          // Convert objects (except arrays) to JSON string
          if (typeof displayVal === 'object' && !Array.isArray(displayVal) && displayVal !== null) {
            displayVal = JSON.stringify(displayVal);
          }

          // Join arrays as comma separated string
          if (Array.isArray(displayVal)) {
            displayVal = displayVal.join(', ');
          }

          // Safely encode for HTML display
          html += $('<div>').text(displayVal).html();
        }

        html += '</div>';
        $('#dynamicFields').append(html);
      });
    } else {
      $('#dynamicFields').append('<p>No additional information provided.</p>');
    }
  });
});

// Generate a strong random password start
function generateStrongPassword(length = 12) {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*';
  let password = '';

  for (let i = 0; i < length; i++) {
    password += chars.charAt(Math.floor(Math.random() * chars.length));
  }

  return password;
}

$(document).on('click', '#generatePasswordBtn', function () {
  const $newPassword = $('#new_password');
  const $confirmPassword = $('#new_password_confirmation');

  if (!$newPassword.length || !$confirmPassword.length) {
    return;
  }

  const password = generateStrongPassword(12);

  $newPassword.val(password).attr('type', 'text').trigger('input').trigger('change');
  $confirmPassword.val(password).attr('type', 'text').trigger('input').trigger('change');

  setTimeout(function () {
    $newPassword.attr('type', 'password');
    $confirmPassword.attr('type', 'password');
  }, 3000);
});

// Generate a strong random password end



