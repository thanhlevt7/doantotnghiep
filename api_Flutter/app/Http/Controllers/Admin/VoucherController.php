<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Voucher;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class VoucherController extends Controller
{
    public function Index()
    {
        $currentDate = Carbon::now('Asia/Ho_Chi_Minh');
        $loadData = DB::table('vouchers')->where('limit', '>', 0)
            ->paginate(8);
        return view('admin.vouchers.index', compact('loadData', 'currentDate'));
    }
    public function FormCreate()
    {
        $data = DB::table('users')->where('type', 'user')->get();
        return view('admin.vouchers.create', compact('data'));
    }

    public function viewVoucher($id)
    {
        $data = Voucher::find($id);
        return view('admin.vouchers.view', compact('data'));
    }

    public function CreateVoucher(Request $request)
    {

        $radomCode = Str::random(6);
        DB::table('vouchers')
            ->insert([
                'code' => $radomCode,
                'name' => $request->name,
                'userID' => $request->userID,
                'sale' => $request->sale,
                'startDate' =>  Carbon::parse($request->startDate)->format('Y/m/d'),
                'endDate' => Carbon::parse($request->endDate)->format('Y/m/d'),
                'limit' => $request->limit,
                'status' => 1,
            ]);

        return redirect('admin/vouchers')->with('success', 'Tạo thành công');
    }
    public function deleteVoucher($id)
    {
        $voucher = Voucher::find($id);
        if ($voucher != null) {
            $voucher->Delete();
        }
    }

    public function edit($id)
    {
        $voucher = Voucher::find($id);
        $data = DB::table('users')->where('type', 'user')->get();
        return view('admin.vouchers.update', compact('voucher','data'));
    }

    public function updateVoucher(Request $request, $id)
    {
        $voucher = Voucher::find($id);
        $input = $request->all();
        $voucher->update($input);
        return redirect('admin/vouchers')->with('success', 'Cập nhật thành công');
    }
}
