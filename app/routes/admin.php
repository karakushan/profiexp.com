<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Admin Panel Routes
|--------------------------------------------------------------------------
*/

Route::get('/set-locale-admin', 'Admin\BasicSettings\BasicController@setLocaleAdmin')->name('set-locale-admin');
Route::prefix('/admin')->middleware('auth:admin', 'Demo', 'adminLang')->group(function () {

    // admin redirect to dashboard route

    Route::get('/dashboard', 'Admin\AdminController@redirectToDashboard')->name('admin.dashboard');
    Route::get('/membership-request', 'Admin\AdminController@membershipRequest')->name('admin.membership-request');
    Route::post('/membership-request/update/{id}', 'Admin\AdminController@membershipRequestUpdate')->name('admin.membership-request.update');
    Route::get('/monthly-profit', 'Admin\AdminController@monthly_profit')->name('admin.monthly_profit');
    Route::get('/monthly-earning', 'Admin\AdminController@monthly_earning')->name('admin.monthly_earning');

    // change admin-panel theme (dark/light) route
    Route::get('/change-theme', 'Admin\AdminController@changeTheme')->name('admin.change_theme');

    // admin profile settings route start
    Route::get('/edit-profile', 'Admin\AdminController@editProfile')->name('admin.edit_profile');

    Route::post('/update-profile', 'Admin\AdminController@updateProfile')->name('admin.update_profile');

    Route::get('/change-password', 'Admin\AdminController@changePassword')->name('admin.change_password');

    Route::post('/update-password', 'Admin\AdminController@updatePassword')->name('admin.update_password');
    // admin profile settings route end

    // admin logout attempt route
    Route::get('/logout', 'Admin\AdminController@logout')->name('admin.logout');

    // menu-builder route start
    Route::prefix('/menu-builder')->middleware('permission:Menu Builder')->group(function () {
        Route::get('', 'Admin\MenuBuilderController@index')->name('admin.menu_builder');

        Route::post('/update-menus', 'Admin\MenuBuilderController@update')->name('admin.menu_builder.update_menus');
    });
    // menu-builder route end

    // Payment Log
    Route::get('/payment-log', 'Admin\PaymentLogController@index')->name('admin.payment-log.index');
    Route::post('/payment-log/update', 'Admin\PaymentLogController@update')->name('admin.payment-log.update');

    Route::prefix('packages')->group(function () {
        // Package Settings routes
        Route::get('/settings', 'Admin\PackageController@settings')->name('admin.package.settings');
        Route::post('/settings', 'Admin\PackageController@updateSettings')->name('admin.package.settings.update');
        // Package routes

        Route::get('', 'Admin\PackageController@index')->name('admin.package.index');
        Route::post('/store', 'Admin\PackageController@store')->name('admin.package.store');
        Route::get('/{id}/edit', 'Admin\PackageController@edit')->name('admin.package.edit');

        Route::post('/update', 'Admin\PackageController@update')->name('admin.package.update');
        Route::post('package/upload', 'Admin\PackageController@upload')->name('admin.package.upload');

        Route::post('package/{id}/uploadUpdate', 'Admin\PackageController@uploadUpdate')->name('admin.package.uploadUpdate');
        Route::post('package/delete', 'Admin\PackageController@delete')->name('admin.package.delete');
        Route::post('package/bulk-delete', 'Admin\PackageController@bulkDelete')->name('admin.package.bulk.delete');
    });

    Route::prefix('/feature-listings')->group(function () {

        Route::get('/charges', 'Admin\FeaturedListing\ChargeController@index')->name('admin.featured_listing.charge');
        Route::post('/charge-store', 'Admin\FeaturedListing\ChargeController@store')->name('admin.featured_listing.charge_store');

        Route::post('/update-charge', 'Admin\FeaturedListing\ChargeController@update')->name('admin.featured_listing.update');

        Route::post('/delete-charge/{id}', 'Admin\FeaturedListing\ChargeController@destroy')->name('admin.featured_listing.charge.delete');

        Route::post('/bulk-delete-charge', 'Admin\FeaturedListing\ChargeController@bulkDestroy')->name('admin.featured_listing.charge.bulk_delete');

        Route::get('/all-requests', 'Admin\FeaturedListing\OrderRequestController@index')->name('admin.featured_listing.all_request');

        Route::get('/pending-requests', 'Admin\FeaturedListing\OrderRequestController@pending')->name('admin.featured_listing.pending_request');

        Route::get('/approved-requests', 'Admin\FeaturedListing\OrderRequestController@approved')->name('admin.featured_listing.approved_request');

        Route::get('/rejected-requests', 'Admin\FeaturedListing\OrderRequestController@rejected')->name('admin.featured_listing.rejected_request');


        Route::post('/update-payment-status/{id}', 'Admin\FeaturedListing\OrderRequestController@updatePaymentStatus')->name('admin.featured_listing.update_payment_status');

        Route::post('/update-order-status/{id}', 'Admin\FeaturedListing\OrderRequestController@updateOrderStatus')->name('admin.featured_listing.update_order_status');

        Route::post('/delete/{id}', 'Admin\FeaturedListing\OrderRequestController@destroy')->name('admin.featured_listing.delete');

        Route::post('/bulk-delete-order', 'Admin\FeaturedListing\OrderRequestController@bulkDestroy')->name('admin.featured_listing.bulk_delete_order');
    });



    //Listing specification
    Route::prefix('listing-specification')->group(function () {
        // Listing category route
        Route::get('/categories', 'Admin\Listing\CategoryController@index')->name('admin.listing_specification.categories');

        Route::post('/store-category', 'Admin\Listing\CategoryController@store')->name('admin.listing_specification.store_category');
        Route::post('/update-category', 'Admin\Listing\CategoryController@update')->name('admin.listing_specification.update_category');
        Route::post('/delete-category/{id}', 'Admin\Listing\CategoryController@destroy')->name('admin.listing_specification.delete_category');
        Route::post('/bulk-delete-category', 'Admin\Listing\CategoryController@bulkDestroy')->name('admin.listing_specification.bulk_delete_category');
        Route::post('/generate-category-seo', 'Admin\Listing\CategoryController@generateSeo')->name('admin.listing_specification.generate_category_seo');


        // Listing Aminites route
        Route::get('/aminites', 'Admin\Listing\AminiteController@index')->name('admin.listing_specification.aminites');
        Route::post('/store-aminites', 'Admin\Listing\AminiteController@store')->name('admin.listing_specification.store_aminites');
        Route::post('/update-aminites', 'Admin\Listing\AminiteController@update')->name('admin.listing_specification.update_aminite');
        Route::post('/delete-aminites/{id}', 'Admin\Listing\AminiteController@destroy')->name('admin.listing_specification.delete_aminite');
        Route::post('/bulk-delete-aminites', 'Admin\Listing\AminiteController@bulkDestroy')->name('admin.listing_specification.bulk_delete_aminite');

        // Listing Location route
        Route::prefix('location')->group(function () {

            // Listing Country route
            Route::get('/countries', 'Admin\Listing\Location\CountryController@index')->name('admin.listing_specification.location.countries');

            Route::post('/store-country', 'Admin\Listing\Location\CountryController@store')->name('admin.listing_specification.location.store_country');

            Route::post('/update-country', 'Admin\Listing\Location\CountryController@update')->name('admin.listing_specification.location.update_country');

            Route::post('/delete-country/{id}', 'Admin\Listing\Location\CountryController@destroy')->name('admin.listing_specification.location.delete_country');

            Route::post('/bulk-delete-country', 'Admin\Listing\Location\CountryController@bulkDestroy')->name('admin.listing_specification.location.bulk_delete_country');


            //  states route
            Route::get('/states', 'Admin\Listing\Location\StateController@index')->name('admin.listing_specification.location.states');

            Route::get('/get-country/{language_id}', 'Admin\Listing\Location\StateController@getCountry')->name('admin.listing_specification.location.get-countries');

            Route::post('/store-state', 'Admin\Listing\Location\StateController@store')->name('admin.listing_specification.location.store_state');

            Route::post('/update-state', 'Admin\Listing\Location\StateController@update')->name('admin.listing_specification.location.update_state');

            Route::post('/delete-state/{id}', 'Admin\Listing\Location\StateController@destroy')->name('admin.listing_specification.location.delete_state');

            Route::post('/bulk-delete-state', 'Admin\Listing\Location\StateController@bulkDestroy')->name('admin.listing_specification.location.bulk_delete_state');

            //  City route

            Route::get('/city', 'Admin\Listing\Location\CityController@index')->name('admin.listing_specification.location.city');
            Route::get('/get-state/{country}', 'Admin\Listing\Location\CityController@getState')->name('admin.listing_specification.location.get-state');
            Route::post('/store-city', 'Admin\Listing\Location\CityController@store')->name('admin.listing_specification.location.store_city');
            Route::post('delete-city-image', 'Admin\Listing\Location\CityController@ImageRemove')->name('admin.listing_specification.location.city.remove.image');
            Route::post('/update-city', 'Admin\Listing\Location\CityController@update')->name('admin.listing_specification.location.update_city');
            Route::post('/delete-city/{id}', 'Admin\Listing\Location\CityController@destroy')->name('admin.listing_specification.location.delete_city');
            Route::post('/bulk-delete-city', 'Admin\Listing\Location\CityController@bulkDestroy')->name('admin.listing_specification.location.bulk_delete_city');
        });
    });

    //Listings Management

    Route::prefix('listings-management')->group(function () {
        Route::get('get-select-country', 'Admin\Listing\ListingController@getCountry')->name('admin.get_country');
        Route::get('get-select-city', 'Admin\Listing\ListingController@getSearchCity')->name('admin.get_city');
        Route::get('get-select-state', 'Admin\Listing\ListingController@searchSate')->name('admin.get_state');
        Route::get('get-select-categories', 'Admin\Listing\ListingController@homeCategories')->name('admin.get_categories');

        Route::get('/settings', 'Admin\Listing\ListingController@settings')->name('admin.listing_management.settings');
        Route::post('/update-settings', 'Admin\Listing\ListingController@updateSettings')->name('admin.listing_management.update_settings');

        Route::get('/', 'Admin\Listing\ListingController@index')->name('admin.listing_management.listings');
        Route::post('/get-state', 'Admin\Listing\ListingController@getState')->name('admin.listing_management.get-state')->withoutMiddleware('Demo');
        Route::post('/get-city', 'Admin\Listing\ListingController@getCity')->name('admin.listing_management.get-city')->withoutMiddleware('Demo');


        Route::get('/select-vendor', 'Admin\Listing\ListingController@selectVendor')->name('admin.listing_management.select_vendor');
        Route::post('take-vendor', 'Admin\Listing\ListingController@findVendor')->name('admin.listing_management.find_vendor_id')->withoutMiddleware('Demo');

        Route::get('/create/{vendor_id}', 'Admin\Listing\ListingController@create')->name('admin.listing_management.create_listing');
        Route::post('store', 'Admin\Listing\ListingController@store')->name('admin.listing_management.store_listing');


        Route::get('edit-listing/{id}', 'Admin\Listing\ListingController@edit')->name('admin.listing_management.edit_listing');
        Route::post('update/{id}', 'Admin\Listing\ListingController@update')->name('admin.listing_management.update_listing');

        Route::post('delete-video-image/{id}', 'Admin\Listing\ListingController@videoImageRemove')->name('admin.listing_management.video_image.delete');

        Route::post('update_status', 'Admin\Listing\ListingController@updateStatus')->name('admin.listing_management.update_listing_status');

        Route::post('update_visibility', 'Admin\Listing\ListingController@updateVisibility')->name('admin.listing_management.update_listing_visibility');

        Route::post('/update_featured', 'Admin\Listing\ListingController@updateFeatured')->name('admin.listing_management.listing.purchase_feature');

        Route::get('slider-images/{id}', 'Admin\Listing\ListingController@getSliderImages');

        Route::post('delete/{id}', 'Admin\Listing\ListingController@delete')->name('admin.listing_management.delete_listing');

        Route::post('bulk_delete', 'Admin\Listing\ListingController@bulkDelete')->name('admin.listing_management.bulk_delete.listing');

        Route::post('specification/delete', 'Admin\Listing\ListingController@featureDelete')->name('admin.listing_management.feature_delete');

        Route::post('social/delete', 'Admin\Listing\ListingController@socialDelete')->name('admin.listing_management.social_delete');

        //business hours

        Route::get('/business-hours/{id}', 'Admin\Listing\ListingController@businessHours')->name('admin.listing_management.listing.business_hours');

        Route::post('update-business-hours/{id}', 'Admin\Listing\ListingController@updateBusinessHours')->name('admin.listing_management.listing.business_hours_update');

        Route::post('update_holiday', 'Admin\Listing\ListingController@updateHoliday')->name('admin.listing_management.listing.business_hours.update_holiday');
        //end Business Hours

        // Claim Listings Management Routes start
        Route::get('/claim-listings',  'Admin\Listing\ClaimListingController@index')->name('claim-listings.index');
        Route::post('/update-claim-listing-status/{id}',  'Admin\Listing\ClaimListingController@updateStatus')->name('claim-listings.updated_status');
        Route::get('/claims/redeem', 'Admin\Listing\ClaimListingController@start')->name('claims.redeem')->withoutMiddleware('auth:admin');
        Route::get('claim-listings/{id}/details', 'Admin\Listing\ClaimListingController@details')
            ->name('admin.claim_listings.details');
        Route::post('claim-listings/{id}/delete', 'Admin\Listing\ClaimListingController@destroy')
            ->name('admin.claim_listings.delete');
        Route::post('claim-listings/bulk-delete', 'Admin\Listing\ClaimListingController@bulkDestroy')
            ->name('admin.claim_listings.bulk_delete');
        // Claim Listings Management Routes end

        //FAQ ROUTE START

        Route::get('/faq/{id}', 'Admin\Listing\FaqController@index')->name('admin.listing_management.listing.faq');

        Route::post('/store-faq', 'Admin\Listing\FaqController@store')->name('admin.listing_management.listing.store_faq');

        Route::post('/update-faq', 'Admin\Listing\FaqController@update')->name('admin.listing_management.listing.update_faq');

        Route::post('/delete-faq/{id}', 'Admin\Listing\FaqController@destroy')->name('admin.listing_management.listing.delete_faq');

        Route::post('/bulk-delete-faq', 'Admin\Listing\FaqController@bulkDestroy')->name('admin.listing_management.listing.bulk_delete_faq');

        //FAQ ROUTE END

        //listing plugins route start
        Route::get('/plugins/{id}', 'Admin\Listing\ListingController@plugins')->name('admin.listing_management.listing.plugins');
        Route::post('/update-tawkto/{id}', 'Admin\Listing\ListingController@updateTawkTo')->name('admin.listing_management.listing.update_tawkto');

        Route::post('/update-telegram/{id}', 'Admin\Listing\ListingController@updateTelegram')->name('admin.listing_management.listing.update_telegram');

        Route::post('/update-whatsapp/{id}', 'Admin\Listing\ListingController@updateWhatsApp')->name('admin.listing_management.listing.update_whatsapp');
        Route::post('/update-messenger/{id}', 'Admin\Listing\ListingController@updateMessanger')->name('admin.listing_management.listing.update_messenger');
        // listing plugins route end

        //mnange social link

        Route::get('manage-social-link/{id}', 'Admin\Listing\ListingController@manageSocialLink')->name('admin.listing_management.manage_social_link');

        Route::post('upadte-social-link/{id}', 'Admin\Listing\ListingController@updateSocialLink')->name('admin.listing_management.update_social_link');

        //end managing social link

        //mnange Feature

        Route::get('manage-additional-specification/{id}', 'Admin\Listing\ListingController@manageAdditionalSpecification')->name('admin.listing_management.manage_additional_specification_link');

        Route::post('upadte-additional-specification/{id}', 'Admin\Listing\ListingController@updateAdditionalSpecification')->name('admin.listing_management.update_additional_specification');

        //end managing Feature link

        //#==========Listing slider image
        Route::post('/img-store', 'Admin\Listing\ListingController@imagesstore')->name('admin.listing.imagesstore');
        Route::post('/img-remove', 'Admin\Listing\ListingController@imagermv')->name('admin.listing.imagermv');
        Route::post('/img-db-remove', 'Admin\Listing\ListingController@imagedbrmv')->name('admin.listing.imgdbrmv');
        //#==========Listing slider image End
    });
    // End Listings Management

    // Form  Routes start here
    Route::prefix('/forms')
        ->group(function () {

            Route::get('', 'Admin\FormController@index')->name('admin.listings-management.form.index');
            Route::post('/store-form', 'Admin\FormController@store')->name('admin.listings-management.form.store');
            Route::post('/update-form', 'Admin\FormController@update')->name('admin.listings-management.update_form');
            Route::post('/delete-form/{id}', 'Admin\FormController@destroy')->name('admin.listings-management.delete_form');

            // Form Input Management Routes
            Route::prefix('/form')->group(function () {
                Route::get('/{id}/input', 'Admin\FormInputController@manageInput')->name('admin.listings-management.form.input');
                Route::post('/{id}/store-input', 'Admin\FormInputController@storeInput')->name('admin.listings-management.form.store_input');
                Route::get('/{form_id}/edit-input/{input_id}', 'Admin\FormInputController@editInput')
                    ->name('admin.listings-management.form.edit_input');
                Route::post('/update-input/{id}', 'Admin\FormInputController@updateInput')
                    ->name('admin.listings-management.form.update_input');
                Route::post('/delete-input/{id}', 'Admin\FormInputController@destroyInput')
                    ->name('admin.listings-management.form.delete_input');
                Route::post('/sort-input', 'Admin\FormInputController@sortInput')
                    ->name('admin.listings-management.form.sort_input');
            });
        });

    //Show message
    Route::get('/listing-messages', 'Admin\MessageController@index')->name('admin.listing.messages');
    Route::post('/listing-message/delete', 'Admin\MessageController@delete')->name('admin.listing.message.delete_message');

    Route::post('listing-bulk-delete', 'Admin\MessageController@bulkDelete')->name('admin.listing.message.bulk_delete.message');


    Route::get('/product-messages', 'Admin\MessageController@productIndex')->name('admin.product.messages');
    Route::get('product/message/{id}/details', 'Admin\MessageController@showMessageDetails')
        ->name('admin.product.message.details');
    Route::post('/product-message/delete', 'Admin\MessageController@productDelete')->name('admin.product.message.delete_message');

    Route::post('product-bulk-delete', 'Admin\MessageController@productBulkDelete')->name('admin.product.message.bulk_delete.message');
    //End Message

    // shop route start
    Route::prefix('/shop-management')->middleware('permission:Shop Management')->group(function () {
        // tax route
        Route::get('/tax-amount', 'Admin\BasicSettings\BasicController@productTaxAmount')->name('admin.shop_management.tax_amount');

        Route::post('/update-tax-amount', 'Admin\BasicSettings\BasicController@updateProductTaxAmount')->name('admin.shop_management.update_tax_amount');

        Route::get('/settings', 'Admin\BasicSettings\BasicController@settings')->name('admin.shop_management.settings');

        Route::post('/update-settings', 'Admin\BasicSettings\BasicController@updateSettings')->name('admin.shop_management.update_settings');

        // shipping charge route
        Route::get('/shipping-charges', 'Admin\Shop\ShippingChargeController@index')->name('admin.shop_management.shipping_charges');

        Route::post('/store-charge', 'Admin\Shop\ShippingChargeController@store')->name('admin.shop_management.store_charge');

        Route::post('/update-charge', 'Admin\Shop\ShippingChargeController@update')->name('admin.shop_management.update_charge');

        Route::post('/delete-charge/{id}', 'Admin\Shop\ShippingChargeController@destroy')->name('admin.shop_management.delete_charge');

        // coupon route
        Route::get('/coupons', 'Admin\Shop\CouponController@index')->name('admin.shop_management.coupons');

        Route::post('/store-coupon', 'Admin\Shop\CouponController@store')->name('admin.shop_management.store_coupon');

        Route::post('/update-coupon', 'Admin\Shop\CouponController@update')->name('admin.shop_management.update_coupon');

        Route::post('/delete-coupon/{id}', 'Admin\Shop\CouponController@destroy')->name('admin.shop_management.delete_coupon');

        // product category route
        Route::prefix('/product')->group(function () {
            Route::get('/categories', 'Admin\Shop\CategoryController@index')->name('admin.shop_management.product.categories');

            Route::post('/store-category', 'Admin\Shop\CategoryController@store')->name('admin.shop_management.product.store_category');

            Route::post('/update-category', 'Admin\Shop\CategoryController@update')->name('admin.shop_management.product.update_category');

            Route::post('/delete-category/{id}', 'Admin\Shop\CategoryController@destroy')->name('admin.shop_management.product.delete_category');

            Route::post('/bulk-delete-category', 'Admin\Shop\CategoryController@bulkDestroy')->name('admin.shop_management.product.bulk_delete_category');
        });

        // product route
        Route::get('/products', 'Admin\Shop\ProductController@index')->name('admin.shop_management.products');

        Route::get('/select-product-type', 'Admin\Shop\ProductController@productType')->name('admin.shop_management.select_product_type');

        Route::get('/create-product/{type}', 'Admin\Shop\ProductController@create')->name('admin.shop_management.create_product');

        Route::post('/upload-slider-image', 'Admin\Shop\ProductController@uploadImage')->name('admin.shop_management.upload_slider_image');

        Route::post('/remove-slider-image', 'Admin\Shop\ProductController@removeImage')->name('admin.shop_management.remove_slider_image');

        Route::post('/store-product', 'Admin\Shop\ProductController@store')->name('admin.shop_management.store_product');

        Route::get('/edit-product/{id}/{type}', 'Admin\Shop\ProductController@edit')->name('admin.shop_management.edit_product');

        Route::post('/detach-slider-image', 'Admin\Shop\ProductController@detachImage')->name('admin.shop_management.detach_slider_image');

        Route::post('/update-product/{id}', 'Admin\Shop\ProductController@update')->name('admin.shop_management.update_product');

        Route::post('/product/{id}/download', 'Admin\Shop\ProductController@downloadProduct')->name('user.product_order.product.download');

        Route::post('/delete-product/{id}', 'Admin\Shop\ProductController@destroy')->name('admin.shop_management.delete_product');

        Route::post('/bulk-delete-product', 'Admin\Shop\ProductController@bulkDestroy')->name('admin.shop_management.bulk_delete_product');

        Route::get('/listings/by-vendor', 'Admin\Shop\ProductController@getListingsByVendor')->name('admin.shop_management.listings.byVendor');

        // order route
        Route::get('/orders', 'Admin\Shop\OrderController@orders')->name('admin.shop_management.orders');

        Route::prefix('/order/{id}')->group(function () {
            Route::post('/update-payment-status', 'Admin\Shop\OrderController@updatePaymentStatus')->name('admin.shop_management.order.update_payment_status');

            Route::post('/update-order-status', 'Admin\Shop\OrderController@updateOrderStatus')->name('admin.shop_management.order.update_order_status');

            Route::get('/details', 'Admin\Shop\OrderController@show')->name('admin.shop_management.order.details');

            Route::post('/delete', 'Admin\Shop\OrderController@destroy')->name('admin.shop_management.order.delete');
        });

        Route::post('/bulk-delete-order', 'Admin\Shop\OrderController@bulkDestroy')->name('admin.shop_management.bulk_delete_order');

        // report route
        Route::get('/report', 'Admin\Shop\OrderController@report')->name('admin.shop_management.report');

        Route::get('/export-report', 'Admin\Shop\OrderController@exportReport')->name('admin.shop_management.export_report');
    });
    // shop route end

    // user management route start
    Route::prefix('/user-management')->middleware('permission:User Management')->group(function () {
        // registered user route
        Route::get('/registered-users', 'Admin\User\UserController@index')->name('admin.user_management.registered_users');

        Route::get('/create', 'Admin\User\UserController@create')->name('admin.user_management.registered_user.create');
        Route::post('/store', 'Admin\User\UserController@store')->name('admin.user_management.registered_user.store');

        Route::prefix('/user/{id}')->group(function () {

            Route::get('/edit', 'Admin\User\UserController@edit')->name('admin.user_management.registered_user.edit');
            Route::post('/update', 'Admin\User\UserController@update')->name('admin.user_management.registered_user.update');

            Route::post('/update-account-status', 'Admin\User\UserController@updateAccountStatus')->name('admin.user_management.user.update_account_status');

            Route::post('/update-email-status', 'Admin\User\UserController@updateEmailStatus')->name('admin.user_management.user.update_email_status');

            Route::get('/change-password', 'Admin\User\UserController@changePassword')->name('admin.user_management.user.change_password');

            Route::post('/update-password', 'Admin\User\UserController@updatePassword')->name('admin.user_management.user.update_password');

            Route::post('/delete', 'Admin\User\UserController@destroy')->name('admin.user_management.user.delete');
            Route::get('/secret-login', 'Admin\User\UserController@secret_login')->name('admin.user_management.user.secret-login');
        });

        Route::post('/bulk-delete-user', 'Admin\User\UserController@bulkDestroy')->name('admin.user_management.bulk_delete_user');

        // subscriber route
        Route::get('/subscribers', 'Admin\User\SubscriberController@index')->name('admin.user_management.subscribers');

        Route::post('/subscriber/{id}/delete', 'Admin\User\SubscriberController@destroy')->name('admin.user_management.subscriber.delete');

        Route::post('/bulk-delete-subscriber', 'Admin\User\SubscriberController@bulkDestroy')->name('admin.user_management.bulk_delete_subscriber');

        Route::get('/mail-for-subscribers', 'Admin\User\SubscriberController@writeEmail')->name('admin.user_management.mail_for_subscribers');

        Route::post('/subscribers/send-email', 'Admin\User\SubscriberController@prepareEmail')->name('admin.user_management.subscribers.send_email');

        // push notification route
        Route::prefix('/push-notification')->group(function () {
            Route::get('/settings', 'Admin\User\PushNotificationController@settings')->name('admin.user_management.push_notification.settings');

            Route::post('/update-settings', 'Admin\User\PushNotificationController@updateSettings')->name('admin.user_management.push_notification.update_settings');

            Route::get('/notification-for-visitors', 'Admin\User\PushNotificationController@writeNotification')->name('admin.user_management.push_notification.notification_for_visitors');

            Route::post('/send', 'Admin\User\PushNotificationController@sendNotification')->name('admin.user_management.push_notification.send');
        });
    });
    // user management route end

    // vendor management route start
    Route::prefix('/vendor-management')->middleware('permission:User Management')->group(function () {
        Route::get('/settings', 'Admin\VendorManagementController@settings')->name('admin.vendor_management.settings');
        Route::post('/settings/update', 'Admin\VendorManagementController@update_setting')->name('admin.vendor_management.setting.update');

        Route::get('/add-vendor', 'Admin\VendorManagementController@add')->name('admin.vendor_management.add_vendor');
        Route::post('/save-vendor', 'Admin\VendorManagementController@create')->name('admin.vendor_management.save-vendor');

        Route::get('/registered-vendors', 'Admin\VendorManagementController@index')->name('admin.vendor_management.registered_vendor');

        Route::prefix('/vendor/{id}')->group(function () {

            Route::post('/update-account-status', 'Admin\VendorManagementController@updateAccountStatus')->name('admin.vendor_management.vendor.update_account_status');

            Route::post('/update-email-status', 'Admin\VendorManagementController@updateEmailStatus')->name('admin.vendor_management.vendor.update_email_status');

            Route::get('/details', 'Admin\VendorManagementController@show')->name('admin.vendor_management.vendor_details');

            Route::get('/edit', 'Admin\VendorManagementController@edit')->name('admin.edit_management.vendor_edit');

            Route::post('/update', 'Admin\VendorManagementController@update')->name('admin.vendor_management.vendor.update_vendor');

            Route::post('/update/vendor/balance', 'Admin\VendorManagementController@update_vendor_balance')->name('admin.vendor_management.update_vendor_balance');

            Route::get('/change-password', 'Admin\VendorManagementController@changePassword')->name('admin.vendor_management.vendor.change_password');

            Route::post('/update-password', 'Admin\VendorManagementController@updatePassword')->name('admin.vendor_management.vendor.update_password');

            Route::post('/delete', 'Admin\VendorManagementController@destroy')->name('admin.vendor_management.vendor.delete');
        });

        Route::post('/vendor/current-package/remove', 'Admin\VendorManagementController@removeCurrPackage')->name('vendor.currPackage.remove');

        Route::post('/vendor/current-package/change', 'Admin\VendorManagementController@changeCurrPackage')->name('vendor.currPackage.change');

        Route::post('/vendor/current-package/add', 'Admin\VendorManagementController@addCurrPackage')->name('vendor.currPackage.add');

        Route::post('/vendor/next-package/remove', 'Admin\VendorManagementController@removeNextPackage')->name('vendor.nextPackage.remove');

        Route::post('/vendor/next-package/change', 'Admin\VendorManagementController@changeNextPackage')->name('vendor.nextPackage.change');

        Route::post('/vendor/next-package/add', 'Admin\VendorManagementController@addNextPackage')->name('vendor.nextPackage.add');

        Route::post('/bulk-delete-vendor', 'Admin\VendorManagementController@bulkDestroy')->name('admin.vendor_management.bulk_delete_vendor');

        Route::get('/secret-login/{id}', 'Admin\VendorManagementController@secret_login')->name('admin.vendor_management.vendor.secret_login');
    });
    // vendor management route start

    // home-page route start
    Route::prefix('/home-page')->middleware('permission:Home Page')->group(function () {
        // hero section
        Route::prefix('/hero-section')->group(function () {

            Route::get('', 'Admin\HomePage\HeroSectionController@heroSection')->name('admin.home_page.hero_section');
            Route::post('/update', 'Admin\HomePage\HeroSectionController@update')->name('admin.home_page.hero_section.update');
            Route::post('/store', 'Admin\HomePage\HeroSectionController@store')->name('admin.home_page.hero_section.store');
        });

        // Featured category section
        Route::get('/category-section', 'Admin\HomePage\CategorySectionController@index')->name('admin.home_page.category_section');

        Route::post('/update-category-section-image', 'Admin\HomePage\CategorySectionController@updateImage')->name('admin.home_page.update_category_section_image');

        Route::post('/update-category-section', 'Admin\HomePage\CategorySectionController@update')->name('admin.home_page.update_category_section');

        // Featured Listing Section
        Route::get('/listing-section', 'Admin\HomePage\FeaturedListingController@index')->name('admin.home_page.listing_section');


        Route::post('/update-listing-section', 'Admin\HomePage\FeaturedListingController@update')->name('admin.home_page.update_listing_section');

        // Featured Video Section
        Route::get('/video-section', 'Admin\HomePage\VideoSectionController@index')->name('admin.home_page.video_section');

        Route::post('/update-video-section-image', 'Admin\HomePage\VideoSectionController@updateImage')->name('admin.home_page.update_video_section_image');


        Route::post('/update-video-section', 'Admin\HomePage\VideoSectionController@update')->name('admin.home_page.update_video_section');


        // call to action section
        Route::get('/call-to-action-section', 'Admin\HomePage\CallToActionController@index')->name('admin.home_page.call_to_action_section');

        Route::post('/update-call-to-action-section-image', 'Admin\HomePage\CallToActionController@updateImage')->name('admin.home_page.update_call_to_action_section_image');

        Route::post('/update-call-to-action-section', 'Admin\HomePage\CallToActionController@update')->name('admin.home_page.update_call_to_action_section');


        // Featured Package Section
        Route::get('/package-section', 'Admin\HomePage\PacakageSectionController@index')->name('admin.home_page.package_section');

        Route::post('/update-package-section', 'Admin\HomePage\PacakageSectionController@update')->name('admin.home_page.update_package_section');


        // work process section
        Route::get('/work-process-section', 'Admin\HomePage\WorkProcessController@sectionInfo')->name('admin.home_page.work_process_section');

        Route::post('/update-work-process-section', 'Admin\HomePage\WorkProcessController@updateSectionInfo')->name('admin.home_page.update_work_process_section');

        Route::prefix('/work-process')->group(function () {
            Route::post('/store', 'Admin\HomePage\WorkProcessController@storeWorkProcess')->name('admin.home_page.store_work_process');

            Route::post('/update', 'Admin\HomePage\WorkProcessController@updateWorkProcess')->name('admin.home_page.update_work_process');

            Route::post('{id}/delete', 'Admin\HomePage\WorkProcessController@destroyWorkProcess')->name('admin.home_page.delete_work_process');

            Route::post('/bulk-delete', 'Admin\HomePage\WorkProcessController@bulkDestroyWorkProcess')->name('admin.home_page.bulk_delete_work_process');
        });

        // features section
        Route::get('/feature-section', 'Admin\HomePage\LatestListingSectionController@sectionInfo')->name('admin.home_page.feature_section');

        Route::post('/update-feature-section', 'Admin\HomePage\LatestListingSectionController@updateSectionInfo')->name('admin.home_page.update_feature_section');


        // counter section
        Route::get('/counter-section', 'Admin\HomePage\CounterController@index')->name('admin.home_page.counter_section');

        Route::post('/update-counter-section-image', 'Admin\HomePage\CounterController@updateImage')->name('admin.home_page.update_counter_section_image');

        Route::post('/update-counter-section-info', 'Admin\HomePage\CounterController@updateInfo')->name('admin.home_page.update_counter_section_info');

        Route::prefix('/counter')->group(function () {
            Route::post('/store', 'Admin\HomePage\CounterController@storeCounter')->name('admin.home_page.store_counter');

            Route::post('/update', 'Admin\HomePage\CounterController@updateCounter')->name('admin.home_page.update_counter');

            Route::post('{id}/delete', 'Admin\HomePage\CounterController@destroyCounter')->name('admin.home_page.delete_counter');

            Route::post('/bulk-delete', 'Admin\HomePage\CounterController@bulkDestroyCounter')->name('admin.home_page.bulk_delete_counter');
        });

        // testimonial section
        Route::get('/testimonial-section', 'Admin\HomePage\TestimonialController@index')->name('admin.home_page.testimonial_section');

        Route::post('/update-testimonial-section', 'Admin\HomePage\TestimonialController@updateSectionInfo')->name('admin.home_page.update_testimonial_section');

        Route::post(
            '/update-testimonial-section-img',
            'Admin\HomePage\TestimonialController@updateSectionBackground'
        )->name('admin.home_page.update_testimonial_section_background');

        Route::prefix('/testimonial')->group(function () {
            Route::post('/store', 'Admin\HomePage\TestimonialController@storeTestimonial')->name('admin.home_page.store_testimonial');

            Route::post('/update', 'Admin\HomePage\TestimonialController@updateTestimonial')->name('admin.home_page.update_testimonial');

            Route::post('{id}/delete', 'Admin\HomePage\TestimonialController@destroyTestimonial')->name('admin.home_page.delete_testimonial');

            Route::post('/bulk-delete', 'Admin\HomePage\TestimonialController@bulkDestroyTestimonial')->name('admin.home_page.bulk_delete_testimonial');
        });

        // Location section
        Route::get('/location-section', 'Admin\HomePage\LocationSectionController@index')->name('admin.home_page.location_section');

        Route::post('/update-location-section', 'Admin\HomePage\LocationSectionController@update')->name('admin.home_page.update_location_section');

        // blog section
        Route::get(
            '/blog-section',
            'Admin\HomePage\BlogController@index'
        )->name('admin.home_page.blog_section');

        Route::post('/update-blog-section', 'Admin\HomePage\BlogController@update')->name('admin.home_page.update_blog_section');

        // section customization
        Route::get('/section-customization', 'Admin\HomePage\SectionController@index')->name('admin.home_page.section_customization');

        Route::post('/update-section-status', 'Admin\HomePage\SectionController@update')->name('admin.home_page.update_section_status');
    });
    // home-page route end

    // about-us route start
    Route::prefix('/about-us')->middleware('permission:About Us')->group(function () {

        // work process section
        Route::get('/work-process-section', 'Admin\AboutUs\WorkProcessController@sectionInfo')->name('admin.about_us.work_process_section');

        Route::post('/update-work-process-section', 'Admin\AboutUs\WorkProcessController@updateSectionInfo')->name('admin.about_us.update_work_process_section');

        Route::prefix('/work-process')->group(function () {
            Route::post('/store', 'Admin\AboutUs\WorkProcessController@storeWorkProcess')->name('admin.about_us.store_work_process');

            Route::post('/update', 'Admin\AboutUs\WorkProcessController@updateWorkProcess')->name('admin.about_us.update_work_process');

            Route::post('{id}/delete', 'Admin\AboutUs\WorkProcessController@destroyWorkProcess')->name('admin.about_us.delete_work_process');

            Route::post('/bulk-delete', 'Admin\AboutUs\WorkProcessController@bulkDestroyWorkProcess')->name('admin.about_us.bulk_delete_work_process');
        });


        // counter section
        Route::get('/counter-section', 'Admin\AboutUs\CounterController@index')->name('admin.about_us.counter_section');

        Route::post('/update-counter-section-image', 'Admin\AboutUs\CounterController@updateImage')->name('admin.about_us.update_counter_section_image');

        Route::post('/update-counter-section-info', 'Admin\AboutUs\CounterController@updateInfo')->name('admin.about_us.update_counter_section_info');

        Route::prefix('/counter')->group(function () {
            Route::post('/store', 'Admin\AboutUs\CounterController@storeCounter')->name('admin.about_us.store_counter');

            Route::post('/update', 'Admin\AboutUs\CounterController@updateCounter')->name('admin.about_us.update_counter');

            Route::post('{id}/delete', 'Admin\AboutUs\CounterController@destroyCounter')->name('admin.about_us.delete_counter');

            Route::post('/bulk-delete', 'Admin\AboutUs\CounterController@bulkDestroyCounter')->name('admin.about_us.bulk_delete_counter');
        });

        // testimonial section
        Route::get('/testimonial-section', 'Admin\AboutUs\TestimonialController@index')->name('admin.about_us.testimonial_section');

        Route::post('/update-testimonial-section', 'Admin\AboutUs\TestimonialController@updateSectionInfo')->name('admin.about_us.update_testimonial_section');

        Route::post(
            '/update-testimonial-section-img',
            'Admin\AboutUs\TestimonialController@updateSectionBackground'
        )->name('admin.about_us.update_testimonial_section_background');

        Route::prefix('/testimonial')->group(function () {
            Route::post('/store', 'Admin\AboutUs\TestimonialController@storeTestimonial')->name('admin.about_us.store_testimonial');

            Route::post('/update', 'Admin\AboutUs\TestimonialController@updateTestimonial')->name('admin.about_us.update_testimonial');

            Route::post('{id}/delete', 'Admin\AboutUs\TestimonialController@destroyTestimonial')->name('admin.about_us.delete_testimonial');

            Route::post('/bulk-delete', 'Admin\AboutUs\TestimonialController@bulkDestroyTestimonial')->name('admin.about_us.bulk_delete_testimonial');
        });
    });
    // about-us route end


    #====support tickets ============

    Route::prefix('support-ticket')->group(function () {
        Route::get('/setting', 'Admin\SupportTicketController@setting')->name('admin.support_ticket.setting');
        Route::post('/setting/update', 'Admin\SupportTicketController@update_setting')->name('admin.support_ticket.update_setting');
        Route::get('/tickets', 'Admin\SupportTicketController@index')->name('admin.support_tickets');
        Route::get('/message/{id}', 'Admin\SupportTicketController@message')->name('admin.support_tickets.message');
        Route::post('/zip-upload', 'Admin\SupportTicketController@zip_file_upload')->name('admin.support_ticket.zip_file.upload');
        Route::post('/reply/{id}', 'Admin\SupportTicketController@ticketreply')->name('admin.support_ticket.reply');
        Route::post('/closed/{id}', 'Admin\SupportTicketController@ticket_closed')->name('admin.support_ticket.close');
        Route::post('/assign-stuff/{id}', 'Admin\SupportTicketController@assign_stuff')->name('assign_stuff.supoort.ticket');

        Route::get('/unassign-stuff/{id}', 'Admin\SupportTicketController@unassign_stuff')->name('admin.support_tickets.unassign');

        Route::post('/delete/{id}', 'Admin\SupportTicketController@delete')->name('admin.support_tickets.delete');
        Route::post('/bulk-delete', 'Admin\SupportTicketController@bulk_delete')->name('admin.support_tickets.bulk_delete');
    });


    // footer route start
    Route::prefix('/footer')->middleware('permission:Footer')->group(function () {
        // logo & image route
        Route::get('/logo-and-image', 'Admin\Footer\ImageController@index')->name('admin.footer.logo_and_image');

        Route::post('/update-logo', 'Admin\Footer\ImageController@updateLogo')->name('admin.footer.update_logo');

        // content route
        Route::get('/content', 'Admin\Footer\ContentController@index')->name('admin.footer.content');

        Route::post('/update-content', 'Admin\Footer\ContentController@update')->name('admin.footer.update_content');

        // quick link route
        Route::get('/quick-links', 'Admin\Footer\QuickLinkController@index')->name('admin.footer.quick_links');

        Route::post('/store-quick-link', 'Admin\Footer\QuickLinkController@store')->name('admin.footer.store_quick_link');

        Route::post('/update-quick-link', 'Admin\Footer\QuickLinkController@update')->name('admin.footer.update_quick_link');

        Route::post('/delete-quick-link/{id}', 'Admin\Footer\QuickLinkController@destroy')->name('admin.footer.delete_quick_link');
    });
    // footer route end


    // custom-pages route start
    Route::prefix('/custom-pages')->middleware('permission:Custom Pages')->group(function () {
        Route::get('', 'Admin\CustomPageController@index')->name('admin.custom_pages');

        Route::get('/create-page', 'Admin\CustomPageController@create')->name('admin.custom_pages.create_page');

        Route::post('/store-page', 'Admin\CustomPageController@store')->name('admin.custom_pages.store_page');

        Route::get('/edit-page/{id}', 'Admin\CustomPageController@edit')->name('admin.custom_pages.edit_page');

        Route::post('/update-page/{id}', 'Admin\CustomPageController@update')->name('admin.custom_pages.update_page');

        Route::post('/delete-page/{id}', 'Admin\CustomPageController@destroy')->name('admin.custom_pages.delete_page');

        Route::post('/bulk-delete-page', 'Admin\CustomPageController@bulkDestroy')->name('admin.custom_pages.bulk_delete_page');
    });
    // custom-pages route end

    // blog route start
    Route::prefix('/blog-management')->middleware('permission:Blog Management')->group(function () {
        // blog category route
        Route::get('/categories', 'Admin\Journal\CategoryController@index')->name('admin.blog_management.categories');

        Route::post('/store-category', 'Admin\Journal\CategoryController@store')->name('admin.blog_management.store_category');

        Route::post('/update-category', 'Admin\Journal\CategoryController@update')->name('admin.blog_management.update_category');

        Route::post('/delete-category/{id}', 'Admin\Journal\CategoryController@destroy')->name('admin.blog_management.delete_category');

        Route::post('/bulk-delete-category', 'Admin\Journal\CategoryController@bulkDestroy')->name('admin.blog_management.bulk_delete_category');

        // blog route
        Route::get('/blogs', 'Admin\Journal\BlogController@index')->name('admin.blog_management.blogs');

        Route::get('/create-blog', 'Admin\Journal\BlogController@create')->name('admin.blog_management.create_blog');

        Route::post('/store-blog', 'Admin\Journal\BlogController@store')->name('admin.blog_management.store_blog');

        Route::get('/edit-blog/{id}', 'Admin\Journal\BlogController@edit')->name('admin.blog_management.edit_blog');

        Route::post('/update-blog/{id}', 'Admin\Journal\BlogController@update')->name('admin.blog_management.update_blog');

        Route::post('/delete-blog/{id}', 'Admin\Journal\BlogController@destroy')->name('admin.blog_management.delete_blog');

        Route::post('/bulk-delete-blog', 'Admin\Journal\BlogController@bulkDestroy')->name('admin.blog_management.bulk_delete_blog');
    });
    // blog route end

    // faq route start
    Route::prefix('/faq-management')->middleware('permission:FAQ Management')->group(function () {
        Route::get('', 'Admin\FaqController@index')->name('admin.faq_management');

        Route::post('/store-faq', 'Admin\FaqController@store')->name('admin.faq_management.store_faq');

        Route::post('/update-faq', 'Admin\FaqController@update')->name('admin.faq_management.update_faq');

        Route::post('/delete-faq/{id}', 'Admin\FaqController@destroy')->name('admin.faq_management.delete_faq');

        Route::post('/bulk-delete-faq', 'Admin\FaqController@bulkDestroy')->name('admin.faq_management.bulk_delete_faq');
    });
    // faq route end

    // advertise route start
    Route::prefix('/advertise')->middleware('permission:Advertise')->group(function () {
        Route::get('/settings', 'Admin\AdvertisementController@advertiseSettings')->name('admin.advertise.settings');

        Route::post('/update-settings', 'Admin\AdvertisementController@updateAdvertiseSettings')->name('admin.advertise.update_settings');

        Route::get('/all-advertisement', 'Admin\AdvertisementController@index')->name('admin.advertise.all_advertisement');

        Route::post('/store-advertisement', 'Admin\AdvertisementController@store')->name('admin.advertise.store_advertisement');

        Route::post('/update-advertisement', 'Admin\AdvertisementController@update')->name('admin.advertise.update_advertisement');

        Route::post('/delete-advertisement/{id}', 'Admin\AdvertisementController@destroy')->name('admin.advertise.delete_advertisement');

        Route::post('/bulk-delete-advertisement', 'Admin\AdvertisementController@bulkDestroy')->name('admin.advertise.bulk_delete_advertisement');
    });
    // advertise route end

    // announcement-popup route start
    Route::prefix('/announcement-popups')->middleware('permission:Announcement Popups')->group(function () {
        Route::get('', 'Admin\PopupController@index')->name('admin.announcement_popups');

        Route::get('/select-popup-type', 'Admin\PopupController@popupType')->name('admin.announcement_popups.select_popup_type');

        Route::get('/create-popup/{type}', 'Admin\PopupController@create')->name('admin.announcement_popups.create_popup');

        Route::post('/store-popup', 'Admin\PopupController@store')->name('admin.announcement_popups.store_popup');

        Route::post('/popup/{id}/update-status', 'Admin\PopupController@updateStatus')->name('admin.announcement_popups.update_popup_status');

        Route::get('/edit-popup/{id}', 'Admin\PopupController@edit')->name('admin.announcement_popups.edit_popup');

        Route::post('/update-popup/{id}', 'Admin\PopupController@update')->name('admin.announcement_popups.update_popup');

        Route::post('/delete-popup/{id}', 'Admin\PopupController@destroy')->name('admin.announcement_popups.delete_popup');

        Route::post('/bulk-delete-popup', 'Admin\PopupController@bulkDestroy')->name('admin.announcement_popups.bulk_delete_popup');
    });
    // announcement-popup route end

    // payment-gateway route start
    Route::prefix('/payment-gateways')->middleware('permission:Payment Gateways')->group(function () {
        Route::get('/online-gateways', 'Admin\PaymentGateway\OnlineGatewayController@index')->name('admin.payment_gateways.online_gateways');

        Route::post('/update-paypal-info', 'Admin\PaymentGateway\OnlineGatewayController@updatePayPalInfo')->name('admin.payment_gateways.update_paypal_info');
        Route::post('/update-instamojo-info', 'Admin\PaymentGateway\OnlineGatewayController@updateInstamojoInfo')->name('admin.payment_gateways.update_instamojo_info');
        Route::post('/update-paystack-info', 'Admin\PaymentGateway\OnlineGatewayController@updatePaystackInfo')->name('admin.payment_gateways.update_paystack_info');
        Route::post('/update-flutterwave-info', 'Admin\PaymentGateway\OnlineGatewayController@updateFlutterwaveInfo')->name('admin.payment_gateways.update_flutterwave_info');
        Route::post('/update-razorpay-info', 'Admin\PaymentGateway\OnlineGatewayController@updateRazorpayInfo')->name('admin.payment_gateways.update_razorpay_info');
        Route::post('/update-mercadopago-info', 'Admin\PaymentGateway\OnlineGatewayController@updateMercadoPagoInfo')->name('admin.payment_gateways.update_mercadopago_info');
        Route::post('/update-mollie-info', 'Admin\PaymentGateway\OnlineGatewayController@updateMollieInfo')->name('admin.payment_gateways.update_mollie_info');
        Route::post('/update-stripe-info', 'Admin\PaymentGateway\OnlineGatewayController@updateStripeInfo')->name('admin.payment_gateways.update_stripe_info');
        Route::post('/update-paytm-info', 'Admin\PaymentGateway\OnlineGatewayController@updatePaytmInfo')->name('admin.payment_gateways.update_paytm_info');
        Route::post('/update-anet-info', 'Admin\PaymentGateway\OnlineGatewayController@updateAnetInfo')->name('admin.payment_gateways.update_anet_info');
        Route::post('/update-iyzico-info', 'Admin\PaymentGateway\OnlineGatewayController@updateIyzicoInfo')->name('admin.payment_gateways.update_iyzico_info');
        Route::post('/update-midtrans-info', 'Admin\PaymentGateway\OnlineGatewayController@updateMidtransInfo')->name('admin.payment_gateways.update_midtrans_info');
        Route::post('/update-myfatoorah-info', 'Admin\PaymentGateway\OnlineGatewayController@updateMyFatoorahInfo')->name('admin.payment_gateways.update_myfatoorah_info');
        Route::post('/update-phonepe-info', 'Admin\PaymentGateway\OnlineGatewayController@updatePhonepeInfo')->name('admin.payment_gateways.update_phonepe_info');
        Route::post('/update-yoco-info', 'Admin\PaymentGateway\OnlineGatewayController@updateYocoInfo')->name('admin.payment_gateways.update_yoco_info');
        Route::post('/update-toyyibpay-info', 'Admin\PaymentGateway\OnlineGatewayController@updateToyyibpayInfo')->name('admin.payment_gateways.update_toyyibpay_info');
        Route::post('/update-paytabs-info', 'Admin\PaymentGateway\OnlineGatewayController@updatePaytabsInfo')->name('admin.payment_gateways.update_paytabs_info');
        Route::post('/update-perfect_money-info', 'Admin\PaymentGateway\OnlineGatewayController@updatePerfectMoneyInfo')->name('admin.payment_gateways.update_perfect_money_info');
        Route::post('/update-zendit-info', 'Admin\PaymentGateway\OnlineGatewayController@updateXenditInfo')->name('admin.payment_gateways.update_xendit_info');
        Route::post('/update-wayforpay-info', 'Admin\PaymentGateway\OnlineGatewayController@updateWayforPayInfo')->name('admin.payment_gateways.update_wayforpay_info');


        Route::post('/monify', 'Admin\PaymentGateway\OnlineGatewayController@updateMonify')->name('admin.payment_gateways.update_monify');
        Route::post('/nowpayments', 'Admin\PaymentGateway\OnlineGatewayController@updateNowPayments')->name('admin.payment_gateways.update_nowpayments');




        Route::get('/offline-gateways', 'Admin\PaymentGateway\OfflineGatewayController@index')->name('admin.payment_gateways.offline_gateways');
        Route::post('/store-offline-gateway', 'Admin\PaymentGateway\OfflineGatewayController@store')->name('admin.payment_gateways.store_offline_gateway');
        Route::post('/update-status/{id}', 'Admin\PaymentGateway\OfflineGatewayController@updateStatus')->name('admin.payment_gateways.update_status');
        Route::post('/update-offline-gateway', 'Admin\PaymentGateway\OfflineGatewayController@update')->name('admin.payment_gateways.update_offline_gateway');
        Route::post('/delete-offline-gateway/{id}', 'Admin\PaymentGateway\OfflineGatewayController@destroy')->name('admin.payment_gateways.delete_offline_gateway');
    });
    // payment-gateway route end

    Route::prefix('/basic-settings')->middleware('permission:Basic Settings')->group(function () {
        // basic settings favicon route

        Route::get('/favicon', 'Admin\BasicSettings\BasicController@favicon')->name('admin.basic_settings.favicon');
        Route::post('/update-favicon', 'Admin\BasicSettings\BasicController@updateFavicon')->name('admin.basic_settings.update_favicon');

        // basic settings logo route
        Route::get('/logo', 'Admin\BasicSettings\BasicController@logo')->name('admin.basic_settings.logo');

        Route::post('/update-logo', 'Admin\BasicSettings\BasicController@updateLogo')->name('admin.basic_settings.update_logo');

        // basic settings information route
        Route::get('/information', 'Admin\BasicSettings\BasicController@information')->name('admin.basic_settings.information');

        Route::post('/update-info', 'Admin\BasicSettings\BasicController@updateInfo')->name('admin.basic_settings.update_info');

        Route::get('/general-settings', 'Admin\BasicSettings\BasicController@general_settings')->name('admin.basic_settings.general_settings');

        Route::post('/update-general-settings', 'Admin\BasicSettings\BasicController@update_general_setting')->name('admin.basic_settings.general_settings.update');

        Route::get('/contact-page', 'Admin\BasicSettings\BasicController@contact_page')->name('admin.basic_settings.contact_page');

        Route::post('/update-contact-page', 'Admin\BasicSettings\BasicController@update_contact_page')->name('admin.basic_settings.contact_page.update');

        // basic settings (theme & home) route
        Route::get('/theme-and-home', 'Admin\BasicSettings\BasicController@themeAndHome')->name('admin.basic_settings.theme_and_home');

        Route::post(
            '/update-theme-and-home',
            'Admin\BasicSettings\BasicController@updateThemeAndHome'
        )->name('admin.basic_settings.update_theme_and_home');

        // basic settings currency route
        Route::get('/currency', 'Admin\BasicSettings\BasicController@currency')->name('admin.basic_settings.currency');

        Route::post('/update-currency', 'Admin\BasicSettings\BasicController@updateCurrency')->name('admin.basic_settings.update_currency');

        // basic settings appearance route
        Route::get('/appearance', 'Admin\BasicSettings\BasicController@appearance')->name('admin.basic_settings.appearance');

        Route::post('/update-appearance', 'Admin\BasicSettings\BasicController@updateAppearance')->name('admin.basic_settings.update_appearance');

        // basic settings mail route start
        Route::get('/mail-from-admin', 'Admin\BasicSettings\BasicController@mailFromAdmin')->name('admin.basic_settings.mail_from_admin');

        Route::post('/update-mail-from-admin', 'Admin\BasicSettings\BasicController@updateMailFromAdmin')->name('admin.basic_settings.update_mail_from_admin');

        Route::get('/mail-to-admin', 'Admin\BasicSettings\BasicController@mailToAdmin')->name('admin.basic_settings.mail_to_admin');

        Route::post('/update-mail-to-admin', 'Admin\BasicSettings\BasicController@updateMailToAdmin')->name('admin.basic_settings.update_mail_to_admin');

        Route::get('/mail-templates', 'Admin\BasicSettings\MailTemplateController@index')->name('admin.basic_settings.mail_templates');

        Route::get('/edit-mail-template/{id}', 'Admin\BasicSettings\MailTemplateController@edit')->name('admin.basic_settings.edit_mail_template');

        Route::post('/update-mail-template/{id}', 'Admin\BasicSettings\MailTemplateController@update')->name('admin.basic_settings.update_mail_template');
        // basic settings mail route end

        // basic settings breadcrumb route
        Route::get('/breadcrumb', 'Admin\BasicSettings\BasicController@breadcrumb')->name('admin.basic_settings.breadcrumb');

        Route::post('/update-breadcrumb', 'Admin\BasicSettings\BasicController@updateBreadcrumb')->name('admin.basic_settings.update_breadcrumb');

        // basic settings page-headings route
        Route::get('/page-headings', 'Admin\BasicSettings\PageHeadingController@pageHeadings')->name('admin.basic_settings.page_headings');

        Route::post('/update-page-headings', 'Admin\BasicSettings\PageHeadingController@updatePageHeadings')->name('admin.basic_settings.update_page_headings');

        // basic settings plugins route start
        Route::get('/plugins', 'Admin\BasicSettings\BasicController@plugins')->name('admin.basic_settings.plugins');

        Route::post('/update-disqus', 'Admin\BasicSettings\BasicController@updateDisqus')->name('admin.basic_settings.update_disqus');

        Route::post('/update-tawkto', 'Admin\BasicSettings\BasicController@updateTawkTo')->name('admin.basic_settings.update_tawkto');

        Route::post('/update-recaptcha', 'Admin\BasicSettings\BasicController@updateRecaptcha')->name('admin.basic_settings.update_recaptcha');

        Route::post('/update-facebook', 'Admin\BasicSettings\BasicController@updateFacebook')->name('admin.basic_settings.update_facebook');

        Route::post('/update-google', 'Admin\BasicSettings\BasicController@updateGoogle')->name('admin.basic_settings.update_google');

        Route::post(
            '/update-google-map-api',
            'Admin\BasicSettings\BasicController@updateGoogleMapApi'
        )->name('admin.basic_settings.update_google_map_api');

        Route::post('/update-whatsapp', 'Admin\BasicSettings\BasicController@updateWhatsApp')->name('admin.basic_settings.update_whatsapp');
        Route::post('/update-openai', 'Admin\BasicSettings\BasicController@updateOpenAI')->name('admin.basic_settings.update_openai');
        Route::post('/update-gemini', 'Admin\BasicSettings\BasicController@updateGemini')->name('admin.basic_settings.update_gemini');
        Route::post('/update-translate-settings', 'Admin\BasicSettings\BasicController@updateTranslateSettings')->name('admin.basic_settings.update_translate_settings');
        // Route::post('/update-pollinations', 'Admin\BasicSettings\BasicController@updatePollinations')->name('admin.basic_settings.update_pollinations');
        // basic settings plugins route end

        // basic settings seo route
        Route::get('/seo', 'Admin\BasicSettings\SEOController@index')->name('admin.basic_settings.seo');

        Route::post('/update-seo', 'Admin\BasicSettings\SEOController@update')->name('admin.basic_settings.update_seo');

        // basic settings maintenance-mode route
        Route::get('/maintenance-mode', 'Admin\BasicSettings\BasicController@maintenance')->name('admin.basic_settings.maintenance_mode');

        Route::post('/update-maintenance-mode', 'Admin\BasicSettings\BasicController@updateMaintenance')->name('admin.basic_settings.update_maintenance_mode');

        // basic settings cookie-alert route
        Route::get('/cookie-alert', 'Admin\BasicSettings\CookieAlertController@cookieAlert')->name('admin.basic_settings.cookie_alert');

        Route::post('/update-cookie-alert', 'Admin\BasicSettings\CookieAlertController@updateCookieAlert')->name('admin.basic_settings.update_cookie_alert');

        // basic-settings social-media route
        Route::get('/social-medias', 'Admin\BasicSettings\SocialMediaController@index')->name('admin.basic_settings.social_medias');

        Route::post('/store-social-media', 'Admin\BasicSettings\SocialMediaController@store')->name('admin.basic_settings.store_social_media');

        Route::post('/update-social-media', 'Admin\BasicSettings\SocialMediaController@update')->name('admin.basic_settings.update_social_media');

        Route::post('/delete-social-media/{id}', 'Admin\BasicSettings\SocialMediaController@destroy')->name('admin.basic_settings.delete_social_media');
    });

    /*
 * Mobile App Settings
 * */

    Route::prefix('mobile-interface')->middleware('permission:Mobile App Settings')->group(function () {
        Route::get('/', 'Admin\MobileInterfaceController@index')->name('admin.mobile_interface');
        Route::get('/home-page-content', 'Admin\MobileInterfaceController@content')->name('admin.mobile_interface_content');
        Route::post('home-page-content/update', 'Admin\MobileInterfaceController@update')->name('admin.mobile_interface_update');
        Route::get('/general-setting', 'Admin\MobileInterfaceController@setting')->name('admin.mobile_interface_gsetting');
        Route::post('/general-setting/update', 'Admin\MobileInterfaceController@settingUpdate')->name('admin.mobile_interface_gsetting.update');
        Route::get('/online-gateways', 'Admin\MobileInterfaceController@paymentGateways')->name('admin.mobile_interface.payment_gateways');
        Route::get('/plugins', 'Admin\MobileInterfaceController@plugins')->name('admin.mobile_interface.plugins');
        Route::post('/update-firebase', 'Admin\MobileInterfaceController@updateFirebase')->name('admin.basic_settings.updateFirebase');

        Route::post('/update-google', 'Admin\MobileInterfaceController@updateGoogle')->name('admin.basic_settings.mobile_interface.update_google');
        Route::post('/update-facebook', 'Admin\MobileInterfaceController@updateFacebook')->name('admin.basic_settings.mobile_interface.update_facebook');
        Route::post('/update-geo', 'Admin\MobileInterfaceController@updateGeo')->name('admin.basic_settings.mobile_interface.geo');
    });

    // admin management route start
    Route::prefix('/admin-management')->middleware('permission:Admin Management')->group(function () {
        // role-permission route
        Route::get('/role-permissions', 'Admin\Administrator\RolePermissionController@index')->name('admin.admin_management.role_permissions');

        Route::post('/store-role', 'Admin\Administrator\RolePermissionController@store')->name('admin.admin_management.store_role');

        Route::get('/role/{id}/permissions', 'Admin\Administrator\RolePermissionController@permissions')->name('admin.admin_management.role.permissions');

        Route::post('/role/{id}/update-permissions', 'Admin\Administrator\RolePermissionController@updatePermissions')->name('admin.admin_management.role.update_permissions');

        Route::post('/update-role', 'Admin\Administrator\RolePermissionController@update')->name('admin.admin_management.update_role');

        Route::post('/delete-role/{id}', 'Admin\Administrator\RolePermissionController@destroy')->name('admin.admin_management.delete_role');

        // registered admin route
        Route::get('/registered-admins', 'Admin\Administrator\SiteAdminController@index')->name('admin.admin_management.registered_admins');

        Route::post('/store-admin', 'Admin\Administrator\SiteAdminController@store')->name('admin.admin_management.store_admin');

        Route::post('/update-status/{id}', 'Admin\Administrator\SiteAdminController@updateStatus')->name('admin.admin_management.update_status');

        Route::post('/update-admin', 'Admin\Administrator\SiteAdminController@update')->name('admin.admin_management.update_admin');

        Route::post('/delete-admin/{id}', 'Admin\Administrator\SiteAdminController@destroy')->name('admin.admin_management.delete_admin');
    });
    // admin management route end


    // language management route start
    Route::prefix('/language-management')->group(function () {
        Route::get('', 'Admin\LanguageController@index')->name('admin.language_management');

        Route::post('/store', 'Admin\LanguageController@store')->name('admin.language_management.store');

        Route::post('/{id}/make-default-language', 'Admin\LanguageController@makeDefault')->name('admin.language_management.make_default_language');

        Route::post('/update', 'Admin\LanguageController@update')->name('admin.language_management.update');

        Route::get(
            '/{id}/edit-fornt-keyword',
            'Admin\LanguageController@editKeyword'
        )->name('admin.language_management.edit_front_keyword');

        Route::get(
            '/{id}/edit-admin-keyword',
            'Admin\LanguageController@editAdminKeyword'
        )->name('admin.language_management.edit_admin_keyword');

        Route::post('add-keyword-fornt', 'Admin\LanguageController@addKeyword')->name('admin.language_management.add_keyword_front');

        Route::post('add-keyword-admin', 'Admin\LanguageController@addKeywordAdmin')->name('admin.language_management.add_keyword_admin');

        Route::post(
            '/{id}/update-keyword',
            'Admin\LanguageController@updateKeyword'
        )->name('admin.language_management.update_keyword');

        Route::post('/{id}/delete', 'Admin\LanguageController@destroy')->name('admin.language_management.delete');
        Route::get('/{id}/check-rtl', 'Admin\LanguageController@checkRTL');
    });
    // language management route end

    // Withdrawals Management Routes start
    Route::prefix('withdraw')
        ->middleware(['permission:Withdrawal Management,Payment Methods,Withdraw Requests'])
        ->group(function () {

            // Payment Methods Management
            Route::prefix('/payment-methods')
                ->middleware(['permission:Payment Methods'])
                ->group(function () {
                    // CRUD Operations
                    Route::get('', 'Admin\Withdraw\WithdrawPaymentMethodController@index')
                        ->name('admin.withdraw.payment_method');
                    Route::post('/store', 'Admin\Withdraw\WithdrawPaymentMethodController@store')
                        ->name('admin.withdraw_payment_method.store');
                    Route::put('/update', 'Admin\Withdraw\WithdrawPaymentMethodController@update')
                        ->name('admin.withdraw_payment_method.update');
                    Route::post('/delete/{id}', 'Admin\Withdraw\WithdrawPaymentMethodController@destroy')
                        ->name('admin.withdraw_payment_method.delete');

                    // Payment Method Inputs Management
                    Route::prefix('/inputs')->group(function () {
                        Route::get('', 'Admin\Withdraw\WithdrawPaymentMethodInputController@index')
                            ->name('admin.withdraw_payment_method.mange_input');
                        Route::post('/store', 'Admin\Withdraw\WithdrawPaymentMethodInputController@store')
                            ->name('admin.withdraw_payment_method.store_input');
                        Route::get('/edit/{id}', 'Admin\Withdraw\WithdrawPaymentMethodInputController@edit')
                            ->name('admin.withdraw_payment_method.edit_input');
                        Route::post('/update', 'Admin\Withdraw\WithdrawPaymentMethodInputController@update')
                            ->name('admin.withdraw_payment_method.update_input');
                        Route::post('/order-update', 'Admin\Withdraw\WithdrawPaymentMethodInputController@order_update')
                            ->name('admin.withdraw_payment_method.order_update');
                        Route::get('/options/{id}', 'Admin\Withdraw\WithdrawPaymentMethodInputController@get_options')
                            ->name('admin.withdraw_payment_method.options');
                        Route::post('/delete', 'Admin\Withdraw\WithdrawPaymentMethodInputController@delete')
                            ->name('admin.withdraw_payment_method.options_delete');
                    });
                });

            // Withdraw Requests Management
            Route::prefix('/requests')
                ->middleware(['permission:Withdraw Requests'])
                ->group(function () {
                    Route::get('', 'Admin\Withdraw\WithdrawController@index')
                        ->name('admin.withdraw.withdraw_request');
                    Route::post('/delete', 'Admin\Withdraw\WithdrawController@delete')
                        ->name('admin.witdraw.delete_withdraw');
                    Route::get('/approve/{id}', 'Admin\Withdraw\WithdrawController@approve')
                        ->name('admin.witdraw.approve_withdraw');
                    Route::get('/decline/{id}', 'Admin\Withdraw\WithdrawController@decline')
                        ->name('admin.witdraw.decline_withdraw');
                });
        });
    // Withdrawals Management Routes end
});
