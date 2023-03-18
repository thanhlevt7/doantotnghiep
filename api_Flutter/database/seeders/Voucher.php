<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class Voucher extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('vouchers')->insert([
            [
                'id' => 1,
                'code' => 'pqrbGC',
                'name' => 'Giảm giá ',
                'sale' => '10000',
                'startDate' => "2023/02/13",
                'endDate' => "2030/02/11",
                'limit' => 22222222,
                'status' => 1,

            ],
        ]);
    }
}
