import 'package:fluter_19pmd/services/home/new_product_bloc.dart';
import 'package:flutter/material.dart';
import '../../../function.dart';
import '../../../models/product_models.dart';
import '../../../repository/products_api.dart';
import '../../details_product/details_product.dart';

// ignore: camel_case_types
class newProductPage extends StatefulWidget {
  const newProductPage({Key key}) : super(key: key);

  @override
  State<newProductPage> createState() => _newProductPageState();
}

// ignore: camel_case_types
class _newProductPageState extends State<newProductPage> {
  List<String> image;
  final _newProduct = NewProductBloc();

  @override
  void initState() {
    _newProduct.eventSink.add(Event.fetch);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _newProduct.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder<List<Product>>(
        initialData: const [],
        stream: _newProduct.newproductStream,
        builder: (context, snapshot) {
          if (snapshot.data.isEmpty) {
            return const Text("");
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Sản phẩm mới",
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFF717171),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.3,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        final currentTime = DateTime.now();
                        final createDate = DateTime.parse(
                            snapshot.data[index].createDate.toString());
                        final results = currentTime.difference(createDate);
                        final images = snapshot.data[index].image;
                        image = images.split(",");
                        return Card(
                          color: Colors.white,
                          shadowColor: Colors.teal,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          margin: const EdgeInsets.all(12),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: InkWell(
                              onTap: () {
                                RepositoryProduct.getID =
                                    snapshot.data[index].id;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsProductScreen(
                                      products: snapshot.data[index],
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        snapshot.data[index].type,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 150),
                                      _timeNewProduct(results),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 130,
                                        width: 130,
                                        child: Image.network(image[0]),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data[index].name,
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.grey.shade500,
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "${convertToVND(snapshot.data[index].price)}đ",
                                                  style: TextStyle(
                                                    fontSize: 19,
                                                    color: Colors.grey.shade500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "\\",
                                                  style: TextStyle(
                                                    fontSize: 19,
                                                    color: Colors.grey.shade500,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      " ${snapshot.data[index].unit}",
                                                  style: TextStyle(
                                                    fontSize: 19,
                                                    color: Colors.grey.shade500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          }
        });
  }
}

Widget _timeNewProduct(results) {
  if (results.inSeconds < 60 &&
      results.inMinutes == 0 &&
      results.inHours == 0) {
    return Text(
      '${results.inSeconds} giây trước',
      style: const TextStyle(fontSize: 18, color: Colors.red),
    );
  } else if (results.inMinutes > 0 &&
      results.inMinutes < 60 &&
      results.inHours == 0) {
    return Text(
      '${results.inMinutes} phút trước',
      style: const TextStyle(fontSize: 18, color: Colors.red),
    );
  } else if (results.inHours > 0 && results.inHours < 24) {
    return Text(
      '${results.inHours} giờ trước',
      style: const TextStyle(fontSize: 18, color: Colors.red),
    );
  } else {
    return Text(
      '${(results.inHours / 24).toInt()} ngày trước',
      style: const TextStyle(fontSize: 18, color: Colors.red),
    );
  }
}
