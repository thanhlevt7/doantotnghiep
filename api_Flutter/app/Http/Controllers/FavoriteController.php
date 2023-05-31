<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;

use Illuminate\Http\Request;

class FavoriteController extends Controller
{
    public function showFavorite($userID)
    {
        $data = DB::table('favorites')
            ->where('userID', $userID)
            ->select('favorites.*')
            ->addSelect(DB::raw('null as products'))
            ->get();

        foreach ($data as $item) {
            $details = DB::table('favorite_details')
                ->join('products', 'favorite_details.productID', '=', 'products.id')
                ->where('favoriteID', $item->id)
                ->select('products.*')
                ->addSelect(DB::raw('null as checkFavorite,null as reviews '))
                ->get();
            foreach ($details as $key) {
                $key->total = DB::table('invoice_details')
                    ->addSelect(DB::raw('SUM(invoice_details.quantity) as total'))
                    ->where('invoice_details.productID', $key->id)
                    ->groupBy('invoice_details.productID')
                    ->get()->implode('total', ', ');
                $key->checkFavorite =  DB::table('favorites')
                    ->join('favorite_details', 'favorites.id', 'favorite_details.favoriteID')
                    ->where('favorites.userID', $userID)
                    ->where('favorite_details.productID', $key->id)->exists();
                $key->reviews = DB::table('reviews')
                    ->join('users', 'reviews.userID', '=', 'users.id')
                    ->where('reviews.productID', $key->id)
                    ->orderBy('reviews.postedDate', 'desc')
                    ->select('reviews.*', 'users.fullName', 'users.avatar')
                    ->get();
                $item->products = $details;
            }
        }

        return response()->json($data);
    }

    public function AddFavoriteTitle(Request $request, $userID)
    {

        DB::table('favorites')->where('userID', $userID)->insert([
            'userID' => $userID,
            'title' => $request->title,
        ]);
        return response()->json([
            'success' => "Thành công",
        ], 200);
    }

    public function DeleteFavorite(Request $request)
    {
        DB::table('favorite_details')->where('favoriteID', $request->id)->delete();
        DB::table('favorites')->where('id', $request->id)->delete();
        $data = DB::table('favorites')->where('id', $request->id)->get();
        return response()->json([
            'success' => "Thành công",
        ], 200);
    }

    public function AddProduct(Request $request)
    {
        DB::table('favorite_details')
            ->insert([
                'favoriteID' => $request->favoriteID,
                'productID' => $request->productID,
            ]);
        return response()->json([
            "success" => "Thành công",
        ], 200);
    }

    public function DeleteProduct(Request $request)
    {
        if (empty($request->favoriteID)) {
            DB::table('favorite_details')
                ->where('productID', $request->productID)
                ->delete();
            return response()->json([
                "success" => "Thành công",
            ], 200);
        } else {
            DB::table('favorite_details')
                ->where('favoriteID', $request->favoriteID)
                ->where('productID', $request->productID)
                ->delete();
            return response()->json([
                "success" => "Thành công",
            ], 200);
        }
    }
}
