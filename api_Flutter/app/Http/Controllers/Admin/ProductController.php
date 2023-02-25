<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Product;
use Response;
use Carbon\Carbon;
class ProductController extends Controller
{
    public function loadProduct(){

            $data =DB::table('products')
            ->orderBy('id','desc')
            ->get();
            $type = DB::table('products')
            ->select('products.type')->groupBy('products.type')->distinct()->get();
          
            return view('admin.products.index',compact('data','type'));
    }
    public function handleRequestSwap($request){
            if($request == 'price_up'){
                $data =DB::table('products')
                ->where('price','>=','50000')->paginate(4);
                return view('admin.products.index',compact('data'));
            }else if($request == 'price_down'){
                $data =DB::table('products')
                ->where('price','<=','50000')->paginate(4);
                return view('admin.products.index',compact('data'));
            } else if($request == 'stock'){
                $data = Product::orderBy('stock')->paginate(4);
                return view('admin.products.index',compact('data'));
            }
    }
    public function viewCreate(){
        $data =DB::table('products')->select('type')->distinct()->get();
        return view('admin.products.create',compact('data'));
    }
    
    
    public function createProduct(Request $request){
        $currentDate = Carbon::now('Asia/Ho_Chi_Minh');
        DB::table('products')->insert([
            'name' => $request->name,
            'price' => $request->price,
            'stock' => $request->stock,
            'image' => $request->image,
            'type' => $request->type,
            'unit' => $request->unit,
            'description' => $request->description,
            'createDate'=>$currentDate,
            'status' => 1,         
        ]);
        $data = DB::table('products')
        ->get();
        return view('admin.products.index',compact('data'));
    }

    public function updateProduct(Request $request, $id)
    {
       $products= Product::find($id);
        return response()->json($products);
    }

    public function deleteProduct($id){
         Product::find($id)->delete();
       
      
      
            return response()->json([
                'message' => "Success",
               
            ]);
        
    }

    public function Search(Request $request){
        if(isset($_GET['keyWord'])){
            $searchText = $_GET['keyWord'];
            $data = DB::table('products')->where('name','LIKE','%'.$searchText.'%')->paginate(2);
            $data ->appends($request->all());
            return view('admin.products.index',compact('data'));
        }else{
            return view('admin.dashboard');
        }
    }

  
}