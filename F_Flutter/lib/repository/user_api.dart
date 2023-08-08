import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:fluter_19pmd/models/user_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

class RepositoryUser {
  static User info;
  static List<String> image = [];
  static String dataLogin;
  static String address;
  static String province;
  static String district;
  static String ward;
  static int otp;
  static int delay = 0;
  static int countAddress;
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
      Uri.parse('$hostDomainLocal/api/users/return-user/${info.id}'),
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
        await client.post(Uri.parse('$hostDomainLocal/api/users/login'),
            body: ({
              'email': email.text,
              'password': password.text,
            }));
    if (response.statusCode == 200) {
      dataLogin = response.body;
      info = userFromJson(response.body);
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
        await client.get(Uri.parse('$hostDomainLocal/api/users/logout'));
    if (response.statusCode == 200) {
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
        Uri.parse('$hostDomainLocal/api/users/editUser/${info.id}'),
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
        Uri.parse('$hostDomainLocal/api/users/editImage/${info.id}'),
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
        Uri.parse('$hostDomainLocal/api/users/register'),
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
        Uri.parse('$hostDomainLocal/api/users/create-Address'),
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
        .delete(Uri.parse('$hostDomainLocal/api/users/delete-address/$id'));
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

    var response =
        await client.post(Uri.parse('$hostDomainLocal/api/users/check/$email'),
            body: ({
              'email': email,
            }));
    if (response.statusCode == 200) {
      return 200;
    } else if (response.statusCode == 201) {
      return 201;
    } else {
      return 404;
    }
  }

  static Future changePassword(String email, String password) async {
    var client = http.Client();
    var response = await client.put(
        Uri.parse('$hostDomainLocal/api/users/change-Password/$email'),
        body: ({'password': password}));
    if (response.statusCode == 200) {
      return 200;
    } else if (response.statusCode == 201) {
      return 201;
    } else {
      return 404;
    }
  }

  static Future uploadFile(File image) async {
    final url =
        Uri.parse("https://api.cloudinary.com/v1_1/thanhlevt7/image/upload");
    var response = await http.post(url, body: {
      'file': 'data:image/png;base64,' + base64Encode(image.readAsBytesSync()),
      'upload_preset': "amdyfjvl",
    });
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      RepositoryUser.image.add(json['secure_url']);
    }
  }

  static Future sendEmail(String email, String template) async {
    final otp = Random().nextInt(899999) + 100000;
    RepositoryUser.otp = otp;
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    var response = await http.post(url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': template,
          'user_id': userId,
          'template_params': {
            'otp': otp,
            'user_name': 'name',
            'user_email': email,
          },
        }));

    if (response.statusCode == 200) {
      return 200;
    } else if (response.statusCode == 201) {
      return 201;
    } else {
      return 404;
    }
  }

  static Future countAddressForUser(int id) async {
    var client = http.Client();

    var response = await client.get(
      Uri.parse('$hostDomainLocal/api/users/count-Address/$id'),
    );
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      RepositoryUser.countAddress = (json['countAddressForUser']);
    }
  }

  static Future getProvinces() async {
    List<dynamic> provinces = [];
    var client = http.Client();
    final url = Uri.parse(
        "https://shopee.vn/api/v4/location/get_child_division_list?division_id=0&use_case=shopee.account");
    final response = await client.get(url);
    final json = jsonDecode((const Utf8Decoder().convert(response.bodyBytes)));
    final data = json['data']['divisions'];
    data.forEach((element) {
      provinces.add({"id": element['id'], "name": element['division_name']});
    });
    return provinces;
  }

  static Future getLocation(double latitude, double longitude) async {
    List province = [];
    var client = http.Client();
    final url = Uri.parse(
        "https://shopee.vn/api/v4/location/get_division_hierarchy_by_geo?lat=$latitude&lon=$longitude&useCase=shopee.account");
    var response = await client.get(url, headers: {'cookie': cookie});
    final json = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    if (json['data'] == null) {
      return null;
    } else {
      final data = json['data']['division_info_list'];

      data.forEach((e) {
        province.add(e['division_name']);
      });
      return province;
    }
  }

  static Future getDistricts(id) async {
    List districts = [];
    final url = Uri.parse(
        "https://shopee.vn/api/v4/location/get_child_division_list?division_id=$id&use_case=shopee.account");
    var client = http.Client();
    final response = await client.get(url);
    final json = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    final data = json['data']['divisions'];
    data.forEach((element) {
      districts.add({"id": element['id'], "name": element['division_name']});
    });
    return districts;
  }

  static Future getWards(id) async {
    List wards = [];
    final url = Uri.parse(
        "https://shopee.vn/api/v4/location/get_child_division_list?division_id=$id&use_case=shopee.account");
    var client = http.Client();
    final response = await client.get(url);
    final json = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    final data = json['data']['divisions'];
    data.forEach((element) {
      wards.add({"id": element['id'], "name": element['division_name']});
    });
    return wards;
  }

  static Future suggestAddress(String input) async {
    List suggest = [];
    var state = RepositoryUser.province;
    var district = RepositoryUser.district;
    var ward = RepositoryUser.ward;
    var client = http.Client();
    String sessiontoken = "a11ba2b3-v2a4-s2g2-ssw2-a2g2g4s3fs34";
    final url = Uri.parse(
        "https://shopee.vn/api/v4/geo/autocomplete?city=$district&components=$components&district=$ward&input=$input&sessiontoken=$sessiontoken&state=$state&use_case=shopee.account&v=3");
    final response = await client.get(url);
    final json = jsonDecode(response.body);
    final predictions = json['predictions'];
    if (response.statusCode == 200) {
      predictions.forEach((e) {
        suggest.add({
          "main_text": e['structured_formatting']['main_text'],
          "description": e['description'],
          "placeid": e['place_id']
        });
      });
      return suggest;
    }
    return null;
  }

  static Future location(String placeid, String experiment) async {
    var client = http.Client();
    String fields = "geometry";
    String group = "DS";
    String sessiontoken = "a11ba2b3-v2a4-s2g2-ssw2-a2g2g4s3fs34";
    final url = Uri.parse(
        "https://shopee.vn/api/v4/geo/details?components=$components&experiment=$experiment&fields=$fields&group=$group&placeid=$placeid&sessiontoken=$sessiontoken&use_case=shopee.account&v=3");
    final response = await client.get(url);
    final json = jsonDecode(response.body);
    return json['result']['geometry']['location'];
  }
}
