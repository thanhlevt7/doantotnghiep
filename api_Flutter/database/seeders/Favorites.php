<?php

namespace Database\Seeders;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Seeder;

class Favorites extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('favorites')->insert([
            [
                'id' => 1,
                'userID' => 1,
                'title' => 'Sưu tầm trái cây ngon',           
                    
            ],
            [
                'id' => 2,
                'title' => 'Sưu tầm nước healthy',           
                'userID' => 1,
             
            ],
        ]);
        DB::table('favorite_details')->insert([
            [
                'id' => 1,
                'favoriteID' => 1,
                'productID' => 2,           
                    
            ],
           
            [
                'id' => 3,
                'favoriteID' => 2,           
                'productID' => 3,
             
            ],
        ]);
    }
}
