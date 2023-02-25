import 'dart:convert';
import 'package:http/http.dart' as http;

class RepositoryVoucher {
  static int sale = 0;

  static Future<dynamic> checkVoucher(String voucher) async {
    var client = http.Client();
    var reponse = await client.post(
        Uri.parse('http://10.0.2.2:8000/api/vouchers/check-voucher'),
        body: ({'code': voucher}));
    if (reponse.statusCode == 200) {
      final data = jsonDecode(reponse.body);
      sale = data[0]['sale'];
      return 200;
    } else {
      return 201;
    }
  }
}
