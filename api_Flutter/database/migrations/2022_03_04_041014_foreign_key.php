<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class ForeignKey extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {

       
        Schema::table('vouchers', function (Blueprint $table) {
            // $table->foreign('productID')->references('id')->on('products');
            $table->foreign('employeeID')->references('id')->on('employees');
        });
        
        // Schema::table('notifications', function (Blueprint $table) {
        //     $table->foreign('userID')->references('id')->on('users');
        // });

        Schema::table('addresses', function (Blueprint $table) {
            $table->foreign('userID')->references('id')->on('users');
        });
        Schema::table('favorites', function (Blueprint $table) {
            $table->foreign('userID')->references('id')->on('users');
          
        });
        Schema::table('favorite_details', function (Blueprint $table) {
            $table->foreign('favoriteID')->references('id')->on('favorites');
            $table->foreign('productID')->references('id')->on('products');
        });
        Schema::table('reviews', function (Blueprint $table) {
            $table->foreign('productID')->references('id')->on('products');
            $table->foreign('userID')->references('id')->on('users');
        });
       
        Schema::table('invoices', function (Blueprint $table) {
            $table->foreign('employeeID')->references('id')->on('employees');
            $table->foreign('userID')->references('id')->on('users');
        });
        Schema::table('invoice_details', function (Blueprint $table) {
            $table->foreign('productID')->references('id')->on('products');
            $table->foreign('invoiceID')->references('id')->on('invoices');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
}
