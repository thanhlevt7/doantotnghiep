import 'dart:async';

import 'package:fluter_19pmd/repository/cart_api.dart';

import '../../../counter_event.dart';

class CounterBloc {
  final _stateStreamController = StreamController<int>();
  StreamSink<int> get counterSink => _stateStreamController.sink;
  Stream<int> get counterStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<CounterEvent>();
  StreamSink<CounterEvent> get eventSink => _eventStreamController.sink;
  Stream<CounterEvent> get _eventStream => _eventStreamController.stream;
  CounterBloc() {
    _eventStream.listen((event) async {
      if (event == CounterEvent.increment) {
        await RepositoryCart.updateQuantityIncrement();
      } else if (event == CounterEvent.decrement) {
        await RepositoryCart.updateQuantityDecrement();
      }
    });
  }
  void dispose() {
    _stateStreamController.close();
  }
}
