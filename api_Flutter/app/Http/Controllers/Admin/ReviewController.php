<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use App\Models\Review;

class ReviewController extends Controller
{
    public function Index()
    {
        $rating = DB::table('reviews')
            ->join('users', 'reviews.userID', 'users.id')
            ->select('reviews.*', 'users.username')
            ->where('reviews.status', 1)->paginate(8);
        return view('admin.reviews.index', compact('rating'));
    }
    public function deleteReview($id)
    {
        $review = Review::find($id);
        if ($review != null) {
            $review->delete();
        }
    }
}
