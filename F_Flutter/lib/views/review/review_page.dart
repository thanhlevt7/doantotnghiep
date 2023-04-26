import 'dart:async';
import 'dart:io';
import 'package:fluter_19pmd/bloc/loading_bloc.dart';
import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/review_api.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import '../../repository/user_api.dart';
import '../home/home_page.dart';

// ignore: must_be_immutable
class ReviewPage extends StatefulWidget {
  ReviewPage({this.inv, this.idInvoice, Key key}) : super(key: key);
  int inv;
  String idInvoice;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List image;
  final _invoiceSuccess = InvoiceBloc();
  final _isLoading = LoadingBloc();
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  final _stateStreamController = StreamController<int>();
  StreamSink<int> get selectedSink => _stateStreamController.sink;
  Stream<int> get selectedStream => _stateStreamController.stream;
  final _productStreamController = StreamController<List<Product>>();
  StreamSink<List<Product>> get productSink => _productStreamController.sink;
  Stream<List<Product>> get productStream => _productStreamController.stream;
  String rating = "5";

  Future getImage() async {
    var image = await ImagePicker().pickMultiImage();
    if (image != null) {
      for (int i = 0; i < image.length; i++) {
        setState(() {
          RepositoryUser.uploadFile(File(image[i].path));
        });
      }
    }
  }

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
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Đánh giá bài viết"),
          elevation: 0,
          backgroundColor: Colors.teal.shade700,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.teal.shade200],
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: _rating(size),
      ),
    );
  }

  Widget _rating(Size size) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar.builder(
                    initialRating: 5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    // ignore: prefer_const_constructors
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (value) {
                      setState(() {
                        rating = value.toString();
                      });
                    },
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  getImage();
                },
                child: const Text(
                  "Thêm hình ảnh",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              RepositoryUser.image != null
                  ? SizedBox(
                      height: 200,
                      width: 500,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                        ),
                        itemCount: RepositoryUser.image.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                        child: Image.network(
                                            RepositoryUser.image[index])),
                                  ]),
                            ),
                          );
                        },
                      ),
                    )
                  : Text("Don't have data"),
              const Text(
                "Thêm video",
                style: TextStyle(fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Text(
                      'Nội dung đánh giá',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: _commentController,
                  minLines: 4,
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Hãy viết gì đó ......',
                      border: const OutlineInputBorder(),
                      labelStyle: TextStyle(
                        color: Colors.grey.shade400,
                      )),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 22.0,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Không được để trống';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: _button(
                    text: 'Gửi',
                    icon: const Icon(Icons.send),
                    press: () async {
                      final isValid = _formKey.currentState.validate();
                      if (!isValid) {
                        return;
                      }

                      var data = await RepositoryReview.post(
                        id: widget.idInvoice,
                        starNumber: rating,
                        content: _commentController.text,
                        product: widget.inv,
                        image: RepositoryUser.image.toString(),
                      );

                      if (data == 200) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                        MotionToast.success(
                            description: const Text(
                          'Đã bình luận',
                          style: TextStyle(fontSize: 22, color: Colors.teal),
                        )).show(context);
                      } else {}
                    }),
              ),

              // Text(RepositoryUser.image.toString()),
            ],
          ),
        ));
  }

  Widget _button({icon, text, press}) => SizedBox(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              buttonColor,
            ),
          ),
          onPressed: press,
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
}
