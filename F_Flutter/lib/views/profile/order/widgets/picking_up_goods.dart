import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/invoices_models.dart';
import 'package:fluter_19pmd/repository/invoice_api.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_bloc.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_event.dart';
import 'package:fluter_19pmd/views/profile/order/details/order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PickingUpGoods extends StatefulWidget {
  const PickingUpGoods({Key key}) : super(key: key);

  @override
  State<PickingUpGoods> createState() => _PickingUpGoodsState();
}

class _PickingUpGoodsState extends State<PickingUpGoods> {
  final _invoiceSuccess = InvoiceBloc();
  @override
  void initState() {
    super.initState();
    _invoiceSuccess.eventSink.add(InvoiceEvent.fetchPickingUpGoods);
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
                      height: 130,
                      width: 130,
                      child: Image.asset('assets/images/icons-png/invoice.png'),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    _contentCardRight(snapshot, index, size),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget _button({icon, text, id}) => SizedBox(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              buttonColor,
            ),
          ),
          onPressed: () {
            _showMyDialog(context, id);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _contentCardRight(snapshot, index, size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tổng đơn : ${convertToVND(snapshot.data[index].total)}đ",
          style: const TextStyle(
            fontSize: 20,
            color: Color(0xFF717171),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        _button(
            icon: const Icon(Icons.cancel_presentation),
            text: 'Hủy đơn hàng',
            id: snapshot.data[index].id),
      ],
    );
  }

  Future<void> _showMyDialog(context, id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Center(
              child: Text(
            "Hủy đơn hàng",
            style: TextStyle(fontSize: 22, color: Colors.black),
          )),
          content: Center(
            child: Column(
              children: const [
                Center(
                  child: Text(
                    "Bạn có chắc chắn muốn hủy đơn hàng ?",
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text(
                    'Quay lại',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text(
                    'Xác nhận',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                    ),
                  ),
                  onPressed: () async {
                    var reponse = await RepositoryInvoice.cancelOrder(id);
                    if (reponse == 200) {
                      Navigator.of(context).pop();
                      EasyLoading.showSuccess('Đã hủy đơn hàng');
                      _invoiceSuccess.eventSink
                          .add(InvoiceEvent.fetchWaitingToAccept);
                    } else {
                      Navigator.of(context).pop();
                      EasyLoading.showError(
                          'Đơn hàng đang vận chuyển không thể hủy');
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
