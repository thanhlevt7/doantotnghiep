<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Notification;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use CloudinaryLabs\CloudinaryLaravel\Facades\Cloudinary;

class NotificationController extends Controller
{
    public function Index()
    {
        $currentDate = Carbon::now('Asia/Ho_Chi_Minh');
        $loadData = DB::table('notifications')
            ->paginate(8);
        return view('admin.notifications.index', compact('loadData', 'currentDate'));
    }
    public function FormCreate()
    {
        $currentDate = Carbon::now('Asia/Ho_Chi_Minh');
        $data = DB::table('users')->where('type', 'user')->get();
        return view('admin.notifications.create', compact('data', 'currentDate'));
    }

    public function CreateNotification(Request $request)
    {
        $uploadedFileUrl = Cloudinary::uploadFile($request->file('image')->getRealPath())->getSecurePath();
        DB::table('notifications')
            ->insert([
                'title' => $request->title,
                'userID' => $request->userID,
                'content' => $request->content,
                'image' => $uploadedFileUrl,
                'startDate' => $request->startDate,
                'endDate' => $request->endDate,
            ]);
        return redirect('admin/notifications');
    }
    public function deleteNotification($id)
    {
        $notification = Notification::find($id);
        if ($notification != null) {
            $notification->Delete();
        }
    }
    public function edit($id)
    {
        $notification = Notification::find($id);
        $data = DB::table('users')->where('type', 'user')->get();
        return view('admin.notifications.update', compact('notification', 'data'));
    }

    public function updateNotification(Request $request, $id)
    {
        $notification = Notification::find($id);
        $notification->title = $request->title;
        $notification->userID = $request->userID;
        $notification->content = $request->content;
        $notification->startDate = $request->startDate;
        $notification->endDate = $request->endDate;
        if ($request->file('image') != null) {
            $uploadedFileUrl = Cloudinary::uploadFile($request->file('image')->getRealPath())->getSecurePath();
            $notification->image = $uploadedFileUrl;
        }
        $notification->update();
        return redirect('admin/notifications')->with('success', 'Cập nhật thành công');
    }
}
