import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/products_api.dart';
import 'package:fluter_19pmd/services/home/best_seller_bloc.dart';
import 'package:fluter_19pmd/views/details_product/details_product.dart';
import 'package:fluter_19pmd/views/home/widgets/banner.dart';
import 'package:fluter_19pmd/views/home/widgets/newProduct.dart';
import 'package:fluter_19pmd/views/home/widgets/products.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _bestSeller = BestSellerBloc();

  @override
  void initState() {
    _bestSeller.eventSink.add(Event.fetch);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _bestSeller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BannerHome(),
              const SizedBox(height: 30),
              loadBestSeller(size: size),
              const SizedBox(height: 20),
              const newProductPage(),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Tất cả sản phẩm",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF717171),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const ProductsHome(),
            ],
          ),
        ),
      ),
    );
  }

  Widget loadBestSeller({Size size}) => StreamBuilder<List<Product>>(
      initialData: [],
      stream: _bestSeller.bestSellerStream,
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
                  "Bán chạy",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF717171),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.35,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => Card(
                    color: Colors.white,
                    shadowColor: Colors.teal,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    margin: const EdgeInsets.all(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data[index].type,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.5,
                              ),
                              SizedBox(
                                height: 45,
                                width: 45,
                                child: Image.asset(
                                  'assets/images/icons-png/best_seller.png',
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 130,
                                width: 130,
                                child:
                                    Image.network(snapshot.data[index].image),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data[index].name,
                                    style: TextStyle(
                                      fontSize: 26,
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
                                          text: " ${snapshot.data[index].unit}",
                                          style: TextStyle(
                                            fontSize: 19,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 130,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                buttonColor),
                                      ),
                                      onPressed: () {
                                        RepositoryProduct.getID =
                                            snapshot.data[index].id;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailsProductScreen(
                                              products: snapshot.data[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Xem ngay',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Đã bán : ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey[500]),
                                      ),
                                      Text(
                                        "${snapshot.data[index].total}"
                                            .substring(9)
                                            .replaceAll(RegExp('}]'), ''),
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey[500]),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      });
}
