// To parse this JSON data, do
//
//     final Notifications = NotificationsFromJson(jsonString);

import 'dart:convert';

List<Notifications> notificationsFromJson(String str) =>
    List<Notifications>.from(
      json.decode(str).map(
            (x) => Notifications.fromJson(x),
          ),
    );

String notificationsToJson(List<Notifications> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notifications {
  Notifications({
    this.id,
    this.title,
    this.userId,
    this.content,
    this.image,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String title;
  dynamic userId;
  String content;
  String image;
  DateTime startDate;
  DateTime endDate;
  dynamic createdAt;
  dynamic updatedAt;

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        id: json["id"],
        title: json["title"],
        userId: json["userID"],
        content: json["content"],
        image: json["image"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "userID": userId,
        "content": content,
        "image": image,
        "startDate": startDate,
        "endDate": endDate,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
