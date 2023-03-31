@extends('admin.app')
@section('title') Quản lý thông báo @endsection
@section('content')
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<div class="app-title">
    <div>
        <h1>Chỉnh sửa thông báo</h1>
    </div>

</div>
<div class="row">
    <form action="{{ url('admin/notifications/update/' .$notification->id) }}" method="post" enctype="multipart/form-data">
        {{csrf_field() }}
        <h1>ID : {{$notification->id}}</h1>
        <label>Tiêu đề</label></br>
        <input type="text" name="title" id="title" value="{{$notification->title}}" class="form-control" required></br>
        <div class="form-group">
            <label>Đối tượng</label>
            <select class="form-select" id="userID" name="userID">
                <option hidden value="1">@if($notification->userID==1) <th>Cho tất cả người dùng</th> @endif
                    @if($notification->userID!=1) <th>{{$notification->userID}}</th> @endif </option>
                <option value="1">Cho tất cả người dùng</option>
                @foreach($data as $item)
                <option>{{$item ->id}}</option>
                @endforeach
            </select>
        </div>
        <div class="form-group">

            <label>Nội dung</label></br>
            <input type="text" name="content" id="content" value="{{$notification->content}}" class="form-control" required></br>
            <label>Ngày bắt đầu</label></br>
            <input type="text" name="startDate" id="startDate" value="{{ \Carbon\Carbon::parse($notification ->startDate)->format('Y/m/d') }}" autocomplete="off" class="form-control" required></br>
            <label>Ngày kết thúc</label></br>
            <input type="text" name="endDate" id="endDate" value="{{ \Carbon\Carbon::parse($notification ->endDate)->format('Y/m/d') }}" autocomplete="off" class="form-control" required></br>
            <label>Ảnh</label>
            <input type="file" class="form-control" id="image" name="image"></br>
            <button type="submit" class="btn btn-success">Cập nhật</br>
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