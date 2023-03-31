import 'dart:convert';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:http/http.dart' as http;

class RepositoryVoucher {
  static int sale = 0;

  static Future<dynamic> checkVoucher(String voucher) async {
    var client = http.Client();
    var reponse = await client.post(
        Uri.parse(
            'http://10.0.2.2:8000/api/vouchers/check-voucher/${RepositoryUser.info.id}'),
        body: ({'code': voucher}));
    print(reponse.statusCode);
    if (reponse.statusCode == 200) {
      final data = jsonDecode(reponse.body);
      sale = data;
      return 200;
    } else if (reponse.statusCode == 202) {
      return 202;
    } else {
      return 201;
    }
  }
}
