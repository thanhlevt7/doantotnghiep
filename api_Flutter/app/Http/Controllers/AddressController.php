<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AddressController extends Controller
{
    public function deleteAddress($id)
    {
        $userId = Db::table('addresses')
            ->select('userId')
            ->where('id', $id)
            ->get();
        foreach ($userId as $item) {
            $count = Db::table('addresses')
                ->addSelect(DB::raw('count(addresses.id) as count'))
                ->where('userId', $item->userId)
                ->groupBy('userId')
                ->having('count', '>', '1')
                ->exists();
        }

        if ($count == true) {
            Db::table('addresses')
                ->where('id', $id)
                ->delete();
            return response()->json([
                'success' => 'Xóa thành công',
            ], 200);
        } else {
            return response()->json([
                'success' => 'Xóa thất bại',
            ], 201);
        }
    }
    public function createAddress(Request $request)
    {
        Db::table('addresses')
            ->insert([
                'userID' => $request->userID,
                'name' => $request->name,
            ]);
        return response()->json([
            'success' => 'tạo thành công',
        ]);
    }
}
