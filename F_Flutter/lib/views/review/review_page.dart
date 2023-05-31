import 'dart:async';
import 'dart:io';
import 'package:fluter_19pmd/models/invoices_models.dart';
import 'package:fluter_19pmd/repository/review_api.dart';
import 'package:fluter_19pmd/services/invoiceForUser/invoice_bloc.dart';
import 'package:fluter_19pmd/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../repository/user_api.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:full_screen_image/full_screen_image.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key key, this.invoice}) : super(key: key);
  final Invoices invoice;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List<String> imageProduct;
  List image;
  final _invoiceSuccess = InvoiceBloc();
  final _stateStreamController = StreamController<int>();
  String rating = "5";
  List<String> strarray;
  int indexId;
  List dataReviews = [];
  Future getImage(int value) async {
    RepositoryUser.image.clear();
    var image = await ImagePicker().pickMultiImage();
    if (image != null) {
      if (image.length > 5) {
        image.length = 5;
      }
      for (int i = 0; i < image.length; i++) {
        var index = i + 1;
        EasyLoading.show(status: 'Đang tải ảnh $index', dismissOnTap: true);
        await RepositoryUser.uploadFile(File(image[i].path));
        EasyLoading.showSuccess('Hoàn tất! ');
      }
      changeValue(RepositoryUser.image.join(","), "image", value);
      changeValue(RepositoryUser.image.length.toString(), "countImage", value);
      setState(() {});
    }
  }

  void changeValue(String value, String key, int index) {
    Map data = dataReviews.asMap();
    data[index].update(key, (valueKey) {
      return value;
    });
  }

  @override
  void initState() {
    for (int i = 0; i < widget.invoice.products.length; i++) {
      dataReviews.add({
        "id": widget.invoice.products[i].id,
        "content": "",
        "starNumber": "5.0",
        "image": "",
        "countImage": "",
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _invoiceSuccess.dispose();
    _stateStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    print(dataReviews);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Đánh giá sản phẩm"),
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
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            'assets/icons/arrow_back.svg',
            color: Colors.white,
            width: 30,
            height: 30,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                for (int i = 0; i < widget.invoice.products.length; i++) {
                  final idInvoice = widget.invoice.id.toString();
                  final productId = widget.invoice.products[i].id.toString();
                  final content = dataReviews[i]["content"].toString();
                  final starNumber = dataReviews[i]["starNumber"].toString();
                  final image = dataReviews[i]["image"].toString();
                  await RepositoryReview.post(
                      idInvoice, productId, content, image, starNumber);
                }
                EasyLoading.showSuccess('Hoàn tất! ');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: const Text(
                "Gửi",
                style: TextStyle(fontSize: 18, color: Colors.red),
              ))
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView.builder(
            itemCount: widget.invoice.products.length,
            itemBuilder: (context, index) {
              var image = widget.invoice.products[index].image.toString();
              imageProduct = image.split(",");

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Card(
                      child: Row(
                        children: [
                          Image.network(
                            imageProduct[0],
                            width: 80,
                            height: 80,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.invoice.products[index].name.toString(),
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Chất lượng sản phẩm",
                          style: TextStyle(fontSize: 16),
                        ),
                        RatingBar.builder(
                          initialRating:
                              double.parse(dataReviews[index]["starNumber"]),
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 3.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (value) {
                            setState(() {
                              indexId = index;
                              changeValue(
                                  value.toString(), "starNumber", indexId);
                              rating = value.toString();
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    dataReviews[index]["image"].toString().isNotEmpty
                        ? SizedBox(
                            height: 200,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ListView.separated(
                                itemCount:
                                    int.parse(dataReviews[index]["countImage"]),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 15,
                                ),
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, snapshot) {
                                  final image1 = dataReviews[index]["image"];
                                  strarray = image1.split(",");
                                  return FullScreenWidget(
                                      backgroundIsTransparent: false,
                                      disposeLevel: DisposeLevel.High,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          strarray[snapshot].toString(),
                                          width: 120,
                                          height: 120,
                                        ),
                                      ));
                                },
                              ),
                            ),
                          )
                        : Center(
                            child: InkWell(
                              onTap: () {
                                indexId = index;
                                getImage(indexId);
                              },
                              child: const Text(
                                "Thêm hình ảnh",
                                style:
                                    TextStyle(fontSize: 20, color: Colors.blue),
                              ),
                            ),
                          ),
                    dataReviews[index]["image"].toString().isNotEmpty
                        ? Center(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  indexId = index;
                                  changeValue("", "image", indexId);
                                });
                              },
                              child: const Text(
                                "Xóa ảnh",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.blue),
                              ),
                            ),
                          )
                        : Container(height: 0),
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
                        initialValue: dataReviews[index]["content"],
                        minLines: 4,
                        maxLines: null,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: 'Hãy chia sẻ nhận xét sản phẩm này',
                            border: const OutlineInputBorder(),
                            labelStyle: TextStyle(
                              color: Colors.grey.shade400,
                            )),
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 22.0,
                        ),
                        onChanged: (value) {
                          changeValue(value, "content", index);
                        },
                        onTapOutside: (event) => event,
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
