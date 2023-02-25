<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;
use App\Models\Invoice;
use App\Models\User;
use App\Models\InvoiceDetails;
use App\Models\Product;
use Illuminate\Http\Request;

class CartController extends Controller
{
   
    function getCartForUser($userID){
        $query = DB::table('invoices')
        ->join('users','invoices.userID','=','users.id')
        ->select('invoices.*') 
        ->where('invoices.userID',$userID)
        ->Where('invoices.status','=',0)
        ->addSelect(DB::raw("null as products"))->get();
        $checkProductInDetails =  DB::table('invoice_details')
        ->join('products','invoice_details.productID','=','products.id')
        ->where('invoiceID',$query[0]->id)
        ->select('products.*','invoice_details.quantity')->exists();
        if($checkProductInDetails){
            foreach( $query  as $item){
                $listProduct = DB::table('invoice_details')
                ->join('products','invoice_details.productID','=','products.id')
                ->where('invoiceID',$item->id)
                ->select('products.*','invoice_details.quantity')->get();
                $item->products = $listProduct;
            }
        }else{
            $query[0]->products = null;
        }
        if(!empty($query[0]->products)){
            return json_encode(
                $query,
            );
        }else{
            return response()->json([
                "success" => false,
            ],201);
        }
    }
    public function AddToCart(Request $request,$id){
        $checkInvoice = DB::table('invoices')
        ->where('userID',$id)
        ->where('status',0)
        ->select('invoices.*')
        ->addSelect(DB::raw('null as products'))
        ->exists();  
        if($checkInvoice){
            $count = 0;
            $invoices = DB::table('invoices')
            ->where('userID',$id)
            ->where('status',0)
            ->select('invoices.*')
            ->addSelect(DB::raw('null as products'))
            ->get(); 
            $invoices[0]->products = DB::table('invoice_details')
            ->where('invoiceID',$invoices[0]->id)
            ->exists();
            if( $invoices[0]->products){
                $invoices[0]->products = DB::table('invoice_details')
                ->where('invoiceID',$invoices[0]->id)
                ->get();
            }else{
                $invoices[0]->products= null;
            }
            if(empty($invoices[0]->products)){
                $count= -1;
            }else{
                foreach($invoices[0]->products as $item){
                    if(empty($request->quantity)){
                        if($item->productID == $request->productID){
                            DB::table('invoice_details')
                            ->where('id',$item->id)
                            ->update([
                                'quantity' =>$item->quantity+1,
                            ]);
                            return response()->json([
                                "increment-product" => true,
                            ],200);
                        }
                    }else{
                        if($item->productID == $request->productID){
                            DB::table('invoice_details')
                            ->where('id',$item->id)
                            ->update([
                                'quantity' =>$item->quantity+$request->quantity,
                            ]);
                            return response()->json([
                                "increment-product" => true,
                            ],200);
                       }
                    }
                   $count=-1;
               }
            }
           if($count == -1){
                if(empty($request->quantity)){                  
                    DB::table('invoice_details')
                    ->where('invoiceID',$invoices[0]->id)
                    ->insert([
                         'invoiceID' => $invoices[0]->id,
                         'productID' => $request->productID,
                         'quantity' => 1,
                         'status'=>1
                    ]);
                    return response()->json([
                        "create-details-quantity-1" => true,
                    ],200);
                }
                else{
                    DB::table('invoice_details')
                    ->where('invoiceID',$invoices[0]->id)
                    ->insert([
                         'invoiceID' => $invoices[0]->id,
                         'productID' => $request->productID,
                         'quantity' => $request->quantity,
                         'status'=>1
                    ]);
                    return response()->json([
                        "create-details-quantity-request" => true,
                    ],200);
                }
           }        
        }else{
            $countInv =  DB::table('invoices')->count()+1;
            $randomIDInvoice ='HD' .Date('Ymd') .  $countInv;
            if(!empty($request->quantity)){
                $product_price= DB::table('products')
                ->where('products.id',$request->productID)
                ->select('price')
                ->get();
                DB::table('invoices')
                ->insert([
                    'id'   =>   $randomIDInvoice,
                     'userID' => $id,
                     'shippingName' => $request->shippingName,
                     'shippingPhone' => $request->shippingPhone,
                     'dateCreated' => $request->dateCreated,
                     'total' =>    $product_price[0]->price * $request->quantity,
                     'isPaid' => 0,
                    'status' =>0,
                ]);
                 DB::table('invoice_details')
                 ->insert([
                      'invoiceID' => $randomIDInvoice,
                      'productID' => $request->productID,
                      'quantity' => $request->quantity,
                      'status'=>1
                 ]);
                 return response()->json([
                     "create-cart- have quantity" => true,
                 ],200);
            }else{
                $product_price= DB::table('products')
                ->where('products.id',$request->productID)
                ->select('price')
                ->get();
                DB::table('invoices')
                ->insert([
                     'id'   =>   $randomIDInvoice,
                     'userID' => $id,
                     'shippingName' => $request->shippingName,
                     'shippingPhone' => $request->shippingPhone,
                     'dateCreated' => $request->dateCreated,
                     'total' =>    $product_price[0]->price * 1,
                     'isPaid' => 0,
                    'status' =>0,
                ]);
                 DB::table('invoice_details')
                 ->insert([
                      'invoiceID' => $randomIDInvoice,
                      'productID' => $request->productID,
                      'quantity' => 1,
                      'status'=>1
                 ]);
                 return response()->json([
                     "create-cart-not have quantity" => true,
                 ],200);
            }
        }
       
    }

    public function updateQuantityIncrement(Request $request,$userID){
        $getDetails = DB::table('invoice_details')
        ->where('invoiceID',$request->invoiceID)
        ->where('productID',$request->productID)
        ->get();
        DB::table('invoice_details')
        ->where('invoiceID',$getDetails[0]->invoiceID)
        ->where('productID',$getDetails[0]->productID)
        ->update([
            'quantity' => $getDetails[0]->quantity + 1,
        ]); 
        return response()->json(["success "=>"Đã tăng số lượng giỏ hàng"],200);
    }

    public function updateQuantityDecrement(Request $request,$userID){
        $getDetails = DB::table('invoice_details')
        ->where('invoiceID',$request->invoiceID)
        ->where('productID',$request->productID)
        ->get();
        DB::table('invoice_details')
        ->where('invoiceID',$getDetails[0]->invoiceID)
        ->where('productID',$getDetails[0]->productID)
        ->update([
            'quantity' => $getDetails[0]->quantity - 1,
        ]); 
        return response()->json(["success "=>"Đã giảm số lượng giỏ hàng"],200);
    }
    
    public function deleteProductCart(Request $request,$userID){
        $getInvoice = DB::table('invoices')
        ->where('userID',$userID)
        ->where('status',0)
        ->get();
        $getDetails =DB::table('invoice_details')
        ->where('invoiceID',$getInvoice[0]->id)
        ->where('productID',$request->productID)
        ->delete();
        return response()->json([
            "message" => true
        ],200); 
    }
}
