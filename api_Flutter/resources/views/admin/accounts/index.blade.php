@extends('admin.app')
@section('title') Tài khoản người dùng @endsection
@section('content')
<div class="app-title">
    <div>
        <h1>Quản lí tài khoản</h1>
        <p>Xin chào {{Session::get('emp')->fullName}} </p>
    </div>
    <ul class="app-breadcrumb breadcrumb">

        <li class="breadcrumb-item"><i class="fa fa-home" aria-hidden="true"></i></li>
        <li class="breadcrumb-item"><a href="#">Quản lí tài khoản</a></li>
    </ul>
</div>
<div class="page-wrapper">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

    <div class="row">
        <div class="col-sm-4  text-white">
        </div>
        <div class="col-sm-4 text-white">
            <form class="d-flex" method="GET" action="{{ route('admin.account.search') }}">
                <input class="form-control me-2" name="keyWord" type="text" placeholder="Search">
                <button class="btn btn-primary" type="submit">Tìm kiếm</button>
            </form>
        </div>

    </div>
</div>
<div class="container-fluid">
    <div class="container mt-3">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên hiển thị</th>
                    <th>Email</th>
                    <th>Họ tên</th>
                    <th>Ảnh</th>
                    <th>Số điện thoại</th>
                    <th>Loại tài khoản</th>
                    <th>Thao tác</th>

                </tr>
            </thead>
            <tbody>
                @foreach ($data as $item)
                <tr>
                    <td> {{ $item->id }}</td>
                    <td> {{ $item->username }}</td>
                    <td> {{ $item->email }}</td>
                    <td> {{ $item->fullName }}</td>
                    <td> <img src="{{$item->avatar}}" class="rounded" alt="Ảnh" width="70" height="70"> </td>
                    <td> {{ $item->phone }}</td>
                    <td> {{ $item->type }}</td>


                    <td id="">
                        <div class="btn-group">
                            <a href="{{ url('/admin/account/view/' . $item->id) }}" class="btn btn-primary" type="button"><i class="fa fa-eye"></i></a>
                            <div class="btn-group">
                                @if($item->type=='user')
                                @if($item->status==-1)
                                <a class="btn btn-primary" href="{{route('admin.account.unLockUser',$item->id)}}">
                                    <i class="fa fa-unlock"></i>
                                </a>
                                @endif
                                @if($item->status!=-1)
                                <a class="btn btn-primary" href="{{route('admin.account.lockUser',$item->id)}}">
                                    <i class="fa fa-lock"></i>
                                </a>
                                @endif
                                @endif

                            </div>


                        </div>
                    </td>



                </tr>
                @endforeach
            </tbody>
        </table>
        {{ $data->links() }}
    </div>
</div>
</div>
</div>


@endsection