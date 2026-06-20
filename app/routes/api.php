<?php

use App\Http\Controllers\Api\FcmTokenController;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Api\HomeController;
use App\Http\Controllers\Api\LanguageController;
use App\Http\Controllers\Api\ListingController;
use App\Http\Controllers\Api\ProductController;
use App\Http\Controllers\Api\ProductOrderController;
use App\Http\Controllers\Api\ProductPurchaseController;
use App\Http\Controllers\Api\WishlistController;
use App\Http\Controllers\Api\VendorApi\VendorController;
use App\Http\Controllers\Api\VendorApi\SupportTicketController;
use App\Http\Controllers\Api\VendorApi\VendorWithdrawController;
use App\Http\Controllers\Api\VendorApi\VendorCheckoutController;
use App\Http\Controllers\Api\VendorApi\BuyPlanController;
use App\Http\Controllers\Api\VendorApi\MAilSetController;
use App\Http\Controllers\Api\VendorApi\MessageController;
use App\Http\Controllers\Api\VendorApi\Ai\AiContentController as VendorAiContentController;
use App\Http\Controllers\Api\VendorApi\Ai\AiImageController as VendorAiImageController;
use App\Http\Controllers\Api\VendorApi\Listing\FaqController as VendorListingFaqController;
use App\Http\Controllers\Api\VendorApi\Listing\ListingController as VendorListingController;
use App\Http\Controllers\Api\VendorApi\Shop\CategoryController as VendorShopCategoryController;
use App\Http\Controllers\Api\VendorApi\Shop\ProductController as VendorShopProductController;
use App\Http\Controllers\Api\VendorApi\Shop\OrderController as VendorShopOrderController;
use App\Http\Controllers\Api\VendorApi\Shop\FormController as VendorShopFormController;
use App\Http\Controllers\Api\VendorApi\Shop\FormInputController as VendorShopFormInputController;
use App\Http\Controllers\Api\VendorApi\VendorFcmTokenController;
use App\Http\Controllers\Api\VendorApi\VendorNotificationController;

Route::get('/', [HomeController::class, 'index'])->name('api.index');
Route::get('/get-lang', [LanguageController::class, 'getLang']);
Route::get('/get-basic', [HomeController::class, 'getBasic'])->name('api.getBasic');
Route::get('/get-payment', [HomeController::class, 'getPayment'])->name('api.getpayment');

Route::get('/get-categories', [HomeController::class, 'getCategories'])->name('getcategories');

Route::post('/save-fcm-token', [FcmTokenController::class, 'store']);
Route::get('/get-notifications', [FcmTokenController::class, 'getNotifications']);


Route::post('verfiy-payment', [HomeController::class, 'verfiyPayment'])->name('frontend.service.payment.verfiy');

Route::prefix('listings')->middleware(['Demo'])->group(function () {
  Route::get('/', [ListingController::class, 'index'])->name('api.listings');
  Route::get('/details/{slug}/{id}', [ListingController::class, 'details'])->name('api.listing.details');
  Route::post('/store-review/{id}', [ListingController::class, 'storeReview'])->name('api.listing.store.review');
  Route::post('/contact-message', [ListingController::class, 'contact'])->name('api.listing.contact_message');
});
Route::post('/product/contact-message', [ListingController::class, 'productContact'])->name('api.listing.product.contact_message')->middleware('Demo');

//products
Route::prefix('products')->group(function () {
  Route::get('/', [ProductController::class, 'index'])->name('api.products');
  Route::get('/details/{slug}', [ProductController::class, 'show'])->name('api.products.show');
  Route::post('/add-to-cart', [ProductController::class, 'addToCart'])->name('api.products.add_to_cart');
  Route::post('/remove-product', [ProductController::class, 'removeProductCart'])->name('api.products.remove_cart');
  Route::post('/update-cart', [ProductController::class, 'updateCart'])->name('api.products.update_cart');

  Route::prefix('/checkout')->middleware(['Demo'])->group(function () {
    Route::get('/', [ProductController::class, 'checkout'])->name('api.products.checkout');
    Route::post('/apply-coupon', [ProductController::class, 'applyCoupon'])->name('api.products.apply_coupon');
    Route::post('/purchase',  [ProductPurchaseController::class, 'index'])->name('api.products.purchase');
  });
});
Route::post('/product/store-review/{id}', [ProductController::class, 'storeReview'])->name('api.product_details.store_review')->middleware('Demo');

