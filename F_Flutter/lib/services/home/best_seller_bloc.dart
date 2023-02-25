import 'dart:async';

import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/products_api.dart';

enum Event {
  fetch,
}

class BestSellerBloc {
  final _stateStreamController = StreamController<List<Product>>();
  StreamSink<List<Product>> get bestSellerSink => _stateStreamController.sink;
  Stream<List<Product>> get bestSellerStream => _stateStreamController.stream;
  final _eventStreamController = StreamController<Event>();
  StreamSink<Event> get eventSink => _eventStreamController.sink;
  Stream<Event> get _eventStream => _eventStreamController.stream;

  BestSellerBloc() {
    _eventStream.listen((event) async {
      if (event == Event.fetch) {
        var products = await RepositoryProduct.bestSeller();
        try {
          if (products != null) {
            bestSellerSink.add(products);
          } else {
            bestSellerSink.addError('get products don\'t completed');
          }
        } on Exception {
          bestSellerSink.addError('get products don\'t completed');
        }
      }
    });
  }

  void dispose() {
    _stateStreamController.close();
  }
}
