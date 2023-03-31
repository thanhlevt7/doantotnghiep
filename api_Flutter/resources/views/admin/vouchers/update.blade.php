@extends('admin.app')
@section('title') Sửa khuyến mãi @endsection
@section('content')
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<div class="app-title">
    <div>
        <h1>Chỉnh sửa khuyến mãi</h1>
    </div>

</div>
<div class="row">
    <form action="{{ url('admin/vouchers/update/' .$voucher->id) }}" method="post">
        {{csrf_field() }}
        <h1>ID : {{$voucher->id}}</h1>
        <label>Mã khuyến mãi</label></br>
        <input type="text" name="code" id="code" value="{{$voucher->code}}" class="form-control" required></br>
        <label>Tên khuyến mãi</label></br>
        <input type="text" name="name" id="name" value="{{$voucher->name}}" class="form-control" required></br>
        <div class="form-group">
            <label>Đối tượng</label>
            <select class="form-select" id="userID" name="userID">
                <option hidden value="1">@if($voucher->userID==1) <th>Cho tất cả người dùng</th> @endif
                    @if($voucher->userID!=1) <th>{{$voucher->userID}}</th> @endif </option>
                <option value="1">Cho tất cả người dùng</option>
                @foreach($data as $item)
                <option>{{$item ->id}}</option>
                @endforeach
            </select>
        </div>
        <label>Số tiền giảm</label></br>
        <input type="number" name="sale" id="sale" value="{{$voucher->sale}}" class="form-control" required></br>
        <label>Ngày bắt đầu</label></br>
        <input type="text" name="startDate" id="startDate" value="{{ \Carbon\Carbon::parse($voucher ->startDate)->format('Y/m/d') }}" autocomplete="off" class="form-control" required></br>
        <label>Ngày kết thúc</label></br>
        <input type="text" name="endDate" id="endDate" value="{{ \Carbon\Carbon::parse($voucher ->endDate)->format('Y/m/d') }}" autocomplete="off" class="form-control" required></br>
        <label>Giới hạn</label></br>
        <input type="number" name="limit" id="limit" value="{{$voucher->limit}}" class="form-control" required></br>
        <button type="submit" class="btn btn-success">Cập nhật</button>
    </form>
</div>
<style>
    h1 {
        text-align: center;
    }

    label {
        text-align: center;
    }
</style>
@endsection('content')