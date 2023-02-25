<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;

use Illuminate\Http\Request;

class VoucherController extends Controller
{
   public function CheckVoucher(Request $request){
       $currentDate = Date('Y-m-d');
       $vouchers = DB::table('vouchers')
       ->where('code',$request->code)
       ->where('limit','>',0)   
       ->whereDate('endDate','>=',$currentDate)
       ->exists(); 
       if($vouchers){
            $id=DB::table('vouchers')
            ->select('id')->where('code',$request->code)->get();
            $limit=DB::table('vouchers')
            ->select('limit')->where('id','=',$id[0]->id)->get();
            $sale=DB::table('vouchers')
            ->select('sale')->where('id','=',$id[0]->id)->get();
            DB::table('vouchers')
            ->where('id',$id[0]->id)
            ->update(['limit'=>$limit[0]->limit -1]);
            return response()->json(
                $sale
            );
       }
       else{
           return response()->json([
               'message' => 'Voucher không tồn tại',
           ],201);
       } 
   }
   
}