//user routes
Route::prefix('user')->middleware(['Demo'])->group(function () {
  Route::get('/signup', [UserController::class, 'signup'])->name('api.user.signup');
  Route::post('/signup/submit', [UserController::class, 'signupSubmit'])->name('api.user.signup_submit');

  Route::get('/login', [UserController::class, 'login'])->name('api.user.login');
  Route::get('/authentication-fail', [UserController::class, 'authentication_fail'])->name('api.user.authentication.fail');
  Route::post('/login/submit', [UserController::class, 'loginSubmit'])->name('api.user.login_submit');
  //forget password
  Route::post('/forget-password', [UserController::class, 'forget_password'])->name('api.user.forget_password');
  Route::post('/reset-password-update', [UserController::class, 'reset_password_submit'])->name('api.user.update_reset_password');
});

/* ************************************
 * Customer dashboard routes are goes here
 * ************************************/
Route::prefix('/users')->middleware(['auth:sanctum', 'Demo'])->group(function () {
  Route::get('/dashboard', [UserController::class, 'dashboard'])->name('api.users.dashboard');

  //wishlists
  Route::prefix('wishlists')->group(function () {
    Route::get('/', [WishlistController::class, 'index'])->name('api.users.wishlists.index');
    Route::post('/store', [WishlistController::class, 'store'])->name('api.users.wishlists.store');
    Route::post('/delete', [WishlistController::class, 'delete'])->name('api.users.wishlists.delete');
  });

  // product orders
  Route::get('/product-orders', [ProductOrderController::class, 'product_order'])->name('api.users.product_orders');
  Route::get('/product-order/details', [ProductOrderController::class, 'product_order_details'])->name('api.users.product_order.details');

  //claim request
  Route::get('/get-claim-request', [UserController::class, 'getClaimRequest'])->name('api.users.get_claim_request');
  Route::post('/store-claim-request', [UserController::class, 'storeClaimRequestInfo'])->name('api.users.claim_request_info_store');

  //update profile info
  Route::get('/edit-profile', [UserController::class, 'edit_profile'])->name('api.users.edit_profile');
  Route::post('/update/profile', [UserController::class, 'update_profile'])->name('api.users.update_profile');

  //update profile
  Route::post('/update/password', [UserController::class, 'updated_password'])->name('api.users.updated_password');
  Route::post('/logout', [UserController::class, 'logoutSubmit'])->name('api.users.logout');
});

/**
 * =================================Vendor Routes =============================
 */

// Public vendor auth routes
Route::prefix('vendor')->middleware('api.lang')->group(function () {
  Route::get('/signup', [VendorController::class, 'signup'])->name('api.vendor.signup');
  Route::post('/signup/submit', [VendorController::class, 'create'])->name('api.vendor.create');
  Route::get('/login', [VendorController::class, 'login'])->name('api.vendor.login');
  Route::post('/login/submit', [VendorController::class, 'authentication'])->name('api.vendor.authentication')->middleware('Demo');
  Route::get('/email/verify', [VendorController::class, 'confirm_email'])->name('api.vendor.email.verify');
  Route::post('/send-forget-mail', [VendorController::class, 'forget_mail'])->name('api.vendor.forget.mail');
  Route::post('/verify-forget-otp', [VendorController::class, 'verify_forget_otp'])->name('api.vendor.verify.forget.otp');
  Route::post('/update-forget-password', [VendorController::class, 'update_password'])->name('api.vendor.update.forget.password');
});

