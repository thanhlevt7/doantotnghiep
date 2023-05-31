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
                ->orderBy('dateCreated', 'desc')
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







    public function paymentMomo()
    {
        $endpoint = "https://test-payment.momo.vn/v2/gateway/api/create";
        $orderId = time() . "";
        $redirectUrl = "https://webhook.site/b3088a6a-2d17-4f8d-a383-71389a6c600b";
        $ipnUrl = "https://webhook.site/b3088a6a-2d17-4f8d-a383-71389a6c600b";
        $extraData = "";
        $partnerCode = 'MOMOBKUN20180529';
        $accessKey = 'klm05TvNBzhg7h7j';
        $serectkey = 'at67qH6mk8w5Y1nAyMoYKMWACiEi2bsa';
        $orderInfo = "HD456";
        $amount = "10000";
        $requestId = time() . "";
        $requestType = "captureWallet";
        //before sign HMAC SHA256 signature
        $rawHash = "accessKey=" . $accessKey . "&amount=" . $amount . "&extraData=" . $extraData . "&ipnUrl=" . $ipnUrl . "&orderId=" . $orderId . "&orderInfo=" . $orderInfo . "&partnerCode=" . $partnerCode . "&redirectUrl=" . $redirectUrl . "&requestId=" . $requestId . "&requestType=" . $requestType;
        $signature = hash_hmac("sha256", $rawHash, $serectkey);
        $data = array(
            'partnerCode' => $partnerCode,
            'partnerName' => "Test",
            "storeId" => "MomoTestStore",
            'requestId' => $requestId,
            'amount' => $amount,
            'orderId' => $orderId,
            'orderInfo' => $orderInfo,
            'redirectUrl' => $redirectUrl,
            'ipnUrl' => $ipnUrl,
            'lang' => 'vi',
            'extraData' => $extraData,
            'requestType' => $requestType,
            'signature' => $signature
        );

        //endddddddddd
        $ch = curl_init($endpoint);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt(
            $ch,
            CURLOPT_HTTPHEADER,
            array(
                'Content-Type: application/json',
                'Content-Length: ' . strlen(json_encode($data))
            )
        );
        curl_setopt($ch, CURLOPT_TIMEOUT, 5);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
        //execute post
        $result1 = curl_exec($ch);
        //close connection
        curl_close($ch);
        $result = $result1;
        $jsonResult = json_decode($result, true);  // decode json
        return $jsonResult;
        //Just a example, please check more in there


    }

    public function paymentAtm()
    {
        function execPostRequest($url, $data)
        {
            $ch = curl_init($url);
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
            curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt(
                $ch,
                CURLOPT_HTTPHEADER,
                array(
                    'Content-Type: application/json',
                    'Content-Length: ' . strlen($data)
                )
            );
            curl_setopt($ch, CURLOPT_TIMEOUT, 5);
            curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
            //execute post
            $result = curl_exec($ch);
            //close connection
            curl_close($ch);
            return $result;
        }
        $endpoint = "https://test-payment.momo.vn/v2/gateway/api/create";
        $partnerCode = 'MOMOBKUN20180529';
        $accessKey = 'klm05TvNBzhg7h7j';
        $serectkey = 'at67qH6mk8w5Y1nAyMoYKMWACiEi2bsa';
        $orderInfo = "HD123";
        $amount = "20000";
        $orderId = time() . "";
        $redirectUrl = "https://webhook.site/b3088a6a-2d17-4f8d-a383-71389a6c600b";
        $ipnUrl = "https://webhook.site/b3088a6a-2d17-4f8d-a383-71389a6c600b";
        $extraData = "";
        $requestId = time() . "";
        $requestType = "payWithATM";
        //before sign HMAC SHA256 signature
        $rawHash = "accessKey=" . $accessKey . "&amount=" . $amount . "&extraData=" . $extraData . "&ipnUrl=" . $ipnUrl . "&orderId=" . $orderId . "&orderInfo=" . $orderInfo . "&partnerCode=" . $partnerCode . "&redirectUrl=" . $redirectUrl . "&requestId=" . $requestId . "&requestType=" . $requestType;
        $signature = hash_hmac("sha256", $rawHash, $serectkey);
        $data = array(
            'partnerCode' => $partnerCode,
            'partnerName' => "Test",
            "storeId" => "MomoTestStore",
            'requestId' => $requestId,
            'amount' => $amount,
            'orderId' => $orderId,
            'orderInfo' => $orderInfo,
            'redirectUrl' => $redirectUrl,
            'ipnUrl' => $ipnUrl,
            'lang' => 'vi',
            'extraData' => $extraData,
            'requestType' => $requestType,
            'signature' => $signature
        );
        $result = execPostRequest($endpoint, json_encode($data));
        $jsonResult = json_decode($result, true);  // decode json
        return $jsonResult;
    }

    public function checkPayment($id)
    {
        $endpoint = "https://test-payment.momo.vn/v2/gateway/api/query";
        $partnerCode = 'MOMOBKUN20180529';
        $accessKey = 'klm05TvNBzhg7h7j';
        $secretKey = 'at67qH6mk8w5Y1nAyMoYKMWACiEi2bsa';
        $requestId = time() . "";
        $requestType = "captureWallet";

        $orderId = $id; // Mã đơn hàng cần kiểm tra trạng thái

        //before sign HMAC SHA256 signature
        $rawHash = "accessKey=" . $accessKey . "&orderId=" . $orderId . "&partnerCode=" . $partnerCode . "&requestId=" . $requestId;
        // echo "<script>console.log('Debug Objects: " . $rawHash . "' );</script>";

        $signature = hash_hmac("sha256", $rawHash, $secretKey);

        $data = array(
            'partnerCode' => $partnerCode,
            'requestId' => $requestId,
            'orderId' => $orderId,
            'requestType' => $requestType,
            'signature' => $signature,
            'lang' => 'vi'
        );

        $ch = curl_init($endpoint);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt(
            $ch,
            CURLOPT_HTTPHEADER,
            array(
                'Content-Type: application/json',
                'Content-Length: ' . strlen(json_encode($data))
            )
        );
        curl_setopt($ch, CURLOPT_TIMEOUT, 5);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
        //execute post
        $result = curl_exec($ch);
        //close connection
        curl_close($ch);

        $jsonResult = json_decode($result, true);  // decode json
        if ($jsonResult["resultCode"] == 0) {
            return $jsonResult;
        }
        if ($jsonResult["resultCode"] == 42) {
            return response()->json([
                "message" => "Không tìm thấy mã đơn hàng"
            ], 201);
        }
    }
    
}
