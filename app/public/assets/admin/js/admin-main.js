$(function ($) {
    "use strict";
    WebFont.load({
        google: { "families": ["Lato:300,400,700,900"] },
        custom: { "families": ["Flaticon", "Font Awesome 5 Solid", "Font Awesome 5 Regular", "Font Awesome 5 Brands", "simple-line-icons"], urls: [baseUrl + '/assets/css/fonts.min.css'] },
        active: function () {
            sessionStorage.fonts = true;
        }
    });
    // Hide Check Limit Modal
    $("#listingProductDownModal").on('shown.bs.modal', function (e) {
        $("#checkLimitModal").modal('hide');
    });
    $("#listingImgDownModal").on('shown.bs.modal', function (e) {
        $("#checkLimitModal").modal('hide');
    });
    $("#listingFaqDownModal").on('shown.bs.modal', function (e) {
        $("#checkLimitModal").modal('hide');
    });
    $("#listingFeatureDownModal").on('shown.bs.modal', function (e) {
        $("#checkLimitModal").modal('hide');
    });
    $("#listingSocialDownModal").on('shown.bs.modal', function (e) {
        $("#checkLimitModal").modal('hide');
    });
    $("#listingamenitiesDownModal").on('shown.bs.modal', function (e) {
        $("#checkLimitModal").modal('hide');
    });
    $("#listingProductImgDownModal").on('shown.bs.modal', function (e) {
        $("#checkLimitModal").modal('hide');
    });
    //showing a message
    $(document).ready(function () {
        $(".updateButton").on('click', function () {

            var message = YourPackagelimitreachedorexceeded;
            bootnotify(message, 'Alert', 'warning')
        });
    });
    $(document).ready(function () {
        $(".noPackage").on('click', function () {

            var message = "Please Buy a plan to add a ticket.!";
            bootnotify(message, 'Alert', 'warning')
        });
    });


    // Call the function to display the message

    if (demo_mode == 'active') {
        $.ajaxSetup({
            beforeSend: function (jqXHR, settings, event) {
                if (settings.type == 'POST' && settings.url.indexOf('user/qr-code/generate') == -1) {
                    if ($(".request-loader").length > 0) {
                        $(".request-loader").removeClass('show');
                    }
                    if ($(".modal").length > 0) {
                        $(".modal").modal('hide');
                    }
                    if ($("button[disabled='disabled']").length > 0) {
                        $("button[disabled='disabled']").removeAttr('disabled');
                    }
                    bootnotify('This is demo version. You cannot change anything here!', 'Demo Version', 'warning')
                    jqXHR.abort(event);
                }
            },
            complete: function () {
                // hide progress spinner
            }
        });
    }

    /*****************************************************
  ==========Bootstrap Notify start==========
  ******************************************************/

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
    /*****************************************************
    ==========Bootstrap Notify end==========
    ******************************************************/
    if (account_status == 1 || secret_login == 1) {
        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });
    } else {
        $.ajaxSetup({
            beforeSend: function (jqXHR, settings) {
                if (settings.type == 'POST' && status == 0) {
                    if ($(".request-loader").length > 0) {
                        $(".request-loader").removeClass('show');
                    }
                    if ($(".modal").length > 0) {
                        $(".modal").modal('hide');
                    }
                    if ($("button[disabled='disabled']").length > 0) {
                        $("button[disabled='disabled']").removeAttr('disabled');
                    }
                    var message = adminApproveNotice.admin_approval_notice;
                    bootnotify(message, 'Alert', 'warning')
                    jqXHR.abort(event);
                }
            },
            complete: function () {
            }
        });
    }

    // sidebar search start
    $(".sidebar-search").on('input', function () {
        let term = $(this).val().toLowerCase();

        if (term.length > 0) {
            $(".sidebar ul li.nav-item").each(function (i) {
                let menuName = $(this).find("p").text().toLowerCase();
                let $mainMenu = $(this);

                // if any main menu is matched
                if (menuName.indexOf(term) > -1) {
                    $mainMenu.removeClass('d-none');
                    $mainMenu.addClass('d-block');
                } else {
                    let matched = 0;
                    let count = 0;
                    // search sub-items of the current main menu (which is not matched)
                    $mainMenu.find('span.sub-item').each(function (i) {
                        // if any sub-item is matched of the current main menu, set the flag
                        if ($(this).text().toLowerCase().indexOf(term) > -1) {
                            count++;
                            matched = 1;
                        }
                    });

                    // if any sub-item is matched  of the current main menu (which is not matched)
                    if (matched == 1) {
                        $mainMenu.removeClass('d-none');
                        $mainMenu.addClass('d-block');
                    } else {
                        $mainMenu.removeClass('d-block');
                        $mainMenu.addClass('d-none');
                    }
                }
            });
        } else {
            $(".sidebar ul li.nav-item").addClass('d-block');
        }
    });
    // sidebar search end


    // disabling default behave of form submits start
    $("#ajaxEditForm").attr('onsubmit', 'return false');
    $("#ajaxForm").attr('onsubmit', 'return false');
    $("#ajaxForm2").attr('onsubmit', 'return false');
    // disabling default behave of form submits end


    // bootstrap datepicker & timepicker start
    $('.datepicker').datepicker({
        autoclose: true
    });

    $('.timepicker').timepicker();
    // bootstrap datepicker & timepicker end


    // fontawesome icon picker start
    $('.icp-dd').iconpicker();
    // fontawesome icon picker end


    // select2 start
    $('.select2').select2();
    // select2 end

    /*****************************************************
    ==========tinymce initialization start==========
    ******************************************************/
    // summernote initialization start
    $(".summernote").each(function (i) {

        tinymce.init({
            selector: '.summernote',
            plugins: 'autolink charmap emoticons image link lists media searchreplace table visualblocks wordcount directionality',
            toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table mergetags | addcomment showcomments | spellcheckdialog a11ycheck typography | align lineheight | checklist numlist bullist indent outdent | emoticons charmap | removeformat | ltr rtl',
            tinycomments_mode: 'embedded',
            tinycomments_author: 'Author name',
            promotion: false,
            mergetags_list: [
                { value: 'First.Name', title: 'First Name' },
                { value: 'Email', title: 'Email' },
            ]
        });

    });


    $(document).on('click', ".note-video-btn", function () {
        let i = $(this).index();

        if ($(".summernote").eq(i).parents(".modal").length > 0) {
            setTimeout(() => {
                $("body").addClass('modal-open');
            }, 500);
        }
    });
    /*****************************************************
    ==========Summernote initialization end==========
    ******************************************************/


    // Form Submit with AJAX Request Start
    $("#submitBtn").on('click', function (e) {
        $(e.target).attr('disabled', true);
        $(".request-loader").addClass("show");

        if ($(".iconpicker-component").length > 0) {
            $("#inputIcon").val($(".iconpicker-component").find('i').attr('class'));
        }

        let ajaxForm = document.getElementById('ajaxForm');
        let fd = new FormData(ajaxForm);
        let url = $("#ajaxForm").attr('action');
        let method = $("#ajaxForm").attr('method');

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
                console.log(data);
                $(e.target).attr('disabled', false);
                $('.request-loader').removeClass('show');

                $('.em').each(function () {
                    $(this).html('');
                });

                if (data.status == 'success') {
                    location.reload();
                }
                if (data.status == 'error') {
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
                    document.getElementById('err_' + x).innerHTML = error.responseJSON.errors[x][0];
                }

                $('.request-loader').removeClass('show');
                $(e.target).attr('disabled', false);
            }
        });
    });
    // Form Submit with AJAX Request End

    $("#submitBtn2").on('click', function (e) {
        $(e.target).attr('disabled', true);
        $(".request-loader").addClass("show");

        if ($(".iconpicker-component").length > 0) {
            $("#inputIcon").val($(".iconpicker-component").find('i').attr('class'));
        }

        let ajaxForm2 = document.getElementById('ajaxForm2');
        let fd = new FormData(ajaxForm2);
        let url = $("#ajaxForm2").attr('action');
        let method = $("#ajaxForm2").attr('method');

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
                })

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
                    document.getElementById('err_' + x).innerHTML = error.responseJSON.errors[x][0];
                }

                $('.request-loader').removeClass('show');
                $(e.target).attr('disabled', false);
            }
        });
    });

    $("#submitBtn3").on('click', function (e) {
        $(e.target).attr('disabled', true);
        $(".request-loader").addClass("show");

        if ($(".iconpicker-component").length > 0) {
            $("#inputIcon").val($(".iconpicker-component").find('i').attr('class'));
        }

        let ajaxForm = document.getElementById('ajaxForm3');
        let fd = new FormData(ajaxForm);
        let url = $("#ajaxForm3").attr('action');
        let method = $("#ajaxForm3").attr('method');

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
                })

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
                    document.getElementById('err_' + x).innerHTML = error.responseJSON.errors[x][0];
                }

                $('.request-loader').removeClass('show');
                $(e.target).attr('disabled', false);
            }
        });
    });


    // Form Prepopulate After Clicking Edit Button Start
    $(".editBtn").on('click', function () {
        let datas = $(this).data();
        delete datas['toggle'];

        var p = $(this).data('ok');
        if (p) {
            $('#e_hide_state').removeClass('d-none');
        } else {
            $('#e_hide_state').addClass('d-none');
        }

        var cityImage = $(this).data('cie');
        if (cityImage) {
            $('.cityimagermvbtndb').removeClass('d-none').attr('data-indb', cityImage);
        } else {
            $('.cityimagermvbtndb').addClass('d-none');
        }

        for (let x in datas) {

            if ($("#in_" + x).hasClass('summernote')) {
                tinyMCE.get("in_" + x).setContent(datas[x]);
            } else if ($("#in_" + x).data('role') == 'tagsinput') {
                if (datas[x].length > 0) {
                    let arr = datas[x].split(" ");
                    for (let i = 0; i < arr.length; i++) {
                        $("#in_" + x).tagsinput('add', arr[i]);
                    }
                } else {
                    $("#in_" + x).tagsinput('removeAll');
                }
            } else if ($("input[name='" + x + "']").attr('type') == 'radio') {
                $("input[name='" + x + "']").each(function (i) {
                    if ($(this).val() == datas[x]) {
                        $(this).prop('checked', true);
                    }
                });
            } else if ($("#in_" + x).hasClass('select2')) {
                $("#in_" + x).val(datas[x]);
                $("#in_" + x).trigger('change');
            } else {
                $("#in_" + x).val(datas[x]);

                if ($('.in_image').length > 0) {
                    $('.in_image').attr('src', datas['image']);
                }
               
                if ($('.in_mobile_image').length > 0) {
                    $('.in_mobile_image').attr('src', datas['mobile_image']);
                }

                if ($('#in_icon').length > 0) {
                    $('#in_icon').attr('class', datas['icon']);
                }
            }
        }

        if ('edit' in datas && datas.edit === 'editAdvertisement') {
            if (datas.ad_type === 'banner') {
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
        }

        // focus & blur colorpicker inputs
        setTimeout(() => {
            $(".jscolor").each(function () {
                $(this).focus();
                $(this).blur();
            });
        }, 300);
    });
    // Form Prepopulate After Clicking Edit Button End

    $('#VendorSettingBtn').on('click', function () {
        $('#VendorSettingForm').submit();
    });


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


    // Delete Using AJAX Request Start
    $('.deleteBtn').on('click', function (e) {
        e.preventDefault();
        $(".request-loader").addClass("show");

        swal({
            title: Areyousure,
            text: Youwontbeabletorevertthis,
            type: 'warning',
            buttons: {
                confirm: {
                    text: Yesdeleteit,
                    className: 'btn btn-success'
                },
                cancel: {
                    text: cancelText,
                    visible: true,
                    className: 'btn btn-danger'
                }
            }
        }).then((Delete) => {
            if (Delete) {
                $(this).parent(".deleteForm").submit();
            } else {
                swal.close();
                $(".request-loader").removeClass("show");
            }
        });
    });
    // Delete Using AJAX Request End

    //Package Delete Using AJAX Request Start
    $('.packageDeleteBtn').on('click', function (e) {
        e.preventDefault();
        $(".request-loader").addClass("show");

        swal({
            title: Areyousure,
            text: Ifyoudeletethispackageallmembershipsunderthispackagewillbedeleted,
            type: 'warning',
            buttons: {
                confirm: {
                    text: Yesdeleteit,
                    className: 'btn btn-success'
                },
                cancel: {
                    text: cancelText,
                    visible: true,
                    className: 'btn btn-danger'
                }
            }
        }).then((Delete) => {
            if (Delete) {
                $(this).parent(".packageDeleteForm").submit();
            } else {
                swal.close();
                $(".request-loader").removeClass("show");
            }
        });
    });
    //Package Delete Using AJAX Request End
    //unfeature Using AJAX Request Start
    $('.unFeatureBtn').on('click', function (e) {
        e.preventDefault();
        $(".request-loader").addClass("show");

        swal({
            title: Areyousure,
            type: 'warning',
            buttons: {
                confirm: {
                    text: Yesdeleteit,
                    className: 'btn btn-success'
                },
                cancel: {
                    text: cancelText,
                    visible: true,
                    className: 'btn btn-danger'
                }
            }
        }).then((Delete) => {
            if (Delete) {
                $(this).parent(".deleteForm").submit();
            } else {
                swal.close();
                $(".request-loader").removeClass("show");
            }
        });
    });
    //Package Delete Using AJAX Request End

    /*****************************************************
  ==========Close Ticket Using AJAX Request Start======
  ******************************************************/
    $('.close-ticket').on('click', function (e) {
        e.preventDefault();
        $(".request-loader").addClass("show");

        swal({
            title: Areyousure,
            text: Youwanttoclosethisticket,
            type: 'warning',
            buttons: {
                confirm: {
                    text: Yescloseit,
                    className: 'btn btn-success'
                },
                cancel: {
                    text: cancelText,
                    visible: true,
                    className: 'btn btn-danger'
                }
            }
        }).then((Delete) => {
            if (Delete) {
                $("#closeForm").submit();
                $(".request-loader").removeClass("show");
            } else {
                swal.close();
                $(".request-loader").removeClass("show");
            }
        });
    });
    /******************************************************
    ==========Close Ticket Using AJAX Request End==========
    ******************************************************/


    // Bulk Delete Using AJAX Request Start
    $(".bulk-check").on('change', function () {
        let val = $(this).data('val');
        let checked = $(this).prop('checked');

        // if selected checkbox is 'all' then check all the checkboxes
        if (val == 'all') {
            if (checked) {
                $(".bulk-check").each(function () {
                    $(this).prop('checked', true);
                });
            } else {
                $(".bulk-check").each(function () {
                    $(this).prop('checked', false);
                });
            }
        }

        // if any checkbox is checked then flag = 1, otherwise flag = 0
        let flag = 0;

        $(".bulk-check").each(function () {
            let status = $(this).prop('checked');

            if (status) {
                flag = 1;
            }
        });

        // if any checkbox is checked then show the delete button
        if (flag == 1) {
            $(".bulk-delete").addClass('d-inline-block');
            $(".bulk-delete").removeClass('d-none');
        } else {
            // if no checkbox is checked then hide the delete button
            $(".bulk-delete").removeClass('d-inline-block');
            $(".bulk-delete").addClass('d-none');
        }
    });

    $('.bulk-delete').on('click', function () {
        swal({
            title: Areyousure,
            text: Youwontbeabletorevertthis,
            type: 'warning',
            buttons: {
                confirm: {
                    text: Yesdeleteit,
                    className: 'btn btn-success'
                },
                cancel: {
                    text: cancelText,
                    visible: true,
                    className: 'btn btn-danger'
                }
            }
        }).then((Delete) => {
            if (Delete) {
                $(".request-loader").addClass('show');
                let href = $(this).data('href');
                let ids = [];

                // take ids of checked one's
                $(".bulk-check:checked").each(function () {
                    if ($(this).data('val') != 'all') {
                        ids.push($(this).data('val'));
                    }
                });

                let fd = new FormData();
                for (let i = 0; i < ids.length; i++) {
                    fd.append('ids[]', ids[i]);
                }

                $.ajax({
                    url: href,
                    method: 'POST',
                    data: fd,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        $(".request-loader").removeClass('show');

                        if (data.status == "success") {
                            location.reload();
                        }
                    }
                });
            } else {
                swal.close();
            }
        });
    });
    // Bulk Delete Using AJAX Request End


    // DataTable Start
    $('#basic-datatables').DataTable({
        ordering: false,
        responsive: true
    });
    // DataTable End


    // Uploaded Image Preview Start
    $('.img-input').on('change', function (event) {
        let file = event.target.files[0];
        let reader = new FileReader();

        reader.onload = function (e) {
            $('.uploaded-img').attr('src', e.target.result);
        };

        reader.readAsDataURL(file);
    });
    $('.img-input2').on('change', function (event) {
        let file = event.target.files[0];
        let reader = new FileReader();

        reader.onload = function (e) {
            $('.uploaded-img2').attr('src', e.target.result);
        };

        reader.readAsDataURL(file);
    });

    $('.img-input3').on('change', function (event) {
        let file = event.target.files[0];
        let reader = new FileReader();

        reader.onload = function (e) {
            $('.uploaded-img3').attr('src', e.target.result);
        };

        reader.readAsDataURL(file);
    });
    // Uploaded Image Preview End


    // Uploaded Image Preview Start
    $('.preloader-input').on('change', function (event) {
        let file = event.target.files[0];
        let reader = new FileReader();

        reader.onload = function (e) {
            $('.preloader-uploaded-img').attr('src', e.target.result);
        };

        reader.readAsDataURL(file);
    });
    // Uploaded Image Preview End


    // Uploaded Background Image Preview Start
    $('.background-img-input').on('change', function (event) {
        let file = event.target.files[0];
        let reader = new FileReader();

        reader.onload = function (e) {
            $('.uploaded-background-img').attr('src', e.target.result);
        };

        reader.readAsDataURL(file);
    });
    // Uploaded Background Image Preview End

    // Change Input Direction Start
    $('select[name="language_id"]').on('change', function () {
        $('.request-loader').addClass('show');

        let currentPath = window.location.pathname;
        let userType = currentPath.includes('/admin/') ? 'admin' : '/vendor';
        let rtlURL = baseUrl + userType + '/language-management/' + $(this).val() + '/check-rtl';
        // send ajax request to check whether the selected language is 'rtl' or not
        $.get(rtlURL, function (response) {
            $('.request-loader').removeClass('show');

            if ('successData' in response) {
                if (response.successData == 1) {
                    $('form.create').addClass('text-right');
                    $('form.create input').each(function () {
                        if (!$(this).hasClass('ltr')) {
                            $(this).addClass('rtl');
                        }
                    });

                    $('form.create select').each(function () {
                        if (!$(this).hasClass('ltr')) {
                            $(this).addClass('rtl');
                        }
                    });

                    $('form.create textarea').each(function () {
                        if (!$(this).hasClass('ltr')) {
                            $(this).addClass('rtl');
                        }
                    });

                    $('form.create .note-editor.note-frame .note-editing-area .note-editable').each(function () {
                        if (!$(this).hasClass('ltr')) {
                            $(this).addClass('rtl');
                        }
                    });
                } else {
                    $('form.create').removeClass('text-right');
                    $('form.create input, form.create select, form.create textarea, form.create .note-editor.note-frame .note-editing-area .note-editable').removeClass('rtl');
                }
            } else {
                alert(response.errorData);
            }
        });
    });
    // Change Input Direction End

    // Change Input Direction Start
    $('select[name="m_language_id"]').on('change', function () {
        $('.request-loader').addClass('show');

        let rtlURL = baseUrl + 'admin/language-management/' + $(this).val() + '/check-rtl';

        // send ajax request to check whether the selected language is 'rtl' or not
        $.get(rtlURL, function (response) {
            $('.request-loader').removeClass('show');

            if ('successData' in response) {
                if (response.successData == 1) {
                    $('form.create').addClass('text-right');
                    $('form.create input').each(function () {
                        if (!$(this).hasClass('ltr')) {
                            $(this).addClass('rtl');
                        }
                    });

                    $('form.create select').each(function () {
                        if (!$(this).hasClass('ltr')) {
                            $(this).addClass('rtl');
                        }
                    });

                    $('form.create textarea').each(function () {
                        if (!$(this).hasClass('ltr')) {
                            $(this).addClass('rtl');
                        }
                    });

                    $('form.create .note-editor.note-frame .note-editing-area .note-editable').each(function () {
                        if (!$(this).hasClass('ltr')) {
                            $(this).addClass('rtl');
                        }
                    });
                } else {
                    $('form.create').removeClass('text-right');
                    $('form.create input, form.create select, form.create textarea, form.create .note-editor.note-frame .note-editing-area .note-editable').removeClass('rtl');
                }
            } else {
                alert(response.errorData);
            }
        });
    });
    // Change Input Direction End

});

