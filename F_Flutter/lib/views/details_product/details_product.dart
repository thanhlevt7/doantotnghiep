import 'package:fluter_19pmd/bloc/loading_bloc.dart';
import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/cart_api.dart';
import 'package:fluter_19pmd/repository/products_api.dart';
import 'package:fluter_19pmd/views/buynow/buynow_page.dart';
import 'package:fluter_19pmd/views/cart/cart_screen.dart';
import 'package:fluter_19pmd/views/details_product/widgets/body.dart';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../repository/user_api.dart';
import '../profile/account/widgets/address/create_adress_page.dart';

class DetailsProductScreen extends StatefulWidget {
  const DetailsProductScreen({Key key, this.products}) : super(key: key);
  final Product products;
  @override
  State<DetailsProductScreen> createState() => _DetailsProductScreenState();
}

class _DetailsProductScreenState extends State<DetailsProductScreen> {
  final _isLoading = LoadingBloc();
  List<String> image;

  @override
  void dispose() {
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listImage = widget.products.image;
    image = listImage.split(",");
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: (widget.products == null)
          ? Scaffold(
              body: Column(
                children: [
                  SizedBox(height: size.height * 0.45),
                  const Center(
                    child: CircularProgressIndicator(
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            )
          : Scaffold(
              backgroundColor: Colors.white,
              body: NestedScrollView(
                  floatHeaderSlivers: true,
                  headerSliverBuilder: (context, innerBoxIsScroll) => [
                        SliverAppBar(
                          backgroundColor: Colors.white,
                          elevation: 2,
                          leading: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.red,
                              size: 24,
                            ),
                          ),
                          actions: [
                            (widget.products.checkFavorite)
                                ? const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 24,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: InkWell(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.favorite_outline,
                                        color: Colors.red,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                          ],
                          snap: true,
                          floating: true,
                          pinned: true,
                          expandedHeight: 280,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Swiper(
                              autoplay: true,
                              viewportFraction: 0.95,
                              scale: 0.8,
                              pagination: const SwiperPagination(
                                  alignment: Alignment.bottomRight),
                              itemCount: image.length,
                              control: const SwiperControl(
                                  color: Colors.black, size: 15),
                              itemBuilder: (context, index) {
                                return Image.network(image[index]);
                              },
                            ),
                          ),
                        ),
                      ],
                  body: Body(details: widget.products)),
              bottomNavigationBar: _buildBottomNav(size, context),
            ),
    );
  }

  Widget _buildBottomNav(size, context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.white],
          begin: Alignment.bottomLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, 0),
            color: Colors.grey,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<bool>(
              initialData: false,
              stream: _isLoading.loadingStream,
              builder: (context, state) {
                return SizedBox(
                  width: size.width * 0.5,
                  height: size.height * 0.08,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        buttonColor,
                      ),
                    ),
                    onPressed: () async {
                      if (widget.products.stock == 0) {
                        showDialog<void>(
                          context: context,
                          // barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              content: Center(
                                child: Column(
                                  children: const [
                                    Text(
                                      "Đã hết sản phẩm",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.red),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        _isLoading.loadingSink.add(true);

                        var data = await RepositoryCart.addToCartDetails(
                            RepositoryProduct.getID);
                        if (data == 200) {
                          _isLoading.loadingSink.add(false);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CartPage(),
                              ));
                        }
                      }
                    },
                    child: (state.data)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.car_repair_sharp),
                              Text(
                                "Đang xử lý ...",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.card_travel),
                              Text(
                                "Thêm giỏ hàng",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                  ),
                );
              }),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            width: size.width * 0.4,
            height: size.height * 0.08,
            child: ElevatedButton(
              onPressed: () async {
                if (widget.products.stock == 0) {
                  showDialog<void>(
                    context: context,
                    // barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        scrollable: true,
                        content: Center(
                          child: Column(
                            children: const [
                              Text(
                                "Đã hết sản phẩm",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  await RepositoryUser.countAddressForUser(
                      RepositoryUser.info.id);
                  if (RepositoryUser.countAddress == 0) {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          content: Center(
                            child: Column(
                              children: const [
                                Text(
                                  "Bạn chưa có địa chỉ vui lòng thêm địa chỉ giao hàng",
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  child: const Text(
                                    'Quay lại',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text(
                                    'Tạo mới',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.teal,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CreateAddress()));
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BuyNowPage(
                                  products: widget.products,
                                  quantity: RepositoryCart.getQuantity,
                                )));
                  }
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  buttonColor,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.card_travel),
                  Text(
                    "Mua ngay",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
