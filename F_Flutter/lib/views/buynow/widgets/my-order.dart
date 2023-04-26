import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/product_models.dart';
import 'package:flutter/material.dart';


class MyOrderBuyNow extends StatefulWidget {
  const MyOrderBuyNow({Key key, this.product, this.quantity}) : super(key: key);
  final Product product;
  final int quantity;

  @override
  State<MyOrderBuyNow> createState() => _MyOrderBuyNowState();
}

class _MyOrderBuyNowState extends State<MyOrderBuyNow> {
  @override
  Widget build(BuildContext context) {
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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 60,
                          width: 80,
                          child: Image.network(widget.product.image),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "x${widget.quantity}",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          widget.product.name,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${convertToVND(widget.product.price)}đ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