function cloneInput(fromId, toId, event) {
    let $target = $(event.target);
    if ($target.is(':checked')) {
        $('#' + fromId + ' .form-control').each(function (i) {
            let index = i;
            let val = $(this).val();
            let $toInput = $('#' + toId + ' .form-control').eq(index);

            if ($toInput.hasClass('summernote')) {
                let val = tinyMCE.activeEditor.getContent();
                let tmcId = $toInput.attr('id');
                tinyMCE.get(tmcId).setContent(val);
            } else if ($(this).data('role') == 'tagsinput') {
                if (val.length > 0) {
                    let tags = val.split(',');
                    tags.forEach(tag => {
                        $toInput.tagsinput('add', tag);
                    });
                } else {
                    $toInput.tagsinput('removeAll');
                }
            } else {
                $toInput.val(val);
            }
        });
    } else {
        $('#' + toId + ' .form-control').each(function (i) {
            let $toInput = $('#' + toId + ' .form-control').eq(i);
            if ($(this).hasClass('summernote')) {
                let tmcId = $toInput.attr('id');
                tinyMCE.get(tmcId).setContent('');
            } else if ($(this).data('role') == 'tagsinput') {
                $toInput.tagsinput('removeAll');
            } else {
                $toInput.val('');
            }
        });
    }
}

