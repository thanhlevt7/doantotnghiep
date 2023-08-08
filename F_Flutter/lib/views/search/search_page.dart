import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/products_api.dart';
import 'package:fluter_19pmd/services/home/product_bloc.dart';
import 'package:fluter_19pmd/views/search/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String type;
  String min;
  String max;

  final searchController = TextEditingController();
  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();
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
                actions: [
                  Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: buildIcon(
                        size: size,
                        img: "assets/icons/filter.svg",
                        press: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                      ),
                    );
                  }),
                ],
              ),
              body: Body(
                products: snapshot.data,
              ),
              endDrawer: Drawer(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top),
                      ),
                      _buildItem(),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  InkWell buildIcon({Size size, String img, Function() press}) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(15),
        width: size.width * 0.12,
        height: size.height * 0.08,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          img,
          fit: BoxFit.cover,
          color: textColor,
        ),
      ),
    );
  }

  Widget _search(size) => Container(
        width: size.width * 0.65,
        height: size.height * 0.055,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: TextField(
          controller: searchController,
          style: const TextStyle(
            fontSize: 22,
          ),
          onChanged: (value) async {
            if (value.isNotEmpty) {
              var results = await RepositoryProduct.filterProuct(value);
              _resultBloc.searchSink.add(results);
            }
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
          ),
        ),
      );

  Widget _buildItem() => Column(
        children: [
          _buildText('Chọn loại'),
          Column(
            children: [
              typeProduct("Trái cây", "Trái cây"),
              typeProduct("Thức uống", "Thức uống"),
              typeProduct("Thịt", "Thịt"),
              typeProduct("Rau củ", "Rau củ"),
            ],
          ),
          const SizedBox(height: 10.0),
          _buildText('Khoảng giá(đ)'),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              inputPrice("Tối thiểu", (value) {
                setState(() {
                  min = value;
                });
              }, minPriceController),
              inputPrice("Tối đa", (value) {
                setState(() {
                  max = value;
                });
              }, maxPriceController),
            ],
          ),
          Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              _buildList(
                  text: "0-100k",
                  press: () {
                    min = "0";
                    minPriceController.text = "0";
                    max = "100000";
                    maxPriceController.text = "100000";
                  }),
              _buildList(
                  text: "100k-200k",
                  press: () {
                    min = "100000";
                    minPriceController.text = "100000";
                    max = "200000";
                    maxPriceController.text = "200000";
                  }),
              _buildList(
                  text: "200k-300k",
                  press: () {
                    min = "200000";
                    minPriceController.text = "200000";
                    max = "300000";
                    maxPriceController.text = "300000";
                  }),
              _buildList(
                  text: "300k-400k",
                  press: () {
                    min = "300000";
                    minPriceController.text = "300000";
                    max = "400000";
                    maxPriceController.text = "400000";
                  }),
            ],
          ),
          const SizedBox(height: 20.0),
          _submit(type),
        ],
      );

  Widget _buildText(text) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 23,
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
  Widget typeProduct(text, value) => ListTile(
        title: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
        leading: Radio(
            value: value,
            groupValue: type,
            onChanged: (newValue) {
              setState(() {
                type = newValue;
              });
            }),
      );
  Widget inputPrice(String text, onpress, controller) => SizedBox(
        width: 100,
        child: TextFormField(
            controller: controller,
            maxLength: 7,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              floatingLabelStyle: TextStyle(
                fontSize: 22,
                color: Colors.grey.shade500,
              ),
              enabledBorder: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(),
              hintText: text,
            ),
            onChanged: (onpress)),
      );

  Widget _buildList({text, Function press}) => InkWell(
        onTap: press,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          height: 60,
          width: 120,
          decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: Colors.grey.shade400),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 19,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ),
      );

  Widget _submit(type) => Align(
        alignment: Alignment.bottomCenter,
        child: Builder(builder: (context) {
          return InkWell(
            onTap: () async {
              if (minPriceController.text.isNotEmpty &&
                  maxPriceController.text.isNotEmpty) {
                int a = int.parse(min);
                int b = int.parse(max);
                if (a < b) {
                  var results = await RepositoryProduct.filterProuct(
                      searchController.text,
                      minPrice: minPriceController.text,
                      maxPrice: maxPriceController.text,
                      typeProduct: type);
                  _resultBloc.searchSink.add(results);
                  Scaffold.of(context).closeEndDrawer();
                } else {
                  print("thay đổi giá coi");
                }
              } else {
                var results = await RepositoryProduct.filterProuct(
                    searchController.text,
                    minPrice: minPriceController.text,
                    maxPrice: maxPriceController.text,
                    typeProduct: type);
                _resultBloc.searchSink.add(results);
                Scaffold.of(context).closeEndDrawer();
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              decoration: const BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              height: 50,
              width: 180,
              child: const Center(
                  child: Text('Áp dụng',
                      style: TextStyle(fontSize: 20, color: Colors.white))),
            ),
          );
        }),
      );
}
