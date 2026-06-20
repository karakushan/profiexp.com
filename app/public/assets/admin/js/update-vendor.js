"use strict";
// Form Update with AJAX Request Start
$("#updateBtn").on('click', function (e) {
  $(".request-loader").addClass("show");

  if ($(".edit-iconpicker-component").length > 0) {
    $("#editInputIcon").val($(".edit-iconpicker-component").find('i').attr('class'));
  }

  let ajaxEditForm = document.getElementById('ajaxEditForm');
  let fd = new FormData(ajaxEditForm);
  let url = $("#ajaxEditForm").attr('action');
  let method = $("#ajaxEditForm").attr('method');

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
      $('.request-loader').removeClass('show');
      $(e.target).attr('disabled', false);

      $('.em').each(function () {
        $(this).html('');
      });

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
      $('.em').each(function () {
        $(this).html('');
      });

      for (let x in error.responseJSON.errors) {
        document.getElementById('editErr_' + x).innerHTML = error.responseJSON.errors[x][0];
      }

      $('.request-loader').removeClass('show');
      $(e.target).attr('disabled', false);
    }
  });
});
// Form Update with AJAX Request End
