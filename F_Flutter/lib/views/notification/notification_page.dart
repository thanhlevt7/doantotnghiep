import 'package:fluter_19pmd/views/notification/widgets/body.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.5,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.teal.shade200],
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Center(
            child: Text(
              "Thông báo",
              style: TextStyle(
                fontFamily: "Pacifico",
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: const Body(),
      ),
    );
  }
}
