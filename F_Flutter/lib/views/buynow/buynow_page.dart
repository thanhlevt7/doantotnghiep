import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/repository/voucher_api.dart';
import 'package:fluter_19pmd/views/buynow/widgets/body.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/product_models.dart';
import '../../repository/invoice_api.dart';

class BuyNowPage extends StatefulWidget {
  const BuyNowPage({Key key, this.products, this.quantity}) : super(key: key);
  final Product products;
  final int quantity;

  @override
  _BuyNowPageState createState() => _BuyNowPageState();
}

class _BuyNowPageState extends State<BuyNowPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.5,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.teal.shade200],
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          leading: IconButton(
              onPressed: () {
                RepositoryVoucher.sale = 0;
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Center(
            child: Text(
              "Thanh toán",
              style: TextStyle(
                fontFamily: "Pacifico",
                fontSize: 24,
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: BodyBuyNow(
          product: widget.products,
          quantity: widget.quantity,
        ),
        bottomNavigationBar: _buildBottomNav(size),
      ),
    );
  }

  Widget _buildBottomNav(size) {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.white],
          begin: Alignment.bottomLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, 0),
            color: Colors.grey,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      "Tổng thanh toán :",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${convertToVND(RepositoryInvoice.total(widget.quantity, widget.products.price))} đ",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: size.width * 0.5,
                  height: size.height * 0.08,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        buttonColor,
                      ),
                    ),
                    onPressed: () async {
                      if (RepositoryInvoice.paymentMethodSelected == "0") {
                        payment();
                      } else if (RepositoryInvoice.paymentMethodSelected ==
                          "1") {
                        await RepositoryInvoice.paymentMomo();
                        _launchUrl(Uri.parse(RepositoryInvoice.url));
                        for (int i = 0; i < 120; i++) {
                          var status = await RepositoryInvoice.checkPayment(
                              RepositoryInvoice.orderId);
                          await Future.delayed(const Duration(seconds: 5));
                          if (status == 200) {
                            payment();
                            i = 120;
                          }
                        }
                      } else {
                        await RepositoryInvoice.paymentAtm();
                        _launchUrl(Uri.parse(RepositoryInvoice.url));
                        for (int i = 0; i < 120; i++) {
                          var status = await RepositoryInvoice.checkPayment(
                              RepositoryInvoice.orderId);
                          await Future.delayed(const Duration(seconds: 5));
                          if (status == 200) {
                            payment();
                            i = 120;
                          }
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.card_travel),
                        Text(
                          "Đặt hàng",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(Uri _url) async {
    if (await canLaunchUrl(_url)) {
      // ignore: deprecated_member_use
      await launch(RepositoryInvoice.url, forceSafariVC: false);
    }
  }

  void payment() async {
    RepositoryVoucher.sale = 0;
    await RepositoryInvoice.buynow(
        RepositoryInvoice.total(widget.quantity, widget.products.price),
        widget.products.id,
        widget.quantity,
        RepositoryInvoice.paymentMethodSelected);
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDiaLogCustom(
            json: "assets/done.json",
            text: "Đặt hàng thành công.",
            navigator: "Go",
          );
        });
  }
}
