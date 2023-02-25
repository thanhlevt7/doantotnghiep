<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class Notification extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('notifications')->insert([
            [
                'id' => 1,
                'title' => 'Giảm giá ',
                'content' => 'Nhanh tay mua ngay, nhập ngay mã voucher :pqrbGC',
                'userID' => '-1',
                'image' => 'https://img-cache.coccoc.com/image2?i=4&l=54/854640637',
                'startDate' => "2023/02/13",
                'endDate' =>  "2030/02/11",

            ],
        ]);
    }
}
