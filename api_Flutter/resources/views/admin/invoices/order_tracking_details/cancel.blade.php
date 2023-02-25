@extends('admin.app')
@section('title') Đơn xác nhận @endsection
@section('content')

<div class="app-title">
    <div>
      <h1>Hóa đơn / Theo dõi đơn hàng / Đơn thành công</h1>  
        <p>Xin chào  {{Session::get('emp')->fullName}} </p>
    </div>
    <ul class="app-breadcrumb breadcrumb">
     
      <li class="breadcrumb-item"><i class="fa fa-home" aria-hidden="true"></i></li>
      <li class="breadcrumb-item"><a href="{{ route('admin.invoice.orderTracking') }}">Theo dõi đơn hàng</a></li>
      <li class="breadcrumb-item"><a href="#">Đơn đã hủy</a></li>
    </ul>
</div>
<div class="container-fluid">
<div class="row">
      <div class="col-md-4">
        <div class="form-group has-search">
       
          <input type="text" name="keyword" id="keyword" class="form-control" placeholder="Tìm kiếm">
        </div>
      </div>

      <div class="col-md-4">
        <div class="row">
          <div class="form-group has-search">
          
            <input type="date" class="form-control" placeholder="Tìm theo ngày">
          </div>
          <span><button class="btn btn-primary"type="submit">Duyệt</button></span>
        </div>
      </div>
    </div>
</div>
<div class="container-fluid">
    <div class="container mt-3">
            <table class="table">
            <thead class="thead-dark">
                <tr>
              
                <th scope="col">Mã hóa đơn</th>
                <th scope="col">Nhân viên</th>
                <th scope="col">Khách hàng</th>
                <th scope="col">Ngày tạo hóa đơn</th>
                <th scope="col">Tổng</th>
                <!-- <th scope="col">Thanh toán</th> -->
                <th scope="col">Lý do</th>
                <th scope="col">Thao tác</th>
             
                </tr>
            </thead>
            <tbody>
                @foreach($load as $item)
                <tr>
                  
                    <td>{{$item->id}}</td>
                    <td>{{$item->NV}}</td>
                    <td>{{$item->fullName}}</td>
                    <td>{{$item->dateCreated}}</td>
                    <td>{{number_format($item->total)}}VNĐ</td>
                    <!-- <td>
                        <span>   <i class="fa fa-check" style="color:green" ></i>Ok</span>
                    </td> -->
                    <td>123</td>
                    <td>
                    <div class="btn-group">
                        <a class="btn btn-primary" href="{{route('admin.invoice.details',$item->id)}}"><i class="fa fa-eye"></i></a>
                        <a class="btn btn-primary" href="#"><i class="fa fa-lg fa-edit"></i></a>
                    </div>
                    </td>
                </tr>
                @endforeach
            </tbody>
            </table>
            {{ $load->links() }}
    </div>
</div>
@endsection