import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/invoices_models.dart';
import 'package:fluter_19pmd/repository/invoice_api.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_bloc.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_event.dart';
import 'package:fluter_19pmd/views/profile/order/details/order_details.dart';
import 'package:flutter/material.dart';

class Cancel extends StatefulWidget {
  const Cancel({Key key}) : super(key: key);

  @override
  State<Cancel> createState() => _CancelState();
}

class _CancelState extends State<Cancel> {
  List<String> resons = [
    "Đổi ý, mua sản phẩm khác.",
    "Đổi địa chỉ giao hàng.",
    "Không đủ điều kiện kinh tế.",
    "Thích thì hủy.",
  ];
  final _invoiceSuccess = InvoiceBloc();
  @override
  void initState() {
    super.initState();
    _invoiceSuccess.eventSink.add(InvoiceEvent.fetchCancelOrder);
  }

  @override
  void dispose() {
    super.dispose();
    _invoiceSuccess.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<List<Invoices>>(
        initialData: const [],
        stream: _invoiceSuccess.invoiceStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.teal,
                ),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 15,
                            ),
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return itemCart(size, index, snapshot);
                        }),
                  ),
                ],
              );
            }
          } else {
            return const Center(
              child: Text(
                "Bạn chưa hủy đơn hàng",
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

  Widget itemCart(size, index, snapshot) => InkWell(
        onTap: () {
          RepositoryInvoice.getInvoiceID = snapshot.data[index].id;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OrderDetails(invoices: snapshot.data[index]),
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
                      height: 100,
                      width: 100,
                      child: Image.asset('assets/images/icons-png/invoice.png'),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "#${snapshot.data[index].id}",
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
