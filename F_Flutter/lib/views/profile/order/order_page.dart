import 'package:fluter_19pmd/views/profile/order/widgets/cancel.dart';
import 'package:fluter_19pmd/views/profile/order/widgets/on_delivery.dart';
import 'package:fluter_19pmd/views/profile/order/widgets/order_history.dart';
import 'package:fluter_19pmd/views/profile/order/widgets/picking_up_goods.dart';
import 'package:fluter_19pmd/views/profile/order/widgets/waiting_to_accept.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            bottom: buildTabbar(),
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
              "Xem đơn hàng",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          body: bodyTabbar(),
          // body: Body(),
        ),
      ),
    );
  }

  Widget bodyTabbar() => const TabBarView(
        children: [
          WaitingToAccept(),
          PickingUpGoods(),
          OnDelivery(),
          OrderHistory(),
          Cancel(),
        ],
      );
  Widget buildTabbar() => const TabBar(
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        isScrollable: true,
        tabs: [
          Tab(
            child: Text(
              "Chờ xác nhận",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Đã xác nhận",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Đang vận chuyển",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Lịch sử mua",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Đã hủy",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
}
