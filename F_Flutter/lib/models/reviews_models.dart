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
    this.fullName,
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
  String fullName;
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
        fullName: json["fullName"],
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
        "fullName": fullName,
        "avatar": avatar,
      };
  @override
  String toString() {
    return toJson().toString();
  }
}