$(document).ready(function () {
    $("body").on('click', '#vendor_admin_approval', function () {
        if ($('#vendor_admin_approval').is(":checked")) {
            $('.admin_approval_notice').removeClass('d-none');
        } else {
            $('.admin_approval_notice').addClass('d-none');
        }
    });
})

$('#listing_title').on('keypress', function (e) {
    if (e.which == 13) {
        $(this).closest('form').submit();
    }
})
$('#order_no').on('keypress', function (e) {
    if (e.which == 13) {
        $(this).closest('form').submit();
    }
})

$(document).ready(function () {
    // Attach a click event to the select element
    $('select').on('select2:open', function (e) {
        // Find the parent element with class 'form-group'
        var formGroup = $(this).closest('.form-group');

        // Check if the parent element has class 'rtl'
        if (formGroup.hasClass('rtl')) {
            // Add class 'rtl' to the Select2 dropdown
            $('.select2-dropdown').addClass('rtl');
            $('.select2-dropdown').attr('dir', 'rtl')
        }
    });
});

$(document).on('change', '.langBtn', function () {
    let $this = $(this);
    let $code = $this.val();
    let curr_url = window.location.href.split('?')[0];

    $.ajax({
        url: $("#setLocale").val(),
        method: 'get',
        data: { code: $code },
        success: function () {
            let new_url = curr_url + '?language=' + encodeURIComponent($code);
            window.location = new_url;
        }
    });
});
