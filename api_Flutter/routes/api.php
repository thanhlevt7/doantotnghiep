<?php

use App\Http\Controllers\AddressController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\FavoriteController;
use App\Http\Controllers\InvoiceController;
use App\Http\Controllers\InvoiceDetailsController;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\UserReview;
use App\Http\Controllers\VoucherController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
 */

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });
//product controller
Route::group(['prefix' => 'products'], function () {
    Route::get('/getAllProduct/{userID}', [ProductController::class, 'getAllProduct']);

    Route::get('/newProduct/{userID}', [ProductController::class, 'newProduct']);

    Route::get('/Fruit/{id}', [ProductController::class, 'Fruit']);

    Route::get('/Vegetable/{id}', [ProductController::class, 'Vegetable']);

    Route::get('/Meat/{id}', [ProductController::class, 'Meat']);

    Route::get('/Drink/{id}', [ProductController::class, 'Drink']);

    Route::get('/getBestSeller', [ProductController::class, 'getProductBestSeller']);

    Route::post('/result-filter/{userID}', [ProductController::class, 'Filter']);
});

//user controller
Route::group(['prefix' => 'users'], function () {
    Route::get('/return-user/{id}', [UserController::class, 'loadUser']);

    Route::post('/register', [UserController::class, 'register']);

    Route::put('/editUser/{id}', [UserController::class, 'editUser']);

    Route::put('/editImage/{id}', [UserController::class, 'editImage']);

    Route::put('/change-Password/{id}', [UserController::class, 'changePassword']);

    Route::delete('/delete-address/{id}', [AddressController::class, 'deleteAddress']);

    Route::post('/create-Address', [AddressController::class, 'createAddress']);

    Route::get('/count-Address/{id}', [AddressController::class, 'countAddress']);

    Route::post('/check/{id}', [UserController::class, 'check']);

    Route::post('/login', [UserController::class, 'login']);

    Route::get('/logout', [UserController::class, 'logout']);
});
//invoices controller
Route::group(['prefix' => 'invoices'], function () {
    Route::get('/getInvoiceForUser/{id}', [InvoiceController::class, 'getInvoiceForUser']);

    Route::get('/review/{id}', [InvoiceController::class, 'review']);

    Route::post('/createInvoice', [InvoiceController::class, 'createInvoice']);

    Route::put('/editUser/{id}', [InvoiceController::class, 'editUser']);

    Route::delete('/deleteUser/{id}', [InvoiceController::class, 'deleteUser']);

    Route::put('/payment/{id}', [InvoiceController::class, 'payment']);

    Route::post('/buynow', [InvoiceController::class, 'buynow']);

    Route::get('/order-details/{id}', [InvoiceController::class, 'OrderDetails']);

    Route::delete('/CancelOrder/{id}', [InvoiceController::class, 'CancelOrder']);
    //cart
    Route::get('/getCart/{id}', [CartController::class, 'getCartForUser']);

    Route::post('/AddToCart/{id}', [CartController::class, 'AddToCart']);

    Route::delete('/DeleteProductCart/{id}', [CartController::class, 'deleteProductCart']);

    Route::put('/UpdateQuantityIncrement', [CartController::class, 'updateQuantityIncrement']);

    Route::put('/UpdateQuantityDecrement', [CartController::class, 'UpdateQuantityDecrement']);

    Route::put('/UpdateQuantity', [CartController::class, 'UpdateQuantity']);
    //end cart
    Route::get('/getInvoiceSuccess/{id}', [InvoiceController::class, 'getInvoiceForUser']);

    Route::get('/getWaitingToAccept/{id}', [InvoiceController::class, 'getInvoiceWaitingToAccept']);

    Route::get('/getPickingUpGood/{id}', [InvoiceController::class, 'getInvoicePickingUpGood']);

    Route::get('/getOnDelivery/{id}', [InvoiceController::class, 'getInvoiceOnDelivery']);

    Route::get('/getCancelOrder/{id}', [InvoiceController::class, 'getCancelOrder']);
});
//'invoice_details controller
Route::group(['prefix' => 'invoice_details'], function () {
    Route::post('/createInvoiceDetails', [InvoiceDetailsController::class, 'createInvoiceDetails']);

    Route::post('/createInvoice', [InvoiceDetailsController::class, 'createInvoice']);

    Route::put('/editUser/{id}', [InvoiceDetailsController::class, 'editUser']);

    Route::delete('/deleteUser/{id}', [InvoiceDetailsController::class, 'deleteUser']);

    Route::get('/showAll', [InvoiceDetailsController::class, 'showAll']);
});

Route::group(['prefix' => 'notifications'], function () {

    Route::get('/show', [NotificationController::class, 'loadNotification']);
    Route::get('/getNoticationsForUser/{id}', [NotificationController::class, 'loadNotificationForUser']);
});

Route::group(['prefix' => 'favorites'], function () {

    Route::get('/show/{userID}', [FavoriteController::class, 'showFavorite']);

    Route::post('/AddFavoriteTitle/{userID}', [FavoriteController::class, 'AddFavoriteTitle']);

    Route::delete('/DeleteFavoriteTitle', [FavoriteController::class, 'DeleteFavorite']);

    Route::post('/Add-product', [FavoriteController::class, 'AddProduct']);

    Route::post('/delete-product', [FavoriteController::class, 'DeleteProduct']);
});
Route::group(['prefix' => 'reviews'], function () {

    Route::post('/post-comment', [UserReview::class, 'Post']);
});
Route::group(['prefix' => 'vouchers'], function () {

    Route::post('/check-voucher/{userID}', [VoucherController::class, 'CheckVoucher']);
});
