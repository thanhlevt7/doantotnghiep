@extends('admin.app')
@section('title') Đánh giá @endsection
@section('content')


  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<div class="app-title">
    <div>
      <h1>Đánh giá người dùng</h1>
        <p>Xin chào {{Session::get('emp')->fullName}} </p>
    </div>
    <ul class="app-breadcrumb breadcrumb">

      <li class="breadcrumb-item"><i class="fa fa-home" aria-hidden="true"></i></li>
      <li class="breadcrumb-item"><a href="#">Đánh giá người dùng</a></li>
    </ul>
  </div>
<div class="row">
    <div class="container-fluid">
        <div class="container mt-3">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th> ID</th>
                        <th> Tên người dùng </th>
                        <th> Mã Sản phẩm</th>
                        <th> Nội dung </th>
                        <th> Số sao </th>
                        <th> Ngày giờ</th>
                        <!-- <th> Ảnh minh họa</th> -->
                        <th> Trạng thái</th>
                        <th>Thao tác </th>

                    </tr>
                </thead>
                <tbody> 
                    @foreach ($rating as $item)
                        <tr>
                            <td> {{ $item->id }}</td>
                            <td> {{ $item->username }}</td>
                            <td>{{$item->productID}}</td>
                            <td> {{ $item->content }}</td>
                            <td> {{ $item->quantity }}</td>
                            <td> {{\Carbon\Carbon::parse($item->postedDate)->format('d-m-Y H:i:s') }}</td>
                            <!-- <td> <img style="background:white"
                                    src="{{$item->image}}"
                                    class="rounded" alt="Ảnh" width="70" height="70"> </td> -->
                            <td> {{ $item->status }}</td>
                            <td>
                            <div class="btn-group">
                                <!-- <a class="btn btn-primary" href="#"><i class="fa fa-lg fa-lock"></i></a>
                                <a class="btn btn-primary" href="#"><i class="fa fa-lg fa-edit"></i></a> -->
                                <a class="btn btn-primary" onclick="deleteReview({{$item->id}})"
                                    href=""><i class="fa fa-lg fa-trash"></i></a>
                            </div>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
            {{ $rating->links() }}
        </div>
    </div>
@endsection

<script>
    function deleteReview(id)
    {
        if(confirm("Bạn có chắc muốn xóa? "))
        {
            $.ajax({
                type: 'get',
                url: '/admin/reviews/delete/'+id,
                success: function (data) {
                    setTimeout(function () {
                    window.location.href = "reviews";
                    }, 200);
                },
            });
        }
    }
</script>
