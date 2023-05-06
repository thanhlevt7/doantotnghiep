// To parse this JSON data, do
//
//     final vouchers = vouchersFromJson(jsonString);

import 'dart:convert';

List<Vouchers> vouchersFromJson(String str) =>
    List<Vouchers>.from(json.decode(str).map((x) => Vouchers.fromJson(x)));

String vouchersToJson(List<Vouchers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Vouchers {
  Vouchers({
    this.id,
    this.code,
    this.productId,
    this.name,
    this.sale,
    this.startDate,
    this.endDate,
    this.limit,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String code;
  int productId;
  String name;
  int sale;
  DateTime startDate;
  DateTime endDate;
  int limit;
  int status;
  dynamic createdAt;
  dynamic updatedAt;

  factory Vouchers.fromJson(Map<String, dynamic> json) => Vouchers(
        id: json["id"],
        code: json["code"],
        productId: json["productID"],
        name: json["name"],
        sale: json["sale"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        limit: json["limit"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "productID": productId,
        "name": name,
        "sale": sale,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "limit": limit,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
  @override
  String toString() {
    return toJson().toString();
  }
}
