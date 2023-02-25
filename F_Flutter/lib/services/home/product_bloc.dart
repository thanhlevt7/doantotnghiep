import 'dart:async';

import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/products_api.dart';

enum EventProduct { fetch, viewDetails, search, filter }

class ProductBloc {
  final _stateStreamController = StreamController<List<Product>>();
  StreamSink<List<Product>> get _productSink => _stateStreamController.sink;
  Stream<List<Product>> get productStream => _stateStreamController.stream;

  final _stateSearchStreamController = StreamController<List<Product>>();
  StreamSink<List<Product>> get searchSink => _stateSearchStreamController.sink;
  Stream<List<Product>> get searchStream => _stateSearchStreamController.stream;

  final _eventStreamController = StreamController<EventProduct>();
  StreamSink<EventProduct> get eventSink => _eventStreamController.sink;
  Stream<EventProduct> get _eventStream => _eventStreamController.stream;

  ProductBloc() {
    _eventStream.listen((event) async {
      if (event == EventProduct.fetch) {
        var products = await RepositoryProduct.getAllProduct();
        if (products != null) {
          _productSink.add(products);
        } else {
          _productSink.addError('get products don\'t completed');
        }
      }
    });
  }

  void dispose() {
    _stateStreamController.close();
    _stateSearchStreamController.close();
  }
}
