// To parse this JSON data, do
//
//     final favorites = favoritesFromJson(jsonString);

import 'dart:convert';

import 'package:fluter_19pmd/models/product_models.dart';

List<Favorites> favoritesFromJson(String str) =>
    List<Favorites>.from(json.decode(str).map((x) => Favorites.fromJson(x)));

String favoritesToJson(List<Favorites> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Favorites {
  Favorites({
    this.id,
    this.userId,
    this.title,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  int id;
  int userId;
  String title;
  dynamic createdAt;
  dynamic updatedAt;
  List<Product> products;

  factory Favorites.fromJson(Map<String, dynamic> json) => Favorites(
        id: json["id"],
        userId: json["userID"],
        title: json["title"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        products: json["products"] == null
            ? null
            : List<Product>.from(
                json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "title": title,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "products": products == null
            ? null
            : List<dynamic>.from(products.map((x) => x.toJson())),
      };
  @override
  String toString() {
    return toJson().toString();
  }
}
