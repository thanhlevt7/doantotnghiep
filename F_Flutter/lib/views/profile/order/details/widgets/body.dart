import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/invoices_models.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key key, this.invoice}) : super(key: key);
  final Invoices invoice;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.all(20.0),
            height: 500,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 70),
                    height: 70 * invoice.products.length.toDouble() + 100,
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 70 * invoice.products.length.toDouble(),
                          child: ListView.separated(
                            padding: const EdgeInsets.all(20.0),
                            itemBuilder: (context, index) => ListTile(
                              leading: Text(
                                'x${invoice.products[index].quantity}',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey.shade500),
                              ),
                              title: Text(
                                invoice.products[index].name,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey.shade500),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Text(
                                '${convertToVND(invoice.products[index].price)}đ',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey.shade500),
                              ),
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 5,
                            ),
                            itemCount: invoice.products.length,
                          ),
                        ),
                      ],
                    )),
                Positioned(
                  left: 80,
                  right: 80,
                  top: 20,
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.teal, width: 2.0),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50))),
                    child: const Center(
                      child: Text(
                        "Sản phẩm",
                        style: TextStyle(fontSize: 24, color: Colors.teal),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
