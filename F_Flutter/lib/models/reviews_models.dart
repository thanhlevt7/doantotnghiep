import 'dart:convert';

List<Review> reviewFromJson(String str) =>
    List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
  Review({
    this.id,
    this.userId,
    this.productId,
    this.image,
    this.content,
    this.quantity,
    this.postedDate,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.imageProduct,
    this.nameProduct,
    this.userName,
    this.avatar,
  });

  int id;
  int userId;
  int productId;
  String image;
  String content;
  int quantity;
  DateTime postedDate;
  int status;
  dynamic createdAt;
  dynamic updatedAt;
  String imageProduct;
  String nameProduct;
  String userName;
  String avatar;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        userId: json["userID"],
        productId: json["productID"],
        image: json["image"],
        content: json["content"],
        quantity: json["quantity"],
        postedDate: DateTime.parse(json["postedDate"]),
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        imageProduct: json["imageProduct"],
        nameProduct: json["nameProduct"],
        userName: json["userName"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "productID": productId,
        "image": image,
        "content": content,
        "quantity": quantity,
        "postedDate": postedDate.toIso8601String(),
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "imageProduct": imageProduct,
        "nameProduct": nameProduct,
        "userName": userName,
        "avatar": avatar,
      };
  @override
  String toString() {
    return toJson().toString();
  }
}
