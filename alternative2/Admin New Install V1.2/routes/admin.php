<?php

use Illuminate\Support\Facades\Route;

Route::group(['namespace' => 'Admin', 'as' => 'admin.'], function () {
    /*authentication*/
    Route::group(['namespace' => 'Auth', 'prefix' => 'auth', 'as' => 'auth.'], function () {
        Route::get('login', 'LoginController@login')->name('login');
        Route::post('login', 'LoginController@submit')->middleware('actch');
        Route::get('logout', 'LoginController@logout')->name('logout');
    });
    /*authentication*/

    Route::group(['middleware' => ['admin']], function () {
        Route::get('/', 'SystemController@dashboard')->name('dashboard');
        Route::get('settings', 'SystemController@settings')->name('settings');
        Route::post('settings', 'SystemController@settings_update');
        Route::post('settings-password', 'SystemController@settings_password_update')->name('settings-password');
        Route::get('/get-restaurant-data', 'SystemController@restaurant_data')->name('get-restaurant-data');

        Route::group(['prefix' => 'banner', 'as' => 'banner.'], function () {
            Route::get('add-new', 'BannerController@index')->name('add-new');
            Route::post('store', 'BannerController@store')->name('store');
            Route::get('edit/{id}', 'BannerController@edit')->name('edit');
            Route::put('update/{id}', 'BannerController@update')->name('update');
            Route::get('list', 'BannerController@list')->name('list');
            Route::get('status/{id}/{status}', 'BannerController@status')->name('status');
            Route::delete('delete/{id}', 'BannerController@delete')->name('delete');
        });

        Route::group(['prefix' => 'attribute', 'as' => 'attribute.'], function () {
            Route::get('add-new', 'AttributeController@index')->name('add-new');
            Route::post('store', 'AttributeController@store')->name('store');
            Route::get('edit/{id}', 'AttributeController@edit')->name('edit');
            Route::post('update/{id}', 'AttributeController@update')->name('update');
            Route::delete('delete/{id}', 'AttributeController@delete')->name('delete');
        });

        Route::group(['prefix' => 'branch', 'as' => 'branch.'], function () {
            Route::get('add-new', 'BranchController@index')->name('add-new');
            Route::post('store', 'BranchController@store')->name('store');
            Route::get('edit/{id}', 'BranchController@edit')->name('edit');
            Route::post('update/{id}', 'BranchController@update')->name('update');
            Route::delete('delete/{id}', 'BranchController@delete')->name('delete');
        });

        Route::group(['prefix' => 'delivery-man', 'as' => 'delivery-man.'], function () {
            Route::get('add', 'DeliveryManController@index')->name('add');
            Route::post('store', 'DeliveryManController@store')->name('store');
            Route::get('list', 'DeliveryManController@list')->name('list');
            Route::get('preview/{id}', 'DeliveryManController@preview')->name('preview');
            Route::get('edit/{id}', 'DeliveryManController@edit')->name('edit');
            Route::post('update/{id}', 'DeliveryManController@update')->name('update');
            Route::delete('delete/{id}', 'DeliveryManController@delete')->name('delete');
            Route::post('search', 'DeliveryManController@search')->name('search');

            Route::group(['prefix' => 'reviews', 'as' => 'reviews.'], function () {
                Route::get('list', 'DeliveryManController@reviews_list')->name('list');
            });
        });

        Route::group(['prefix' => 'notification', 'as' => 'notification.'], function () {
            Route::get('add-new', 'NotificationController@index')->name('add-new');
            Route::post('store', 'NotificationController@store')->name('store');
            Route::get('edit/{id}', 'NotificationController@edit')->name('edit');
            Route::post('update/{id}', 'NotificationController@update')->name('update');
            Route::get('status/{id}/{status}', 'NotificationController@status')->name('status');
            Route::delete('delete/{id}', 'NotificationController@delete')->name('delete');
        });

        Route::group(['prefix' => 'product', 'as' => 'product.'], function () {
            Route::get('add-new', 'ProductController@index')->name('add-new');
            Route::post('variant-combination', 'ProductController@variant_combination')->name('variant-combination');
            Route::post('store', 'ProductController@store')->name('store');
            Route::get('edit/{id}', 'ProductController@edit')->name('edit');
            Route::post('update/{id}', 'ProductController@update')->name('update');
            Route::get('list', 'ProductController@list')->name('list');
            Route::delete('delete/{id}', 'ProductController@delete')->name('delete');
            Route::get('status/{id}/{status}', 'ProductController@status')->name('status');
            Route::post('search', 'ProductController@search')->name('search');

            Route::get('view/{id}', 'ProductController@view')->name('view');
            Route::get('remove-image/{id}/{name}', 'ProductController@remove_image')->name('remove-image');
            //ajax request
            Route::get('get-categories', 'ProductController@get_categories')->name('get-categories');
            Route::post('daily-needs', 'ProductController@daily_needs')->name('daily-needs');
        });

        Route::group(['prefix' => 'orders', 'as' => 'orders.'], function () {
            Route::get('list/{status}', 'OrderController@list')->name('list');
            Route::get('details/{id}', 'OrderController@details')->name('details');
            Route::get('status', 'OrderController@status')->name('status');
            Route::get('add-delivery-man/{order_id}/{delivery_man_id}', 'OrderController@add_delivery_man')->name('add-delivery-man');
            Route::get('payment-status', 'OrderController@payment_status')->name('payment-status');
            Route::post('productStatus', 'OrderController@productStatus')->name('productStatus');
            Route::get('generate-invoice/{id}', 'OrderController@generate_invoice')->name('generate-invoice');
            Route::post('add-payment-ref-code/{id}', 'OrderController@add_payment_ref_code')->name('add-payment-ref-code');
            Route::get('branch-filter/{branch_id}', 'OrderController@branch_filter')->name('branch-filter');
            Route::post('date-search', 'OrderController@date_search')->name('date_search');
            Route::post('time-search', 'OrderController@time_search')->name('time_search');

            Route::post('search', 'OrderController@search')->name('search');
        });

        Route::group(['prefix' => 'order', 'as' => 'order.'], function () {
            Route::get('list/{status}', 'OrderController@list')->name('list');
            Route::put('status-update/{id}', 'OrderController@status')->name('status-update');
            Route::get('view/{id}', 'OrderController@view')->name('view');
            Route::post('update-shipping/{id}', 'OrderController@update_shipping')->name('update-shipping');
            Route::post('update-timeSlot', 'OrderController@update_time_slot')->name('update-timeSlot');
            Route::post('update-deliveryDate', 'OrderController@update_deliveryDate')->name('update-deliveryDate');

            Route::delete('delete/{id}', 'OrderController@delete')->name('delete');
        });

        Route::group(['prefix' => 'category', 'as' => 'category.'], function () {
            Route::get('add', 'CategoryController@index')->name('add');
            Route::get('add-sub-category', 'CategoryController@sub_index')->name('add-sub-category');
            Route::get('add-sub-sub-category', 'CategoryController@sub_sub_index')->name('add-sub-sub-category');
            Route::post('store', 'CategoryController@store')->name('store');
            Route::get('edit/{id}', 'CategoryController@edit')->name('edit');
            Route::post('update/{id}', 'CategoryController@update')->name('update');
            Route::post('store', 'CategoryController@store')->name('store');
            Route::get('status/{id}/{status}', 'CategoryController@status')->name('status');
            Route::delete('delete/{id}', 'CategoryController@delete')->name('delete');
            Route::post('search', 'CategoryController@search')->name('search');
        });

        Route::group(['prefix' => 'message', 'as' => 'message.'], function () {
            Route::get('list', 'ConversationController@list')->name('list');
            Route::post('store/{user_id}', 'ConversationController@store')->name('store');
            Route::get('view/{user_id}', 'ConversationController@view')->name('view');
        });

        Route::group(['prefix' => 'reviews', 'as' => 'reviews.'], function () {
            Route::get('list', 'ReviewsController@list')->name('list');
            Route::post('search', 'ReviewsController@search')->name('search');
        });

        Route::group(['prefix' => 'coupon', 'as' => 'coupon.'], function () {
            Route::get('add-new', 'CouponController@add_new')->name('add-new');
            Route::post('store', 'CouponController@store')->name('store');
            Route::get('update/{id}', 'CouponController@edit')->name('update');
            Route::post('update/{id}', 'CouponController@update');
            Route::get('status/{id}/{status}', 'CouponController@status')->name('status');
            Route::delete('delete/{id}', 'CouponController@delete')->name('delete');
        });

        Route::group(['prefix' => 'timeSlot', 'as' => 'timeSlot.'], function () {
            Route::get('add-new', 'TimeSlotController@add_new')->name('add-new');
            Route::post('store', 'TimeSlotController@store')->name('store');
            Route::get('update/{id}', 'TimeSlotController@edit')->name('update');
            Route::post('update/{id}', 'TimeSlotController@update');
            Route::get('status/{id}/{status}', 'TimeSlotController@status')->name('status');
            Route::delete('delete/{id}', 'TimeSlotController@delete')->name('delete');
        });

        Route::group(['prefix' => 'business-settings', 'as' => 'business-settings.'], function () {
            Route::get('ecom-setup', 'BusinessSettingsController@restaurant_index')->name('ecom-setup')->middleware('actch');
            Route::post('update-setup', 'BusinessSettingsController@restaurant_setup')->name('update-setup');

            Route::get('fcm-index', 'BusinessSettingsController@fcm_index')->name('fcm-index')->middleware('actch');
            Route::post('update-fcm', 'BusinessSettingsController@update_fcm')->name('update-fcm');

            Route::post('update-fcm-messages', 'BusinessSettingsController@update_fcm_messages')->name('update-fcm-messages');

            Route::get('mail-config', 'BusinessSettingsController@mail_index')->name('mail-config')->middleware('actch');
            Route::post('mail-config', 'BusinessSettingsController@mail_config');

            Route::get('payment-method', 'BusinessSettingsController@payment_index')->name('payment-method')->middleware('actch');
            Route::post('payment-method-update/{payment_method}', 'BusinessSettingsController@payment_update')->name('payment-method-update');

            Route::get('currency-add', 'BusinessSettingsController@currency_index')->name('currency-add')->middleware('actch');
            Route::post('currency-add', 'BusinessSettingsController@currency_store');
            Route::get('currency-update/{id}', 'BusinessSettingsController@currency_edit')->name('currency-update')->middleware('actch');
            Route::put('currency-update/{id}', 'BusinessSettingsController@currency_update');
            Route::delete('currency-delete/{id}', 'BusinessSettingsController@currency_delete')->name('currency-delete');

            Route::get('terms-and-conditions', 'BusinessSettingsController@terms_and_conditions')->name('terms-and-conditions');
            Route::post('terms-and-conditions', 'BusinessSettingsController@terms_and_conditions_update');

            Route::get('location-setup', 'LocationSettingsController@location_index')->name('location-setup')->middleware('actch');
            Route::post('update-location', 'LocationSettingsController@location_setup')->name('update-location');

            Route::get('privacy-policy', 'BusinessSettingsController@privacy_policy')->name('privacy-policy');
            Route::post('privacy-policy', 'BusinessSettingsController@privacy_policy_update');

            Route::get('about-us', 'BusinessSettingsController@about_us')->name('about-us');
            Route::post('about-us', 'BusinessSettingsController@about_us_update');
        });

        Route::group(['prefix' => 'report', 'as' => 'report.'], function () {
            Route::get('order', 'ReportController@order_index')->name('order');
            Route::get('earning', 'ReportController@earning_index')->name('earning');
            Route::post('set-date', 'ReportController@set_date')->name('set-date');
        });

        Route::group(['prefix' => 'customer', 'as' => 'customer.'], function () {
            Route::get('list', 'CustomerController@customer_list')->name('list');
            Route::get('view/{user_id}', 'CustomerController@view')->name('view');
            Route::post('search', 'CustomerController@search')->name('search');
        });
    });
});
