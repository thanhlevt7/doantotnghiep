import 'package:fluter_19pmd/repository/voucher_api.dart';
import 'package:fluter_19pmd/views/checkout/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VoucherList extends StatefulWidget {
  const VoucherList({Key key}) : super(key: key);

  @override
  State<VoucherList> createState() => _VoucherListState();
}

class _VoucherListState extends State<VoucherList> {
  final _formKey = GlobalKey<FormState>();
  final voucherController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        child: Card(
            child: ListTile(
          onTap: () {
            voucherController.clear();
            _showMyDialog(context);
          },
          title: const Text("Voucher"),
          trailing: const Icon(Icons.keyboard_arrow_right_outlined),
        )));
  }

  Future<void> _showMyDialog(context) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          content: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: voucherController,
                    decoration:
                        const InputDecoration(hintText: "Nhập mã voucher"),
                    // ignore: missing_return
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Không được để trống";
                      }
                    },
                  ),
                ],
              ),
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
                    'Áp dụng',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                    ),
                  ),
                  onPressed: () async {
                    final isValid = _formKey.currentState.validate();
                    if (!isValid) {
                      return;
                    }
                    var check = await RepositoryVoucher.checkVoucher(
                        voucherController.text);
                    if (check == 200) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CheckOutPage(),
                        ),
                      );
                      Fluttertoast.showToast(
                          msg: "Voucher hợp lệ",
                          textColor: Colors.white,
                          fontSize: 20);
                    } else if (check == 202) {
                      Fluttertoast.showToast(
                          msg: "Không thể sử dụng",
                          textColor: Colors.redAccent,
                          fontSize: 25);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Voucher không tồn tại",
                          textColor: Colors.redAccent,
                          fontSize: 25);
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
