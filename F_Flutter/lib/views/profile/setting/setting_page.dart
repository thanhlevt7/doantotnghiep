import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/views/forgot_password/change_password_page.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class settingPage extends StatefulWidget {
  const settingPage({Key key}) : super(key: key);

  @override
  State<settingPage> createState() => _settingPageState();
}

// ignore: camel_case_types
class _settingPageState extends State<settingPage> {
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
            "Cài đặt",
            style: TextStyle(
              fontFamily: "Pacifico",
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Column(children: [
          const SizedBox(height: 12),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangePassword(
                    email: RepositoryUser.info.email.toString(),
                  ),
                ),
              );
            },
            child: const ListTile(
              title: Text(
                "Đổi mật khẩu",
                style: TextStyle(
                  fontSize: 23,
                ),
              ),
              trailing: Icon(Icons.arrow_right),
            ),
          ),
        ]),
      ),
    );
  }
}
