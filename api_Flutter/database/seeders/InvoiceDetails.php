<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class InvoiceDetails extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('invoice_details')->insert([
            [
                'id' => 1,
                'invoiceID' => 'HD202203161',
                'productID' => 2,
                'quantity' => 5,
            ],
            [
                'id' => 2,
                'invoiceID' => 'HD202203161',
                'productID' => 3,
                'quantity' => 5,
            ],
            [
                'id' => 3,
                'invoiceID' => 'HD202203162',
                'productID' => 4,
                'quantity' => 6,
            ],
        ]);
    }
}
