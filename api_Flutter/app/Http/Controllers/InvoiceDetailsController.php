<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Invoice;
use App\Models\Product;
use App\Models\InvoiceDetails;
class InvoiceDetailsController extends Controller
{
    
    function createInvoiceDetails(Request $request)
    {
        $countDetails =  DB::table('invoice_details')->count()+1;
        $randomDe = 'f23112001ide' .  $countDetails;

        $invoiceDetails = new InvoiceDetails;
        
        $invoiceDetails->id = $randomDe;
        $invoiceDetails->invoiceID =   $request->invoiceID;
        $invoiceDetails->productID = $request->productID;
        $invoiceDetails->quantity = $request->quantity;
        $invoiceDetails->status=1;
        $invoiceDetails->created_at = Date('Y-m-d H:i:s');
        $invoiceDetails->updated_at =Date('Y-m-d H:i:s');
        
        $invoiceDetails->save();
        if($invoiceDetails ==null){
            return  json_encode([
                "message" => "Lỗi",
            ]);
        }
        return  json_encode([
             $invoiceDetails,
        ]);
    }
}
