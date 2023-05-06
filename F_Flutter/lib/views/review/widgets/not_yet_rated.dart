import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/invoices_models.dart';
import 'package:fluter_19pmd/repository/invoice_api.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_bloc.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_event.dart';
import 'package:flutter/material.dart';
import '../review_page.dart';
import 'order_details.dart';

class NotYetRated extends StatefulWidget {
  const NotYetRated({
    Key key,
  }) : super(key: key);

  @override
  State<NotYetRated> createState() => _NotYetRatedState();
}

class _NotYetRatedState extends State<NotYetRated> {
  final _invoiceSuccess = InvoiceBloc();
  final _commentController = TextEditingController();
  List<String> image;

  @override
  void initState() {
    super.initState();
    _invoiceSuccess.eventSink.add(InvoiceEvent.fetchNotYetRated);
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
                            return itemCart(size, index, snapshot);
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

  Widget itemCart(size, index, snapshot) {
    var images = snapshot.data[index].products[index].image;
    image = images.split(',');
    return Card(
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
            ListTile(
              leading: SizedBox(
                height: 100,
                width: 100,
                child: Image.network(image[0]),
              ),
              trailing: Text(
                '${convertToVND(snapshot.data[index].products[index].price)}đ',
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
              title: Text(
                snapshot.data[index].products[index].name,
                style: const TextStyle(fontSize: 24, color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            snapshot.data[index].products.length > 1
                ? Center(
                    child: InkWell(
                    onTap: () {
                      RepositoryInvoice.getInvoiceID = snapshot.data[index].id;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailsHistory(
                            invoices: snapshot.data[index],
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Xem thêm ${snapshot.data[index].products.length - 1} sản phẩm",
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ))
                : Container(
                    height: 0,
                  ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "${snapshot.data[index].products.length} sản phẩm Thành tiền : ${snapshot.data[index].total} đ",
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 10),
            Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReviewPage(
                                      invoice: snapshot.data[index],
                                    )));
                      },
                      child: const Text(
                        "Đánh giá",
                        style: TextStyle(fontSize: 18),
                      )),
                )),
          ],
        ),
      ),
    );
  }
}
