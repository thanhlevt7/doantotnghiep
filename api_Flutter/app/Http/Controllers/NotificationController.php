<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class NotificationController extends Controller
{
    public function loadNotification()
    {
        $currentDate = Carbon::now('Asia/Ho_Chi_Minh');
        $get =  DB::table('notifications')
            ->where('endDate', '>=', $currentDate)
            ->orderBy('startDate', 'desc')
            ->get();
        if (!$get->isEmpty()) {
            return response()->json(
                $get,
            );
        } else {
            return response()->json([
                "message" => false
            ], 201);
        }
    }

    public function loadNotificationForUser($userId)
    {
        $currentDate = Carbon::now('Asia/Ho_Chi_Minh');
        $check = DB::table('notifications')
            ->where('userId', $userId)
            ->exists();
        $query = null;
        if ($check) {
            $query = DB::table('notifications')
                ->select('*')
                ->where('endDate', '>', $currentDate)
                ->where('userId', $userId)
                ->orWhere('userId', 1)

                ->get();
            return json_encode($query);
        } else {
            $query = DB::table('notifications')
                ->select('*')
                ->where('userId', 1)
                ->where('endDate', '>', $currentDate)
                ->get();
            return json_encode($query);
        }
    }
}
