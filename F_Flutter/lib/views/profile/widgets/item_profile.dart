import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/views/login/signIn_screen.dart';
import 'package:fluter_19pmd/views/profile/account/account_page.dart';
import 'package:fluter_19pmd/views/profile/collections/collection_page.dart';
import 'package:fluter_19pmd/views/profile/order/order_page.dart';
import 'package:fluter_19pmd/views/profile/setting/setting_page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemProfile extends StatelessWidget {
  int index;
  // ignore: prefer_typing_uninitialized_variables
  var profiles;
  ItemProfile({
    Key key,
    this.profiles,
    this.index,
  }) : super(key: key);

  final pages = [
    const AccountPage(),
    const OrderPage(),
    const CollectionPage(),
    const settingPage(),
    const SignInPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (profiles[index]['text'] == 'Đăng xuất') {
          var code = await RepositoryUser.logout(context);
          if (code == 200) {
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
                builder: (context) => pages[index],
              ),
            );
          }
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => pages[index],
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
                  Image.asset(profiles[index]['icon'], width: 60, height: 60),
                  Text(
                    profiles[index]['text'],
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
