import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/products_api.dart';
import 'package:fluter_19pmd/views/details_product/details_product.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key key, this.products}) : super(key: key);
  final List<Product> products;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (widget.products == null) {
      return Column(
        children: [
          SizedBox(height: size.height * 0.3),
          const Center(
            child: Text(
              "Kết quả tìm kiếm!!!",
              style: TextStyle(
                fontSize: 25,
                color: Colors.teal,
              ),
            ),
          ),
        ],
      );
    } else {
      return ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              RepositoryProduct.getID = widget.products[index].id;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsProductScreen(
                    products: widget.products[index],
                  ),
                ),
              );
            },
            child: Card(
              elevation: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(
                    widget.products[index].image,
                    width: 150,
                    height: 150,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/icons-png/Check.png",
                            width: 30,
                            height: 30,
                          ),
                          Text(
                            widget.products[index].name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        width: size.width * 0.6,
                        height: 50,
                        child: Text(
                          widget.products[index].description,
                          style: const TextStyle(
                            fontSize: 19,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: _buildItemInfo(
                            text: "Giá bán:",
                            number: widget.products[index].price,
                            unit: widget.products[index].unit,
                          )),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }

  Widget _buildItemInfo({String text, int number, String unit}) => RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: text,
              style: const TextStyle(
                fontSize: 18,
                color: textColor,
              ),
            ),
            TextSpan(
              text: '${convertToVND(number)}đ',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            TextSpan(
              text: '/$unit',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
      );
}
