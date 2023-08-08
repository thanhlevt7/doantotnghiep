<?php

use App\Http\Controllers\Admin\AccountController;
use App\Http\Controllers\Admin\HomeController;
use App\Http\Controllers\Admin\InvoiceController;
use App\Http\Controllers\Admin\LoginController;
use App\Http\Controllers\Admin\NotificationController;
use App\Http\Controllers\Admin\ProductController;
use App\Http\Controllers\Admin\ReviewController;
use App\Http\Controllers\Admin\VoucherController;
use App\Http\Controllers\Admin\ProductImportsController;
use Illuminate\Support\Facades\Route;

Route::group(['prefix' => '/'], function () {
    Route::get('login', [LoginController::class, 'loginForm'])->name('admin.login.get');
    Route::post('login', [LoginController::class, 'login'])->name('admin.login.post');
    Route::get('logout', [LoginController::class, 'logout'])->
        name('admin.logout');
        Route::get('/abcdef', [ProductController::class, 'loadProduct'])->
        name('admin.product');

    Route::group(['middleware' => ['auth:admin']], function () {
        Route::get('/dashboard', [HomeController::class, 'index'])->name('admin.dashboard');

        Route::get('/account', [AccountController::class, 'loadAccount'])->
            name('admin.account');

        Route::get('/account/lockUser/{id}', [AccountController::class, 'lockUser'])->
            name('admin.account.lockUser');

        Route::get('/account/unLockUser/{id}', [AccountController::class, 'unLockUser'])->
            name('admin.account.unLockUser');

        Route::get('/account/delete/{id}', [AccountController::class, 'deleteAccount'])->
            name('admin.account.delete');

        Route::get('/account/search', [AccountController::class, 'searchAccount'])->
            name('admin.account.search');

        Route::get('/account/profile', [AccountController::class, 'viewProfile'])->
            name('admin.account.profile');

        Route::get('/account/view/{id}', [AccountController::class, 'viewAccount']);
        Route::post('/account/update/{id}', [AccountController::class, 'editUser']);

        //--------------------------------------------------------------->

        Route::group(['prefix' => '/products'], function () {

            Route::get('', [ProductController::class, 'loadProduct'])->
                name('admin.product');

            Route::get('/search', [ProductController::class, 'Search'])->
                name('admin.product.search');

            Route::get('/create-product', [ProductController::class, 'viewCreate'])->
                name('admin.product.create');
            Route::post('/create-product', [ProductController::class, 'createProduct'])->
                name('admin.product.create.post');

            Route::get('/delete/{id}', [ProductController::class, 'deleteProduct'])->
                name('admin.product.delete');
            Route::get('/edit/{id}', [ProductController::class, 'edit']);
            Route::get('/view/{id}', [ProductController::class, 'viewProduct']);
            Route::post('/update/{id}', [ProductController::class, 'updateProduct']);

        });

        //----------------------------------------------------------------------------------------
        Route::group(['prefix' => '/invoices'], function () {

            Route::get('/details/{invoiceID}', [InvoiceController::class, 'detailsInvoice'])->name('admin.invoice.details');

            Route::get('/search', [InvoiceController::class, 'Search']);

            Route::get('/order-tracking', [InvoiceController::class, 'orderTracking'])->name('admin.invoice.orderTracking');

            Route::get('/order-tracking/confirmStatus/{invoiceID}', [InvoiceController::class, 'handleConfirmStatus'])->name('admin.invoice.confirmStatus');

            Route::get('/waiting-to-accept', [InvoiceController::class, 'waitingToAccept'])->name('admin.invoice.waiting');

            Route::get('/confirmed', [InvoiceController::class, 'confirmed'])->name('admin.invoice.confirmed');

            Route::get('/cancel', [InvoiceController::class, 'cancel'])->name('admin.invoice.cancel');

            Route::get('/on-delivery', [InvoiceController::class, 'onDelivery'])->name('admin.invoice.delivery');

            Route::get('/success-delivery', [InvoiceController::class, 'success'])->name('admin.invoice.success');
        });

        //----------------------------------------------------------

//----------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------

        Route::group(['prefix' => '/vouchers'], function () {

            Route::get('', [VoucherController::class, 'Index'])->name('admin.vouchers.index');

            Route::get('/create', [VoucherController::class, 'FormCreate'])->name('admin.vouchers.create');

            Route::get('/edit/{id}', [VoucherController::class, 'edit']);
            Route::post('/update/{id}', [VoucherController::class, 'updateVoucher']);
            Route::post('/create', [VoucherController::class, 'CreateVoucher'])->name('admin.vouchers.create.post');
            Route::get('/delete/{id}', [VoucherController::class, 'deleteVoucher'])->name('admin.vouchers.delete');
        });

        Route::group(['prefix' => '/reviews'], function () {

            Route::get('', [ReviewController::class, 'Index'])->name('admin.reviews.index');
            Route::get('/delete/{id}', [ReviewController::class, 'deleteReview'])->name('admin.reviews.delete');

        });
        Route::group(['prefix' => '/notifications'], function () {
            Route::get('/edit/{id}', [NotificationController::class, 'edit']);
            Route::post('/update/{id}', [NotificationController::class, 'updateNotification']);
            Route::get('', [NotificationController::class, 'Index'])->name('admin.notifications.index');
            Route::get('/create', [NotificationController::class, 'FormCreate'])->name('admin.notifications.create');
            Route::post('/create', [NotificationController::class, 'CreateNotification'])->name('admin.notifications.create.post');
            Route::get('/delete/{id}', [NotificationController::class, 'deleteNotification'])->name('admin.notifications.delete');

        });

    });

});
