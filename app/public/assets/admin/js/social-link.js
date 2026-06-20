"use strict";
$(document).ready(function () {

  var maxSocialLinks = SocialLinkLimit;
  socialLink(maxSocialLinks);

});

function socialLink(maxSocialLinks) {

  var addItem = function (key) {
    let rpItemNode = '';
    let it = $(".js-repeaters-item:last-child").index() + 1;

    rpItemNode += `<div class="js-repeaters-item p-3" data-item="${it}">
                        <div class="row align-items-end gutters-2">`

    rpItemNode += `<div class="col-sm-4 col-lg-3">
                            <label for="form" class="form-label mb-1">${SocialLink} </label>
                            <div class=" mb-2">
                                <input type="text" required class="form-control" placeholder="" name="socail_link[]">
                            </div>
                            </div>`

    rpItemNode += `<div class="col-sm-4 col-lg-3">
                          <label for="form" class="form-label mb-1">${SelectIcon} </label>
                            <div class="mb-2">
                            <button class="btn btn-primary iconpicker-component aaa">
                            <i class="fab fa-facebook-square"></i>
                              </button>
                              <button type="button" class="icp icp-dd btn btn-primary dropdown-toggle" data-selected="fa-car"
                                data-toggle="dropdown">
                              </button>
                              <div class="dropdown-menu"></div>
                            </div>
                          </div>`;

    rpItemNode += `<div class="col">
                      <button class="btn btn-danger btn-sm js-repeaters-remove mb-2 mr-2" type="button"
                                      onclick="$(this).parents('.js-repeaters-item').remove()">X</button>
                          <div class="repeaters-child-list mt-2 col-12" id="options${it}"></div>
                      </div>
                    </div>
                  </div>`;
    $("#js-repeaters-container").append(rpItemNode);
    $('.icp-dd').iconpicker();
  };
  /* find elements */
  var repeater = $(".js-repeaters");
  var key = 0;
  var addBtn = repeater.find('.js-repeaters-add');
  var items = $(".js-repeaters-item");
  var it = $(".js-repeaters-item").index();

  if (key <= 0) {
    // items.remove();
    /* handle click and add items */
    addBtn.on("click", function () {
      if ($("#js-repeaters-container .js-repeaters-item").length <= maxSocialLinks) {
        key++;
        addItem(key);
      } else {

        bootnotify('Social link limit reached or exceeded.!', 'Alert', 'warning');
      }
    });
  }
}
