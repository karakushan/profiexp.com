!(function ($) {
    "use strict";

    /*============================================
        Preloader
    ============================================*/
    $("#preLoader").delay(1000).queue(function () {
        $(this).remove();
    });


    /*============================================
        Sticky header
    ============================================*/
    $(window).on("scroll", function () {
        var header = $(".header-area");
        // If window scroll down .is-sticky class will added to header
        if ($(window).scrollTop() >= 100) {
            header.addClass("is-sticky");
        } else {
            header.removeClass("is-sticky");
        }
    });


    /*============================================
        Mobile menu
    ============================================*/
    var mobileMenu = function () {
        // Variables
        var body = $("body"),
            mainNavbar = $(".main-navbar"),
            mobileNavbar = $(".mobile-menu"),
            cloneInto = $(".mobile-menu-wrapper"),
            cloneItem = $(".mobile-item"),
            menuToggler = $(".menu-toggler"),
            offCanvasMenu = $("#offcanvasMenu");

        menuToggler.on("click", function () {
            $(this).toggleClass("active");
            body.toggleClass("mobile-menu-active");
        })

        mainNavbar.find(cloneItem).clone(!0).appendTo(cloneInto);

        if (offCanvasMenu) {
            body.find(offCanvasMenu).clone(!0).appendTo(cloneInto);
        }

        mobileNavbar.find("li").each(function (index) {
            var toggleBtn = $(this).children(".toggle")
            toggleBtn.on("click", function (e) {
                $(this)
                    .parent("li")
                    .children("ul")
                    .stop(true, true)
                    .slideToggle(350);
                $(this).parent("li").toggleClass("show");
            })
        })

        // check browser width in real-time
        var checkBreakpoint = function () {
            var winWidth = window.innerWidth;
            if (winWidth <= 1199) {
                mainNavbar.hide();
                mobileNavbar.show()
            } else {
                mainNavbar.show();
                mobileNavbar.hide();
                $('.menu-backdrop').remove();
            }
        }
        checkBreakpoint();

        $(window).on('resize', function () {
            checkBreakpoint();
        });
    }
    mobileMenu();

    var getHeaderHeight = function () {
        var headerNext = $(".header-next");
        var header = headerNext.prev(".header-area");
        var headerHeight = header.height();

        headerNext.css({
            "margin-top": headerHeight
        })
    }
    getHeaderHeight();

    $(window).on('resize', function () {
        getHeaderHeight();
    });

    /*============================================
        Image to background image
    ============================================*/
    $(".bg-img.blur-up").parent().addClass('blur-up lazyload');
    $(".bg-img").each(function () {
        var el = $(this);
        var src = el.attr("src");
        var parent = el.parent();
        if (typeof src != 'undefined') {
            parent.css({
                "background-image": "url(" + src + ")",
                "background-size": "cover",
                "background-position": "center",
                "display": "block"
            });
        }

        el.hide();
    });

    $(".bg-img-popup").parent().addClass('lazyload');
    $(document).ready(function () {
        $(".bg-img-popup").each(function () {
            var el = $(this);
            var src = el.attr("data-bg-image");
            var parent = el.parent();
            if (typeof src != 'undefined') {
                parent.css({
                    "background-image": "url(" + src + ")",
                    "background-size": "cover",
                    "background-position": "center",
                    "display": "block"
                });
            }
            el.hide();
        });
    })

    /*============================================
        Rating background image
    ============================================*/
    var bgImage = $(".rating-bg-img")
    bgImage.each(function () {
        var el = $(this),
            src = el.attr("data-bg-img");

        el.css({
            "background-image": "url(" + src + ")",
            "background-repeat": "no-repeat"
        });
    });




    /*============================================
        Sidebar toggle
    ============================================*/
    $(".category-toggle").on("click", function (t) {
        var i = $(this).closest("li");

        if (i.hasClass("open")) {
            i.removeClass("open")
        } else {
            i.addClass("open");
            i.siblings().removeClass("open")
        }
        t.stopPropagation(), t.preventDefault()
    })

    /*============================================
        Sliders
    ============================================*/
    // Home Slider
    $(".home-slider").each(function () {
        var id = $(this).attr("id");
        var sliderId = "#" + id;

        var homeSlider = new Swiper(sliderId, {
            speed: 700,
            autoplay: {
                delay: 3000
            },
            effect: "fade",
            pagination: true,

            pagination: {
                el: ".swiper-pagination",
                clickable: true,
                renderBullet: function (index, className) {
                    return '<span class="' + className + '">' + "0" + (index + 1) + "</span>";
                },
            },

            scrollbar: {
                el: ".swiper-scrollbar"
            },
        })
    })

    // Category Show More
    $('.category-show-more').on('click', function (e) {
        e.preventDefault();
        var $grid = $(this).closest('.category-area').find('.category-grid');
        var $hiddenItems = $grid.find('.category-grid-item.d-none');
        var $moreText = $(this).find('.show-more-text');
        var $lessText = $(this).find('.show-less-text');

        if ($hiddenItems.length > 0) {
            $hiddenItems.removeClass('d-none');
            $moreText.addClass('d-none');
            $lessText.removeClass('d-none');
        } else {
            $grid.find('.category-grid-item').each(function (index) {
                if (index >= 8) {
                    $(this).addClass('d-none');
                }
            });
            $moreText.removeClass('d-none');
            $lessText.addClass('d-none');
            $('html, body').animate({
                scrollTop: $grid.offset().top - 100
            }, 400);
        }
    });

    // City Slider
    var citySlider1 = new Swiper("#city-slider-1", {
        speed: 400,
        loop: false,
        slidesPerView: 4,
        spaceBetween: 24,
        navigation: true,

        // Navigation arrows
        navigation: {
            nextEl: '#city-slider-btn-next',
            prevEl: '#city-slider-btn-prev',
        },

        breakpoints: {
            // when window width is >= 320px
            320: {
                slidesPerView: 1,
                spaceBetween: 0,
            },
            // when window width is >= 640px
            768: {
                slidesPerView: 3,
                spaceBetween: 24,
            },
            // when window width is >= 640px
            1200: {
                slidesPerView: 4
            },
        }
    })
    var citySlider2 = new Swiper("#city-slider-2", {
        speed: 400,
        loop: false,
        slidesPerView: 4,
        spaceBetween: 24,
        pagination: true,

        // Pagination
        pagination: {
            el: "#city-slider-2-pagination",
            clickable: true,
        },

        breakpoints: {
            // when window width is >= 320px
            320: {
                slidesPerView: 1
            },
            // when window width is >= 640px
            768: {
                slidesPerView: 3
            },
            // when window width is >= 640px
            1200: {
                slidesPerView: 4
            },
        }
    })

    // Featured Slider
    var productSlider1 = new Swiper("#product-slider-1", {
        speed: 400,
        spaceBetween: 24,
        loop: false,
        pagination: true,

        pagination: {
            el: "#product-slider-1-pagination",
            clickable: true,
        },

        breakpoints: {
            // when window width is >= 320px
            320: {
                slidesPerView: 1
            },
            // when window width is >= 400px
            400: {
                slidesPerView: 2
            },
            // when window width is >= 640px
            768: {
                slidesPerView: 2
            },
            // when window width is >= 640px
            992: {
                slidesPerView: 3
            }
        }
    });

    // testimonial Slider
    var testimonialSlider1 = new Swiper("#testimonial-slider-1", {
        speed: 400,
        spaceBetween: 25,
        loop: false,
        slidesPerView: 2,

        // Navigation arrows
        navigation: {
            nextEl: '#testimonial-slider-btn-next',
            prevEl: '#testimonial-slider-btn-prev',
        },

        breakpoints: {
            // when window width is >= 320px
            320: {
                slidesPerView: 1
            },
            // when window width is >= 400px
            576: {
                slidesPerView: 2
            }
        }
    });
    var testimonialSlider2 = new Swiper("#testimonial-slider-2", {
        speed: 400,
        spaceBetween: 25,
        loop: false,
        slidesPerView: 1,
        effect: "creative",

        creativeEffect: {
            prev: {
                translate: [0, 0, -400],
            },
            next: {
                translate: ["100%", 0, 0],
            },
        },

        pagination: {
            el: "#testimonial-slider-2-pagination",
            clickable: true,
        }
    });

    // Product single slider
    var proSingleThumbs = new Swiper(".slider-thumbnails", {
        spaceBetween: 10,
        slidesPerView: 4,
        freeMode: true,
        watchSlidesProgress: true
    });
    var proSingleSlider = new Swiper(".product-single-slider", {
        loop: false,
        spaceBetween: 30,
        // Navigation arrows
        navigation: {
            nextEl: "#product-single-next",
            prevEl: "#product-single-prev",
        },
        thumbs: {
            swiper: proSingleThumbs,
        }
    });

    // Products slider
    var productsSlider = new Swiper(".products-slider", {
        speed: 400,
        spaceBetween: 24,
        slidesPerView: 3,
        slidesPerGroup: 3,
        pagination: true,
        watchSlidesProgress: true,

        pagination: {
            el: "#products-slider-pagination",
            clickable: true,
        },

        breakpoints: {
            // when window width is >= 320px
            320: {
                slidesPerView: 1
            },
            // when window width is >= 400px
            400: {
                slidesPerView: 2
            },
            // when window width is >= 640px
            768: {
                slidesPerView: 2
            },
            // when window width is >= 640px
            992: {
                slidesPerView: 3
            }
        }
    });

    // Products modal single slider
    $(document).ready(function () {
        $('.products-modal').each(() => {
            var proModalSlider = new Swiper('.product-modal-single-slider', {
                spaceBetween: 30,
                effect: "fade",
                pagination: true,

                pagination: {
                    el: "#product-modal-single-slider-pagination",
                    clickable: true,
                },

                // Navigation arrows
                navigation: {
                    nextEl: "#slider-btn-next",
                    prevEl: "#slider-btn-prev",
                },
            });
        })
    })

    /*============================================
        Pricing toggle
    ============================================*/
    $("#toggleSwitch").on("change", function (event) {
        if (event.currentTarget.checked) {
            $("#yearly").addClass("active");
            $("#monthly").removeClass("active");
        } else {
            $("#monthly").addClass("active");
            $("#yearly").removeClass("active");
        }
    })


    /*============================================
        Tabs mouse hover animation
    ============================================*/
    $("[data-hover='fancyHover']").mouseHover();


    /*============================================
        Pricing show more toggle
    ============================================*/
    $(".pricing-list").each(function (i) {
        var list = $(this).children();

        if (list.length > 6) {
            this.insertAdjacentHTML('afterEnd', `<span class="show-more">${show_more}</span>`);
            const showLink = $(this).next(".show-more");

            list.slice(6).toggle(300);

            showLink.on("click", function () {
                list.slice(6).toggle(300);

                showLink.html(showLink.html() === show_more ? show_less : show_more)
            })
        }
    })


    /*============================================
      Read more toggle button
    ============================================*/
    $(".read-more-btn").on("click", function () {
        $(this).prev().toggleClass('show');

        if ($(this).prev().hasClass("show")) {
            $(this).text(read_less);
        } else {
            $(this).text(read_more);
        }
    })

    /*============================================
      Toggle List
    ============================================*/
    $("#toggleList").each(function (i) {
        var list = $(this).children();
        var listShow = $(this).data("toggle-show");
        var listShowBtn = $(this).next("[data-toggle-btn]");

        if (list.length > listShow) {
            listShowBtn.show()
            list.slice(listShow).toggle(300);

            listShowBtn.on("click", function () {
                list.slice(listShow).slideToggle(300);

                $(this).prev().toggleClass('show');
                if ($(this).prev().hasClass("show")) {
                    $(this).text(show_less);
                } else {
                    $(this).text(show_more);
                }
            })
        } else {
            listShowBtn.hide()
        }
    })


    /*============================================
        Gallery popup
    ============================================*/
    $(".gallery-popup").each(function () {
        $(this).magnificPopup({
            delegate: 'a',
            type: 'image',
            mainClass: 'mfp-fade',
            gallery: {
                enabled: true,
                navigateByImgClick: true,
                preload: [0, 1]
            },
            image: {
                tError: '<a href="%url%">The image #%curr%</a> could not be loaded.'
            },
            callbacks: {
                elementParse: function (item) {
                    // the class name
                    if (item.el.hasClass("video-link")) {
                        item.type = 'iframe';
                    } else {
                        item.type = 'image';
                    }
                }
            },
            removalDelay: 500, //delay removal by X to allow out-animation
            closeOnContentClick: true,
            midClick: true
        });
    })


    /*============================================
        Youtube popup
    ============================================*/
    $(".youtube-popup").magnificPopup({
        disableOn: 300,
        type: "iframe",
        mainClass: "mfp-fade",
        removalDelay: 160,
        preloader: false,
        fixedContentPos: false
    })


    /*============================================
        Go to top
    ============================================*/
    $(window).on("scroll", function () {
        // If window scroll down .active class will added to go-top
        var goTop = $(".go-top");

        if ($(window).scrollTop() >= 200) {
            goTop.addClass("active");
        } else {
            goTop.removeClass("active")
        }
    })
    $(".go-top").on("click", function (e) {
        $("html, body").animate({
            scrollTop: 0,
        }, 0);
    });


    /*============================================
        Lazyload image
    ============================================*/
    var lazyLoad = function () {
        window.lazySizesConfig = window.lazySizesConfig || {};
        window.lazySizesConfig.loadMode = 2;
        lazySizesConfig.preloadAfterLoad = true;
    }


    /*============================================
        Tooltip
    ============================================*/
    var tooltipTriggerList = [].slice.call($('[data-tooltip="tooltip"]'))

    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
    })


    /*============================================
        Aos animation
    ============================================*/
    AOS.init({
        easing: "ease-out",
        duration: 700,
        once: true
    });

    /*============================================
        Nice select
    ============================================*/
    $(".niceselect").niceSelect();

    var selectList = $(".nice-select .list")
    $(".nice-select .list").each(function () {
        var list = $(this).children();
        if (list.length > 5) {
            $(this).css({
                "height": "160px",
                "overflow-y": "scroll"
            })
        }
    })

    /*============================================
      Select2
    ============================================*/
    $('.select2').select2();


    /*============================================
        Odometer
    ============================================*/
    $(".counter").counterUp({
        delay: 10,
        time: 1000
    });


    /*============================================
        Data picker
    ============================================*/
    $(".datepicker").datepicker({
        format: 'mm/dd/yyyy',
        startDate: '-3d',
        clearBtn: true
    });


    /*============================================
        Data tables
    ============================================*/
    var dataTable = function () {
        var dTable = $("#myTable");

        if (dTable.length) {
            dTable.DataTable()
        }
    }


    /*============================================
        Image upload
    ============================================*/
    var fileReader = function (input) {
        var regEx = new RegExp(/\.(gif|jpe?g|tiff?|png|webp|bmp)$/i);
        var errorMsg = $("#errorMsg");

        if (input.files && input.files[0] && regEx.test(input.value)) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#imagePreview').css('background-image', 'url(' + e.target.result + ')');
                $('#imagePreview').hide();
                $('#imagePreview').fadeIn(650);
            };
            reader.readAsDataURL(input.files[0]);
        } else {
            errorMsg.html("Please upload a valid file type")
        }
    }
    $("#imageUpload").on("change", function () {
        fileReader(this);
    });


    /*============================================
        Cookiebar
    ============================================*/
    window.setTimeout(function () {
        $(".cookie-bar").addClass("show")
    }, 1000);
    $(".cookie-bar .btn").on("click", function () {
        $(".cookie-bar").removeClass("show")
    });

    /*============================================
        Footer date
    ============================================*/
    var date = new Date().getFullYear();
    $("#footerDate").text(date);


    /*============================================
        Document on ready
    ============================================*/
    $(document).ready(function () {
        lazyLoad(),
            dataTable()
    })

    /*============================================
        Toggle List
    ============================================*/
    $("[data-toggle-list]").each(function (i) {
        var list = $(this).children();
        var listShow = $(this).data("toggle-show");
        var listShowBtn = $(this).next("[data-toggle-btn]");

        if (list.length > listShow) {
            listShowBtn.show()
            list.slice(listShow).toggle(300);

            listShowBtn.on("click", function () {
                list.slice(listShow).slideToggle(300);
                $(this).text($(this).text() === show_less ? show_more : show_less)
            })
        } else {
            listShowBtn.hide()
        }
    })

})(jQuery);
// add user email for subscription
$('.subscription-form').on('submit', function (event) {
    event.preventDefault();
    let formURL = $(this).attr('action');
    let formMethod = $(this).attr('method');

    let formData = new FormData($(this)[0]);

    $.ajax({
        url: formURL,
        method: formMethod,
        data: formData,
        processData: false,
        contentType: false,
        dataType: 'json',
        success: function (response) {
            $('input[name="email_id"]').val('');
            toastr[response.alert_type](response.message)
            toastr.options = {
                "closeButton": true,
                "progressBar": true,
                "timeOut ": 10000,
                "extendedTimeOut": 10000,
                "positionClass": "toast-top-right",
            }
        },
        error: function (errorData) {
            toastr['error'](errorData.responseJSON.error.email_id[0]);
        }
    });
});


