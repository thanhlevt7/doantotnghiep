import 'dart:async';

import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/products_api.dart';

enum Event {
  fetch,
}

class NewProductBloc {
  final _stateStreamController = StreamController<List<Product>>();
  StreamSink<List<Product>> get _newproductSink => _stateStreamController.sink;
  Stream<List<Product>> get newproductStream => _stateStreamController.stream;
  final _eventStreamController = StreamController<Event>();
  StreamSink<Event> get eventSink => _eventStreamController.sink;
  Stream<Event> get _eventStream => _eventStreamController.stream;

  NewProductBloc() {
    _eventStream.listen((event) async {
      if (event == Event.fetch) {
        var products = await RepositoryProduct.newProduct();
        try {
          if (products != null) {
            _newproductSink.add(products);
          } else {
            _newproductSink.addError('get products don\'t completed');
          }
        } on Exception {
          _newproductSink.addError('get products don\'t completed');
        }
      }
    });
  }

  void dispose() {
    _stateStreamController.close();
  }
}
