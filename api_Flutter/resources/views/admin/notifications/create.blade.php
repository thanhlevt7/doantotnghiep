@extends('admin.app')
@section('title') Tạo thông báo @endsection
@section('content')
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<div class="row">
  <form action="{{route('admin.notifications.create.post')}}" method="POST" enctype="multipart/form-data">
    @csrf
    <div class="col">
      <div class="mb-3" require>
        <label for="title" class="form-label">Tên thông báo :</label>
        <input type="text" class="form-control" id="title" placeholder="Nhập tên" name="title" >
      </div>
      <div class="mb-3 mt-3">
        <label for="userId" class="form-label">Đối tượng:</label>
        <select class="form-select" id="userID" name="userID">
          <option value="-1">Cho tất cả người dùng</option>
          @foreach($data as $item)
          <option value="{{$item->id}}">{{$item->id}}-{{$item->email}}</option>
          @endforeach
        </select>
      </div>
      <div class="mb-3">
        <label for="content" class="form-label">Nội dung:</label>
        <input type="text" class="form-control" id="content" placeholder="Nhập nội dung" name="content" >
      </div>
      <div class="mb-3">
        <label for="image" class="form-label">Nhập link ảnh:</label>
        <input type="text" class="form-control" id="image" placeholder="Nhập link ảnh" name="image" >
      </div>
    </div>
    <div class="col">
      <div class="mb-3">
        <label for="startDate" class="form-label">Ngày bắt đầu:</label>
        <input type="date" class="form-control" id="startDate" placeholder="Chọn ngày bắt đầu" name="startDate" >
      </div>
      <div class="mb-3">
        <label for="endDate" class="form-label">Ngày kết thúc:</label>
        <input type="date" class="form-control" id="endDate" placeholder="Chọn ngày kết thúc" name="endDate" min={{$currentDate}} >
      </div>
      <button type="submit" class="btn btn-primary">Tạo mới</button>
    </div>
  </form>
</div>





@endsection