$(document).ready(function () {
    $('#vendorContactForm').on('submit', function (e) {
        e.preventDefault();
        $(".request-loader").addClass("show");
        $('.text-danger').text('');

        // Instead of serialize(), use FormData
        var formData = new FormData(this);

        $.ajax({
            url: $(this).attr('action'),
            type: 'POST',
            data: formData,
            processData: false, 
            contentType: false, 
            success: function (response) {
                $('.request-loader').removeClass('show');
                location.reload();
            },
            error: function (xhr) {
                $('.request-loader').removeClass('show');
                var errors = xhr.responseJSON.errors;
                if (errors) {
                    $.each(errors, function (key, value) {
                        $('#err_' + key).text(value[0]);
                    });
                    // Show modal on errors
                    $('#productsModal_{{ $details->id }}').modal('show');
                }
            }
        });
    });


    /*============================================
        Mobile Language Switcher
    ============================================*/
    $(document).on('click', '.mobile-lang-btn', function (e) {
        e.stopPropagation();
        $(this).parent('.mobile-lang').toggleClass('open');
    });

    $(document).on('click', function () {
        $('.mobile-lang').removeClass('open');
    });

    $(document).on('click', '.mobile-lang-dropdown a', function (e) {
        e.preventDefault();
        var langCode = $(this).data('lang');
        var $form = $(this).closest('.mobile-lang').find('form');
        $form.find('input[name="lang_code"]').val(langCode);
        $form.submit();
    });
});
