import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/invoices_models.dart';
import 'package:flutter/material.dart';

import 'detailProducts.dart';

class OrderDetailsHistory extends StatelessWidget {
  const OrderDetailsHistory({Key key, this.invoices}) : super(key: key);
  final Invoices invoices;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
            body: DetailProducts(
              invoice: invoices,
            ),
            backgroundColor: Colors.grey.shade100,
            appBar: appbar("Chi tiết đơn hàng", context)),
      ),
    );
  }
}
