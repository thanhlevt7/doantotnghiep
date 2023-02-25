<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use PhpParser\Builder\Function_;
use PhpParser\Node\Expr\FuncCall;

class AccountController extends Controller
{
    public function loadAccount(){
        $data =DB::table('users')->paginate(5);
        return view('admin.accounts.index',compact('data'));
    }


    public function loadUserActive(){
        $data =DB::table('users')
        ->where('status',1)->paginate(5);
        return view('admin.accounts.index',compact('data'));
    }


    public function deleteAccount($id){
        DB::table('addresses')
        ->where('userID',$id)->delete();
        $users = User::find($id);
       
        if($users !=null){
            $users->delete();
            return redirect()->route('admin.account');
        }
    }

    public function searchAccount(Request $request){
      
        if(isset($_GET['keyWord'])){
            $searchText = $_GET['keyWord'];
            $data = DB::table('users')->where('fullName','LIKE','%'.$searchText.'%')
            // ->where('type','LIKE','%NV%')
            ->paginate(4);
            $data ->appends($request->all());
            return view('admin.accounts.index',compact('data'));
        }else{
            return view('admin.dashboard');
        }
    }

    public function viewProfile(){
       return view('admin.accounts.profile');
    }

    public function lockUser($userID){
         DB::table('users')
        ->where('id',$userID)
        ->update([
            'status' => -1,
        ]);
        return redirect()->route('admin.account');
    }
    public function unLockUser($userID){
        DB::table('users')
       ->where('id',$userID)
       ->update([
           'status' => 0,
       ]);
       return redirect()->route('admin.account');
   }
}