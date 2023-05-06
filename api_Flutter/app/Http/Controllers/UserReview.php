<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Carbon\Carbon;


class UserReview extends Controller
{
    public function Post(Request $request)
    {
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
        DB::table('invoices')
            ->where('id', $request->invoiceID)
            ->update([
                'status' => -2,
            ]);
        return response()->json(["success" => "Tạo bài đăng thành công"], 200);
    }
    public function getReviewsForUser($userId)
    {
        $checkReview = DB::table('reviews')
            ->where('userId', $userId)
            ->exists();
        $query = null;
        if ($checkReview) {
            $query = DB::table('reviews')
                ->select("reviews.*")
                ->where('userID', $userId)
                ->orderBy('postedDate', 'desc')
                ->get();
            foreach ($query as $item) {
                $item->imageProduct = DB::table('products')
                    ->where('id', $item->productID)
                    ->select('products.image as imageProduct')
                    ->get()->implode('imageProduct', ', ');

                $item->nameProduct = DB::table('products')
                    ->where('id', $item->productID)
                    ->select('products.name as nameProduct')
                    ->get()->implode('nameProduct', ', ');
            }
        }
        if ($query != null) {
            return json_encode(
                $query,
            );
        } else {
            return response()->json([
                "message" => false
            ], 201);
        }
    }
}
