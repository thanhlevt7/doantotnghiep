<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
class Review extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('reviews')->insert([
            [             
                'userID' => 1,               
                'productID' => 3,
                'content' => 'Giao hàng rất nhanh, Hàng rất tốt. Shop xứng đáng 10đ',           
                'quantity' => 4,     
                'image' => 'https://o.remove.bg/downloads/660ff7cf-71e5-40a1-b78a-71da6707f263/image-removebg-preview.png',      
                'postedDate' => Date('Y-m-d H:i:s'),           
                'status' => 1,           
            ],
            [             
                'userID' => 1,               
                'productID' => 4,
                'content' => 'Chúc shop năm mới vui vẻ nhé.',           
                'quantity' => 4,      'image' => 'https://o.remove.bg/downloads/660ff7cf-71e5-40a1-b78a-71da6707f263/image-removebg-preview.png',     
                'postedDate' => Date('Y-m-d H:i:s'),           
                'status' => 1,           
            ],
            [             
                'userID' => 1,               
                'productID' => 5,
                'content' => 'Sản phẩm tốt quá. Mình rất thích chất lượng như thế này.',           
                'quantity' => 5,    'image' => 'https://o.remove.bg/downloads/660ff7cf-71e5-40a1-b78a-71da6707f263/image-removebg-preview.png',       
                'postedDate' => Date('Y-m-d H:i:s'),           
                'status' => 1,           
            ],
            [             
                'userID' => 1,               
                'productID' => 6,
                'content' => 'Thịt cũng rất tươi và chất lượng. Nhưng khâu giao hàng tệ quá.',           'image' => 'https://o.remove.bg/downloads/660ff7cf-71e5-40a1-b78a-71da6707f263/image-removebg-preview.png',
                'quantity' => 3,           
                'postedDate' => '2022-01-04 11:01:30',           
                'status' => 1,           
            ],
           
        ]);
    }
}
