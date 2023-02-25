import 'package:fluter_19pmd/models/invoices_models.dart';
import 'package:fluter_19pmd/views/profile/order/details/history/bodyhistory.dart';
import 'package:flutter/material.dart';

class OrderDetailsHistory extends StatelessWidget {
  const OrderDetailsHistory({Key key, this.invoices}) : super(key: key);
  final Invoices invoices;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          body: BodyHistory(
            invoice: invoices,
          ),
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
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
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            title: const Text(
              "Chi tiết đơn hàng ",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
