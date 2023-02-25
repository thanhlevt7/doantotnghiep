jQuery(document).ready(function ($) {
    //----- Open model CREATE -----//
    jQuery("#btn-add").click(function () {
        jQuery("#btn-add-new").val("add");
        jQuery("#myForm").trigger("reset");
        jQuery("#formModal").modal("show");
    });
    // CREATE
    $("#btn-add-new").click(function (e) {
        $.ajaxSetup({
            headers: {
                "X-CSRF-TOKEN": jQuery('meta[name="csrf-token"]').attr(
                    "content"
                ),
            },
        });
        e.preventDefault();
        var formData = {
            name: jQuery("#name").val(),
            price: jQuery("#price").val(),
            unit: jQuery("#unit").val(),
            description: jQuery("#description").val(),
            image: jQuery("#image").val(),
            stock: jQuery("#stock").val(),
            type: jQuery("#type").val(),
            status: 1,
        };
        var state = jQuery("#btn-add-new").val();
        var ajaxUrl = "products/create-product";

        $.ajax({
            type: "POST",
            url: ajaxUrl,
            data: formData,
            dataType: "json",
            success: function (data) {
                var todo =
                    '<tr id="todo' +
                    data.id +
                    '"><td>' +
                    data.name +
                    "</td><td>" +
                    data.stock +
                    "</td><td> " +
                    data.type +
                    "</td> <td>" +
                    data.price +
                    "</td> <td> <span> " +
                    data.description +
                    '</span></td><td><img src="' +
                    data.image +
                    '"class="rounded" alt="Ảnh" width="70" height="70"> </td><td>' +
                    data.unit +
                    "</td><td>" +
                    data.status +
                    '</td> <td><div class="btn-group"><a class="btn btn-primary" href="#"><i class="fa fa-lg fa-edit"></i></a><a class="btn btn-primary"href=""><i class="fa fa-lg fa-trash"></i></a></div></td>';
                if (state == "add") {
                    jQuery("#todo-list").append(todo);
                }
                setTimeout(function () {
                    window.location.href = "products";
                }, 200);
                jQuery("#myForm").trigger("reset");
                jQuery("#formModal").modal("hide");
            },
            error: function (data) {
                console.log(data);
            },
        });
    });

    //Delete
    $("#btn-delete-product").click(function (e) {
        $.ajaxSetup({
            headers: {
                "X-CSRF-TOKEN": jQuery('meta[name="csrf-token"]').attr(
                    "content"
                ),
            },
        });
         e.preventDefault();
        var ajaxUrl = "products/delete";
        if (confirm('Bạn có chắc muốn xóa không? ')) {
            $.ajax({
                type: "get",
                url: ajaxUrl,
                dataType: "json",
                data: {
                    id: jQuery("#id").val(),
                },
                success: function (data) {
                    alert("Xóa thành công");
                    jQuery("#todo-list").html(data);
                    window.location.reload();
                },
                error: function (data) {
                    alert("Xóa thất bại");
                }


            });
        }

    });
});
