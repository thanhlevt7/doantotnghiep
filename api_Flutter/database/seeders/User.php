<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class User extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('users')->insert([
            [
                'id' => 1,
                'username' => 'thanhle',
                'password' => Hash::make('123456'),
                'email' => 'thanhlevt7@gmail.com',
                'fullName' => 'Nguyễn Thành Lễ',
                'phone' => '0348340873',
                'avatar' => 'https://res.cloudinary.com/thanhlevt7/image/upload/v1682571666/image_flutter/nlfptupmdv1bh4xwkptw.jpg',
                'type' => 'admin',
                'status' => 0,
            ],
            [
                'id' => 2,
                'username' => 'thanhbui',
                'password' => Hash::make('123456'),
                'email' => 'thanhbui@gmail.com',
                'fullName' => 'Bùi kim thanh',
                'phone' => '0348340873',
                'avatar' => 'https://res.cloudinary.com/thanhlevt7/image/upload/v1682571666/image_flutter/nlfptupmdv1bh4xwkptw.jpg',
                'type' => 'user',
                'status' => 0,
            ],

        ]);
    }
}
