import 'dart:convert';
import 'package:fluter_19pmd/models/user_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RepositoryUser {
  static User info;
  static String address;
  static String province;
  static String district;
  static String ward;
  static int otp;
  static double getHeightAddress() {
    double dem = 0;
    for (var i = 0; i < info.address.length; i++) {
      dem += 50;
    }
    return dem;
  }

  static Future<User> fetchUserOnline() async {
    var client = http.Client();
    var response = await client.get(
      Uri.parse('http://10.0.2.2:8000/api/users/return-user/${info.id}'),
    );
    if (response.statusCode == 200) {
      var user = userFromJson(response.body);
      info = user;
      return user;
    } else {
      throw Exception("............................");
    }
  }

  static Future<dynamic> login(
      TextEditingController email, TextEditingController password) async {
    var client = http.Client();

    var response =
        await client.post(Uri.parse('http://10.0.2.2:8000/api/users/login'),
            body: ({
              'email': email.text,
              'password': password.text,
            }));
    if (response.statusCode == 200) {
      info = userFromJson(response.body);
      if (info.fullName.isEmpty) {
        info.fullName = "1";
      }
      return 200;
    } else if (response.statusCode == 201) {
      return 201;
    } else {
      return 404;
    }
  }

  static Future<dynamic> logout(context) async {
    var client = http.Client();
    var response =
        await client.get(Uri.parse('http://10.0.2.2:8000/api/users/logout'));
    if (response.statusCode == 200) {
      await Future.delayed(const Duration(seconds: 2));
      info = User();
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  static Future<dynamic> updateAccount(
      String username, String fullName, String phone) async {
    var client = http.Client();

    var response = await client.put(
        Uri.parse('http://10.0.2.2:8000/api/users/editUser/${info.id}'),
        body: ({
          'username': username,
          'fullName': fullName,
          'phone': phone,
        }));

    if (response.statusCode == 200) {
      return "Đã chỉnh sửa thông tin";
    } else if (response.statusCode == 201) {
      return "Email đã tồn tại";
    } else {
      return "Chỉnh sửa thất bại";
    }
  }

  static Future<dynamic> updateImage(String image) async {
    var client = http.Client();

    var response = await client.put(
        Uri.parse('http://10.0.2.2:8000/api/users/editImage/${info.id}'),
        body: ({
          'image': image,
        }));

    if (response.statusCode == 200) {
      return 200;
    }
  }

  static Future register(String email, String password, String displayname,
      String fullname, String phone) async {
    var client = http.Client();
    var response = await client.post(
        Uri.parse('http://10.0.2.2:8000/api/users/register'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          'email': email,
          'password': password,
          'username': displayname,
          'fullname': fullname,
          'phone': phone,
        }));
    if (response.statusCode == 200) {
      return 200;
    } else if (response.statusCode == 201) {
      return 201;
    } else {
      return 404;
    }
  }

  static Future createAddress(String name) async {
    var client = http.Client();
    var response = await client.post(
        Uri.parse('http://10.0.2.2:8000/api/users/create-Address'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          'name': name,
          'userID': info.id,
        }));
    if (response.statusCode == 200) {
      return 200;
    } else if (response.statusCode == 201) {
      return 201;
    } else {
      return 404;
    }
  }

  static Future deleteAddress(int id) async {
    var client = http.Client();
    var response = await client
        .delete(Uri.parse('http://10.0.2.2:8000/api/users/delete-address/$id'));
    if (response.statusCode == 200) {
      return 200;
    } else if (response.statusCode == 201) {
      return 201;
    } else {
      return 404;
    }
  }

  static Future check(String email) async {
    var client = http.Client();

    var response = await client.post(
        Uri.parse('http://10.0.2.2:8000/api/users/check/$email'),
        body: ({
          'email': email,
        }));
    if (response.statusCode == 200) {
      return "Email tồn tại";
    } else if (response.statusCode == 201) {
      return "Email không tồn tại";
    } else {
      return 404;
    }
  }

  static Future changePassword(String email, String password) async {
    var client = http.Client();
    var response = await client.put(
        Uri.parse('http://10.0.2.2:8000/api/users/change-Password/$email'),
        body: ({'password': password}));
    if (response.statusCode == 200) {
      return 200;
    } else if (response.statusCode == 201) {
      return 201;
    } else {
      return 404;
    }
  }
}