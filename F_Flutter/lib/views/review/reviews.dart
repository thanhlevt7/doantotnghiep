import 'package:fluter_19pmd/views/review/widgets/haveEvaluated.dart';
import 'package:fluter_19pmd/views/review/widgets/not_yet_rated.dart';
import 'package:flutter/material.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({Key key}) : super(key: key);

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            bottom: buildTabbar(),
            elevation: 0,
            backgroundColor: Colors.white,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal, Colors.teal.shade200],
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            title: const Text(
              "Đánh giá của tôi",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          body: bodyTabbar(),
        ),
      ),
    );
  }

  Widget bodyTabbar() => const TabBarView(children: [
        NotYetRated(),
        HaveEvaluated(),
      ]);

  Widget buildTabbar() => const TabBar(
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        isScrollable: true,
        tabs: [
          Tab(
            child: Text(
              "Chưa đánh giá",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Đã đánh giá",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
}
