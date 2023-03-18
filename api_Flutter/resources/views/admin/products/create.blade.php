@extends('admin.app')
@section('title') Tạo sản phẩm @endsection
@section('content')
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<div class="row">
    <form action="{{route('admin.product.create.post')}}" method="POST" enctype="multipart/form-data">
        @csrf
        <div class="col">
            <form id="myForm" name="myForm" class="form-horizontal">
                <div class="form-group">
                    <label>Tên sản phẩm</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Nhập tên sản phẩm" value="" required>
                </div>
                <div class="form-group">
                    <label>Giá bán</label>
                    <input type="number" class="form-control" id="price" name="price" placeholder="Nhập giá" value="" required>
                </div>
                <div class="form-group">
                    <label>Chọn loại:</label>
                    <select class="form-select" id="type" name="type">
                        @foreach($data as $item)
                        <option>{{$item->type}}</option>
                        @endforeach
                    </select>
                </div>
                <div class="form-group">
                    <label>Nhập số lượng vào kho:</label>
                    <input type="number" class="form-control" id="stock" placeholder="Nhập tồn kho" name="stock" required>
                </div>
                <div class="form-group">
                    <label>Đơn vị tính:</label>
                    <input type="text" class="form-control" id="unit" placeholder="Nhập đơn vị tính" name="unit" required>
                </div>
                <div class="form-group">
                    <label>ảnh</label>
                    <input type="file" class="form-control" id="image"  name="image" required>
                </div>
                <div class="form-group">
                    <label>Mô tả</label>
                    <textarea class="form-control" rows="3" id="description" name="description" required></textarea>
                </div>


            </form>
            <button type="submit" class="btn btn-success">Tạo mới</button>
        </div>
    </form>
</div>
@endsection