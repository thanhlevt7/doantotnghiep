import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/products_api.dart';
import 'package:fluter_19pmd/services/home/product_bloc.dart';
import 'package:fluter_19pmd/views/search/body.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _resultBloc = ProductBloc();
  @override
  void dispose() {
    _resultBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: StreamBuilder<List<Product>>(
          initialData: null,
          stream: _resultBloc.searchStream,
          builder: (context, snapshot) {
            return Scaffold(
              backgroundColor: Colors.grey.shade100,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.teal.shade700,
                title: _search(size),
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
              body: Body(
                products: snapshot.data,
              ),
            );
          }),
    );
  }

  Widget _search(size) => Container(
        width: size.width * 0.65,
        height: size.height * 0.06,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: TextField(
          style: const TextStyle(
            fontSize: 22,
          ),
          onChanged: (value) async {
            var results = await RepositoryProduct.resultSearch(value);
            _resultBloc.searchSink.add(results);
          },
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 30,
            ),
            hintText: "Tìm kiếm...",
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            prefixIcon: const Icon(
              Icons.search,
              size: 25,
              color: Colors.black87,
            ),
          ),
        ),
      );
}
