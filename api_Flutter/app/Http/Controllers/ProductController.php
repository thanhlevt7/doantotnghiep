<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;

class ProductController extends Controller
{
    public function getAllProduct($userID)
    {

        $data = DB::table('products')
            ->where('status', 1)
            ->select('products.*')
            // ->where('products.stock', '>', 0)
            ->orderBy('products.id', 'asc')
            ->addSelect(DB::raw('null as checkFavorite,null as reviews', 'null as total', 'null as countReviews'))
            ->get();
        foreach ($data as $item) {
            $item->total = DB::table('invoices')
                ->join('invoice_details', 'invoices.id', '=', 'invoice_details.invoiceID')
                ->addSelect(DB::raw('SUM(invoice_details.quantity) as total'))
                ->where('invoice_details.productID', $item->id)
                ->whereIn('invoices.status', [-1, -2])
                ->groupBy('invoice_details.productID')
                ->get()->implode('total', ', ');
            $item->countReviews = DB::table('reviews')
                ->addSelect(DB::raw('Count(reviews.productId) as countReviews'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get()->implode('countReviews', ', ');
            $item->rating = DB::table('reviews')
                ->addSelect(DB::raw('Sum(quantity)/ Count(productId) as rating'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get()->implode('rating', ', ');
            $item->checkFavorite = DB::table('favorites')
                ->join('favorite_details', 'favorites.id', 'favorite_details.favoriteID')
                ->where('favorites.userID', $userID)
                ->where('favorite_details.productID', $item->id)->exists();
            $item->reviews = DB::table('reviews')
                ->join('users', 'reviews.userID', 'users.id')
                ->where('reviews.status', 1)
                ->where('reviews.productID', $item->id)
                ->orderBy('reviews.postedDate', 'desc')
                ->select('reviews.*', 'users.userName', 'users.avatar')
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
            // ->where('products.stock', '>', 0)
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
                    ->whereIn('invoices.status', [-1, -2])
                    ->groupBy('invoice_details.productID')
                    ->get()->implode('total', ', ');
                $item->countReviews = DB::table('reviews')
                    ->addSelect(DB::raw('Count(reviews.productId) as countReviews'))
                    ->where('reviews.productID', $item->id)
                    ->groupBy('reviews.productId')
                    ->get()->implode('countReviews', ', ');
                $item->rating = DB::table('reviews')
                    ->addSelect(DB::raw('Sum(quantity)/ Count(productId) as rating'))
                    ->where('reviews.productID', $item->id)
                    ->groupBy('reviews.productId')
                    ->get()->implode('rating', ', ');
                $item->checkFavorite = DB::table('favorites')
                    ->join('favorite_details', 'favorites.id', 'favorite_details.favoriteID')
                    ->where('favorites.userID', $userID)
                    ->where('favorite_details.productID', $item->id)->exists();
                $item->reviews = DB::table('reviews')
                    ->join('users', 'reviews.userID', 'users.id')
                    ->where('reviews.status', 1)
                    ->where('reviews.productID', $item->id)
                    ->orderBy('reviews.postedDate', 'desc')
                    ->select('reviews.*', 'users.userName', 'users.avatar')
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
        $products = DB::table('products')->where('type', 'Trái cây')
            ->select('products.*')->addSelect(DB::raw('null as checkFavorite'))->get();
        foreach ($products as $item) {
            $item->total = DB::table('invoices')
                ->join('invoice_details', 'invoices.id', '=', 'invoice_details.invoiceID')
                ->addSelect(DB::raw('SUM(invoice_details.quantity) as total'))
                ->where('invoice_details.productID', $item->id)
                ->whereIn('invoices.status', [-1, -2])
                ->groupBy('invoice_details.productID')
                ->get()->implode('total', ', ');
            $item->countReviews = DB::table('reviews')
                ->addSelect(DB::raw('Count(reviews.productId) as countReviews'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get()->implode('countReviews', ', ');
            $item->rating = DB::table('reviews')
                ->addSelect(DB::raw('Sum(quantity)/ Count(productId) as rating'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get()->implode('rating', ', ');
            $item->checkFavorite = DB::table('favorites')
                ->join('favorite_details', 'favorites.id', 'favorite_details.favoriteID')
                ->where('favorites.userID', $userID)
                ->where('favorite_details.productID', $item->id)->exists();
            $item->reviews = DB::table('reviews')
                ->join('users', 'reviews.userID', 'users.id')
                ->where('reviews.status', 1)
                ->where('reviews.productID', $item->id)
                ->orderBy('reviews.postedDate', 'desc')
                ->select('reviews.*', 'users.userName', 'users.avatar')
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
        $products = DB::table('products')->where('type', 'Thịt')
            ->select('products.*')->addSelect(DB::raw('null as checkFavorite'))->get();
        foreach ($products as $item) {
            $item->total = DB::table('invoices')
                ->join('invoice_details', 'invoices.id', '=', 'invoice_details.invoiceID')
                ->addSelect(DB::raw('SUM(invoice_details.quantity) as total'))
                ->where('invoice_details.productID', $item->id)
                ->whereIn('invoices.status', [-1, -2])
                ->groupBy('invoice_details.productID')
                ->get()->implode('total', ', ');
            $item->countReviews = DB::table('reviews')
                ->addSelect(DB::raw('Count(reviews.productId) as countReviews'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get()->implode('countReviews', ', ');
            $item->rating = DB::table('reviews')
                ->addSelect(DB::raw('Sum(quantity)/ Count(productId) as rating'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get()->implode('rating', ', ');
            $item->checkFavorite = DB::table('favorites')
                ->join('favorite_details', 'favorites.id', 'favorite_details.favoriteID')
                ->where('favorites.userID', $userID)
                ->where('favorite_details.productID', $item->id)->exists();
            $item->reviews = DB::table('reviews')
                ->join('users', 'reviews.userID', 'users.id')
                ->where('reviews.status', 1)
                ->where('reviews.productID', $item->id)
                ->orderBy('reviews.postedDate', 'desc')
                ->select('reviews.*', 'users.userName', 'users.avatar')
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
        $products = DB::table('products')->where('type', 'Thức uống')
            ->select('products.*')->addSelect(DB::raw('null as checkFavorite'))->get();
        foreach ($products as $item) {
            $item->total = DB::table('invoices')
                ->join('invoice_details', 'invoices.id', '=', 'invoice_details.invoiceID')
                ->addSelect(DB::raw('SUM(invoice_details.quantity) as total'))
                ->where('invoice_details.productID', $item->id)
                ->whereIn('invoices.status', [-1, -2])
                ->groupBy('invoice_details.productID')
                ->get()->implode('total', ', ');
            $item->countReviews = DB::table('reviews')
                ->addSelect(DB::raw('Count(reviews.productId) as countReviews'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get()->implode('countReviews', ', ');
            $item->rating = DB::table('reviews')
                ->addSelect(DB::raw('Sum(quantity)/ Count(productId) as rating'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get()->implode('rating', ', ');
            $item->checkFavorite = DB::table('favorites')
                ->join('favorite_details', 'favorites.id', 'favorite_details.favoriteID')
                ->where('favorites.userID', $userID)
                ->where('favorite_details.productID', $item->id)->exists();
            $item->reviews = DB::table('reviews')
                ->join('users', 'reviews.userID', 'users.id')
                ->where('reviews.status', 1)
                ->where('reviews.productID', $item->id)
                ->orderBy('reviews.postedDate', 'desc')
                ->select('reviews.*', 'users.userName', 'users.avatar')
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
        $products = DB::table('products')->where('type', 'Rau củ')
            ->select('products.*')->addSelect(DB::raw('null as checkFavorite'))->get();
        foreach ($products as $item) {
            $item->total = DB::table('invoices')
                ->join('invoice_details', 'invoices.id', '=', 'invoice_details.invoiceID')
                ->addSelect(DB::raw('SUM(invoice_details.quantity) as total'))
                ->where('invoice_details.productID', $item->id)
                ->whereIn('invoices.status', [-1, -2])
                ->groupBy('invoice_details.productID')
                ->get()->implode('total', ', ');
            $item->countReviews = DB::table('reviews')
                ->addSelect(DB::raw('Count(reviews.productId) as countReviews'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get()->implode('countReviews', ', ');
            $item->rating = DB::table('reviews')
                ->addSelect(DB::raw('Sum(quantity)/ Count(productId) as rating'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get()->implode('rating', ', ');
            $item->checkFavorite = DB::table('favorites')
                ->join('favorite_details', 'favorites.id', 'favorite_details.favoriteID')
                ->where('favorites.userID', $userID)
                ->where('favorite_details.productID', $item->id)->exists();
            $item->reviews = DB::table('reviews')
                ->join('users', 'reviews.userID', 'users.id')
                ->where('reviews.status', 1)
                ->where('reviews.productID', $item->id)
                ->orderBy('reviews.postedDate', 'desc')
                ->select('reviews.*', 'users.userName', 'users.avatar')
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
            ->whereIn('invoices.status', [-1, -2])
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
                    ->whereIn('invoices.status', [-1, -2])
                    ->groupBy('invoice_details.productID')
                    ->get()->implode('total', ', ');
                $key->countReviews = DB::table('reviews')
                    ->addSelect(DB::raw('Count(reviews.productId) as countReviews'))
                    ->where('reviews.productID', $key->id)
                    ->groupBy('reviews.productId')
                    ->get()->implode('countReviews', ', ');
                $key->rating = DB::table('reviews')
                    ->addSelect(DB::raw('Sum(quantity)/ Count(productId) as rating'))
                    ->where('reviews.productID', $key->id)
                    ->groupBy('reviews.productId')
                    ->get()->implode('rating', ', ');
                $key->checkFavorite = DB::table('favorites')
                    ->join('favorite_details', 'favorites.id', 'favorite_details.favoriteID')
                    ->where('favorite_details.productID', $key->id)->exists();
                $key->reviews = DB::table('reviews')
                    ->join('users', 'reviews.userID', '=', 'users.id')
                    ->where('reviews.productID', $key->id)
                    ->orderBy('reviews.postedDate', 'desc')
                    ->select('reviews.*', 'users.userName', 'users.avatar')
                    ->get();
            }
        }
        return json_encode(
            $array
        );
    }
    public function Filter($userID, Request $request)
    {

        if ($request->type != null) {
            if ($request->maxPrice != null && $request->minPrice != null) {
                $data = DB::table('products')
                    ->where('name', 'LIKE', '%' . $request->keyword . '%')
                    ->where('type', $request->type)
                    ->whereBetween('price', [$request->minPrice, $request->maxPrice])
                    ->select('products.*')
                    ->get();
            } else if ($request->minPrice != null) {
                $data = DB::table('products')
                    ->where('name', 'LIKE', '%' . $request->keyword . '%')
                    ->where('type', $request->type)
                    ->where('price', '>=', $request->minPrice)
                    ->select('products.*')
                    ->get();
            } else if ($request->maxPrice != null) {
                $data = DB::table('products')
                    ->where('name', 'LIKE', '%' . $request->keyword . '%')
                    ->where('type', $request->type)
                    ->where('price', '<=', $request->maxPrice)
                    ->select('products.*')
                    ->get();
            } else {
                $data = DB::table('products')
                    ->where('name', 'LIKE', '%' . $request->keyword . '%')
                    ->where('type', $request->type)
                    ->select('products.*')
                    ->get();
            }
        } else {
            if (!empty($request->maxPrice)  && !empty($request->minPrice)) {
                $data = DB::table('products')
                    ->where('name', 'LIKE', '%' . $request->keyword . '%')
                    ->whereBetween('price', [$request->minPrice, $request->maxPrice])
                    ->select('products.*')
                    ->get();
            } else if (!empty($request->minPrice)) {
                $data = DB::table('products')
                    ->where('name', 'LIKE', '%' . $request->keyword . '%')
                    ->where('price', '>=', $request->minPrice)
                    ->select('products.*')
                    ->get();
            } else if (!empty($request->maxPrice)) {
                $data = DB::table('products')
                    ->where('name', 'LIKE', '%' . $request->keyword . '%')
                    ->where('price', '<=', $request->maxPrice)
                    ->select('products.*')
                    ->get();
            } else {
                $data = DB::table('products')
                    ->select('products.*')
                    ->where('name', 'LIKE', '%' . $request->keyword . '%')
                    ->orderBy("products.price")
                    ->get();
            }
        }

        foreach ($data as $item) {
            $item->total = DB::table('invoices')
                ->join('invoice_details', 'invoices.id', '=', 'invoice_details.invoiceID')
                ->addSelect(DB::raw('SUM(invoice_details.quantity) as total'))
                ->where('invoice_details.productID', $item->id)
                ->whereIn('invoices.status', [-1, -2])
                ->groupBy('invoice_details.productID')
                ->get()->implode('total', ', ');
            $item->countReviews = DB::table('reviews')
                ->addSelect(DB::raw('Count(reviews.productId) as countReviews'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get()->implode('countReviews', ', ');
            $item->rating = DB::table('reviews')
                ->addSelect(DB::raw('Sum(quantity)/ Count(productId) as rating'))
                ->where('reviews.productID', $item->id)
                ->groupBy('reviews.productId')
                ->get()->implode('rating', ', ');
            $item->checkFavorite = DB::table('favorites')
                ->join('favorite_details', 'favorites.id', 'favorite_details.favoriteID')
                ->where('favorites.userID', $userID)
                ->where('favorite_details.productID', $item->id)->exists();
            $item->reviews = DB::table('reviews')
                ->join('users', 'reviews.userID', '=', 'users.id')
                ->where('reviews.status', 1)
                ->where('reviews.productID', $item->id)
                ->orderBy('reviews.postedDate', 'desc')
                ->select('reviews.*', 'users.userName', 'users.avatar')
                ->get();
        }
        return json_encode(
            $data,
        );
    }
}
