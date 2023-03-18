<?php

namespace App\Http\Controllers;

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
        $isCheckEmail = DB::table('users')->where('email', $request->email)->exists();
        if ($isCheckEmail) {
            return response()->json([
                "message" => "Email đã tồn tại",
            ], 201);
        }
        DB::table('users')->insert([
            'username' => $request->username,
            'fullName' => $request->fullname,
            'email' => $request->email,
            'avatar' => "a.png",
            'phone' => $request->phone,
            'password' => Hash::make($request->password),
            'type' => 'user',
            'status' => 0,
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
