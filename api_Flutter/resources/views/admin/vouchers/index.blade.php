@extends('admin.app')
@section('title') Quản lý khuyến mãi @endsection
@section('content')
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<div class="app-title">
    <div>
        <h1>Quản lí khuyến mãi</h1>
        <p>Xin chào {{Session::get('emp')->fullName}} </p>
    </div>
    <ul class="app-breadcrumb breadcrumb">

        <li class="breadcrumb-item"><i class="fa fa-home" aria-hidden="true"></i></li>
        <li class="breadcrumb-item"><a href="#">Quản lí khuyến mãi</a></li>
    </ul>
</div>
@if(session('success'))
<div class="alert alert-success" id="alert">
    <button type="button" class="close" data-dismiss="alert">x</button>
    {{session('success')}}
</div>
@endif
<div class="row">
    <div class="col-sm-4  text-white">
        <a href="{{route('admin.vouchers.create')}}" class="btn btn-primary">Tạo khuyến mãi</a>

    </div>
</div>
<div class="container-fluid">
    <div class="container mt-3">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th> ID</th>
                    <th> Mã</th>
                    <th> Đối tượng</th>
                    <th> Tên khuyến mãi </th>
                    <th> Số tiền giảm </th>
                    <th> Ngày bắt đầu</th>
                    <th>Ngày kết thúc</th>
                    <th>Giới hạn </th>
                    <th>Trạng thái</th>
                    <th>Thao tác </th>
                </tr>
            </thead>
            <tbody>
                @foreach ($loadData as $item)
                <tr>
                    <td> {{ $item->id }}</td>
                    <td> {{ $item->code }}</td>
                    @if( $item->userID==1 ) <td> Mọi người </td>

                    @endif
                    @if( $item->userID!=1 ) <td> {{$item->userID}} </td>

                    @endif
                    <td> {{ $item->name }}</td>
                    <td> {{ $item->sale }}</td>
                    <td> {{ \Carbon\Carbon::parse($item->startDate)->format('d/m/Y') }}</td>
                    <td> {{ \Carbon\Carbon::parse($item->endDate)->format('d/m/Y') }}</td>
                    <td> {{ $item->limit }}</td>
                    @if( $item->startDate >$currentDate)
                    <td> Chưa tới thời gian sử dụng</td>
                    @endif
                    @if( $item->endDate <$currentDate) <td> hết hạn sử dụng </td>

                        @endif
                        @if( $item->endDate >$currentDate&& $item->startDate<$currentDate ) <td> Còn hạn sử dụng </td>

                            @endif

                            <td>
                                <div class="btn-group">
                                    <a class="btn btn-primary" href="{{url('/admin/vouchers/edit/' . $item->id)}}"><i class="fa fa-lg fa-edit"></i></a>
                                    <a class="btn btn-primary" onclick="deleleVoucher({{$item->id}})" href=""><i class="fa fa-lg fa-trash"></i></a>
                                </div>
                            </td>
                </tr>
                @endforeach
            </tbody>
        </table>
        {{ $loadData->links() }}

    </div>
</div>
@endsection

<script>
    function deleleVoucher(id) {
        if (confirm("Bạn có chắc muốn xóa không? ")) {
            $.ajax({
                type: 'get',
                url: '/admin/vouchers/delete/' + id,
                success: function(data) {
                    setTimeout(function() {
                        window.location.href = "vouchers";
                    }, 200);

                },
            });
        }
    }
</script>