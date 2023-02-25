import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.username,
    this.fullName,
    this.email,
    this.password,
    this.phone,
    this.avatar,
    this.status,
    this.emailVerifiedAt,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
    this.address,
  });

  int id;
  String username;
  String fullName;
  String email;
  String password;
  String phone;
  String avatar;
  int status;
  dynamic emailVerifiedAt;
  String rememberToken;
  dynamic createdAt;
  dynamic updatedAt;
  List<Address> address;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        fullName: json["fullName"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        avatar: json["avatar"],
        status: json["status"],
        emailVerifiedAt: json["email_verified_at"],
        rememberToken: json["remember_token"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        address:
            List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "fullName": fullName,
        "email": email,
        "password": password,
        "phone": phone,
        "avatar": avatar,
        "status": status,
        "email_verified_at": emailVerifiedAt,
        "remember_token": rememberToken,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "address": List<dynamic>.from(address.map((x) => x.toJson())),
      };
  @override
  String toString() {
    return toJson().toString();
  }
}

class Address {
  Address({
    this.id,
    this.name,
  });

  int id;
  String name;
  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
  @override
  String toString() {
    return toJson().toString();
  }
}
