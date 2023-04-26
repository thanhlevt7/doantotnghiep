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
  static int delay;
  static int countAddress;
  static String serviceId = 'service_yed4dhz';
  static String templateRegister = 'template_tmzua9o';
  static String templateForgot = 'template_zirzlbc';
  static String userId = 'MsE9IzXWqJEcqdVgd';
  static String cookie =
      "__LOCALE__null=VN; csrftoken=Pm5L1NDxla1hd6p1AP6PqOMdt1FO8eSp; SPC_SI=u0k+ZAAAAABDWmE3T0VJS5cUowEAAAAAT1RSb3lDYmc=; _gcl_au=1.1.874773339.1682322138; SPC_F=r5MqTFiu8W2y8vb5cpfpT9g4ykkNyzke; REC_T_ID=89f290ad-e273-11ed-be9c-9440c93e45e8; _fbp=fb.1.1682322138380.121315920; _QPWSDCXHZQA=a363ce13-b7e0-4515-e1c0-d3810432d207; _hjFirstSeen=1; _hjIncludedInSessionSample_868286=0; _hjSession_868286=eyJpZCI6ImYzOWFlZGE3LWE4YjUtNDUzYy1hNGE0LWRjMTcxZjRkOTM4MSIsImNyZWF0ZWQiOjE2ODIzMjIxNDAyNTEsImluU2FtcGxlIjpmYWxzZX0=; _hjAbsoluteSessionInProgress=0; AMP_TOKEN=%24NOT_FOUND; _gid=GA1.2.1793482190.1682322141; _dc_gtm_UA-61914164-6=1; SPC_CLIENTID=cjVNcVRGaXU4VzJ5imjkavkkjuvjwixd; SPC_ST=.THFlamliS3g5U0JGdXB1Vgt5rnZPRYC83AcLZN0bm6dw09YsR3hNQIh50Dd7WxSLluGzYjEqcXhuFonKNSU3zOFv7IYrqY6hU/ogzo3nHV3ur72AGcRZX/XVmmDMJH4vf3nhz4/lDTybLwAA3KkrhkxFj9ePlPdxXuKhHX4A4surcDS/tmjm0lmJOXgiOYIjUrzIlWXDIDYOZsZnVXSp7Q==; SPC_U=953323022; SPC_R_T_ID=BgCEgqdHbeozTEAwcHPcDuUXK4QyPF8AaaXGmGYLmBFYwUaygxasJf68FEaZlxDycSJ/NlZFgEt56Ikx++MxA3HmVdFR+qpNQgpHzuuC2MppXChVyTSlzx6Dgxiu6YDtbezWrweQzk7LO8F0E+GKiUsG8k1tjZBsHy9nzk6xWWw=; SPC_R_T_IV=RXpJN053ZjJhbEtVbmxYWA==; SPC_T_ID=BgCEgqdHbeozTEAwcHPcDuUXK4QyPF8AaaXGmGYLmBFYwUaygxasJf68FEaZlxDycSJ/NlZFgEt56Ikx++MxA3HmVdFR+qpNQgpHzuuC2MppXChVyTSlzx6Dgxiu6YDtbezWrweQzk7LO8F0E+GKiUsG8k1tjZBsHy9nzk6xWWw=; SPC_T_IV=RXpJN053ZjJhbEtVbmxYWA==; shopee_webUnique_ccd=dpGkFHtLfmgZ6u7fzWrX9w%3D%3D%7Ce3sXtWfNP0cSmie%2FQLDPSXojvu9cSdUc25m5soWLeyw9qMEHEET%2Fh2j3Tu4A4h7IR4mUlZdpLvH4XK%2Fm3nEQ%2FFVWLCl3md2IiQ%3D%3D%7CL9Rd3LJ56qVKvA%2Bx%7C06%7C3; ds=30c7f6dc886eedd20857096b796ae57a; _ga_M32T05RVZT=GS1.1.1682322140.1.1.1682322181.19.0.0; _ga=GA1.1.782243779.1682322140; _hjSessionUser_868286=eyJpZCI6ImQyOTc2N2E3LTU2YzEtNWU0OC1iZmI5LWU5MDc0OTljM2FlOSIsImNyZWF0ZWQiOjE2ODIzMjIxNDAyNDQsImV4aXN0aW5nIjp0cnVlfQ==; SPC_EC=clU4b255d1N6bUN0djBqS+avQL0urX/wleSkZhfBR14MFtSmyuL4o3V6iyJoPDgPf5RbBKtvPh71DZ8d0Qs8Etq0tvkIghltaH9MrY7Mfti+jeflgJPR5h+CHcsjHy9olLdcYkdAxEMEqjLLuqd5AnYFsQ54oxTl8MWwEV9rlT4=; useragent=TW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzExMi4wLjAuMCBTYWZhcmkvNTM3LjM2; _uafec=Mozilla%2F5.0%20(Windows%20NT%2010.0%3B%20Win64%3B%20x64)%20AppleWebKit%2F537.36%20(KHTML%2C%20like%20Gecko)%20Chrome%2F112.0.0.0%20Safari%2F537.36; ";
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
