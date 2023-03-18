<?php

namespace Database\Seeders;

use App\Models\Provider;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        // \App\Models\User::factory(10)->create();
        $this->call([

            User::class,
            Address::class,
            Product::class,
            Voucher::class,
            Notification::class,
            Invoice::class,
            InvoiceDetails::class,
            Review::class,
            Favorites::class,
        ]);
    }
}