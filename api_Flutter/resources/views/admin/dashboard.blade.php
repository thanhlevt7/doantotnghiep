@extends('admin.app')
@section('title') Dashboard @endsection
@section('css') 
  <style>
    .has-search .form-control {
    padding-left: 2.375rem;
    }

    .has-search .form-control-feedback {
        position: absolute;
        z-index: 2;
        display: block;
        width: 2.375rem;
        height: 2.375rem;
        line-height: 2.375rem;
        text-align: center;
        pointer-events: none;
        color: #aaa;
    }
  </style>
@endsection
@section('content')
  <div class="app-title">
    <div>
      <h1> Dashboard</h1>
        <p>Xin chào  {{Session::get('emp')->fullName}} </p>
    </div>
    <ul class="app-breadcrumb breadcrumb">

      <li class="breadcrumb-item"><i class="fa fa-home" aria-hidden="true"></i></li>
      <li class="breadcrumb-item"><a href="#">Dashboard</a></li>
    </ul>
  </div>

  <div class="row">
    <div class="col-md-6 col-lg-3">
      <div class="widget-small primary coloured-icon">
        <i class="icon fa fa-truck fa-3x"></i>
        <div class="info">
          <h4>Tổng hóa đơn</h4>
          <p><b>{{$countInv}}</b></p>
        </div>
    </div>
  </div>

    <div class="col-md-6 col-lg-3">
        <div class="widget-small primary coloured-icon">
          <i class="icon fa fa-truck fa-3x"></i>
          <div class="info">
            <h4>Doanh thu</h4>
            <p><b>{{number_format($sales)}}VND</b></p>
          </div>
      </div>
      </div>

      <div class="col-md-6 col-lg-3">
        <div class="widget-small warning coloured-icon">
            <i class="icon fa fa-users fa-3x"></i>
            <div class="info">
                <h4>Nhân sự</h4>
                <p><b>{{$countUser}}</b></p>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-lg-3">
        <div class="widget-small danger coloured-icon">
            <i class="icon fa fa-star fa-3x"></i>
            <div class="info">
                <h4>Đánh giá</h4>
                <p><b>{{$rating}}</b></p>
            </div>
        </div>
    </div>
    </div>
    <div class="row">
      <div class="col-md-4">
        <div class="form-group has-search">
          <span class="fa fa-search form-control-feedback"></span>
          <input type="text" class="form-control" placeholder="Tìm kiếm">
        </div>
      </div>

      <div class="col-md-4">
        <div class="row">
          <div class="form-group has-search">
            <span class="fa fa-search form-control-feedback"></span>
            <input type="date" class="form-control" placeholder="Tìm theo ngày">
          </div>
          <span><button class="btn btn-primary"type="submit">Duyệt</button></span>
        </div>
      </div>
    </div>
@endsection
