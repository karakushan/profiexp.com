<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| vendor Interface Routes
|--------------------------------------------------------------------------
*/

Route::post('/ai/generate/image', 'Vendor\Ai\AiImageController@generateImage')
  ->name('vendor.ai.generate.category.image')->middleware('aiQuotaWarning');
Route::post('/ai/generate/content', 'Vendor\Ai\AiContentController@generateContent')
  ->name('vendor.ai.generate.content')->middleware('aiQuotaWarning');
Route::post('/vendor/ai/generate-slider-images', 'Vendor\Ai\AiImageController@generateSliderImages')
  ->name('vendor.ai.generate.slider.images')->middleware('aiQuotaWarning');

Route::post('/vendor/membership/wayforpay/notify', 'Payment\WayforpayController@notify')->name('membership.wayforpay.notify');

Route::prefix('vendor')->middleware('change.lang')->group(function () {
  Route::get('/signup', 'Vendor\VendorController@signup')->name('vendor.signup');
  Route::post('/signup/submit', 'Vendor\VendorController@create')->name('vendor.signup_submit')->middleware('Demo');
  Route::get('/login', 'Vendor\VendorController@login')->name('vendor.login');
  Route::post('/login/submit', 'Vendor\VendorController@authentication')->name('vendor.login_submit');

  Route::get('/email/verify', 'Vendor\VendorController@confirm_email');

  Route::get('/forget-password', 'Vendor\VendorController@forget_passord')->name('vendor.forget.password');
  Route::post('/send-forget-mail', 'Vendor\VendorController@forget_mail')->name('vendor.forget.mail');
  Route::get('/reset-password', 'Vendor\VendorController@reset_password')->name('vendor.reset.password');
  Route::post('/update-forget-password', 'Vendor\VendorController@update_password')->name('vendor.update-forget-password');
  Route::get('/language-management/{id}/check-rtl', 'Vendor\VendorController@checkRTL')
    ->name('language-management.check-rtl');
});

Route::get('/set-locale-vendor', 'Vendor\VendorController@setLocaleAdmin')->name('set-locale-vendor');

