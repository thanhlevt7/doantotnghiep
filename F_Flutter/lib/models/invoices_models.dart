// To parse this JSON data, do
//
//     final invoices = invoicesFromJson(jsonString);

import 'dart:convert';

Invoices invoiceFromJson(String str) => Invoices.fromJson(json.decode(str));

String invoiceToJson(Invoices data) => json.encode(data.toJson());

List<Invoices> invoicesFromJson(String str) =>
    List<Invoices>.from(json.decode(str).map((x) => Invoices.fromJson(x)));

String invoicesToJson(List<Invoices> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Invoices {
  Invoices({
    this.id,
    this.userId,
    this.employeeId,
    this.shippingName,
    this.shippingAddress,
    this.shippingPhone,
    this.total,
    this.dateCreated,
    this.isPaid,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  String id;
  int userId;
  dynamic employeeId;
  String shippingName;
  dynamic shippingAddress;
  String shippingPhone;
  int total;
  DateTime dateCreated;
  int isPaid;
  int status;
  dynamic createdAt;
  dynamic updatedAt;
  List<Cart> products;

  factory Invoices.fromJson(Map<String, dynamic> json) => Invoices(
        id: json["id"],
        userId: json["userID"],
        employeeId: json["employeeID"],
        shippingName: json["shippingName"],
        shippingAddress: json["shippingAddress"],
        shippingPhone: json["shippingPhone"],
        total: json["total"],
        dateCreated: DateTime.parse(json["dateCreated"]),
        isPaid: json["isPaid"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        products:
            List<Cart>.from(json["products"].map((x) => Cart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "employeeID": employeeId,
        "shippingName": shippingName,
        "shippingAddress": shippingAddress,
        "shippingPhone": shippingPhone,
        "total": total,
        "dateCreated": dateCreated.toIso8601String(),
        "isPaid": isPaid,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
  @override
  String toString() {
    return toJson().toString();
  }
}

class Cart {
  Cart({
    this.id,
    this.name,
    this.price,
    this.stock,
    this.type,
    this.unit,
    this.description,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.quantity,
  });

  int id;
  String name;
  int price;
  int stock;
  String type;
  String unit;
  String description;
  String image;
  int status;
  dynamic createdAt;
  dynamic updatedAt;
  int quantity;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        stock: json["stock"],
        type: json["type"],
        unit: json["unit"],
        description: json["description"],
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "stock": stock,
        "type": type,
        "unit": unit,
        "description": description,
        "image": image,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "quantity": quantity,
      };
  @override
  String toString() {
    return toJson().toString();
  }
}
