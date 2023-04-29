import 'package:fluter_19pmd/counter_event.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/views/details_product/counter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../models/product_models.dart';

class DescriptionWidthCounter extends StatefulWidget {
  const DescriptionWidthCounter({
    Key key,
    this.description,
    this.stock,
    this.price,
    this.sell,
    this.name,
    this.unit,
    this.product,
  }) : super(key: key);

  final String description;
  final int stock;
  final int price;
  final String sell;
  final String name;
  final String unit;
  final Product product;

  @override
  State<DescriptionWidthCounter> createState() =>
      _DescriptionWidthCounterState();
}

class _DescriptionWidthCounterState extends State<DescriptionWidthCounter> {
  final _counterBloc = CounterDetailsBloc();

  @override
  void dispose() {
    _counterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<int>(
        initialData: 1,
        stream: _counterBloc.counterStream,
        builder: (context, value) {
          _counterBloc.totalSink.add(value.data * widget.price);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Card(
                    child: Column(
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 24,
                            letterSpacing: 1.5,
                            color: Colors.grey.shade700,
                          ),
                          maxLines: 2,
                        ),
                        Text(
                          '${convertToVND(widget.price)}đ/${widget.unit}',
                          style:
                              const TextStyle(color: Colors.red, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Số lượng:",
                      style:
                          TextStyle(fontSize: 22, color: Colors.grey.shade600),
                    ),
                    _counter(value.data),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tổng: ",
                      style:
                          TextStyle(fontSize: 22, color: Colors.grey.shade600),
                    ),
                    StreamBuilder<int>(
                        initialData: widget.price,
                        stream: _counterBloc.totalStream,
                        builder: (context, snapshot) {
                          return Text(
                            "${convertToVND(snapshot.data)}đ",
                            style: TextStyle(
                                fontSize: 20, color: Colors.grey.shade600),
                          );
                        }),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Đã bán:",
                        style: TextStyle(
                            fontSize: 22, color: Colors.grey.shade600)),
                    widget.sell.length < 5
                        ? Text(
                            "0",
                            style: TextStyle(
                                fontSize: 22, color: Colors.grey.shade600),
                          )
                        : Text(
                            widget.sell
                                .substring(9)
                                .replaceAll(RegExp('}]'), ''),
                            style: TextStyle(
                                fontSize: 22, color: Colors.grey.shade600),
                          )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tồn kho: ",
                      style:
                          TextStyle(fontSize: 22, color: Colors.grey.shade600),
                    ),
                    Text(widget.stock.toString(),
                        style: TextStyle(
                            fontSize: 22, color: Colors.grey.shade600)),
                  ],
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Thông tin sản phẩm",
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.teal,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: SizedBox(
                    width: size.width,
                    child: Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1.5,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _counter(int value) => SizedBox(
        width: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.teal.shade200,
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    _counterBloc.eventSink.add(CounterEvent.decrement);
                  },
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.teal.shade200,
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: IconButton(
                onPressed: () {
                  if (value < widget.stock) {
                    _counterBloc.eventSink.add(CounterEvent.increment);
                  }
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
}
