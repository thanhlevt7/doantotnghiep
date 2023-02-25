@extends('admin.app')
@section('title') Quản lý thông báo @endsection
@section('content')
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<div class="app-title">
    <div>
        <h1>Quản lí mã khuyến mãi</h1>
        <p>Xin chào {{Session::get('emp')->fullName}} </p>
    </div>
    <ul class="app-breadcrumb breadcrumb">

        <li class="breadcrumb-item"><i class="fa fa-home" aria-hidden="true"></i></li>
        <li class="breadcrumb-item"><a href="#">Quản lí thông báo</a></li>
    </ul>
</div>
<div class="row">
    <div class="col-sm-4  text-white">
        <a href="{{route('admin.notifications.create')}}" class="btn btn-primary">Tạo thông báo</a>

    </div>
</div>
<div class="container-fluid">
    <div class="container mt-3">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th> ID</th>
                    <th> Tên thông báo </th>
                    <th> Cho người dùng </th>
                    <th>Ảnh </th>
                    <th> Nội dung </th>
                    <th> Ngày bắt đầu</th>
                    <th>Ngày kết thúc</th>
                    <th>Trạng thái</th>
                    <th>Thao tác </th>
                </tr>
            </thead>
            <tbody>
                @foreach ($loadData as $item)
                <tr>
                    <td> {{ $item->id }}</td>
                    <td> {{ $item->title }}</td>
                    @if( $item->userID==-1 ) <td> Mọi người </td>

                            @endif
                            @if( $item->userID!=-1 ) <td> {{$item->userID}} </td>

@endif
                    <td> <img src="{{$item->image}}" class="rounded" alt="Ảnh" width="70" height="70"> </td>
                    <td> {{ $item->content }}</td>
                    <td> {{ $item->startDate }}</td>
                    <td> {{ $item->endDate }}</td>

                    @if( $item->startDate >$currentDate)
                    <td> Chưa thông báo</td>
                    @endif
                    @if( $item->endDate <$currentDate) <td> hết hạn </td>

                        @endif
                        @if( $item->endDate >$currentDate&& $item->startDate<$currentDate ) <td> Đang thông báo </td>

                            @endif


                            <td>
                                <div class="btn-group">
                                    <!-- <a class="btn btn-primary" href="#"><i class="fa fa-lg fa-edit"></i></a> -->
                                    <a class="btn btn-primary" onclick="deleleNotification({{$item->id}})" href=""><i class="fa fa-lg fa-trash"></i></a>
                                </div>
                            </td>
                </tr>
                @endforeach
            </tbody>
        </table>

    </div>
</div>
@endsection

<script>


    function deleleNotification(id) {
        if (confirm("Bạn có chắc muốn xóa không? ")) {
            $.ajax({
                type: 'get',
                url: '/admin/notifications/delete/' + id,
                data: {
                    _token: $("input[name=_token]").val()
                },
                success: function(data) {
                    setTimeout(function() {
                        window.location.href = "vouchers";
                    }, 200);

                },
            });
        }
    }
</script>
