@extends('admin.app')
@section('title') Quản lý khuyến mãi @endsection
@section('content')
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<div class="app-title">
    <div>
      <h1>Quản lí mã khuyến mãi</h1>
        <p>Xin chào {{Session::get('emp')->fullName}} </p>
    </div>
    <ul class="app-breadcrumb breadcrumb">

      <li class="breadcrumb-item"><i class="fa fa-home" aria-hidden="true"></i></li>
      <li class="breadcrumb-item"><a href="#">Quản lí khuyến mãi</a></li>
    </ul>
  </div>
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
                        <th> Tên khuyến mãi </th>
                        <th> Người tạo </th>
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
                            <td> {{ $item->name }}</td>
                            <td>{{Session::get('emp')->fullName   }}</td>
                            <td> {{ $item->sale }}</td>
                            <td> {{ $item->startDate }}</td>
                            <td> {{ $item->endDate }}</td>
                            <td> {{ $item->limit }}</td>
                            <td> {{ $item->status }}</td>
                           
                            <td>
                                <div class="btn-group">                     
                                    <!-- <a class="btn btn-primary" href="#"><i class="fa fa-lg fa-edit"></i></a> -->
                                    <a class="btn btn-primary" onclick="deleleVoucher({{$item->id}})"
                                        href=""><i class="fa fa-lg fa-trash"></i></a>
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
    function deleleVoucher(id)
    {
        if(confirm("Bạn có chắc muốn xóa không? "))
        {
            $.ajax({
                type: 'get',
                url: '/admin/vouchers/delete/'+id,
                data: {
                    _token: $("input[name=_token]").val()
                },
                success: function (data) {
                    setTimeout(function () {
                    window.location.href = "vouchers";
                    }, 200);
                    
                },
            });
        }
    }
</script>