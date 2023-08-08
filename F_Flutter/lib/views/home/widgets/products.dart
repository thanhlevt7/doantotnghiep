import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/cart_api.dart';
import 'package:fluter_19pmd/repository/favorites_api.dart';
import 'package:fluter_19pmd/repository/products_api.dart';
import 'package:fluter_19pmd/services/home/product_bloc.dart';
import 'package:fluter_19pmd/views/details_product/details_product.dart';
import 'package:flutter/material.dart';

import '../../../function.dart';

class ProductsHome extends StatefulWidget {
  const ProductsHome({
    Key key,
  }) : super(key: key);

  @override
  State<ProductsHome> createState() => _ProductsHomeState();
}

class _ProductsHomeState extends State<ProductsHome> {
  List<String> image;
  final productBloc = ProductBloc();
  @override
  void initState() {
    productBloc.eventSink.add(EventProduct.fetch);
    super.initState();
  }

  @override
  void dispose() {
    productBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        StreamBuilder<List<Product>>(
            initialData: [],
            stream: productBloc.productStream,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SizedBox(
                  height: size.height * RepositoryProduct.getHeight(),
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        final images = snapshot.data[index].image;
                        image = images.split(",");
                        return InkWell(
                          onTap: () {
                            RepositoryProduct.getID = snapshot.data[index].id;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsProductScreen(
                                  products: snapshot.data[index],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: SizedBox(
                                          height: 150,
                                          child: Image.network(image[0])),
                                    ),
                                    _contentCard(snapshot, index, context),
                                  ]),
                            ),
                          ),
                        );
                      }),
                );
              }
            }),
      ],
    );
  }

  Widget _contentCard(
      AsyncSnapshot<List<Product>> snapshot, int index, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 35,
          child: Text(
            snapshot.data[index].name,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black.withOpacity(0.8),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${convertToVND(snapshot.data[index].price)}đ",
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.red,
                ),
              ),
              TextSpan(
                text: "\\ ${snapshot.data[index].unit}",
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            SizedBox(
              height: 40,
              width: 130,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(buttonColor),
                ),
                onPressed: () async {
                  var message =
                      await RepositoryCart.addToCart(snapshot.data[index].id);
                  if (message == null) {
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDiaLogCustom(
                            text: "-Thêm sản phẩm vào giỏ hàng.",
                            json: "assets/done.json",
                          );
                        });
                  }
                },
                child: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                if (!snapshot.data[index].checkFavorite) {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertTextFieldCustom(
                          title: "Bộ yêu thích",
                          productID: snapshot.data[index].id,
                        );
                      });
                  productBloc.eventSink.add(EventProduct.fetch);
                } else {
                  await RepositoryFavorite.deleteProduct(
                      snapshot.data[index].id);
                  productBloc.eventSink.add(EventProduct.fetch);
                }
              },
              icon: snapshot.data[index].checkFavorite
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.favorite_border,
                      color: Colors.teal,
                    ),
            )
          ],
        ),
      ],
    );
  }
}
