@extends('admin.app')
@section('title') Theo dõi hóa đơn @endsection
@section('content')
<link  href="{{asset('backend/assets/css/order_tracking.css')}}" rel="stylesheet">
<div class="container">
<div class="app-title">
    <div>
      <h1>Hóa đơn / Theo dõi đơn hàng</h1>  
        <p>Xin chào  {{Session::get('emp')->fullName}} </p>
    </div>
    <ul class="app-breadcrumb breadcrumb">
     
      <li class="breadcrumb-item"><i class="fa fa-home" aria-hidden="true"></i></li>
      <li class="breadcrumb-item"><a href="#">Theo dõi đơn hàng</a></li>
    </ul>
  </div>
<div class="col-lg-11 my-lg-0 my-1">
            <div id="main-content" class="bg-white border">
                <div class="d-flex my-4 flex-wrap">
                    <div class="box me-4 my-1 bg-light"> 
                            <div class="my-eye">
                                <img src="https://www.freepnglogos.com/uploads/box-png/cardboard-box-brown-vector-graphic-pixabay-2.png" alt="">
                                <a href="{{route('admin.invoice.waiting')}}"><i class="fa fa-eye"></i></a>
                            </div>
                        <div class="d-flex align-items-center mt-2">
                            <div class="tag">Đơn mới</div>
                            <div class="ms-auto number">{{$WaitingToAccept}}</div>
                        </div>
                    </div>
                    <div class="box me-4 my-1 bg-light">                         
                        <div class="my-eye">
                            <img src="https://www.freepnglogos.com/uploads/tick-png/check-mark-tick-vector-graphic-21.png" alt="">
                            <a href="{{route('admin.invoice.confirmed')}}"><i class="fa fa-eye"></i></a>
                        </div>
                        <div class="d-flex align-items-center mt-2">
                            <div class="tag">Đã xác nhận</div>
                            <div class="ms-auto number">{{$Confirmed}}</div>
                        </div>
                    </div>
                    <div class="box me-4 my-1 bg-light"> 
                        <div class="my-eye">
                            <img src="https://www.freepnglogos.com/uploads/logo-ifood-png/happy-ifood-logo-delivery-ifood-transparent-21.png" alt="">
                            <a href="{{route('admin.invoice.delivery')}}"><i class="fa fa-eye"></i></a>
                        </div>                         
                        <div class="d-flex align-items-center mt-2">
                            <div class="tag">Đang vận chuyển</div>
                            <div class="ms-auto number">{{$Delivery}}</div>
                        </div>
                    </div>
                    <div class="box me-4 my-1 bg-light"> 
                           
                        <div class="my-eye">
                        <img src="https://www.freepnglogos.com/uploads/thank-you-png/thank-you-png-testimonials-calm-order-professional-home-organizing-29.png" alt="">
                            <a href="{{route('admin.invoice.success')}}"><i class="fa fa-eye"></i></a>
                        </div>    
                        <div class="d-flex align-items-center mt-2">
                            <div class="tag">Thành công</div>
                            <div class="ms-auto number">{{$Success}}</div>
                        </div>
                    </div>
                    <div class="box me-4 my-1 bg-light"> 
                           
                        <div class="my-eye">
                        <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/Red_X.svg/2048px-Red_X.svg.png" alt="">
                            <a href="{{route('admin.invoice.cancel')}}"><i class="fa fa-eye"></i></a>
                        </div>    
                        <div class="d-flex align-items-center mt-2">
                            <div class="tag">Đã hủy</div>
                            <div class="ms-auto number">{{$Cancel}}</div>
                        </div>
                    </div>
                </div>
            </div>
</div>
@endsection