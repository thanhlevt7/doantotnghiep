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
  List<String> image;
  @override
  Widget build(BuildContext context) {
    final images = widget.product.image;
    image = images.split(",");
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: ListTile(
                trailing: Text(
                  "x${widget.quantity}",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                title: SizedBox(
                  width: 200,
                  child: Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                subtitle: Text(
                  "${convertToVND(widget.product.price)}đ",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: SizedBox(
                  height: 60,
                  width: 80,
                  child: Image.network(image[0]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
