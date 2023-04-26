import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/counter_event.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/invoices_models.dart';
import 'package:fluter_19pmd/repository/cart_api.dart';
import 'package:fluter_19pmd/services/cart/cart_bloc.dart';
import 'package:fluter_19pmd/services/cart/cart_event.dart';
import 'package:fluter_19pmd/views/cart/counter_cart_bloc/counter_bloc.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key key, this.openDelete}) : super(key: key);
  final bool openDelete;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _counterBloc = CounterBloc();
  final _cartBloc = CartBloc();
  @override
  void initState() {
    _counterBloc.eventSink.add(CounterEvent.update);
    _cartBloc.eventSink.add(CartEvent.fetchCart);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _counterBloc.dispose();
    _cartBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        StreamBuilder<List<Cart>>(
            initialData: const [],
            stream: _cartBloc.cartStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _card(snapshot, context, size);
              } else {
                return Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.35,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "assets/images/icons-png/shopping_cart.png",
                            width: 30,
                            height: 30,
                          ),
                          const Text(
                            "Bạn chưa có sản phẩm trong giỏ hàng",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }),
      ],
    );
  }

  Widget _card(snapshot, context, size) => Expanded(
          child: ListView.separated(
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.all(15.0),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    height: (widget.openDelete) ? 40 : 40,
                    width: (widget.openDelete) ? 40 : 0,
                    child: InkWell(
                      onTap: () async {
                        var message = await RepositoryCart.deleteProductCart(
                            snapshot.data[index].id);
                        if (message != null) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDiaLogCustom(
                                  json: "assets/done.json",
                                  text: "Sản phẩm đã được xóa",
                                );
                              });
                        }
                        _cartBloc.eventSink.add(CartEvent.fetchCart);
                      },
                      child: Image.asset(
                        "assets/images/icons-png/trash.png",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    height: 130,
                    child: Image.network(snapshot.data[index].image),
                  ),
                  const SizedBox(width: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data[index].name,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildItemInfo(
                          text: "Giá: ", number: snapshot.data[index].price),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildItemInfo(
                          text: "Tồn kho: ",
                          number: snapshot.data[index].stock),
                      const SizedBox(
                        height: 10,
                      ),
                      _counter(
                          size: size,
                          quantity: snapshot.data[index].quantity,
                          productID: snapshot.data[index].id,
                          stock: snapshot.data[index].stock),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 20,
          );
        },
      ));

  Widget _buildItemInfo({String text, int number}) => RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: text,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: convertToVND(number),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
      );

  Widget _counter({Size size, int quantity, int productID, int stock}) =>
      SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: textColor.withOpacity(0.1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    if (quantity > 1) {
                      RepositoryCart.getID = productID;
                      _counterBloc.eventSink.add(CounterEvent.decrement);
                      _cartBloc.eventSink.add(CartEvent.fetchCart);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(milliseconds: 200),
                          content: Text(
                            "Số lượng phải lớn hơn 1",
                            style: TextStyle(fontSize: 20),
                          )));
                    }
                  },
                  icon: const Icon(Icons.remove),
                ),
              ),
            ),
            Text(
              quantity.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: textColor.withOpacity(0.1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: IconButton(
                onPressed: () {
                  if (quantity < stock) {
                    RepositoryCart.getID = productID;
                    _counterBloc.eventSink.add(CounterEvent.increment);
                    _cartBloc.eventSink.add(CartEvent.fetchCart);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(milliseconds: 200),
                        content: Text(
                          "Số lượng tồn kho không đủ",
                          style: TextStyle(fontSize: 20),
                        )));
                  }
                },
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      );
}
