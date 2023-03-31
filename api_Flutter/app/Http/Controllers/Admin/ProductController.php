<?php

namespace App\Http\Controllers\Admin;


use App\Http\Controllers\Controller;
use App\Models\Product;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Response;
use CloudinaryLabs\CloudinaryLaravel\Facades\Cloudinary;

class ProductController extends Controller
{
    public function loadProduct()
    {

        $data = DB::table('products')
            ->orderBy('id', 'desc')
            ->paginate(4);
        $type = DB::table('products')
            ->select('products.type')->groupBy('products.type')->distinct()->get();

        return view('admin.products.index', compact('data', 'type'));
    }
    public function handleRequestSwap($request)
    {
        if ($request == 'price_up') {
            $data = DB::table('products')
                ->where('price', '>=', '50000')->paginate(4);
            return view('admin.products.index', compact('data'));
        } else if ($request == 'price_down') {
            $data = DB::table('products')
                ->where('price', '<=', '50000')->paginate(4);
            return view('admin.products.index', compact('data'));
        } else if ($request == 'stock') {
            $data = Product::orderBy('stock')->paginate(4);
            return view('admin.products.index', compact('data'));
        }
    }
    public function viewCreate()
    {
        $data = DB::table('products')->select('type')->distinct()->get();
        return view('admin.products.create', compact('data'));
    }

    public function viewProduct($id)
    {
        $data = Product::find($id);
        return view('admin.products.view', compact('data'));
    }

    public function createProduct(Request $request)
    {
        dd($request->image);
        $uploadedFileUrl = Cloudinary::uploadFile($request->file('image')->getRealPath())->getSecurePath();
        $currentDate = Carbon::now('Asia/Ho_Chi_Minh');
        DB::table('products')->insert([
            'name' => $request->name,
            'price' => $request->price,
            'stock' => $request->stock,
            'image' => $uploadedFileUrl,
            'type' => $request->type,
            'unit' => $request->unit,
            'description' => $request->description,
            'createDate' => $currentDate,
            'status' => 1,
        ]);
        return redirect('admin/products')->with('success', 'Tạo mới thành công');
    }

    public function edit($id)
    {
        $type = DB::table('products')
            ->select('products.type')->groupBy('products.type')->distinct()->get();

        $product = Product::find($id);
        return view('admin.products.update', compact('product', 'type'));
    }

    public function updateProduct(Request $request, $id)
    {
        $products = Product::find($id);
        $products->name = $request->name;
        $products->price = $request->price;
        $products->stock = $request->stock;
        $products->type = $request->type;
        $products->unit = $request->unit;
        $products->description = $request->description;
        if ($request->file('image') != null) {
            $uploadedFileUrl = Cloudinary::uploadFile($request->file('image')->getRealPath())->getSecurePath();
            $products->image = $uploadedFileUrl;
        }
        $products->update();
        return redirect('admin/products')->with('success', 'Cập nhật thành công');
    }

    public function deleteProduct($id)
    {
        Product::find($id)->delete();
        return response()->json([
            'message' => "Success",
        ]);
    }

    public function Search(Request $request)
    {
        if (isset($_GET['keyWord'])) {
            $searchText = $_GET['keyWord'];
            $data = DB::table('products')->where('name', 'LIKE', '%' . $searchText . '%')->paginate(2);
            $data->appends($request->all());
            return view('admin.products.index', compact('data'));
        } else {
            return view('admin.dashboard');
        }
    }
}
