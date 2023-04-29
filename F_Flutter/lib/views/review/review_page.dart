import 'dart:async';
import 'dart:io';
import 'package:fluter_19pmd/bloc/loading_bloc.dart';
import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/repository/review_api.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../repository/user_api.dart';
import '../home/home_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:full_screen_image/full_screen_image.dart';

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
  final loadImage = LoadImage();
  final _invoiceSuccess = InvoiceBloc();
  final _isLoading = LoadingBloc();
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  final _stateStreamController = StreamController<int>();
  String rating = "5";
  List<String> strarray;

  Future getImage() async {
    var image = await ImagePicker().pickMultiImage();
    if (image != null) {
      if (image.length > 5) {
        for (int i = 0; i < 5; i++) {
          var index = i + 1;
          EasyLoading.show(status: 'Đang tải ảnh $index');
          await RepositoryUser.uploadFile(File(image[i].path));
          EasyLoading.showSuccess('Hoàn tất! ');
        }
        loadImage.getSink.add(RepositoryUser.image.join(","));
      } else {
        for (int i = 0; i < image.length; i++) {
          var index = i + 1;
          EasyLoading.show(status: 'Đang tải ảnh $index');
          await RepositoryUser.uploadFile(File(image[i].path));
          EasyLoading.showSuccess('Hoàn tất! ');
        }
        loadImage.getSink.add(RepositoryUser.image.toString());
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
          leading: IconButton(
            onPressed: () {
              RepositoryUser.image.clear();
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(
              'assets/icons/arrow_back.svg',
              color: Colors.white,
              width: 30,
              height: 30,
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
              const SizedBox(height: 30),
              SizedBox(
                // height: 200,
                child: StreamBuilder(
                  initialData: [],
                  stream: loadImage.getStream,
                  builder: (context, snapshot) {
                    if (snapshot.data.isNotEmpty &&
                        snapshot.connectionState == ConnectionState.active &&
                        RepositoryUser.image.isNotEmpty) {
                      final image = RepositoryUser.image.join(",");
                      strarray = image.split(",");
                      return SizedBox(
                        height: 100,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: strarray.length,
                            itemBuilder: (context, snapshot) {
                              return Column(
                                children: [
                                  Stack(children: [
                                    FullScreenWidget(
                                      backgroundIsTransparent: false,
                                      disposeLevel: DisposeLevel.High,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          strarray[snapshot],
                                          width: 100,
                                          height: 100,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        right: 0,
                                        child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                RepositoryUser.image
                                                    .removeAt(snapshot);
                                                loadImage.getSink.add(
                                                    RepositoryUser.image
                                                        .toString());
                                              });
                                            },
                                            child: const Icon(Icons.close)))
                                  ]),
                                ],
                              );
                            }),
                      );
                    } else {
                      return Row(
                        children: [
                          const SizedBox(width: 35),
                          InkWell(
                            onTap: () {
                              getImage();
                            },
                            child: const Text(
                              "Thêm hình ảnh",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.blue),
                            ),
                          ),
                          const Text(
                            "  (Chỉ chọn được 5 ảnh)",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
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
                        image: RepositoryUser.image.join(","),
                      );
                      if (data == 200) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                        EasyLoading.showSuccess('Hoàn tất! ');
                      }
                    }),
              ),
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

class LoadImage {
  final _stateStreamController = StreamController<String>();
  StreamSink<String> get getSink => _stateStreamController.sink;
  Stream<String> get getStream => _stateStreamController.stream;

  void dispose() {
    _stateStreamController.close();
  }
}
