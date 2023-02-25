import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/repository/cart_api.dart';
import 'package:fluter_19pmd/repository/voucher_api.dart';
import 'package:flutter/material.dart';

class TotalPriceProduct extends StatelessWidget {
  const TotalPriceProduct({Key key, this.quantity}) : super(key: key);
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Tổng số tiền ( ',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      TextSpan(
                        text: RepositoryCart.totalProduct().toString(),
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      TextSpan(
                        text: ' sản phẩm )',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "${convertToVND(RepositoryCart.subTotalCart())} đ",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phí giao hàng",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  "20.000 đ",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            RepositoryVoucher.sale != 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Giảm giá từ Voucher ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        "${convertToVND(RepositoryVoucher.sale)} đ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  )
                : Container(height: 0),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Tổng thanh toán",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                Text(
                  "${convertToVND(RepositoryCart.totalCart())} đ",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
