import 'dart:async';

import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/products_api.dart';

enum CategoryEvent {
  fetchAll,
  fetchFruit,
  fetchMeet,
  fetchDrink,
  fetchVegetable,
}

class CategoryBloc {
  final _stateStreamController = StreamController<List<Product>>();
  StreamSink<List<Product>> get _categorySink => _stateStreamController.sink;
  Stream<List<Product>> get categoryStream => _stateStreamController.stream;
  final _eventStreamController = StreamController<CategoryEvent>();
  StreamSink<CategoryEvent> get eventSink => _eventStreamController.sink;
  Stream<CategoryEvent> get _eventStream => _eventStreamController.stream;

  CategoryBloc() {
    _eventStream.listen((event) async {
      if (event == CategoryEvent.fetchAll) {
        var products = await RepositoryProduct.getAllProduct();

        if (products != null) {
          _categorySink.add(products);
        } else {
          _categorySink.addError('get All don\'t completed');
        }
      } else if (event == CategoryEvent.fetchFruit) {
        var products = await RepositoryProduct.getFruit();

        if (products != null) {
          _categorySink.add(products);
        } else {
          _categorySink.addError('get fruit don\'t completed');
        }
      } else if (event == CategoryEvent.fetchMeet) {
        var products = await RepositoryProduct.getMeat();

        if (products != null) {
          _categorySink.add(products);
        } else {
          _categorySink.addError('get meet don\'t completed');
        }
      } else if (event == CategoryEvent.fetchDrink) {
        var products = await RepositoryProduct.getDrink();

        if (products != null) {
          _categorySink.add(products);
        } else {
          _categorySink.addError('get drink don\'t completed');
        }
      } else if (event == CategoryEvent.fetchVegetable) {
        var products = await RepositoryProduct.getVegetable();

        if (products != null) {
          _categorySink.add(products);
        } else {
          _categorySink.addError('get vegetable don\'t completed');
        }
      }
    });
  }

  void dispose() {
    _stateStreamController.close();
  }
}
