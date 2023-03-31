@extends('admin.app')
@section('title') Quản lý thông báo @endsection
@section('content')
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
  h1 {
    text-align: center;
  }

  label {
    text-align: center;
  }

  /* .goBack{
  text-align: center;
} */
</style>

<div class="row">
  <form action="{{route('admin.vouchers.create.post')}}" method="POST" enctype="multipart/form-data">
    @csrf
    <div class="col">
      <div class="mb-3" require>
        <label for="name" class="form-label">Tên khuyến mãi :</label>
        <input type="text" class="form-control" id="name" placeholder="Nhập tên" name="name" required>
      </div>
      <div class="mb-3 mt-3">
        <label for="userId" class="form-label">Đối tượng:</label>
        <select class="form-select" id="userID" name="userID">
          <option value="1">Cho tất cả người dùng</option>
          @foreach($data as $item)
          <option value="{{$item->id}}">{{$item->id}}-{{$item->email}}</option>
          @endforeach
        </select>
      </div>
      <div class="mb-3">
        <label for="sale" class="form-label">Số tiền giảm:</label>
        <input type="number" class="form-control" id="sale" placeholder="Nhập số tiền giảm" name="sale" required>
      </div>
      <div class="mb-3">
        <label for="startDate" class="form-label">Ngày bắt đầu:</label>
        <input type="text" class="form-control" id="startDate" placeholder="Ngày bắt đầu" name="startDate" autocomplete="off" required>
      </div>
      <div class="mb-3">
        <label for="endDate" class="form-label">Ngày kết thúc:</label>
        <input type="text" class="form-control" id="endDate" placeholder="Ngày kết thúc" name="endDate" autocomplete="off" required>
      </div>
      <div class="mb-3">
        <label for="limit" class="form-label">Giới hạn:</label>
        <input type="number" class="form-control" id="limit" placeholder="Nhập giới hạn dùng" name="limit" required>
      </div>
      <input type="submit" class="btn btn-success" value="Tạo mới ">

    </div>
  </form>


</div>
@endsection