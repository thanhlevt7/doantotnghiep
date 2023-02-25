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
  //thay đổi cookie theo tài khoản shopee của bạn
  static String cookie =
      "__LOCALE__null=VN; _gcl_au=1.1.208634703.1676357535; _fbp=fb.1.1676357534780.1803812968; csrftoken=50m4Wbf2Ro6YdjGigPvoYoy5Kq1rWFDZ; SPC_SI=g3C+YwAAAABOTjVONGxQepZ3/gEAAAAAQmdwa2xDamc=; SPC_F=gkQxu79cr8xfmczafKo3FedFKd20VTAX; REC_T_ID=20631daf-ac34-11ed-8e13-0ecc5b6a0085; AMP_TOKEN=%24NOT_FOUND; _gid=GA1.2.1318147336.1676357549; _QPWSDCXHZQA=32c34031-4d28-476f-c923-d6e571934a5e; SPC_CLIENTID=Z2tReHU3OWNyOHhmsitcutpiagxsoyal; SPC_U=953323022; SPC_R_T_ID=fyawPRtWoWs+CNwgLvjsW+WHA13w1JCHZu3+Q8m/2gYNGFy94aBlcF3WKd3Ehudwi7bnCBycJZ5iLj8SVkdZ90uwocTQqACXEm1RUd6h1S/XF817AsmZ+fhhO1sPuq5XoxOVhJh/SMOAEA5GoiUtGNCGBlK8B4uyEi5IVWe5KSE=; SPC_R_T_IV=a2Y0akdadWVkZTBaMElKMw==; SPC_T_ID=fyawPRtWoWs+CNwgLvjsW+WHA13w1JCHZu3+Q8m/2gYNGFy94aBlcF3WKd3Ehudwi7bnCBycJZ5iLj8SVkdZ90uwocTQqACXEm1RUd6h1S/XF817AsmZ+fhhO1sPuq5XoxOVhJh/SMOAEA5GoiUtGNCGBlK8B4uyEi5IVWe5KSE=; SPC_T_IV=a2Y0akdadWVkZTBaMElKMw==; _hjFirstSeen=1; _hjIncludedInSessionSample_868286=0; _hjSession_868286=eyJpZCI6ImRhZWRjMGI5LWY1NDUtNDMzNy04MGZiLTYzOTNjNDkwMTdmNyIsImNyZWF0ZWQiOjE2NzYzNTc2MzgyMTAsImluU2FtcGxlIjpmYWxzZX0=; _hjAbsoluteSessionInProgress=0; _hjSessionUser_868286=eyJpZCI6ImRiMDU5NWNmLTZhZGQtNWJmYS05OTYzLTk3YWI2OGVmYmYwZCIsImNyZWF0ZWQiOjE2NzYzNTc2MzgxODksImV4aXN0aW5nIjp0cnVlfQ==; _dc_gtm_UA-61914164-6=1; SPC_ST=.dHNHcVdvRGpibzNYVG9rd2hHjJnkRz1VfVMdk7iHiZgELmvn5JlLLI84wZPSUtMo5DzcD5YqeK102pVJe77Ru+04A6xHrGWzmdlZM16p1FVDcL/hUrCvoe+7+HQ0T1WaY5Vm8FM6FS6bVxROMETVwSN9OspUalV7X6mD+tQQW9Qdcyde1E+tSZNK9ApHVkHHLdPC0ZkIyaeweq1vhNWwgA==; _ga_M32T05RVZT=GS1.1.1676357548.1.1.1676358027.56.0.0; _ga=GA1.1.1469132214.1676357549; shopee_webUnique_ccd=8GUJU87g2%2BDojEKjH2i2Fw%3D%3D%7CtWdD8i94G61ZslZ%2FdNjHgjx2ASwyAkkH9k6mNz5NicFamAGdSExGJ51jwK8SWYZ%2FY8DGUNBOH9v33zv30gwxr2jinJUhnPQrb0k%3D%7CVaEs1qgO9wpLNORu%7C06%7C3; ds=0006fe4854bd7c3bd243a924c1c0bde8; SPC_EC=T1l6cUZGbTNEeFdNaUdFWe8Q8Je+UL/oInKg23x4dWbLrFlOJ1aUvHSaquxdMd7WIZ4QK/sm41GoFTbsUM4e+VM3MdHBjn1IAoRlRaZDVt7uWcOyo//+fq8NQojWkZqPAmLevrZozMIYQtKNJfP03TeLKXgTSptQHdMrZs3ZvW0=; useragent=TW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzExMC4wLjAuMCBTYWZhcmkvNTM3LjM2; _uafec=Mozilla%2F5.0%20(Windows%20NT%2010.0%3B%20Win64%3B%20x64)%20AppleWebKit%2F537.36%20(KHTML%2C%20like%20Gecko)%20Chrome%2F110.0.0.0%20Safari%2F537.36; ";
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
