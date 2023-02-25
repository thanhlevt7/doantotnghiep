import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/views/cart/cart_screen.dart';
import 'package:fluter_19pmd/views/category/category_page.dart';
import 'package:fluter_19pmd/views/home/widgets/body.dart';
import 'package:fluter_19pmd/views/notification/notification_page.dart';
import 'package:fluter_19pmd/views/profile/account/account_page.dart';
import 'package:fluter_19pmd/views/profile/profile_page.dart';
import 'package:fluter_19pmd/views/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //controller

  AnimationController animationController;
  int selectedIndex = 0;
  final screens = [
    const Body(),
    const CategoryPage(),
    const NotificationPage(),
    const ProfilePage(),
  ];
  final List _tabIcon = List.unmodifiable([
    {'icon': "assets/images/icons-png/home.png", 'title': "Home"},
    {'icon': "assets/images/icons-png/category.png", 'title': "Danh mục"},
    {'icon': "assets/images/icons-png/notification.png", 'title': "Thông báo"},
    {'icon': "assets/images/icons-png/me.png", 'title': "Me"},
  ]);
  void onTapChanges(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 200),
      lowerBound: 1.0,
      upperBound: 1.3,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.teal.shade700,
          actions: [
            Builder(builder: (context) {
              return SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buttonSearch(size, context),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartPage(),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: size.width * 0.12,
                            height: size.height * 0.08,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.shopping_cart_rounded,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    buildIcon(
                      size: size,
                      img: "assets/icons/person.svg",
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AccountPage()));
                      },
                    ),
                  ],
                ),
              );
            }),
          ],
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
        body: screens[selectedIndex],
        bottomNavigationBar: buildNavBar(),
      ),
    );
  }

  Widget buildNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal, Colors.teal.shade200],
          begin: Alignment.bottomLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, 0),
            color: Colors.grey,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          _tabIcon.length,
          (index) {
            return InkWell(
              onTap: () {
                if (index != selectedIndex) {
                  onTapChanges(index);
                  animationController
                      .forward()
                      .then((value) => animationController.reverse());
                }
              },
              child: ScaleTransition(
                scale: animationController,
                child: Column(
                  children: [
                    Image.asset(
                      _tabIcon[index]['icon'],
                      color: (selectedIndex == index)
                          ? Colors.white
                          : Colors.white70,
                    ),
                    Text(
                      _tabIcon[index]['title'],
                      style: TextStyle(
                        color: (selectedIndex == index)
                            ? Colors.white
                            : Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buttonSearch(size, context) => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchPage(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          width: size.width * 0.65,
          height: size.height * 0.06,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: Colors.grey.shade600,
              ),
              Text(
                "Tìm kiếm",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey.shade600,
                ),
              )
            ],
          ),
        ),
      );
  InkWell buildIcon({Size size, String img, Function() press}) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(15),
        width: size.width * 0.12,
        height: size.height * 0.08,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          img,
          fit: BoxFit.cover,
          color: textColor,
        ),
      ),
    );
  }
}
