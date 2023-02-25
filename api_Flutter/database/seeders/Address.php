<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class Address extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('addresses')->insert([
            [
                'userID' => 1,
                'name' => 'Xã Kim Long, Huyện Châu Đức, Bà Rịa - Vũng Tàu, Việt Nam',
            ],

        ]);
    }
}
