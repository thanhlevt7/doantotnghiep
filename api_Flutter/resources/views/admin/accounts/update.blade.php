@extends('admin.app')
@section('title') Sửa sản phẩm @endsection
@section('content')
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<div class="app-title">
    <div>
        <h1>Quản lí sản phẩm</h1>
        <p>Xin chào {{Session::get('emp')->fullName}} </p>
    </div>
    <ul class="app-breadcrumb breadcrumb">

        <li class="breadcrumb-item"><i class="fa fa-home" aria-hidden="true"></i></li>
        <li class="breadcrumb-item"><a href="#">Quản lí sản phẩm</a></li>
    </ul>
</div>
<div class="row">
    <form action="{{ url('admin/products/update/' .$product->id) }}" method="post">
        {{csrf_field() }}
        <h1>Mã sản phẩm : {{$product->id}}</h1>
        <input type="hidden" name="id" id="id" value="{{$product->id}}" id="id" />
        <label>Tên sản phẩm</label></br>
        <input type="text" name="name" id="name" value="{{$product->name}}" class="form-control"></br>
        <label>Số lượng tồn kho</label></br>
        <input type="number" name="stock" id="stock" value="{{$product->stock}}" class="form-control"></br>
        <label>Giá</label></br>
        <input type="number" name="price" id="price" value="{{$product->price}}" class="form-control"></br>
        <label>Đơn giá</label></br>
        <input type="text" name="unit" id="unit" value="{{$product->unit}}" class="form-control"></br>
        <div class="form-group">
            <label>Loại sản phẩm</label>
            <select class="form-select" id="type" name="type">
                <option hidden>{{$product->type}}</option>
                @foreach($type as $item)
                <option>{{$item ->type}}</option>
                @endforeach
            </select>
        </div>
        <label>Mô tả</label></br>
        <input type="text" name="description" id="description" value="{{$product->description}}" height=300 class="form-control"></br>



        <button type="submit" class="btn btn-success">Cập nhật </br>
    </form>
</div>
@endsection