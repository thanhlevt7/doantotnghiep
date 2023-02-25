<?php

namespace Database\Seeders;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Database\Seeder;

class Invoice extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $data = Date('Y-m-d h:i:s');
        DB::table('invoices')->insert([
            [  
                'id'=>  "HD202203161",             
                'userID' => 1,
                'employeeID' => 1,
                'shippingName' =>  'Nguyễn Thành Lễ',
                'shippingPhone' => '0348340873',
                'shippingAddress' => 'Quận Tân Bình',
                'dateCreated' =>  '2022-03-06 12:45:30',
                 'isPaid' => 1,
                 'total' => 210000,
                'status' => -1,
            ],
            [  
                'id'=>  'HD202203162',             
                'userID' => 2,
                'employeeID' => 1,
                'shippingName' =>  'Nguyễn Thành Lễ',
                'shippingPhone' => '0348340873',
                'shippingAddress' => 'Quận Tân Bình',
                'dateCreated' =>  '2022-03-04 11:10:30',
                 'isPaid' => 1,
                 'total' => 120000,
                'status' => -1,
            ], 
            ]);
    }
}
