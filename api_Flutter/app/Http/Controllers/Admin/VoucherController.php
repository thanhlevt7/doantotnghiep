<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Session;
use App\Models\Voucher;


class VoucherController extends Controller
{
    public function Index(){
        $loadData = DB::table('vouchers')->where('limit','>' ,0)
        ->get();
        return view('admin.vouchers.index',compact('loadData'));
    }
    public function FormCreate(){
        $data = DB::table('products')->get();
        return view('admin.vouchers.create',compact('data'));
    }

    public function CreateVoucher(Request $request){
      
        $radomCode = Str::random(6);
        DB::table('vouchers')
        ->insert([
            'code' =>$radomCode,
            'name' =>$request->name,
            'sale' =>$request->sale,
            'employeeID' =>Session::get('emp')->id,
            'startDate' =>$request->startDate,
            'endDate' =>$request->endDate,
            'limit' =>$request->limit,
            'status' =>1,
        ]);
        $loadData = DB::table('vouchers')
        ->get();
        return view('admin.vouchers.index',compact('loadData'));
    }
    public function deleteReview($id)
    {
        $voucher=Voucher::find($id);
        if($voucher!=null)
        {
            $voucher->Delete();
        }
    }
}
