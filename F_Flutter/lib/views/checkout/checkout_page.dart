import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/repository/cart_api.dart';
import 'package:fluter_19pmd/repository/invoice_api.dart';
import 'package:fluter_19pmd/repository/voucher_api.dart';
import 'package:fluter_19pmd/views/cart/cart_screen.dart';
import 'package:fluter_19pmd/views/checkout/widgets/body.dart';
import 'package:flutter/material.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key key}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
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
        body: const Body(),
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
                      "${convertToVND(RepositoryCart.totalCart())}đ",
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
                      var code = await RepositoryInvoice.payment();
                      RepositoryVoucher.sale = 0;
                      if (code == 200) {
                        await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDiaLogCustom(
                                json: "assets/delivery.json",
                                text: "Xin vui lòng đợi trong giây lát.",
                              );
                            });
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
}
