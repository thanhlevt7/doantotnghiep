<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Session;
use App\Models\Notification;
use Carbon\Carbon;


class NotificationController extends Controller
{
    public function Index(){
        $currentDate = Carbon::now('Asia/Ho_Chi_Minh');
        $loadData = DB::table('notifications')
        ->paginate(10);
        return view('admin.notifications.index',compact('loadData','currentDate'));
    }
    public function FormCreate(){
        $currentDate = Carbon::now('Asia/Ho_Chi_Minh');
        $data = DB::table('users')->get();
        return view('admin.notifications.create',compact('data','currentDate'));
    }

    public function CreateNotification(Request $request){
        $currentDate = Carbon::now('Asia/Ho_Chi_Minh');
        $radomCode = Str::random(6);
        DB::table('notifications')
        ->insert([
            'title' =>$request->title,
            'userID' =>$request->userID,
            'content' =>$request->content,
            'image' =>$request->image,
            'startDate' =>$request->startDate,
            'endDate' =>$request->endDate,
        ]);
        $loadData = DB::table('notifications')
        ->get();
        return view('admin.notifications.index',compact('loadData','currentDate'));
    }
    public function deleteNotification($id)
    {
        $notification=Notification::find($id);
        if($notification!=null)
        {
            $notification->Delete();
        }
    }
}
