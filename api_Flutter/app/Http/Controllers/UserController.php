<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class UserController extends Controller
{
    public function loadUser($id)
    {
        $getUser = DB::table('users')
            ->where('id', $id)
            ->select('users.*')
            ->addSelect(DB::raw('null as address'))
            ->get();
        $getUser[0]->address = DB::table('addresses')
            ->where('userID', $id)
            ->select('id', 'name')
            ->get();
        return response()->json($getUser[0]);
    }

    public function register(Request $request)
    {
        $randomCode = Str::random(6);
        $isCheckEmail = DB::table('users')->where('email', $request->email)->exists();
        if ($isCheckEmail) {
            return response()->json([
                "message" => "Email đã tồn tại",
            ], 201);
        }
        $ID = DB::table('users')->insertGetId([
            'username' => $request->username,
            'fullName' => $request->fullname,
            'email' => $request->email,
            'avatar' => "a.png",
            'phone' => $request->phone,
            'password' => Hash::make($request->password),
            'type' => 'user',
            'status' => 0,
        ]);
        DB::table('vouchers')
            ->insert([
                'code' => $randomCode,
                'name' => "Test",
                'userID' => $ID,
                'sale' => "10000",
                'startDate' =>  Carbon::now('Asia/Ho_Chi_Minh')->format('Y/m/d'),
                'endDate' => Carbon::now('Asia/Ho_Chi_Minh')->addDays(3)->format('Y/m/d'),
                'limit' => 1,
                'status' => 1,
            ]);
        DB::table('notifications')
            ->insert([
                'title' => "Giảm giá",
                'userID' => $ID,
                'content' => "Nhanh tay mua ngay, nhập ngay mã voucher :{$randomCode}",
                'image' => "https://img-cache.coccoc.com/image2?i=4&l=54/854640637",
                'startDate' =>  Carbon::now('Asia/Ho_Chi_Minh')->format('Y/m/d'),
                'endDate' =>  Carbon::now('Asia/Ho_Chi_Minh')->addDays(3)->format('Y/m/d'),
            ]);
        return json_encode([
            "message" => "Thành công",
        ]);
    }
    public function editUser(Request $request, $id)
    {
        $users = DB::table('users')->where('id', $id)->get();
        if ($users != null) {
            DB::table('users')
                ->where('id', $id)
                ->update([
                    'username' => $request->username,
                    'fullName' => $request->fullName,
                    'phone' => $request->phone,
                ]);
            return json_encode(["message" => "Thành công"]);
        } else {
            return json_encode([
                "message" => "Lỗi",
                "data" => "Sửa không thành công",
            ]);
        }
    }

    public function editImage(Request $request, $id)
    {
        $users = DB::table('users')->where('id', $id)->get();
        if ($users != null) {
            DB::table('users')
                ->where('id', $id)
                ->update([
                    'avatar' => $request->image,
                ]);
            return json_encode(["message" => "Thành công"]);
        } else {
            return json_encode([
                "message" => "Lỗi",
                "data" => "Sửa không thành công",
            ]);
        }
    }

    public function login(Request $request)
    {

        if (Auth::guard('user')->attempt([
            'email' => $request->email,
            'password' => $request->password,
        ], $request->get('remember'))) {
            $token = Str::random(length: 40);
            DB::table('users')
                ->where('email', $request->email)
                ->update([
                    // 'remember_token' =>  $token,
                    'status' => 1,
                ]);
            $users = DB::table('users')
                ->where('email', $request->email)
                ->select('users.*')
                ->addSelect(DB::raw('null as address'))
                ->get();
            foreach ($users as $user) {
                $addresses = DB::table('addresses')
                    ->where('userID', $user->id)
                    ->select('id', 'name')
                    ->get();
                $user->address = $addresses;
            }
            return json_encode(
                $users[0]
            );
        }
        return response()->json([
            "message" => false,
        ], 201);
    }

    public function logout(Request $request)
    {
        DB::table('users')
            ->where('email', $request->email)
            ->update([
                'status' => 0,
            ]);
        Auth::guard('user')->logout();
        return response()->json([
            "message" => true,
        ], 200);
    }

    public function check($id)
    {

        $check = DB::table('users')
            ->where('email', $id)
            ->exists();

        if (!$check) {
            return response()->json(['success' => 'Email không tồn tại'], 201);
        } else {

            return response()->json(['success' => 'Email tồn tại'], 200);
        }
    }
    public function changePassword(Request $request, $id)
    {
        $check = DB::table('users')
            ->where('email', $id)
            ->exists();

        if (!$check) {
            return response()->json(['success' => 'Email không tồn tại'], 201);
        } else {
            $user = DB::table('users')
                ->where('email', $id)
                ->select('username')->get();
            DB::table('users')
                ->where('email', $id)
                ->update([
                    'password' => Hash::make($request->password),
                ]);
            return response()->json(['success' => $request->password], 200);
        }
    }
}