// Protected vendor routes (require Sanctum token)
Route::prefix('vendor')->middleware(['auth:sanctum', 'api.lang', 'Demo'])->group(function () {
  Route::post('/logout', [VendorController::class, 'logout'])->name('api.vendor.logout');
  Route::get('/dashboard', [VendorController::class, 'dashboard'])->name('api.vendor.dashboard');
  Route::get('/edit-profile', [VendorController::class, 'edit_profile'])->name('api.vendor.edit.profile');
  Route::post('/update/profile', [VendorController::class, 'update_profile'])->name('api.vendor.update.profile');
  Route::post('/update/password', [VendorController::class, 'updated_password'])->name('api.vendor.update.password');
  Route::get('/payment-log', [VendorController::class, 'payment_log'])->name('api.vendor.payment.log');
  Route::get('/language-management/{id}/check-rtl', [VendorController::class, 'checkRTL'])->name('api.vendor.check.rtl');

  // AI
  Route::prefix('ai')->group(function () {
    Route::post('/generate/image', [VendorAiImageController::class, 'generateImage'])
      ->name('api.vendor.ai.generate.category.image')
      ->middleware('aiQuotaWarning');
    Route::post('/generate/content', [VendorAiContentController::class, 'generateContent'])
      ->name('api.vendor.ai.generate.content')
      ->middleware('aiQuotaWarning');
    Route::post('/generate-slider-images', [VendorAiImageController::class, 'generateSliderImages'])
      ->name('api.vendor.ai.generate.slider.images')
      ->middleware('aiQuotaWarning');
  });

  // Support tickets
  Route::prefix('support-tickets')->group(function () {
    Route::get('/', [SupportTicketController::class, 'index'])->name('api.vendor.support_tickets.index');
    Route::post('/store', [SupportTicketController::class, 'store'])->name('api.vendor.support_tickets.store');
    Route::get('/{id}', [SupportTicketController::class, 'show'])->name('api.vendor.support_tickets.show');
    Route::post('/{id}/reply', [SupportTicketController::class, 'reply'])->name('api.vendor.support_tickets.reply');
    Route::post('/{id}/delete', [SupportTicketController::class, 'delete'])->name('api.vendor.support_tickets.delete');
  });

  // Buy Plan
  Route::prefix('buy-plan')->group(function () {
    Route::get('/', [BuyPlanController::class, 'index'])->name('api.vendor.buy_plan.index');
    Route::get('/checkout/{package_id}', [BuyPlanController::class, 'checkout'])->name('api.vendor.buy_plan.checkout');
    Route::post('/checkout/{package_id}', [VendorCheckoutController::class, 'checkout'])->name('api.vendor.buy_plan.process_checkout');
    Route::post('/checkout/{package_id}/payment-verifier', [VendorCheckoutController::class, 'paymentVerifier'])->name('api.vendor.buy_plan.payment_verifier');
    Route::post('/checkout/{package_id}/complete-online', [VendorCheckoutController::class, 'completeOnlineCheckout'])->name('api.vendor.buy_plan.complete_online_checkout');
  });

  // Withdraw
  Route::prefix('withdraw')->group(function () {
    Route::get('/', [VendorWithdrawController::class, 'index'])->name('api.vendor.withdraw.index');
    Route::get('/methods', [VendorWithdrawController::class, 'methods'])->name('api.vendor.withdraw.methods');
    Route::get('/inputs/{id}', [VendorWithdrawController::class, 'get_inputs'])->name('api.vendor.withdraw.inputs');
    Route::get('/calculate', [VendorWithdrawController::class, 'balance_calculation'])->name('api.vendor.withdraw.calculate');
    Route::post('/request', [VendorWithdrawController::class, 'send_request'])->name('api.vendor.withdraw.request');
    Route::post('/{id}/delete', [VendorWithdrawController::class, 'delete'])->name('api.vendor.withdraw.delete');
    Route::post('/bulk-delete', [VendorWithdrawController::class, 'bulkDelete'])->name('api.vendor.withdraw.bulk_delete');
  });

  //Mail setting
  Route::prefix('mail-setting')->group(function () {
    Route::get('/', [MAilSetController::class, 'mailToAdmin'])->name('api.vendor.mail_setting.index');
    Route::post('/update', [MAilSetController::class, 'updateMailToAdmin'])->name('api.vendor.mail_setting.update');
  });

  // Messages
  Route::prefix('messages')->group(function () {
    Route::get('/listing', [MessageController::class, 'index'])->name('api.vendor.messages.listing');
    Route::post('/listing/{id}/delete', [MessageController::class, 'delete'])->name('api.vendor.messages.listing.delete');
    Route::post('/listing/bulk-delete', [MessageController::class, 'bulkDelete'])->name('api.vendor.messages.listing.bulk_delete');
    Route::get('/product', [MessageController::class, 'productIndex'])->name('api.vendor.messages.product');
    Route::get('/product/{id}', [MessageController::class, 'showMessageDetails'])->name('api.vendor.messages.product.show');
    Route::post('/product/{id}/delete', [MessageController::class, 'productDelete'])->name('api.vendor.messages.product.delete');
    Route::post('/product/bulk-delete', [MessageController::class, 'productBulkDelete'])->name('api.vendor.messages.product.bulk_delete');
  });

  // Listing FAQs
  Route::prefix('listings/{listing_id}/faqs')->group(function () {
    Route::get('/', [VendorListingFaqController::class, 'index'])->name('api.vendor.listing_faqs.index');
    Route::post('/store', [VendorListingFaqController::class, 'store'])->name('api.vendor.listing_faqs.store');
    Route::post('/{faq_id}/update', [VendorListingFaqController::class, 'update'])->name('api.vendor.listing_faqs.update');
    Route::post('/{faq_id}/delete', [VendorListingFaqController::class, 'destroy'])->name('api.vendor.listing_faqs.destroy');
    Route::post('/bulk-delete', [VendorListingFaqController::class, 'bulkDestroy'])->name('api.vendor.listing_faqs.bulk_destroy');
  });

  // Listings management
  Route::get('/listings', [VendorListingController::class, 'index'])->name('api.vendor.listings.index');
  Route::get('/listings/create', [VendorListingController::class, 'getCreateForm'])->name('api.vendor.listings.create');
  Route::get('/listings/states', [VendorListingController::class, 'getState'])->name('api.vendor.listings.states');
  Route::get('/listings/cities', [VendorListingController::class, 'getCity'])->name('api.vendor.listings.cities');
  Route::post('/listings', [VendorListingController::class, 'apiStore'])->name('api.vendor.listings.store');
  Route::post('/listings/{id}/update', [VendorListingController::class, 'apiUpdate'])->name('api.vendor.listings.update');
  Route::post('/listings/{id}/delete', [VendorListingController::class, 'apiDelete'])->name('api.vendor.listings.delete');
  Route::post('/listings/{id}/visibility', [VendorListingController::class, 'apiUpdateVisibility'])->name('api.vendor.listings.visibility');
  Route::get('/listings/{id}/feature-options', [VendorListingController::class, 'featureOptions'])->name('api.vendor.listings.feature_options');
  Route::post('/listings/{id}/feature-request', [VendorListingController::class, 'requestFeature'])->name('api.vendor.listings.feature_request');
  Route::post('/listings/{id}/feature-payment-verifier', [VendorListingController::class, 'featurePaymentVerifier'])->name('api.vendor.listings.feature_payment_verifier');
  Route::post('/listings/{id}/feature-complete-online', [VendorListingController::class, 'completeFeatureOnline'])->name('api.vendor.listings.feature_complete_online');
  Route::get('/listings/{id}/edit', [VendorListingController::class, 'edit'])->name('api.vendor.listings.edit');
  Route::get('/listings/{id}/business-hours', [VendorListingController::class, 'getBusinessHours'])->name('api.vendor.listings.business_hours.index');
  Route::post('/listings/{id}/business-hours', [VendorListingController::class, 'saveBusinessHours'])->name('api.vendor.listings.business_hours.save');
  Route::get('/listings/{id}/social-links', [VendorListingController::class, 'getSocialLinks'])->name('api.vendor.listings.social_links.index');
  Route::post('/listings/{id}/social-links', [VendorListingController::class, 'saveSocialLinks'])->name('api.vendor.listings.social_links.save');
  Route::get('/listings/{id}/features', [VendorListingController::class, 'getFeatures'])->name('api.vendor.listings.features.index');
  Route::post('/listings/{id}/features', [VendorListingController::class, 'saveFeatures'])->name('api.vendor.listings.features.save');
  Route::get('/listings/{id}/plugins', [VendorListingController::class, 'getPlugins'])->name('api.vendor.listings.plugins.index');
  Route::post('/listings/{id}/plugins/tawkto', [VendorListingController::class, 'saveTawkTo'])->name('api.vendor.listings.plugins.tawkto');
  Route::post('/listings/{id}/plugins/telegram', [VendorListingController::class, 'saveTelegram'])->name('api.vendor.listings.plugins.telegram');
  Route::post('/listings/{id}/plugins/whatsapp', [VendorListingController::class, 'saveWhatsApp'])->name('api.vendor.listings.plugins.whatsapp');
  Route::post('/listings/{id}/plugins/messenger', [VendorListingController::class, 'saveMessenger'])->name('api.vendor.listings.plugins.messenger');
  // TODO: add store, update, delete routes here as needed

  // Shop management
  Route::prefix('shop')->group(function () {
    // Categories
    Route::get('/categories', [VendorShopCategoryController::class, 'index']);
    Route::post('/categories', [VendorShopCategoryController::class, 'store']);
    Route::post('/categories/{id}/update', [VendorShopCategoryController::class, 'update']);
    Route::post('/categories/{id}/delete', [VendorShopCategoryController::class, 'destroy']);
    Route::post('/categories/bulk-delete', [VendorShopCategoryController::class, 'bulkDestroy']);

    // Products
    Route::get('/products', [VendorShopProductController::class, 'index']);
    Route::get('/products/create', [VendorShopProductController::class, 'create']);
    Route::post('/products', [VendorShopProductController::class, 'store']);
    Route::get('/products/{id}/edit', [VendorShopProductController::class, 'edit']);
    Route::post('/products/{id}/update', [VendorShopProductController::class, 'update']);
    Route::post('/products/{id}/featured', [VendorShopProductController::class, 'updateFeaturedStatus']);
    Route::post('/products/{id}/slider-image/remove', [VendorShopProductController::class, 'detachImage']);
    Route::post('/products/{id}/delete', [VendorShopProductController::class, 'destroy']);
    Route::post('/products/bulk-delete', [VendorShopProductController::class, 'bulkDestroy']);

    // Orders
    Route::get('/orders', [VendorShopOrderController::class, 'index']);
    Route::get('/orders/{id}', [VendorShopOrderController::class, 'show']);
    Route::post('/orders/{id}/delete', [VendorShopOrderController::class, 'destroy']);
    Route::post('/orders/bulk-delete', [VendorShopOrderController::class, 'bulkDestroy']);

    // Forms
    Route::get('/forms', [VendorShopFormController::class, 'index'])->name('api.vendor.shop.forms.index');
    Route::post('/forms', [VendorShopFormController::class, 'store'])->name('api.vendor.shop.forms.store');
    Route::get('/forms/{id}', [VendorShopFormController::class, 'show'])->name('api.vendor.shop.forms.show');
    Route::put('/forms/{id}', [VendorShopFormController::class, 'update'])->name('api.vendor.shop.forms.update');
    Route::delete('/forms/{id}', [VendorShopFormController::class, 'destroy'])->name('api.vendor.shop.forms.destroy');

    // Form Inputs
    Route::get('/forms/{formId}/inputs', [VendorShopFormInputController::class, 'index'])->name('api.vendor.shop.form_inputs.index');
    Route::post('/forms/{formId}/inputs', [VendorShopFormInputController::class, 'store'])->name('api.vendor.shop.form_inputs.store');
    Route::get('/inputs/{inputId}', [VendorShopFormInputController::class, 'show'])->name('api.vendor.shop.form_inputs.show');
    Route::put('/inputs/{inputId}', [VendorShopFormInputController::class, 'update'])->name('api.vendor.shop.form_inputs.update');
    Route::delete('/inputs/{inputId}', [VendorShopFormInputController::class, 'destroy'])->name('api.vendor.shop.form_inputs.destroy');
    Route::put('/forms/{formId}/inputs/reorder', [VendorShopFormInputController::class, 'reorder'])->name('api.vendor.shop.form_inputs.reorder');
  });

    // Vendor FCM Token save
  Route::post('/save-fcm-token', [VendorFcmTokenController::class, 'store'])
    ->name('api.vendor.save_fcm_token');

  Route::get('/notifications', [VendorNotificationController::class, 'index'])
    ->name('api.vendor.notifications.index');
  Route::post('/notifications/{id}/read', [VendorNotificationController::class, 'markAsRead'])
    ->whereNumber('id')
    ->name('api.vendor.notifications.read');
  Route::delete('/notifications/{id}', [VendorNotificationController::class, 'destroy'])
    ->whereNumber('id')
    ->name('api.vendor.notifications.delete');
  Route::get('/payment-keys', [VendorCheckoutController::class, 'gatewayKeys'])->name('api.vendor.payment_keys');


});

// vendor details info
Route::get('/lang/panel/{code}', [LanguageController::class, 'panelLang']);
