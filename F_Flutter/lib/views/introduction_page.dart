import 'dart:async';
import 'package:fluter_19pmd/views/login/signIn_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key key, this.title, this.content, this.json})
      : super(key: key);
  final String title, content;
  final String json;

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Lottie.asset(widget.json),
              Center(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 35,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  height: 100,
                  child: Text(
                    widget.content,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey.shade700,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

class Welcome extends StatefulWidget {
  const Welcome({Key key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final controller = PageController(initialPage: 0);
  final _stateStreamController = StreamController<int>();
  StreamSink<int> get intSink => _stateStreamController.sink;
  Stream<int> get intStream => _stateStreamController.stream;
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    _stateStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        initialData: controller.initialPage,
        stream: intStream,
        builder: (context, indexPage) {
          return Scaffold(
            bottomNavigationBar:
                indexPage.data == 2 ? null : buildNavBar(indexPage.data),
            body: PageView(
              onPageChanged: (index) {
                intSink.add(index);
              },
              controller: controller,
              children: const [
                IntroductionPage(
                  title: "Xin chào bạn!",
                  content: "Chào mừng đến với BEHEALTHY",
                  json: "assets/supermarket.json",
                ),
                IntroductionPage(
                  title: "BEHEALTHY",
                  content: "Hôm nay mua gì?",
                  json: "assets/food.json",
                ),
                SignInPage(),
              ],
            ),
          );
        });
  }

  Widget buildNavBar(indexPage) {
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
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        TextButton(
          onPressed: () {
            controller.previousPage(
                duration: const Duration(seconds: 1), curve: Curves.easeInOut);
            intSink.add(indexPage - 1);
          },
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInPage(),
                    ),
                  );
                },
                child: const Text(
                  'Bỏ qua',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            controller.nextPage(
                duration: const Duration(seconds: 1), curve: Curves.easeInOut);
            intSink.add(indexPage + 1);
          },
          child: Row(
            children: const [
              Text(
                'Kế tiếp',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              Icon(
                Icons.arrow_right,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
