<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class EmployeeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('employees')->insert([

            [
                'id'=> 1,
                'username'=> 'thanhle',
                'password' => Hash::make('123456'),
                'email' => 'thanhlevt7@gmail.com',
                'fullName' => 'Nguyễn Thành Lễ',
                'address' => 'Tân Bình',
                'type' => 'admin',
                'phone' => '0348340873',
                'salary' =>10000000,
                'avatar' => 'avatar1.png',
                'status' => 1,
            ],
            [
                'id'=> 2,
                'username'=> 'thanhbui',
                'password' => Hash::make('123456'),
                'email' => 'thanhbui@gmail.com',
                'fullName' => 'Bùi Kim Thanh',
                'address' => 'Tân Bình',
                'type' => 'admin',
                'phone' => '0348340873',
                'salary' =>10000000,
                'avatar' => 'avatar1.png',
                'status' => 1,
            ],

            
           
        ]);
    }
}