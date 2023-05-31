import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/invoices_models.dart';
import 'package:fluter_19pmd/repository/invoice_api.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_bloc.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../details/order_details.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({
    Key key,
  }) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  final _invoiceSuccess = InvoiceBloc();

  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _invoiceSuccess.eventSink.add(InvoiceEvent.fetchOrderHistory);
  }

  @override
  void dispose() {
    super.dispose();
    _invoiceSuccess.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<List<Invoices>>(
        initialData: const [],
        stream: _invoiceSuccess.invoiceStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 15,
                              ),
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            DateFormat dateFormat =
                                DateFormat("dd-MM-yyyy HH:mm:ss");
                            String date = dateFormat
                                .format(snapshot.data[index].dateCreated);
                            final currentTime = DateTime.now();
                            final orderDate = DateTime.parse(
                                snapshot.data[index].dateCreated.toString());
                            final results = currentTime.difference(orderDate);

                            return itemCart(
                                size, index, snapshot, results, date);
                          }),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return const Center(
              child: Text(
                "Chưa có đơn hàng",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
        });
  }

  Widget itemCart(size, index, snapshot, results, date) => InkWell(
        onTap: () {
          RepositoryInvoice.getInvoiceID = snapshot.data[index].id;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetails(
                invoices: snapshot.data[index],
              ),
            ),
          );
        },
        child: Card(
          shadowColor: Colors.teal,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          margin: const EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 130,
                      width: 130,
                      child: Image.asset('assets/images/icons-png/invoice.png'),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    _contentCardRight(snapshot, index, size, results, date),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget _contentCardRight(snapshot, index, size, a, date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "#${snapshot.data[index].id}",
          style: const TextStyle(
            fontSize: 20,
            color: Color(0xFFF34848),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Tổng đơn : ${convertToVND(snapshot.data[index].total)}đ",
          style: const TextStyle(
            fontSize: 20,
            color: Color(0xFF717171),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          date,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
