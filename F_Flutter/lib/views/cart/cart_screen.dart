import 'package:fluter_19pmd/bloc/loading_bloc.dart';
import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/repository/cart_api.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/views/cart/widgets/body.dart';
import 'package:fluter_19pmd/views/checkout/checkout_page.dart';
import 'package:fluter_19pmd/views/home/home_page.dart';
import 'package:fluter_19pmd/views/profile/account/widgets/address/create_adress_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _deleteBloc = LoadingBloc();
  @override
  void dispose() {
    super.dispose();
    _deleteBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: StreamBuilder<bool>(
          initialData: false,
          stream: _deleteBloc.loadingStream,
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 1,
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/arrow_back.svg',
                    color: Colors.white,
                    width: 30,
                    height: 30,
                  ),
                ),
                title: const Text(
                  "Giỏ hàng",
                  style: TextStyle(fontSize: 26),
                ),
              ),
              body: Body(
                openDelete: state.data,
              ),
              bottomNavigationBar: Row(
                children: [
                  SizedBox(
                    width: size.width * 0.5,
                    height: size.height * 0.07,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(buttonColor),
                      ),
                      onPressed: () {
                        (state.data)
                            ? _deleteBloc.loadingSink.add(false)
                            : _deleteBloc.loadingSink.add(true);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (state.data)
                              ? const Icon(Icons.check)
                              : const Icon(Icons.delete),
                          (state.data)
                              ? const Text(
                                  "Hoàn tất",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  "Xóa",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.5,
                    height: size.height * 0.07,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          buttonColor,
                        ),
                      ),
                      // ignore: void_checks
                      onPressed: () {
                        if (RepositoryCart.cartClient.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDiaLogCustom(
                                  json: "assets/error.json",
                                  text: "Hãy thêm sản phẩm vào giỏ hàng.",
                                );
                              });
                        } else {
                          if (RepositoryUser.info.address.isEmpty) {
                            showDialog<void>(
                              context: context,
                              barrierDismissible:
                                  false, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  content: Center(
                                    child: Column(
                                      children: const [
                                        Text(
                                          "Bạn chưa có địa chỉ vui lòng thêm địa chỉ giao hàng",
                                          style: TextStyle(fontSize: 18),
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
                                            'Tạo mới',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.teal,
                                            ),
                                          ),
                                          onPressed: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const CreateAddress()));
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CheckOutPage(),
                              ),
                            );
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.card_travel),
                          Text(
                            "Mua hàng",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
