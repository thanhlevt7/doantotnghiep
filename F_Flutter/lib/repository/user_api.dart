import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:fluter_19pmd/models/user_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  static String serviceId = 'service_yed4dhz';
  static String templateRegister = 'template_tmzua9o';
  static String templateForgot = 'template_zirzlbc';
  static String userId = 'MsE9IzXWqJEcqdVgd';
  static String cookie =
      "__LOCALE__null=VN; _gcl_au=1.1.1858533460.1683281844; _fbp=fb.1.1683281844519.2031783287; csrftoken=3coMs7dbsCsFq3CM85uRvloH8tsBsP5Y; SPC_SI=q2dHZAAAAABKWXJ1d1ljMwAEEgAAAAAAZ3JyQk94QVA=; SPC_F=eB0IBNmVn2HDzRZf67932sxdr3i2sxol; REC_T_ID=07be9953-eb2e-11ed-beed-2cea7f9dcc6b; _QPWSDCXHZQA=e428f455-597b-46f4-e34a-b87683856f42; _hjFirstSeen=1; _hjSession_868286=eyJpZCI6ImRmOTk3MzE3LTJhMWEtNGRiOC1hMDVjLTFjZTMxMzBlMWI2ZSIsImNyZWF0ZWQiOjE2ODMyODE4NTAwNjYsImluU2FtcGxlIjpmYWxzZX0=; _hjAbsoluteSessionInProgress=0; AMP_TOKEN=%24NOT_FOUND; _gid=GA1.2.1337360275.1683281851; SPC_CLIENTID=ZUIwSUJObVZuMkhEfsxzeeuwkzwnjqrs; _hjSessionUser_868286=eyJpZCI6IjBiY2U5MmU1LTBmNWMtNWM3NS05MTJlLTQzOWY3ZjFmMzZjNyIsImNyZWF0ZWQiOjE2ODMyODE4NTAwNTYsImV4aXN0aW5nIjp0cnVlfQ==; fblo_421039428061656=y; _ga=GA1.1.1267620568.1683281850; _dc_gtm_UA-61914164-6=1; shopee_webUnique_ccd=P8Nz6%2BhnTRoq03piBddEHw%3D%3D%7CemDeiDuc1wm0pah78CLGt6INLOhkyY%2BMNG35Xz8FvQzIkwju%2BXGxhz4xLHsDZGMzmnp76gu82zVUVeLEtyrEy7OSQNJYTXwhuxg%3D%7CJZ%2BsjYNLL2A4llbb%7C06%7C3; ds=f5e1f7f61a5ba93f82a39dbe47c6f935; SPC_ST=.am4wYUJsZGhscEF2aVZId3n2ZC/lNXtmyihnsE6WG5q2apV0IEtEBZ/mNPRRrr5TcM5qclP3y3p9QT7qzCCKWca/3AiIyCvAjGjqTwPhDP0YaWV/2HubZYa5Jeq2yi5pI7BmZPwPgTnuI/vKM7ikIlpkekKX2vBGn/ZpdZpqKBKq0DRmGds1pLkPUpqTqWQjwOYTQtxmr/AFquXtsr7jpA==; _ga_M32T05RVZT=GS1.1.1683281849.1.1.1683283093.54.0.0; SPC_U=953323022; SPC_T_IV=ZXR4VmJlWmdaRzNSdmJDdw==; SPC_EC=RTFTUlRaVUtnRjNPYldPYuQxx5W+Z18ABgRGrXRtrrz/qq3J6vIdG4oBrgQE0RAcZ5ka7q5X80sYreOG5nhdO2Ba8xQyx1oHuESOnkrC3cWc6j7yK3ybFa6XQuRbnAGFyO342Ue4fbkrpGhUOhZqEk82WefUNHntVW4hGV/kzoY=; SPC_R_T_ID=nvXEZrgArkaJ0uzF8Y7Z0QqNjMmWBObYZQqQ7uM9YAq18pdkeKqCHddf06EdI+mUuwvt3tpGlosU+k02FXr+jNZgQq1kQohTRpCXEcKcuny4YXndTzkRqeBZpDi/FLRWezmi37yayGs0gg4JjJpW/7m7dCx6C824QccqyqrVTGo=; SPC_R_T_IV=ZXR4VmJlWmdaRzNSdmJDdw==; SPC_T_ID=nvXEZrgArkaJ0uzF8Y7Z0QqNjMmWBObYZQqQ7uM9YAq18pdkeKqCHddf06EdI+mUuwvt3tpGlosU+k02FXr+jNZgQq1kQohTRpCXEcKcuny4YXndTzkRqeBZpDi/FLRWezmi37yayGs0gg4JjJpW/7m7dCx6C824QccqyqrVTGo=; useragent=TW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzExMy4wLjAuMCBTYWZhcmkvNTM3LjM2; _uafec=Mozilla%2F5.0%20(Windows%20NT%2010.0%3B%20Win64%3B%20x64)%20AppleWebKit%2F537.36%20(KHTML%2C%20like%20Gecko)%20Chrome%2F113.0.0.0%20Safari%2F537.36; ";
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
        await client.get(Uri.parse('http://10.0.2.2:8000/api/users/logout'));
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
          'service_id': RepositoryUser.serviceId,
          'template_id': template,
          'user_id': RepositoryUser.userId,
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
      Uri.parse('http://10.0.2.2:8000/api/users/count-Address/$id'),
    );
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      RepositoryUser.countAddress = (json['countAddressForUser']);
    }
  }
}
