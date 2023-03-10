import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/invoices_models.dart';
import 'package:fluter_19pmd/repository/invoice_api.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyOrder extends StatelessWidget {
  MyOrder({Key key, this.carts}) : super(key: key);
  List<Cart> carts;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (carts == null) {
    } else {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Đơn hàng của bạn :",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: size.height * RepositoryInvoice.heightMyOrder(),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: carts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 60,
                                width: 80,
                                child: Image.network(carts[index].image),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "x${carts[index].quantity}",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Text(
                                carts[index].name,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${convertToVND(carts[index].price)}đ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
