@extends('admin.app')
@section('title') Sản phẩm @endsection
@section('content')
@section('js')
<script src="{{asset('backend/assets/js/product.js') }}" ></script>
@endsection
<div class="app-title">
    <div>
      <h1>Quản lí sản phẩm</h1>
        <p>Xin chào {{Session::get('emp')->fullName}} </p>
    </div>
    <ul class="app-breadcrumb breadcrumb">

      <li class="breadcrumb-item"><i class="fa fa-home" aria-hidden="true"></i></li>
      <li class="breadcrumb-item"><a href="#">Quản lí sản phẩm</a></li>
    </ul>
</div>
<div class="row">
    <div class="col-sm-4  text-white">
        <a href="{{route('admin.product.create')}}" class="btn btn-primary">Tạo sản phẩm</a>

    </div>
</div>
<div class="container">
    <div class="d-flex bd-highlight mb-4">
        <div class="p-2 w-100 bd-highlight">
            <h2>Sản phẩm</h2>
        </div>
    
    </div>
    <div>
        <table class="table table-inverse">
            <thead>
                    <tr>
                        <th> Tên sản phẩm</th>
                        <th> Số lượng TK </th>
                        <th> Loại sản phẩm </th>
                        <th> Giá </th>
                        <th> Mô tả </th>
                        <th> Ảnh minh họa</th>
                        <th> Đơn vị tính</th>
                        <th>Ngày tạo </th>
                        <th>Trạng thái </th>
                        <th>Thao tác </th>
                        
                    </tr>
            </thead>
            <tbody id="todo-list" name="todo-list">
                @foreach ($data as $item)
                <tr id="todo{{$item->id}}">
                             <td> {{ $item->name }}</td>
                            <td> {{ $item->stock }}</td>
                            <td> {{ $item->type }}</td>
                            <td> {{ number_format( $item->price) }}đ</td>
                            <td> <span>{{ $item->description }}</span></td>

                            <td> <img src="{{$item->image}}"
                                    class="rounded" alt="Ảnh" width="70" height="70"> </td>
                            <td> {{ $item->unit }}</td>
                            <td> {{ $item->createDate }}</td>
                            <td> {{ $item->status }}</td>
                            <td id="">
                                <div class="btn-group">                     
                                    <a class="btn btn-primary" onclick="updateProduct({{$item->id}})" type="button"><i class="fa fa-lg fa-edit"></i></a>
                                    <a class="btn btn-primary" onclick="deleteProduct({{$item->id}})" ><i class="fa fa-lg fa-trash"></i></a>
                                </div>                              
                            </td>
                @endforeach
            </tbody>
        
        </table>
        <div style="margin:auto">
       
    </div>
</div>
<script>   
    function deleteProduct(id)
    {
        if(confirm("Bạn có chắc muốn xóa? "))
        {
            $.ajax({
                type: 'get',
                url: '/admin/products/delete/'+id,
                data: {
                    _token: $("input[name=_token]").val()
                },
                success: function (data) {
                    setTimeout(function () {
                    window.location.href = "products";
                    }, 200);
                     alert("Xóa thành công");
                },
                error: function (data) {
                    alert("Không thể xóa");
                }


            });
        }
    }
</script>

<script>   
    function updateProduct(id)
    {
        $.ajax({
           type:'put',
           url:'/admin/products/update/'+id,
           data: {
                    _token: $("input[name=_token]").val()
                },
                success: function (data) {
                   
                    
                },
               
        });
    }    
</script>
@endsection
