<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

use Illuminate\Http\Request;

class VoucherController extends Controller
{
    public function CheckVoucher(Request $request, $ID)
    {
        $currentDate = Carbon::now('Asia/Ho_Chi_Minh')->toDateString();
        $vouchers = DB::table('vouchers')
            ->where(DB::raw('BINARY `code`'), $request->code)
            ->where('limit', '>', 0)
            ->whereDate('endDate', '>', $currentDate)
            ->exists();
        if ($vouchers) {
            $id = DB::table('vouchers')
                ->select('id')->where('code', $request->code)->get();
            $data = DB::table('vouchers')
                ->select('userID', 'sale', 'limit')->where('id', $id[0]->id)->get();
            if ($data[0]->userID == 1) {
                DB::table('vouchers')
                    ->where('id', $id[0]->id)
                    ->update(['limit' => $data[0]->limit - 1]);
                return response()->json(
                    $data[0]->sale
                );
            } else {
                if ($data[0]->userID == $ID) {
                    DB::table('vouchers')
                        ->where('id', $id[0]->id)
                        ->update(['limit' => $data[0]->limit - 1]);
                    return response()->json(
                        $data[0]->sale
                    );
                } else {
                    return response()->json([
                        'message' => 'Voucher không dành cho bạn',
                    ], 202);
                }
            }
        } else {
            return response()->json([
                'message' => 'Voucher không tồn tại',
            ], 201);
        }
    }
}
