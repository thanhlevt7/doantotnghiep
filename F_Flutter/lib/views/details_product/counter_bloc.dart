import 'dart:async';

import 'package:fluter_19pmd/counter_event.dart';
import 'package:fluter_19pmd/repository/cart_api.dart';

class CounterDetailsBloc {
  int counter;
  final _stateStreamController = StreamController<int>();
  StreamSink<int> get counterSink => _stateStreamController.sink;
  Stream<int> get counterStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<CounterEvent>();
  StreamSink<CounterEvent> get eventSink => _eventStreamController.sink;
  Stream<CounterEvent> get eventStream => _eventStreamController.stream;

  final _stateTotalStreamController = StreamController<int>();
  StreamSink<int> get totalSink => _stateTotalStreamController.sink;
  Stream<int> get totalStream => _stateTotalStreamController.stream;
  CounterDetailsBloc() {
    counter = 1;
    RepositoryCart.getQuantity = counter;
    eventStream.listen((event) async {
      if (event == CounterEvent.decrement) {
        if (counter > 1) {
          counter--;
          RepositoryCart.getQuantity = counter;
        }
      } else if (event == CounterEvent.increment) {
        counter++;
        RepositoryCart.getQuantity = counter;
      }
      counterSink.add(counter);
    });
  }

  void dispose() {
    _stateStreamController.close();
    _stateTotalStreamController.close();
  }
}
