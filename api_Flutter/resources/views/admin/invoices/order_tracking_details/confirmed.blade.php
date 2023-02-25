@extends('admin.app')
@section('title') Đơn xác nhận @endsection
@section('content')
<link  href="{{asset('backend/assets/css/order_tracking.css')}}" rel="stylesheet">
<script>
    function showOrderInfo(str) {   
        var orderInfo = document.getElementById('show-orderInfo-'+str);
        if (orderInfo.style.display === "none") {
            orderInfo.style.display = "block";
        } else {
            orderInfo.style.display = "none";
        }
    }   
</script>
<div class="app-title">
    <div>
      <h1>Hóa đơn / Theo dõi đơn hàng / Đơn đã xác nhận</h1>  
        <p>Xin chào  {{Session::get('emp')->fullName}} </p>
    </div>
    <ul class="app-breadcrumb breadcrumb">
     
      <li class="breadcrumb-item"><i class="fa fa-home" aria-hidden="true"></i></li>
      <li class="breadcrumb-item"><a href="{{ route('admin.invoice.orderTracking') }}">Theo dõi đơn hàng</a></li>
      <li class="breadcrumb-item"><a href="#">Đơn đã xác nhận</a></li>
    </ul>
</div>

    @if($load != null)
    @foreach($load as $item)
<div class="order my-3 bg-light">
    <div class="row">
        <div class="col-lg-4">
            <div class="d-flex flex-column justify-content-between order-summary">
                <div class="d-flex align-items-center">
                    <div class="text-uppercase">Order #{{$item->id}}</div>
                    <div class="green-label ms-auto text-uppercase">cod</div>
                </div>
                <div class="fs-8">{{$item->userID}}</div>
                <div class="fs-8">{{$item->dateCreated}}</div>
                <div class="fs-8">Tổng tiền :{{number_format($item->total)}}VND</div>
                <div class="fs-8"><a href="{{route('admin.invoice.confirmStatus',$item->id)}}" class="btn btn-primary">Đang vận chuyển</a></div>
            </div>
        </div>
         <div class="col-lg-8">
             <div class="d-sm-flex align-items-sm-start justify-content-sm-between">
                <div class="status">Trạng thái : Đã xác nhận</div>
                <div onclick="showOrderInfo('{{$item->id}}')" class="btn btn-primary text-uppercase" >Xem thông tin</div>
             </div>
        </div>   
    </div>   
   
    <div id="show-orderInfo-{{$item->id}}" style="display:none">
            <table class="table table-bordered">
                <thead>
                    <tr class="success">
                        <th>
                            Sản phẩm
                        </th>
                        <th>
                            Hình ảnh
                        </th> 
                        <th>
                            Số lượng
                        </th>
                        <th>
                             Giá bán
                        </th>                
                    </tr>
                </thead>
                <tbody>   
                    @foreach($item->products as $product)
                        <tr>
                            <td>{{$product->name}}</td>
                            <td> <img style="background:white" src="{{$product->image}}" class="rounded" alt="Ảnh" width="70" height="70"> </td>
                            <td>{{$product->quantity}}</td>            
                            <td>{{$product->price}}</td>            
                        </tr>
                    @endforeach
                </tbody>
            </table>
      
    </div>     
</div>
@endforeach
@endif
@endsection