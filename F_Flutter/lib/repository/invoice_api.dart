import 'dart:convert';

import 'package:fluter_19pmd/models/invoices_models.dart';
import 'package:fluter_19pmd/repository/cart_api.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/repository/voucher_api.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

class RepositoryInvoice {
  static var getInvoiceID;
  static String url = "";
  static String orderId;
  static String getAddress;
  static String paymentMethodSelected = "0";
  static double heightMyOrder() {
    double dem = 0;
    for (var i = 1; i <= RepositoryCart.cartClient[0].products.length; i++) {
      dem += 0.13;
    }
    return dem;
  }

  static int total(int quantity, int price) {
    return quantity * price + 20000 - RepositoryVoucher.sale;
  }

  static Future<dynamic> payment() async {
    var client = http.Client();

    var response = await client.put(
      Uri.parse(
          '$hostDomainLocal/api/invoices/payment/${RepositoryCart.cartClient[0].id}'),
      body: ({
        'address': getAddress,
        'total': (RepositoryCart.totalMoney).toString(),
        'isPaid': paymentMethodSelected.toString(),
      }),
    );

    if (response.statusCode == 200) {
      RepositoryCart.cartClient = [];
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  static Future<dynamic> buynow(
      var total, var productId, var quantity, paymentMethodSelected) async {
    var client = http.Client();
    var response = await client.post(
      Uri.parse('$hostDomainLocal/api/invoices/buynow'),
      body: ({
        'total': total.toString(),
        'shippingName': RepositoryUser.info.fullName,
        'shippingPhone': RepositoryUser.info.phone,
        'shippingAddress': getAddress,
        'dateCreated': DateTime.now().toString(),
        'productID': productId.toString(),
        'quantity': quantity.toString(),
        'userID': RepositoryUser.info.id.toString(),
        'isPaid': paymentMethodSelected.toString(),
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return 200;
    } else {
      return response.statusCode;
    }
  }

  static Future<List<Invoices>> orderHistory() async {
    var client = http.Client();

    var response = await client.get(
      Uri.parse(
          '$hostDomainLocal/api/invoices/getInvoiceSuccess/${RepositoryUser.info.id}'),
    );
    if (response.statusCode == 200) {
      List<Invoices> invoices;
      var jsonString = response.body;
      invoices = invoicesFromJson(jsonString);

      return invoices;
    }
    return null;
  }

  static Future<List<Invoices>> waitingToAccept() async {
    var client = http.Client();

    var response = await client.get(
      Uri.parse(
          '$hostDomainLocal/api/invoices/getWaitingToAccept/${RepositoryUser.info.id}'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var invoices = invoicesFromJson(jsonString);

      return invoices;
    } else {
      return null;
    }
  }

  static Future<List<Invoices>> notYetRated() async {
    var client = http.Client();
    List<Invoices> invoices;

    var response = await client.get(
      Uri.parse(
          '$hostDomainLocal/api/invoices/notYetRated/${RepositoryUser.info.id}'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      invoices = invoicesFromJson(jsonString);

      return invoices;
    }
    return null;
  }

  static Future<List<Invoices>> pickingUpGoods() async {
    var client = http.Client();
    List<Invoices> invoices;

    var response = await client.get(
      Uri.parse(
          '$hostDomainLocal/api/invoices/getPickingUpGood/${RepositoryUser.info.id}'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      invoices = invoicesFromJson(jsonString);

      return invoices;
    }
    return null;
  }

  static Future<List<Invoices>> getOnDelivery() async {
    var client = http.Client();
    List<Invoices> invoices;

    var response = await client.get(
      Uri.parse(
          '$hostDomainLocal/api/invoices/getOnDelivery/${RepositoryUser.info.id}'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      invoices = invoicesFromJson(jsonString);

      return invoices;
    }
    return null;
  }

  static Future<List<Invoices>> getCancelOrder() async {
    var client = http.Client();
    List<Invoices> invoices;

    var response = await client.get(
      Uri.parse(
          '$hostDomainLocal/api/invoices/getCancelOrder/${RepositoryUser.info.id}'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      invoices = invoicesFromJson(jsonString);

      return invoices;
    }
    return null;
  }

  static Future<dynamic> cancelOrder(String id) async {
    var client = http.Client();

    var response = await client.delete(
      Uri.parse('$hostDomainLocal/api/invoices/CancelOrder/$id'),
    );
    if (response.statusCode == 200) {
      return 200;
    } else {
      return 201;
    }
  }

  static Future<Invoices> orderDetails() async {
    var client = http.Client();

    var response = await client.get(
      Uri.parse('$hostDomainLocal/api/invoices/order-details/$getInvoiceID'),
    );
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var invoice = invoiceFromJson(jsonData);

      return invoice;
    }
    return throw Exception("Lỗi");
  }

  static paymentMomo() async {
    var client = http.Client();

    var response = await client.get(
      Uri.parse('$hostDomainLocal/api/invoices/paymentMomo'),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      url = data["payUrl"];
      orderId = data["orderId"];
      return 200;
    }
    return throw Exception("Lỗi");
  }

  static paymentAtm() async {
    var client = http.Client();

    var response = await client.get(
      Uri.parse('$hostDomainLocal/api/invoices/paymentAtm'),
    );
    print(response.body);
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      url = data["payUrl"];
      orderId = data["orderId"];
      return 200;
    }
    return throw Exception("Lỗi");
  }

  static checkPayment(String id) async {
    var client = http.Client();

    var response = await client.get(
      Uri.parse('$hostDomainLocal/api/invoices/checkPayment/$id'),
    );
    if (response.body.isNotEmpty) {
      var data = jsonDecode(response.body);
      if (data["message"] == "Thành công.") {
        return 200;
      } else if (response.statusCode == 201) {
        return throw Exception("Lỗi");
      }
    }
  }
}
