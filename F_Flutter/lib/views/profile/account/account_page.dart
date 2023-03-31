import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/views/profile/account/widgets/body.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appbar("Thiết lập tài khoản", context),
        body: const Body(),
      ),
    );
  }
}