Route::prefix('vendor')->middleware(['auth:vendor', 'Demo', 'Deactive', 'email.verify', 'vendorLang'])->group(function () {

  Route::prefix('listing-management')->group(function () {
    Route::get('get-select-country', 'Vendor\Listing\ListingController@getCountry')->name('vendor.get_country');
    Route::get('get-select-city', 'Vendor\Listing\ListingController@getSearchCity')->name('vendor.get_city');
    Route::get('get-select-state', 'Vendor\Listing\ListingController@searchSate')->name('vendor.get_state');
    Route::get('get-select-categories', 'Vendor\Listing\ListingController@homeCategories')->name('vendor.get_categories');

    Route::get('/', 'Vendor\Listing\ListingController@index')->name('vendor.listing_management.listings');

    Route::prefix('/purchase-feature')->group(function () {

      Route::post('', 'Vendor\Listing\FeaturePaymentGetway\ListingFeatureController@index')->name('vendor.listing_management.listing.purchase_feature');
      Route::get('/paypal/notify', 'Vendor\Listing\FeaturePaymentGetway\PayPalController@notify')->name('vendor.listing_management.listing.purchase_feature.paypal.notify');
      Route::get('/instamojo/notify', 'Vendor\Listing\FeaturePaymentGetway\InstamojoController@notify')->name('vendor.listing_management.listing.purchase_feature.instamojo.notify');
      Route::get('/mollie/notify', 'Vendor\Listing\FeaturePaymentGetway\MollieController@notify')->name('vendor.listing_management.listing.purchase_feature.mollie.notify');
      Route::post('/razorpay/notify', 'Vendor\Listing\FeaturePaymentGetway\RazorpayController@notify')->name('vendor.listing_management.listing.purchase_feature.razorpay.notify');
      Route::get('/mercadopago/notify', 'Vendor\Listing\FeaturePaymentGetway\MercadoPagoController@notify')->name('vendor.listing_management.listing.purchase_feature.mercadopago.notify');
      Route::get('/flutterwave/notify', 'Vendor\Listing\FeaturePaymentGetway\FlutterwaveController@notify')->name('vendor.listing_management.listing.purchase_feature.flutterwave.notify');
      Route::get('/paystack/notify', 'Vendor\Listing\FeaturePaymentGetway\PaystackController@notify')->name('vendor.listing_management.listing.purchase_feature.paystack.notify');
      Route::post('/paytm/notify', 'Vendor\Listing\FeaturePaymentGetway\PaytmController@notify')->name('vendor.listing_management.listing.purchase_feature.paytm.notify');


      Route::get('/midtrans/notify', 'Vendor\Listing\FeaturePaymentGetway\MidtransController@creditCardNotify')->name('vendor.listing_management.listing.purchase_feature.midtrans.notify');
      Route::get('/toyyibpay/notify', 'Vendor\Listing\FeaturePaymentGetway\ToyyibpayController@notify')->name('vendor.listing_management.listing.purchase_feature.toyyibpay.notify');
      Route::get('/xendit/notify', 'Vendor\Listing\FeaturePaymentGetway\XenditController@notify')->name('vendor.listing_management.listing.purchase_feature.xendit.notify');
      Route::get('/yoco/notify', 'Vendor\Listing\FeaturePaymentGetway\YocoController@notify')->name('vendor.listing_management.listing.purchase_feature.yoco.notify');
      Route::post('/paytabs/notify', 'Vendor\Listing\FeaturePaymentGetway\PaytabsController@notify')->name('vendor.listing_management.listing.purchase_feature.paytabs.notify');
      Route::get('/paytabs/cancel', 'Vendor\Listing\FeaturePaymentGetway\PaytabsController@cancel')->name('vendor.listing_management.listing.purchase_feature.paytabs.cancel');
      Route::post('/iyzico/notify', 'Vendor\Listing\FeaturePaymentGetway\IyzicoController@notify')->name('vendor.listing_management.listing.purchase_feature.iyzico.notify');
      Route::get('/iyzico/cancle', 'Vendor\Listing\FeaturePaymentGetway\IyzicoController@iyzicoCancle')->name('vendor.listing_management.listing.purchase_feature.iyzico.cancle');

      Route::get('/perfect-money/notify', 'Vendor\Listing\FeaturePaymentGetway\PerfectMoneyController@notify')->name('vendor.listing_management.listing.purchase_feature.perfect_money.notify');
      Route::any('/phonepe/notify', 'Vendor\Listing\FeaturePaymentGetway\PhonepeController@notify')->name('vendor.listing_management.listing.purchase_feature.phonepe.notify');


      Route::get('/offline/success', 'Vendor\Listing\FeaturePaymentGetway\ListingFeatureController@offlineSuccess')->name('vendor.listing_management.listings.purchase_feature.offline.success');
    });

    Route::post('update_visibility', 'Vendor\Listing\ListingController@updateVisibility')->name('vendor.listing_management.update_listing_visibility');


    Route::post('/get-state', 'Vendor\Listing\ListingController@getState')->name('vendor.listing_management.get-state');
    Route::post('/get-city', 'Vendor\Listing\ListingController@getCity')->name('vendor.listing_management.get-city');

    Route::get('/create', 'Vendor\Listing\ListingController@create')->name('vendor.listing_management.create_listing');
    Route::post('store', 'Vendor\Listing\ListingController@store')->name('vendor.listing_management.store_listing')->middleware('packageLimitsCheck:listing,store');

    Route::get('edit-listing/{id}', 'Vendor\Listing\ListingController@edit')->name('vendor.listing_management.edit_listing');
    Route::post('update/{id}', 'Vendor\Listing\ListingController@update')->name('vendor.listing_management.update_listing')->middleware('packageLimitsCheck:listing,update');

    Route::post('delete-video-image/{id}', 'Vendor\Listing\ListingController@videoImageRemove')->name('vendor.listing_management.video_image.delete');

    Route::get('slider-images/{id}', 'Vendor\Listing\ListingController@getSliderImages');

    Route::post('delete/{id}', 'Vendor\Listing\ListingController@delete')->name('vendor.listing_management.delete_listing');

    Route::post('bulk_delete', 'Vendor\Listing\ListingController@bulkDelete')->name('vendor.listing_management.bulk_delete.listing');

    Route::post('specification/delete', 'Vendor\Listing\ListingController@featureDelete')->name('vendor.listing_management.feature_delete');

    Route::post('social/delete', 'Vendor\Listing\ListingController@socialDelete')->name('vendor.listing_management.social_delete');
    Route::post('aminitie/cng', 'Vendor\Listing\ListingController@aminitieUpdate')->name('vendor.listing_management.update_aminitie');


    //listing plugins route start
    Route::get('/plugins/{id}', 'Vendor\Listing\ListingController@plugins')->name('vendor.listing_management.listing.plugins');


    Route::post('/update-tawkto/{id}', 'Vendor\Listing\ListingController@updateTawkTo')->name('vendor.listing_management.listing.update_tawkto');

    Route::post('/update-telegram/{id}', 'Vendor\Listing\ListingController@updateTelegram')->name('vendor.listing_management.listing.update_telegram');

    Route::post('/update-whatsapp/{id}', 'Vendor\Listing\ListingController@updateWhatsApp')->name('vendor.listing_management.listing.update_whatsapp');

    Route::post('/update-messenger/{id}', 'Vendor\Listing\ListingController@updateMessanger')->name('vendor.listing_management.listing.update_messenger');
    // listing plugins route end

    //mnange social link

    Route::get('manage-social-link/{id}', 'Vendor\Listing\ListingController@manageSocialLink')->name('vendor.listing_management.manage_social_link');

    Route::post('upadte-social-link/{id}', 'Vendor\Listing\ListingController@updateSocialLink')->name('vendor.listing_management.update_social_link')->middleware('packageLimitsCheck:listing,update');

    //end managing social link

    //mnange Feature link

    Route::get('manage-additional-specification/{id}', 'Vendor\Listing\ListingController@manageAdditionalSpecification')->name('vendor.listing_management.manage_additional_specifications');

    Route::post('upadte-additional-specification/{id}', 'Vendor\Listing\ListingController@updateAdditionalSpecification')->name('vendor.listing_management.update_additional_specification')->middleware('packageLimitsCheck:listing,update');

    //end managing Feature link

    //business hours

    Route::get('/business-hours/{id}', 'Vendor\Listing\ListingController@businessHours')->name('vendor.listing_management.listing.business_hours');

    Route::post('update-business-hours/{id}', 'Vendor\Listing\ListingController@updateBusinessHours')->name('vendor.listing_management.listing.business_hours_update');

    Route::post('update_holiday', 'Vendor\Listing\ListingController@updateHoliday')->name('vendor.listing_management.listing.business_hours.update_holiday');

    //end Business Hours

    //FAQ ROUTE START

    Route::get('/faq/{id}', 'Vendor\Listing\FaqController@index')->name('vendor.listing_management.listing.faq');

    Route::post('/store-faq', 'Vendor\Listing\FaqController@store')->name('vendor.listing_management.listing.store_faq')->middleware('packageLimitsCheck:faq,store');

    Route::post('/update-faq', 'Vendor\Listing\FaqController@update')->name('vendor.listing_management.listing.update_faq')->middleware('packageLimitsCheck:listing,update');

    Route::post('/delete-faq/{id}', 'Vendor\Listing\FaqController@destroy')->name('vendor.listing_management.listing.delete_faq');

    Route::post('/bulk-delete-faq', 'Vendor\Listing\FaqController@bulkDestroy')->name('vendor.listing_management.listing.bulk_delete_faq');

    //FAQ ROUTE END

    //#==========Listing slider image
    Route::post('/img-store', 'Vendor\Listing\ListingController@imagesstore')->name('vendor.listing.imagesstore');
    Route::post('/img-remove', 'Vendor\Listing\ListingController@imagermv')->name('vendor.listing.imagermv');
    Route::post('/img-db-remove', 'Vendor\Listing\ListingController@imagedbrmv')->name('vendor.listing.imgdbrmv');
    //#==========Listing slider image End
  });



  //MAil set for recived Mail
  Route::get('/mail-to-vendor', 'Vendor\MAilSetController@mailToAdmin')->name('vendor.email_setting.mail_to_admin');

  Route::post('/update-mail-to-vendor', 'Vendor\MAilSetController@updateMailToAdmin')->name('vendor.update_mail_to_vendor');

  //Show message
  Route::get('/listing-messages', 'Vendor\MessageController@index')->name('vendor.listing.messages');
  Route::post('/listing-message/delete', 'Vendor\MessageController@delete')->name('vendor.listing.message.delete_message');

  Route::post('listing-bulk_delete', 'Vendor\MessageController@bulkDelete')->name('vendor.listing.message.bulk_delete.message');

  Route::get('/product-messages', 'Vendor\MessageController@productIndex')->name('vendor.product.messages');
  Route::get('vendor/product/message/{id}/details', 'Vendor\MessageController@showMessageDetails')
    ->name('vendor.product.message.details');
  Route::post('/product-message/delete', 'Vendor\MessageController@productDelete')->name('vendor.product.message.delete_message');

  Route::post('product-bulk_delete', 'Vendor\MessageController@productBulkDelete')->name('vendor.product.message.bulk_delete.message');
  //End Message

  //profile

  Route::get('dashboard', 'Vendor\VendorController@dashboard')->name('vendor.dashboard');
  Route::get('/change-password', 'Vendor\VendorController@change_password')->name('vendor.change_password');
  Route::post('/update-password', 'Vendor\VendorController@updated_password')->name('vendor.update_password');
  Route::get('/edit-profile', 'Vendor\VendorController@edit_profile')->name('vendor.edit.profile');
  Route::post('/profile/update', 'Vendor\VendorController@update_profile')->name('vendor.update_profile');
  Route::get('/logout', 'Vendor\VendorController@logout')->name('vendor.logout');

  // change admin-panel theme (dark/light) route
  Route::post('/change-theme', 'Vendor\VendorController@changeTheme')->name('vendor.change_theme')->withoutMiddleware('Demo');
  Route::get('/payment-log', 'Vendor\VendorController@payment_log')->name('vendor.payment_log');

  //vendor package extend route
  Route::get('/package-list', 'Vendor\BuyPlanController@index')->name('vendor.plan.extend.index');
  Route::get('/package/checkout/{package_id}', 'Vendor\BuyPlanController@checkout')->name('vendor.plan.extend.checkout');
  Route::post('/package/checkout', 'Vendor\VendorCheckoutController@checkout')->name('vendor.plan.checkout');

  Route::post('/payment/instructions', 'Vendor\VendorCheckoutController@paymentInstruction')->name('vendor.payment.instructions')->withoutMiddleware('Demo');


  //checkout payment gateway routes
  Route::prefix('membership')->group(function () {
    Route::get('paypal/success', "Payment\PaypalController@successPayment")->name('membership.paypal.success');
    Route::get('paypal/cancel', "Payment\PaypalController@cancelPayment")->name('membership.paypal.cancel');
    Route::get('stripe/cancel', "Payment\StripeController@cancelPayment")->name('membership.stripe.cancel');
    Route::post('paytm/payment-status', "Payment\PaytmController@paymentStatus")->name('membership.paytm.status');
    Route::get('paystack/success', 'Payment\PaystackController@successPayment')->name('membership.paystack.success');
    Route::post('mercadopago/cancel', 'Payment\paymenMercadopagoController@cancelPayment')->name('membership.mercadopago.cancel');
    Route::get('mercadopago/success', 'Payment\MercadopagoController@successPayment')->name('membership.mercadopago.success');
    Route::post('razorpay/success', 'Payment\RazorpayController@successPayment')->name('membership.razorpay.success');
    Route::post('razorpay/cancel', 'Payment\RazorpayController@cancelPayment')->name('membership.razorpay.cancel');
    Route::get('instamojo/success', 'Payment\InstamojoController@successPayment')->name('membership.instamojo.success');
    Route::post('instamojo/cancel', 'Payment\InstamojoController@cancelPayment')->name('membership.instamojo.cancel');
    Route::post('flutterwave/success', 'Payment\FlutterWaveController@successPayment')->name('membership.flutterwave.success');
    Route::post('flutterwave/cancel', 'Payment\FlutterWaveController@cancelPayment')->name('membership.flutterwave.cancel');
    Route::get('/mollie/success', 'Payment\MollieController@successPayment')->name('membership.mollie.success');
    Route::post('mollie/cancel', 'Payment\MollieController@cancelPayment')->name('membership.mollie.cancel');
    Route::get('anet/cancel', 'Payment\AuthorizeController@cancelPayment')->name('membership.anet.cancel');

    Route::get('/xendit/notify', 'Payment\XenditController@notify')->name('membership.xendit.notify');
    Route::any('/phonepe/notify', 'Payment\PhonepeController@notify')->name('membership.phonepe.notify');
    Route::get('/toyyibpay/notify', 'Payment\ToyyibpayController@notify')->name('membership.toyyibpay.notify');
    Route::get('/midtrans/notify', 'Payment\MidtransController@creditCardNotify')->name('membership.midtrans.notify');
    Route::get('/yoco/notify', 'Payment\YocoController@notify')->name('membership.yoco.notify');
    Route::get('/perfect-money/notify', 'Payment\PerfectMoneyController@notify')->name('membership.perfect_money.notify');
    Route::post('/paytabs/notify', 'Payment\PaytabsController@notify')->name('membership.paytabs.notify');
    Route::get('/paytabs/cancel', 'Payment\PaytabsController@cancel')->name('membership.paytabs.cancel');

    Route::post('/iyzico/notify', 'Payment\IyzicoController@notify')->name('membership.iyzico.notify');
    Route::get('/iyzico/cancle', 'Payment\IyzicoController@iyzicoCancle')->name('membership.iyzico.cancle');


    Route::get('/cancel', 'Vendor\VendorCheckoutController@cancel')->name('membership.cancel');
    Route::get('/offline/success', 'Front\CheckoutController@offlineSuccess')->name('membership.offline.success');
    Route::get('/trial/success', 'Front\CheckoutController@trialSuccess')->name('membership.trial.success');
    Route::get('/online/success', 'Vendor\VendorCheckoutController@onlineSuccess')->name('success.page');
  });

  #====support tickets ============
  Route::get('support/ticket/create', 'Vendor\SupportTicketController@create')->name('vendor.support_ticket.create');
  Route::post('support/ticket/store', 'Vendor\SupportTicketController@store')->name('vendor.support_ticket.store');
  Route::get('support/tickets', 'Vendor\SupportTicketController@index')->name('vendor.support_tickets');
  Route::get('support/message/{id}', 'Vendor\SupportTicketController@message')->name('vendor.support_tickets.message');
  Route::post('support-ticket/zip-upload', 'Vendor\SupportTicketController@zip_file_upload')->name('vendor.support_ticket.zip_file.upload');
  Route::post('support-ticket/reply/{id}', 'Vendor\SupportTicketController@ticketreply')->name('vendor.support_ticket.reply');

  Route::post('support-ticket/delete/{id}', 'Vendor\SupportTicketController@delete')->name('vendor.support_tickets.delete');

  // Vendor Shop Routes
  Route::prefix('/vendor/shop-management')->group(function () {
    
    Route::get('/products', 'Vendor\Shop\ProductController@index')->name('vendor.shop_management.products');
    Route::get('/select-product-type', 'Vendor\Shop\ProductController@productType')->name('vendor.shop_management.select_product_type');
    Route::get('/create-product/{type}', 'Vendor\Shop\ProductController@create')->name('vendor.shop_management.create_product');
    Route::post('/upload-slider-image', 'Vendor\Shop\ProductController@uploadImage')->name('vendor.shop_management.upload_slider_image');
    Route::post('/remove-slider-image', 'Vendor\Shop\ProductController@removeImage')->name('vendor.shop_management.remove_slider_image');
    Route::post('/store-product', 'Vendor\Shop\ProductController@store')->name('vendor.shop_management.store_product')->middleware('packageLimitsCheck:product,store');
    Route::get('/edit-product/{id}/{type}', 'Vendor\Shop\ProductController@edit')->name('vendor.shop_management.edit_product');
    Route::post('/detach-slider-image', 'Vendor\Shop\ProductController@detachImage')->name('vendor.shop_management.detach_slider_image');
    Route::post('/update-product/{id}', 'Vendor\Shop\ProductController@update')->name('vendor.shop_management.update_product')->middleware('packageLimitsCheck:listing,update');
    Route::post('/delete-product/{id}', 'Vendor\Shop\ProductController@destroy')->name('vendor.shop_management.delete_product');
    Route::post('/bulk-delete-product', 'Vendor\Shop\ProductController@bulkDestroy')->name('vendor.shop_management.bulk_delete_product');

    // Order Routes
    Route::get('/orders', 'Vendor\Shop\OrderController@orders')->name('vendor.shop_management.orders');
    Route::prefix('/order/{id}')->group(function () {
      Route::post('/update-payment-status', 'Vendor\Shop\OrderController@updatePaymentStatus')->name('vendor.shop_management.order.update_payment_status');
      Route::post('/update-order-status', 'Vendor\Shop\OrderController@updateOrderStatus')->name('vendor.shop_management.order.update_order_status');
      Route::get('/details', 'Vendor\Shop\OrderController@show')->name('vendor.shop_management.order.details');
      Route::post('/delete', 'Vendor\Shop\OrderController@destroy')->name('vendor.shop_management.order.delete');
    });
    Route::post('/bulk-delete-order', 'Vendor\Shop\OrderController@bulkDestroy')->name('vendor.shop_management.bulk_delete_order');

  });

  Route::prefix('withdraw')->group(function () {
    Route::get('/', 'Vendor\VendorWithdrawController@index')
      ->name('vendor.withdraw');

    Route::get('/create', 'Vendor\VendorWithdrawController@create')
      ->name('vendor.withdraw.create');

    Route::get('/get-method/input/{id}', 'Vendor\VendorWithdrawController@get_inputs');

    Route::get('/balance-calculation/{method}/{amount}', 'Vendor\VendorWithdrawController@balance_calculation');

    Route::post('/send-request', 'Vendor\VendorWithdrawController@send_request')
      ->name('vendor.withdraw.send-request');

    Route::post('/withdraw/bulk-delete', 'Vendor\VendorWithdrawController@bulkDelete')
      ->name('vendor.withdraw.bulk_delete_withdraw');

    Route::post('/withdraw/delete', 'Vendor\VendorWithdrawController@Delete')
      ->name('vendor.withdraw.delete_withdraw');
  });

  // Form Builder Management Routes for vendor
  Route::prefix('forms')->group(function () {

    Route::get('', 'Vendor\FormController@index')->name('vendor.listings-management.form.index');
    Route::post('/store-form', 'Vendor\FormController@store')->name('vendor.listings-management.form.store');
    Route::post('/update-form', 'Vendor\FormController@update')->name('vendor.listings-management.update_form');
    Route::post('/delete-form/{id}', 'Vendor\FormController@destroy')->name('vendor.listings-management.delete_form');

    // Form Input Management Routes for vendor
    Route::prefix('/form')->group(function () {
      Route::get('/{id}/input', 'Vendor\FormInputController@manageInput')->name('vendor.listings-management.form.input');
      Route::post('/{id}/store-input', 'Vendor\FormInputController@storeInput')->name('vendor.listings-management.form.store_input');
      Route::get('/{form_id}/edit-input/{input_id}', 'Vendor\FormInputController@editInput')->name('vendor.listings-management.form.edit_input');
      Route::post('/update-input/{id}', 'Vendor\FormInputController@updateInput')->name('vendor.listings-management.form.update_input');
      Route::post('/delete-input/{id}', 'Vendor\FormInputController@destroyInput')->name('vendor.listings-management.form.delete_input');
      Route::post('/sort-input', 'Vendor\FormInputController@sortInput')->name('vendor.listings-management.form.sort_input');
    });
  });
});
