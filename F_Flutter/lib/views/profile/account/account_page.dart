import 'package:fluter_19pmd/views/profile/account/widgets/body.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.teal.shade200],
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          elevation: 0.5,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.white,
            ),
          ),
          title: const Text(
            "Thiết lập tài khoản",
            style: TextStyle(
              fontFamily: "Pacifico",
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: const Body(),
      ),
    );
  }
}
