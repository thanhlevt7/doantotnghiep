<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Invoice;
use App\Models\InvoiceDetails;
use App\Models\User;
use App\Models\Product;

class InvoiceController extends Controller
{
    function buynow(Request $request)
    {
        $countInv =  DB::table('invoices')->count() + 1;
        $randomIDInvoice = 'HD' . Date('Ymd') .  $countInv;
        DB::table('invoices')
            ->insert([
                'id'   =>   $randomIDInvoice,
                'userID' => $request->userID,
                'shippingName' => $request->shippingName,
                'shippingAddress' => $request->shippingAddress,
                'shippingPhone' => $request->shippingPhone,
                'dateCreated' => $request->dateCreated,
                'total' =>    $request->total,
                'isPaid' => 0,
                'status' => 1,
            ]);
        DB::table('invoice_details')
            ->insert([
                'invoiceID' => $randomIDInvoice,
                'productID' => $request->productID,
                'quantity' => $request->quantity,
                'status' => 1
            ]);
        return response()->json([
            "Message" => "Đặt hàng thành công"
        ], 200);
    }
    function payment(Request $request, $invoiceID)
    {
        DB::table('invoices')->where('id', $invoiceID)
            ->update([
                'shippingAddress' => $request->address,
                'total' => $request->total,
                'status' => 1,
            ]);
        $data = DB::table('invoice_details')
            ->where('invoiceID', $invoiceID)->get();
        foreach ($data as $item) {
            $stock = DB::table('products')
                ->where('id', $item->productID)
                ->select('stock')->get();
            DB::table('products')
                ->where('id', $item->productID)
                ->update([
                    'stock' => $stock[0]->stock - $item->quantity
                ]);
        }
        return response()->json([
            "Thanh toán thành công" => true
        ], 200);
    }
    function getInvoiceForUser($userID)
    {
        $checkInvoice = DB::table('invoices')
            ->where('invoices.userID', $userID)
            ->whereIn('status', [-1, -2])
            ->exists();
        $query = null;
        if ($checkInvoice) {
            $query = DB::table('invoices')
                ->join('users', 'invoices.userID', '=', 'users.id')
                ->select('invoices.*')
                ->where('invoices.userID', $userID)
                ->whereIn('invoices.status', [-1, -2])
                ->addSelect(DB::raw("null as products"))->get();

            foreach ($query  as $item) {
                $listProduct = DB::table('invoice_details')
                    ->join('products', 'invoice_details.productID', '=', 'products.id')
                    ->where('invoiceID', $item->id)
                    ->select('products.*', 'invoice_details.quantity')->get();
                $item->products = $listProduct;
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
    function getInvoiceWaitingToAccept($userID)
    {
        $checkInvoice = DB::table('invoices')
            ->where('invoices.userID', $userID)
            ->Where('invoices.status', '=', 1)
            ->exists();

        $query = null;
        if ($checkInvoice) {
            $query = DB::table('invoices')
                ->join('users', 'invoices.userID', '=', 'users.id')
                ->select('invoices.*')
                ->where('invoices.userID', $userID)
                ->Where('invoices.status', '=', 1)
                ->addSelect(DB::raw("null as products"))->get();

            foreach ($query  as $item) {
                $listProduct = DB::table('invoice_details')
                    ->join('products', 'invoice_details.productID', '=', 'products.id')
                    ->where('invoiceID', $item->id)
                    ->select('products.*', 'invoice_details.quantity')->get();
                $item->products = $listProduct;
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

    function getInvoicePickingUpGood($userID)
    {
        $checkInvoice = DB::table('invoices')
            ->where('invoices.userID', $userID)
            ->Where('invoices.status', '=', 2)
            ->exists();

        $query = null;
        if ($checkInvoice) {
            $query = DB::table('invoices')
                ->join('users', 'invoices.userID', '=', 'users.id')
                ->select('invoices.*')
                ->where('invoices.userID', $userID)
                ->Where('invoices.status', '=', 2)
                ->addSelect(DB::raw("null as products"))->get();

            foreach ($query  as $item) {
                $listProduct = DB::table('invoice_details')
                    ->join('products', 'invoice_details.productID', '=', 'products.id')
                    ->where('invoiceID', $item->id)
                    ->select('products.*', 'invoice_details.quantity')->get();
                $item->products = $listProduct;
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

    function notYetRated($userID)
    {
        $checkInvoice = DB::table('invoices')
            ->where('invoices.userID', $userID)
            ->Where('invoices.status', '=', -1)
            ->exists();

        $query = null;
        if ($checkInvoice) {
            $query = DB::table('invoices')
                ->join('users', 'invoices.userID', '=', 'users.id')
                ->select('invoices.*')
                ->where('invoices.userID', $userID)
                ->Where('invoices.status', '=', -1)
                ->addSelect(DB::raw("null as products"))->get();

            foreach ($query  as $item) {
                $listProduct = DB::table('invoice_details')
                    ->join('products', 'invoice_details.productID', '=', 'products.id')
                    ->where('invoiceID', $item->id)
                    ->select('products.*', 'invoice_details.quantity')->get();
                $item->products = $listProduct;
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

    function getInvoiceOnDelivery($userID)
    {
        $checkInvoice = DB::table('invoices')
            ->where('invoices.userID', $userID)
            ->Where('invoices.status', '=', 3)
            ->exists();

        $query = null;
        if ($checkInvoice) {
            $query = DB::table('invoices')
                ->join('users', 'invoices.userID', '=', 'users.id')
                ->select('invoices.*')
                ->where('invoices.userID', $userID)
                ->Where('invoices.status', '=', 3)
                ->addSelect(DB::raw("null as products"))->get();

            foreach ($query  as $item) {
                $listProduct = DB::table('invoice_details')
                    ->join('products', 'invoice_details.productID', '=', 'products.id')
                    ->where('invoiceID', $item->id)
                    ->select('products.*', 'invoice_details.quantity')->get();
                $item->products = $listProduct;
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
    public function OrderDetails($invoiceID)
    {
        $data = DB::table('invoices')
            ->where('invoices.id', $invoiceID)
            ->select('invoices.*')

            ->get();
        $data[0]->products = DB::table('invoice_details')
            ->join('products', 'invoice_details.productID', '=', 'products.id')
            ->where('invoiceID', $data[0]->id)
            ->select('products.*', 'invoice_details.*')->get();
        return response()->json(
            $data[0]
        );
    }
    public function CancelOrder($invoiceID)
    {
        $check = DB::table('invoices')->where('id', $invoiceID)->whereIn('status', [1, 2])->exists();
        if ($check == true) {
            $updateStock = DB::table('invoice_details')->where('invoiceID', $invoiceID)->select('productID', 'quantity')->get();
            foreach ($updateStock as $item) {
                $getPR =  DB::table('products')
                    ->where('id', $item->productID)
                    ->get();
                $stock = $item->quantity + $getPR[0]->stock;
                DB::table('products')
                    ->where('id', $item->productID)
                    ->update([
                        'stock' => $stock
                    ]);
            }
            DB::table('invoices')
                ->where('id', $invoiceID)->update(['status' => 5]);
            return response()->json([
                "message" => "Xóa đơn hàng thành công",
            ], 200);
        } else {
            return response()->json([
                "message" => "Xin lỗi bạn đơn hàng đã chuẩn bị",
            ], 201);
        }
    }

    public function getCancelOrder($userID)
    {
        $checkInvoice = DB::table('invoices')
            ->where('invoices.userID', $userID)
            ->Where('invoices.status', '=', 5)
            ->exists();

        $query = null;
        if ($checkInvoice) {
            $query = DB::table('invoices')
                ->join('users', 'invoices.userID', '=', 'users.id')
                ->select('invoices.*')
                ->where('invoices.userID', $userID)
                ->Where('invoices.status', '=', 5)
                ->addSelect(DB::raw("null as products"))->get();

            foreach ($query  as $item) {
                $listProduct = DB::table('invoice_details')
                    ->join('products', 'invoice_details.productID', '=', 'products.id')
                    ->where('invoiceID', $item->id)
                    ->select('products.*', 'invoice_details.quantity')->get();
                $item->products = $listProduct;
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
    function review($userID)
    {
        $checkInvoice = DB::table('invoices')
            ->where('invoices.userID', $userID)
            ->Where('invoices.status', '=', -1)
            ->exists();
        $query = null;
        if ($checkInvoice) {
            $query = DB::table('invoices')
                ->join('users', 'invoices.userID', '=', 'users.id')
                ->select('invoices.*')
                ->where('invoices.userID', $userID)
                ->Where('invoices.status', '=', -1)
                ->addSelect(DB::raw("null as products"))->get();

            foreach ($query  as $item) {
                $listProduct = DB::table('invoice_details')
                    ->join('products', 'invoice_details.productID', '=', 'products.id')
                    ->where('invoiceID', $item->id)
                    ->select('products.*',  'invoice_details.quantity')->get();
                $item->products = $listProduct;
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
