<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use Illuminate\Http\Request;use Illuminate\Support\Facades\DB;

class ProductController extends Controller
{
    public function getAllProduct($userID)
    {
        $data = DB::table('products')
            ->where('status', 1)
            ->select('products.*')
            ->where('products.stock', '>', 0)
            ->orderBy('products.id', 'asc')
            ->addSelect(DB::raw('null as checkFavorite,null as reviews', 'null as total', 'null as countReviews'))
            ->get();
        foreach ($data as $item) {
            $item->total = DB::table('invoices')
                ->join('invoice_details', 'invoices.id', '=', 'invoice_details.invoiceID')
                ->addSelect(DB::raw('SUM(invoice_details.quantity) as total'))
                ->where('invoice_details.productID', $item->id)
                ->where('invoices.status', -1)
                ->groupBy('invoice_details.productID')
                ->get();
            $item->countReviews = DB::table('reviews')
                ->addSelect(DB::raw('Count(reviews.productId) as countReviews'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get();
            $item->rating = DB::table('reviews')
                ->addSelect(DB::raw('Sum(quantity)/ Count(productId) as rating'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get();
            $item->checkFavorite = DB::table('favorites')
                ->join('favorite_details', 'favorites.id', 'favorite_details.favoriteID')
                ->where('favorites.userID', $userID)
                ->where('favorite_details.productID', $item->id)->exists();
            $item->reviews = DB::table('reviews')
                ->join('users', 'reviews.userID', 'users.id')
                ->where('reviews.status', 1)
                ->where('reviews.productID', $item->id)
                ->orderBy('reviews.postedDate', 'desc')
                ->select('reviews.*', 'users.fullName', 'users.avatar')
                ->get();
        }
        return json_encode(
            $data,
        );
    }

    public function newProduct($userID)
    {
        $getAll = DB::table('products')
            ->where('status', 1)
            ->select('products.*')
            ->where('products.stock', '>', 0)
            ->get();
        $data = null;
        foreach ($getAll as $item) {
            $data = DB::table('products')
                ->select('*')
                ->where('createDate', '>', Carbon::now('Asia/Ho_Chi_Minh')->subDays(3))
                ->orderBy('createDate', 'desc')
                ->get();
            foreach ($data as $item) {
                $item->total = DB::table('invoices')
                    ->join('invoice_details', 'invoices.id', '=', 'invoice_details.invoiceID')
                    ->addSelect(DB::raw('SUM(invoice_details.quantity) as total'))
                    ->where('invoice_details.productID', $item->id)
                    ->where('invoices.status', -1)
                    ->groupBy('invoice_details.productID')
                    ->get();
                $item->countReviews = DB::table('reviews')
                    ->addSelect(DB::raw('Count(reviews.productId) as countReviews'))
                    ->where('reviews.productID', $item->id)
                    ->groupBy('reviews.productId')
                    ->get();
                $item->rating = DB::table('reviews')
                    ->addSelect(DB::raw('Sum(quantity)/ Count(productId) as rating'))
                    ->where('reviews.productID', $item->id)
                    ->groupBy('reviews.productId')
                    ->get();
                $item->checkFavorite = DB::table('favorites')
                    ->join('favorite_details', 'favorites.id', 'favorite_details.favoriteID')
                    ->where('favorites.userID', $userID)
                    ->where('favorite_details.productID', $item->id)->exists();
                $item->reviews = DB::table('reviews')
                    ->join('users', 'reviews.userID', 'users.id')
                    ->where('reviews.status', 1)
                    ->where('reviews.productID', $item->id)
                    ->orderBy('reviews.postedDate', 'desc')
                    ->select('reviews.*', 'users.fullName', 'users.avatar')
                    ->get();
            }
        }
        if ($data != null) {
            return json_encode(
                $data
            );
        }
    }

    public function Fruit($userID)
    {
        $products = DB::table('products')->where('type', 'Tr??i c??y')
            ->select('products.*')->addSelect(DB::raw('null as checkFavorite'))->get();
        foreach ($products as $item) {
            $item->total = DB::table('invoices')
                ->join('invoice_details', 'invoices.id', '=', 'invoice_details.invoiceID')
                ->addSelect(DB::raw('SUM(invoice_details.quantity) as total'))
                ->where('invoice_details.productID', $item->id)
                ->where('invoices.status', -1)
                ->groupBy('invoice_details.productID')
                ->get();
            $item->countReviews = DB::table('reviews')
                ->addSelect(DB::raw('Count(reviews.productId) as countReviews'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get();
            $item->rating = DB::table('reviews')
                ->addSelect(DB::raw('Sum(quantity)/ Count(productId) as rating'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get();
            $item->checkFavorite = DB::table('favorites')
                ->join('favorite_details', 'favorites.id', 'favorite_details.favoriteID')
                ->where('favorites.userID', $userID)
                ->where('favorite_details.productID', $item->id)->exists();
            $item->reviews = DB::table('reviews')
                ->join('users', 'reviews.userID', '=', 'users.id')
                ->where('reviews.productID', $item->id)
                ->orderBy('reviews.postedDate', 'desc')
                ->select('reviews.*', 'users.fullName', 'users.avatar')
                ->get();

        }
        if ($products != null) {
            return json_encode(
                $products,
            );
        }
    }

    public function Meat($userID)
    {
        $products = DB::table('products')->where('type', 'Th???t')
            ->select('products.*')->addSelect(DB::raw('null as checkFavorite'))->get();
        foreach ($products as $item) {
            $item->total = DB::table('invoices')
                ->join('invoice_details', 'invoices.id', '=', 'invoice_details.invoiceID')
                ->addSelect(DB::raw('SUM(invoice_details.quantity) as total'))
                ->where('invoice_details.productID', $item->id)
                ->where('invoices.status', -1)
                ->groupBy('invoice_details.productID')
                ->get();
            $item->countReviews = DB::table('reviews')
                ->addSelect(DB::raw('Count(reviews.productId) as countReviews'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get();
            $item->rating = DB::table('reviews')
                ->addSelect(DB::raw('Sum(quantity)/ Count(productId) as rating'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get();
            $item->checkFavorite = DB::table('favorites')
                ->join('favorite_details', 'favorites.id', 'favorite_details.favoriteID')
                ->where('favorites.userID', $userID)
                ->where('favorite_details.productID', $item->id)->exists();
            $item->reviews = DB::table('reviews')
                ->join('users', 'reviews.userID', '=', 'users.id')
                ->where('reviews.productID', $item->id)
                ->orderBy('reviews.postedDate', 'desc')
                ->select('reviews.*', 'users.fullName', 'users.avatar')
                ->get();

        }
        if ($products != null) {
            return json_encode(
                $products,
            );
        }
    }

    public function Drink($userID)
    {
        $products = DB::table('products')->where('type', 'Th???c u???ng')
            ->select('products.*')->addSelect(DB::raw('null as checkFavorite'))->get();
        foreach ($products as $item) {
            $item->total = DB::table('invoices')
                ->join('invoice_details', 'invoices.id', '=', 'invoice_details.invoiceID')
                ->addSelect(DB::raw('SUM(invoice_details.quantity) as total'))
                ->where('invoice_details.productID', $item->id)
                ->where('invoices.status', -1)
                ->groupBy('invoice_details.productID')
                ->get();
            $item->countReviews = DB::table('reviews')
                ->addSelect(DB::raw('Count(reviews.productId) as countReviews'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get();
            $item->rating = DB::table('reviews')
                ->addSelect(DB::raw('Sum(quantity)/ Count(productId) as rating'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get();
            $item->checkFavorite = DB::table('favorites')
                ->join('favorite_details', 'favorites.id', 'favorite_details.favoriteID')
                ->where('favorites.userID', $userID)
                ->where('favorite_details.productID', $item->id)->exists();
            $item->reviews = DB::table('reviews')
                ->join('users', 'reviews.userID', '=', 'users.id')
                ->where('reviews.productID', $item->id)
                ->orderBy('reviews.postedDate', 'desc')
                ->select('reviews.*', 'users.fullName', 'users.avatar')
                ->get();

        }
        if ($products != null) {
            return json_encode(
                $products,
            );
        }
    }

    public function Vegetable($userID)
    {
        $products = DB::table('products')->where('type', 'Rau c???')
            ->select('products.*')->addSelect(DB::raw('null as checkFavorite'))->get();
        foreach ($products as $item) {
            $item->total = DB::table('invoices')
                ->join('invoice_details', 'invoices.id', '=', 'invoice_details.invoiceID')
                ->addSelect(DB::raw('SUM(invoice_details.quantity) as total'))
                ->where('invoice_details.productID', $item->id)
                ->where('invoices.status', -1)
                ->groupBy('invoice_details.productID')
                ->get();
            $item->countReviews = DB::table('reviews')
                ->addSelect(DB::raw('Count(reviews.productId) as countReviews'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get();
            $item->rating = DB::table('reviews')
                ->addSelect(DB::raw('Sum(quantity)/ Count(productId) as rating'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get();
            $item->checkFavorite = DB::table('favorites')
                ->join('favorite_details', 'favorites.id', 'favorite_details.favoriteID')
                ->where('favorites.userID', $userID)
                ->where('favorite_details.productID', $item->id)->exists();
            $item->reviews = DB::table('reviews')
                ->join('users', 'reviews.userID', '=', 'users.id')
                ->where('reviews.productID', $item->id)
                ->orderBy('reviews.postedDate', 'desc')
                ->select('reviews.*', 'users.fullName', 'users.avatar')
                ->get();

        }
        if ($products != null) {
            return json_encode(
                $products,
            );
        }
    }
    public function getProductBestSeller()
    {
        $data = DB::table('invoices')
            ->join('invoice_details', 'invoices.id', '=', 'invoice_details.invoiceID')
            ->join('products', 'invoice_details.productID', '=', 'products.id')
            ->groupBy('invoice_details.productID')
            ->where('invoices.status', -1)
            ->select('invoice_details.productID')
            ->addSelect(DB::raw('SUM(invoice_details.quantity) as total'))
            ->orderBy('total', 'desc')
            ->take(3)
            ->get();
        $array = array();
        foreach ($data as $item) {
            $item->products = DB::table('products')->where('id', $item->productID)
                ->select('products.*')

                ->get();
            foreach ($item->products as $key) {
                $array[] = $key;
                $key->total = DB::table('invoices')
                    ->join('invoice_details', 'invoices.id', '=', 'invoice_details.invoiceID')
                    ->addSelect(DB::raw('SUM(invoice_details.quantity) as total'))
                    ->where('invoice_details.productID', $key->id)
                    ->where('invoices.status', -1)
                    ->groupBy('invoice_details.productID')
                    ->get();
                $key->countReviews = DB::table('reviews')
                    ->addSelect(DB::raw('Count(reviews.productId) as countReviews'))
                    ->where('reviews.productID', $key->id)
                    ->groupBy('reviews.productId')
                    ->get();
                $key->rating = DB::table('reviews')
                    ->addSelect(DB::raw('Sum(quantity)/ Count(productId) as rating'))
                    ->where('reviews.productID', $key->id)
                    ->groupBy('reviews.productId')
                    ->get();
                $key->checkFavorite = DB::table('favorites')
                    ->join('favorite_details', 'favorites.id', 'favorite_details.favoriteID')
                    ->where('favorite_details.productID', $key->id)->exists();
                $key->reviews = DB::table('reviews')
                    ->join('users', 'reviews.userID', '=', 'users.id')
                    ->where('reviews.productID', $key->id)
                    ->orderBy('reviews.postedDate', 'desc')
                    ->select('reviews.*', 'users.fullName', 'users.avatar')
                    ->get();
            }
        }
        return json_encode(
            $array
        );
    }

    public function Search(Request $request, $userID)
    {

        $data = DB::table('products')
            ->where('name', 'LIKE', '%' . $request->keyword . '%')
            ->select('products.*')
            ->addSelect(DB::raw('null as checkFavorite,null as reviews'))
            ->get();
        foreach ($data as $item) {
            $item->total = DB::table('invoices')
                ->join('invoice_details', 'invoices.id', '=', 'invoice_details.invoiceID')
                ->addSelect(DB::raw('SUM(invoice_details.quantity) as total'))
                ->where('invoice_details.productID', $item->id)
                ->where('invoices.status', -1)
                ->groupBy('invoice_details.productID')
                ->get();
            $item->countReviews = DB::table('reviews')
                ->addSelect(DB::raw('Count(reviews.productId) as countReviews'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get();
            $item->rating = DB::table('reviews')
                ->addSelect(DB::raw('Sum(quantity)/ Count(productId) as rating'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get();
            $item->checkFavorite = DB::table('favorites')
                ->join('favorite_details', 'favorites.id', 'favorite_details.favoriteID')
                ->where('favorites.userID', $userID)
                ->where('favorite_details.productID', $item->id)->exists();
            $item->reviews = DB::table('reviews')
                ->join('users', 'reviews.userID', '=', 'users.id')
                ->where('reviews.status', 1)
                ->where('reviews.productID', $item->id)
                ->orderBy('reviews.postedDate', 'desc')
                ->select('reviews.*', 'users.fullName', 'users.avatar')
                ->get();

        }
        return response()->json($data);
    }

}
