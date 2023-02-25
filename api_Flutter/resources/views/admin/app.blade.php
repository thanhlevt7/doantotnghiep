<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <link rel="stylesheet" type="text/css" href="{{ asset('backend/assets/css/main.css') }}" />

    <link rel="stylesheet" type="text/css"
        href="{{ asset('backend/assets/css/font-awesome-4.7.0/css/font-awesome.min.css') }}" />
    <link rel="stylesheet" type="text/css"
        href="{{ asset('backend/assets/css/font-awesome-4.7.0/css/font-awesome.css') }}" />
    @yield('css')
   
  
    <link rel="stylesheet" href="{{ asset('backend/assets/css/imp_inv.css') }}">

    <link rel="stylesheet" href="{{ asset('backend/assets/css/imp_inv_detail.css') }}">


    <title>@yield('title')</title>
</head>

<body class=" app sidebar-mini rtl">
    @include('admin.partials.header')

    @if(Session::get('emp')->type == 'admin')
        @include('admin.partials.navbar')
    @endif
    @if(Session::get('emp')->type == 'NV thanh toán')
        @include('admin.partials.navbar_payment')
    @endif
    @if(Session::get('emp')->type == 'NV kiểm kho')
        @include('admin.partials.navbar_inventory')
    @endif
    <main class="app-content">
        @yield('content')
    </main>

    

    <script src="{{ asset('backend/assets/js/jquery-3.2.1.min.js') }}"></script>
    <script src="{{ asset('backend/assets/js/popper.min.js') }}"></script>
    <script src="{{ asset('backend/assets/js/bootstrap.min.js') }}"></script>
    <script src="{{ asset('backend/assets/js/main.js') }}"></script>
    <script src="{{ asset('backend/assets/js/plugins/pace.min.js') }}"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    @yield('js')

</body>

</html>
