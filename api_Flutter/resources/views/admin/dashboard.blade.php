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
@if(session('success'))
<div class="alert alert-success" id="alert">
  <button type="button" class="close" data-dismiss="alert">x</button>
  {{session('success')}}
</div>
@endif
<div class="app-title">
  <div>
    <h1> Dashboard</h1>
    <p>Xin chào {{Session::get('emp')->fullName}} </p>
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
      <span><button class="btn btn-primary" type="submit">Duyệt</button></span>
    </div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<!-- Essential javascripts for application to work-->
<script type="text/javascript">
  $("document").ready(function() {
    setTimeout(function() {
      $("div.alert").remove();
    }, 3000);
  });
</script>

@endsection