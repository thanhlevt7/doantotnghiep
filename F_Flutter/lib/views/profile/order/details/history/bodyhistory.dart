import 'dart:async';

import 'package:fluter_19pmd/bloc/loading_bloc.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/invoices_models.dart';
import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_bloc.dart';
import 'package:fluter_19pmd/views/review/review_page.dart';

import 'package:flutter/material.dart';

class BodyHistory extends StatefulWidget {
  const BodyHistory({Key key, this.invoice}) : super(key: key);
  final Invoices invoice;

  @override
  State<BodyHistory> createState() => _BodyHistoryState();
}

class _BodyHistoryState extends State<BodyHistory> {
  final _invoiceSuccess = InvoiceBloc();
  final _isLoading = LoadingBloc();
  final _commentController = TextEditingController();
  final _stateStreamController = StreamController<int>();
  StreamSink<int> get selectedSink => _stateStreamController.sink;
  Stream<int> get selectedStream => _stateStreamController.stream;
  final _productStreamController = StreamController<List<Product>>();
  StreamSink<List<Product>> get productSink => _productStreamController.sink;
  Stream<List<Product>> get productStream => _productStreamController.stream;

  @override
  void dispose() {
    super.dispose();
    _invoiceSuccess.dispose();
    _isLoading.dispose();
    _stateStreamController.close();
    _commentController.dispose();
    _productStreamController.close();
  }

  

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.all(20.0),
            height: 700,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 70),
                    height:
                        300 * widget.invoice.products.length.toDouble() + 100,
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height:
                              200 * widget.invoice.products.length.toDouble(),
                          child: ListView.separated(
                            padding: const EdgeInsets.all(20.0),
                            itemBuilder: (context, index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'x${widget.invoice.products[index].quantity}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey.shade500),
                                    ),
                                    Text(
                                      widget.invoice.products[index].name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey.shade500),
                                    ),
                                    Text(
                                      '${convertToVND(widget.invoice.products[index].price)}đ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey.shade500),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                (widget.invoice.products[index].status == 1)
                                    ? InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReviewPage(
                                                        inv: widget.invoice
                                                            .products[index].id,
                                                        idInvoice: widget
                                                            .invoice.id
                                                            .toString(),
                                                      )));
                                        },
                                        child: const Text(
                                          "Đánh giá",
                                          style: TextStyle(
                                              color: Colors.blue, fontSize: 20),
                                        ))
                                    : const Text(
                                        "Đã đánh giá",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                              ],
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 5,
                            ),
                            itemCount: widget.invoice.products.length,
                          ),
                        ),
                      ],
                    )),
                Positioned(
                  left: 80,
                  right: 80,
                  top: 20,
                  child: Container(
                    height: 60,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.teal, width: 2.0),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50))),
                    child: const Center(
                      child: Text(
                        "Sản phẩm",
                        style: TextStyle(fontSize: 24, color: Colors.teal),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
