@extends('admin.app')
@section('title') Hồ sơ người dùng @endsection
@section('content')
<div class="container rounded bg-white mt-5 mb-5">
    <div class="row">
        <div class="col-md-3 border-right">
            <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                <img class="rounded-circle mt-5" width="100px" height="100" src="{{Session::get('emp')->avatar}}">
                <span class="font-weight-bold">{{Session::get('emp')->fullName}}</span>
                <span class="text-black-50">{{Session::get('emp')->email}}</span>
                <span> </span>
            </div>
        </div>
      

            <div class="col-md-5 border-right">
                <div class="p-3 py-5">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="text-right">Thiết lập hồ sơ</h4>
                    </div>
                    <div class="row mt-2">
                        <div class="col-md-6">
                            <label class="labels">Tên hiển thị</label>
                            <input type="text" class="form-control" name="username" value="{{Session::get('emp')->username}}">
                        </div>
                        <div class="col-md-6">
                            <label class="labels">Họ tên</label>
                            <input type="text" class="form-control" name="fullName" value="{{Session::get('emp')->fullName}}" placeholder="{{Session::get('emp')->fullName}}" value="">
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-12">
                            <label class="labels">Số điện thoại :</label>
                            <input type="number" class="form-control" name="phone" value="{{Session::get('emp')->phone}}" value="">
                        </div>
                        <div class="col-md-12">
                            <label class="labels">Email :</label>
                            <input type="text" class="form-control" name="address" value="{{Session::get('emp')->email}}" readonly>
                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-md-6">
                            <label class="labels">Thay đổi ảnh</label>
                            <input type="file" class="form-control" id="avatar" name="avatar" >
                        </div>

                    </div>
                    <div class="mt-5 text-center">
                        <button class="btn btn-primary profile-button" type="submit">Cập nhật</button>
                    </div>
                </div>
            </div>
  
    </div>
</div>

@endsection