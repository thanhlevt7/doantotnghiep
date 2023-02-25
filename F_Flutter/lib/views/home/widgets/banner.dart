import 'package:fluter_19pmd/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

// ignore: must_be_immutable
class BannerHome extends StatelessWidget {
  BannerHome({
    Key key,
  }) : super(key: key);
  List banner = List.unmodifiable([
    {
      'title': "Trái cây tươi",
      'subTitle': "100%",
      'img': "assets/images/silder/hero-bg.jpg",
    },
    {
      'title': "Quả mọng",
      'subTitle': "Chọn lọc",
      'img': "assets/images/silder/hero-bg-2.jpg",
    },
    {
      'title': "Cam mỹ ngọt",
      'subTitle': "Mã Voucher : pqrbGC",
      'img': "assets/images/silder/hero-bg-3.jpg",
    }
  ]);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: numberPadding),
      height: size.height * 0.25,
      width: size.width,
      child: Swiper(
        autoplay: true,
        viewportFraction: 0.95,
        scale: 0.8,
        itemCount: banner.length,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Image.asset(
                    banner[index]['img'],
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: size.height,
                  width: size.width,
                  color: Colors.black.withOpacity(0.5),
                ),
                buildTextInSider(index)
              ],
            ),
          );
        },
      ),
    );
  }

  Padding buildTextInSider(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: numberPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //170 - 310 - 250
          Text(
            banner[index]['title'],
            style: const TextStyle(
              fontSize: 30,
              fontFamily: "RobotoSlab",
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 10),
          // ignore: avoid_unnecessary_containers
          Text(
            banner[index]['subTitle'],
            style: const TextStyle(
              fontSize: 18,
              fontFamily: "RobotoSlab",
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            child: Text(
              "shop now".toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
