import 'dart:async';

import 'package:fluter_19pmd/models/invoices_models.dart';
import 'package:fluter_19pmd/repository/cart_api.dart';
import 'package:fluter_19pmd/services/cart/cart_event.dart';

class CartBloc {
  //fetch cart
  final _stateStreamController = StreamController<List<Cart>>();
  StreamSink<List<Cart>> get _cartSink => _stateStreamController.sink;
  Stream<List<Cart>> get cartStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<CartEvent>();
  StreamSink<CartEvent> get eventSink => _eventStreamController.sink;
  Stream<CartEvent> get _eventStream => _eventStreamController.stream;
  CartBloc() {
    _eventStream.listen((event) async {
      if (event == CartEvent.fetchCart) {
        getCart();
      } else if (event == CartEvent.increment) {
      } else if (event == CartEvent.decrement) {}
    });
  }
  void getCart() async {
    var carts = await RepositoryCart.getCart();

    if (carts != null) {
      _cartSink.add(carts);
    } else {
      _cartSink.addError('get products don\'t completed');
    }
  }

  void dispose() {
    _stateStreamController.close();
  }
}
