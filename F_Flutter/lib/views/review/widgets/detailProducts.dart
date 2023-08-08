import 'package:fluter_19pmd/bloc/loading_bloc.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/invoices_models.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_bloc.dart';

import 'package:flutter/material.dart';

import '../../../../constant.dart';
import '../review_page.dart';

class DetailProducts extends StatefulWidget {
  const DetailProducts({Key key, this.invoice}) : super(key: key);
  final Invoices invoice;

  @override
  State<DetailProducts> createState() => _DetailProductsState();
}

class _DetailProductsState extends State<DetailProducts> {
  final _invoiceSuccess = InvoiceBloc();
  final _isLoading = LoadingBloc();
  final _commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _invoiceSuccess.dispose();
    _isLoading.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              buttonColor,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReviewPage(
                  invoice: widget.invoice,
                ),
              ),
            );
          },
          child: const Text(
            "Đánh giá",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
      body: ListView(
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
                                100 * widget.invoice.products.length.toDouble(),
                            child: ListView.separated(
                              padding: const EdgeInsets.all(20.0),
                              itemBuilder: (context, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ListTile(
                                    leading: Text(
                                      'x${widget.invoice.products[index].quantity}',
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                    title: Text(
                                      widget.invoice.products[index].name,
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.black),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: Text(
                                      '${convertToVND(widget.invoice.products[index].price)}đ',
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.red),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
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
      ),
    );
  }
}
