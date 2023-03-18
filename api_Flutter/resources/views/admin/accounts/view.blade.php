@extends('admin.app')
@section('title') Xem tài khoản @endsection
@section('content')
@section('js')
<script src="{{asset('backend/assets/js/product.js') }}" ></script>
@endsection
<div class="app-title">
    <div>
      <h1>Quản lí tài khoản</h1>
        <p>Xin chào {{Session::get('emp')->fullName}} </p>
    </div>
    <ul class="app-breadcrumb breadcrumb">

      <li class="breadcrumb-item"><i class="fa fa-home" aria-hidden="true"></i></li>
      <li class="breadcrumb-item"><a href="#">Quản lí sản phẩm</a></li>
    </ul>
</div>

<div class="container">
    <div class="d-flex bd-highlight mb-4">
        <div class="p-2 w-100 bd-highlight">
        </div>

    </div>
    <div>
        <table class="table table-inverse">
            <thead>
                    <tr>
                    <th> ID</th>
                        <th> Tên hiển thị</th>
                        <th> Email </th>
                        <th> Họ tên </th>
                        <th> Số điện thoại </th>
                        <th> Loại tài khoản </th>
                        <th>Trạng thái</th>


                    </tr>
            </thead>
            <tbody id="todo-list" name="todo-list">
            <td> {{ $data->id }}</td>
                             <td> {{ $data->username }}</td>
                            <td> {{ $data->email }}</td>
                            <td> {{ $data->fullName }}</td>
                            <td> {{ $data->phone }}</td>
                            <td> <span>{{ $data->type }}</span></td>
                            <td>{{$data->status}}</td>


            </tbody>

        </table>
        <div style="margin:auto">

    </div>
</div>

@endsection
