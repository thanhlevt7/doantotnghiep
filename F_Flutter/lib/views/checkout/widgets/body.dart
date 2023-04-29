import 'package:fluter_19pmd/models/invoices_models.dart';
import 'package:fluter_19pmd/repository/voucher_api.dart';
import 'package:fluter_19pmd/services/cart/cart_bloc.dart';
import 'package:fluter_19pmd/services/cart/cart_event.dart';
import 'package:fluter_19pmd/views/checkout/widgets/address.dart';
import 'package:fluter_19pmd/views/checkout/widgets/my-order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../function.dart';
import '../../../repository/cart_api.dart';
import '../checkout_bloc.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final voucherController = TextEditingController();
  final _cartBloc = CartBloc();
  final getValue = VoucherBloc();
  @override
  void initState() {
    _cartBloc.eventSink.add(CartEvent.fetchCart);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _cartBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Cart>>(
        initialData: null,
        stream: _cartBloc.cartStream,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const AddressInPayment(),
                  MyOrder(carts: snapshot.data),
                  SizedBox(
                      height: 60,
                      child: Card(
                          child: ListTile(
                        onTap: () {
                          voucherController.clear();
                          _showMyDialog(context);
                        },
                        title: const Text("Voucher"),
                        trailing:
                            const Icon(Icons.keyboard_arrow_right_outlined),
                      ))),
                  const Card(
                    child: ListTile(
                      title: Text("Phương thức thanh toán :"),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined),
                      subtitle: Text("Thanh toán khi nhận hàng"),
                    ),
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
                                      text: 'Tổng số tiền  ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "${convertToVND(RepositoryCart.subTotalCart())} đ",
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
                              stream: getValue.getStream,
                              builder: (context, value) {
                                print(value);
                                if (value.data != 0) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                              }),
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
                                "${convertToVND(RepositoryCart.totalCart())}đ",
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
          } else {
            return Column(
              children: const [
                SizedBox(height: 300),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          }
        });
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
                      getValue.getSink.add(RepositoryVoucher.sale);
                      Navigator.of(context).pop();
                      EasyLoading.showSuccess('Voucher hợp lệ! ');
                    } else if (check == 202) {
                      EasyLoading.showSuccess('KHông thể sử dụng! ');
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
}
