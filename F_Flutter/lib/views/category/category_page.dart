import 'package:fluter_19pmd/views/category/export_category.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            bottom: buildTab(),
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
            title: const Center(
              child: Text(
                "Danh mục",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          body: _item(),
          // body: Body(),
        ),
      ),
    );
  }

  Widget _item() => const TabBarView(
        dragStartBehavior: DragStartBehavior.down,
        children: [
          AllPage(),
          FruitPage(),
          MeetPage(),
          DrinkPage(),
          VegetablePage(),
        ],
      );
  Widget buildTab() => const TabBar(
        indicatorColor: Colors.white,
        indicatorWeight: 3,
        isScrollable: true,
        tabs: [
          Tab(
            child: Text(
              "Tất cả",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Trái cây",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Thịt",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Thức uống",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Rau củ",
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
