<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Carbon\Carbon;


class UserReview extends Controller
{
    public function Post(Request $request)
    {

        $data = DB::table('invoice_details')
            ->where('invoiceID', $request->invoiceID)
            ->where('productID', $request->productID)
            ->where('status', 1)
            ->select('invoice_details.status')
            ->exists();
        if ($data) {
            DB::table('reviews')
                ->insert([
                    'userID' => $request->userID,
                    'productID' => $request->productID,
                    'content' => $request->content,
                    'quantity' => $request->quantity,
                    'image' => $request->image,
                    'postedDate' => Carbon::now('Asia/Ho_Chi_Minh'),
                    'status' => 1,
                ]);
            DB::table('invoice_details')
                ->where('invoiceID', $request->invoiceID)
                ->where('productID', $request->productID)
                ->update([
                    'status' => 0,
                ]);
            return response()->json(["success" => "Tạo bài đăng thành công"], 200);
        } else {
            return response()->json([
                "message" => $data
            ], 201);
        }
    }
}
