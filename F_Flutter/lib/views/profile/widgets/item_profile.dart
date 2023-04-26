import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/views/login/signIn_screen.dart';
import 'package:fluter_19pmd/views/profile/account/account_page.dart';
import 'package:fluter_19pmd/views/profile/collections/collection_page.dart';
import 'package:fluter_19pmd/views/profile/order/order_page.dart';
import 'package:fluter_19pmd/views/profile/setting/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ItemProfile extends StatefulWidget {
  int index;
  // ignore: prefer_typing_uninitialized_variables
  var profiles;
  ItemProfile({
    Key key,
    this.profiles,
    this.index,
  }) : super(key: key);

  @override
  State<ItemProfile> createState() => _ItemProfileState();
}

class _ItemProfileState extends State<ItemProfile> {
  SharedPreferences logindata;

  final pages = [
    const AccountPage(),
    const OrderPage(),
    const CollectionPage(),
    const settingPage(),
    const settingPage(),
    const SignInPage(),
  ];

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (widget.profiles[widget.index]['text'] == 'Đăng xuất') {
          var code = await RepositoryUser.logout(context);
          if (code == 200) {
            setState(() {
              logindata.setBool('login', true);
            });
            await showDialog(
                context: context,
                builder: (context) {
                  return AlertDiaLogCustom(
                    json: "assets/done.json",
                    text: "Đăng xuất thành công.",
                  );
                });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => pages[widget.index],
              ),
            );
          }
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => pages[widget.index],
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: textColor.withOpacity(0.2),
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.teal.shade200],
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(widget.profiles[widget.index]['icon'],
                      width: 60, height: 60),
                  Text(
                    widget.profiles[widget.index]['text'],
                    style: const TextStyle(
                      fontSize: 20,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
