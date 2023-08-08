import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/views/buynow/widgets/my-order.dart';
import 'package:fluter_19pmd/views/checkout/checkout_bloc.dart';
import 'package:fluter_19pmd/views/checkout/widgets/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../function.dart';
import '../../../repository/invoice_api.dart';
import '../../../repository/voucher_api.dart';

class BodyBuyNow extends StatefulWidget {
  const BodyBuyNow({Key key, this.quantity, this.product}) : super(key: key);
  final Product product;
  final int quantity;

  @override
  State<BodyBuyNow> createState() => _BodyBuyNowState();
}

class _BodyBuyNowState extends State<BodyBuyNow> {
  final getValueVoucher = VoucherBloc();
  final _formKey = GlobalKey<FormState>();
  String selected;
  final voucherController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const AddressInPayment(),
          MyOrderBuyNow(
            product: widget.product,
            quantity: widget.quantity,
          ),
          SizedBox(
              height: 60,
              child: Card(
                  child: ListTile(
                onTap: () {
                  voucherController.clear();
                  _showMyDialog(context);
                },
                title: const Text("Voucher"),
                trailing: const Icon(Icons.keyboard_arrow_right_outlined),
              ))),
          Card(
            child: ListTile(
                onTap: () {
                  paymentMethod(context);
                },
                title: const Text("Phương thức thanh toán :"),
                trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                subtitle: RepositoryInvoice.paymentMethodSelected == "0"
                    ? const Text("Thanh toán khi nhận hàng")
                    : RepositoryInvoice.paymentMethodSelected == "1"
                        ? const Text("Thanh toán qua Momo")
                        : const Text("Thanh toán qua Atm")),
          ),
          Card(
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
                              text: 'Tổng số tiền ',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${convertToVND(widget.quantity * widget.product.price)} đ",
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
                  StreamBuilder<int>(
                      initialData: 0,
                      stream: getValueVoucher.getStream,
                      builder: ((context, snapshot) {
                        if (snapshot.data != 0) {
                          return Row(
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
                          );
                        } else {
                          return Container(height: 0);
                        }
                      })),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tổng thanh toán",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "${convertToVND(RepositoryInvoice.total(widget.quantity, widget.product.price))} đ",
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
          ),
        ],
      ),
    );
  }

  Future<void> _showMyDialog(context) async {
    return showDialog<String>(
      context: context,
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
                      getValueVoucher.getSink.add(RepositoryVoucher.sale);
                      Navigator.of(context).pop();
                      EasyLoading.showSuccess('Voucher hợp lệ! ');
                    } else if (check == 202) {
                      EasyLoading.showSuccess('Không thể sử dụng! ');
                    } else {
                      EasyLoading.showError('Voucher không hợp lệ! ');
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

  Future<void> paymentMethod(context) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          content: Center(
            child: Column(
              children: [
                RadioListTile<String>(
                  groupValue: selected,
                  title: const Text("Thanh toán khi nhận hàng"),
                  value: "0",
                  onChanged: (value) {
                    setState(() {
                      RepositoryInvoice.paymentMethodSelected = value;
                    });
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
                RadioListTile<String>(
                  groupValue: selected,
                  title: const Text("Thanh toán qua Momo"),
                  value: "1",
                  onChanged: (value) {
                    setState(() {
                      RepositoryInvoice.paymentMethodSelected = value;
                    });
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
                RadioListTile<String>(
                  groupValue: selected,
                  title: const Text("Thanh toán qua Atm"),
                  value: "2",
                  onChanged: (value) {
                    setState(() {
                      RepositoryInvoice.paymentMethodSelected = value;
                    });
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
