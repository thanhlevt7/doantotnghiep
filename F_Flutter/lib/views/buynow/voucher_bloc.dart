import 'dart:async';

import 'package:fluter_19pmd/counter_event.dart';
import 'package:fluter_19pmd/repository/cart_api.dart';

// ignore: camel_case_types
enum counterDetailsBloc {
  haveSale,
}

class CounterDetailsBloc {
  int counter;
  final _stateStreamController = StreamController<int>();
  StreamSink<int> get voucherSink => _stateStreamController.sink;
  Stream<int> get voucherStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<CounterEvent>();
  StreamSink<CounterEvent> get eventSink => _eventStreamController.sink;
  Stream<CounterEvent> get eventStream => _eventStreamController.stream;
  CounterDetailsBloc() {
    
    eventStream.listen((event) async {
      if (event == counterDetailsBloc.haveSale) {
        if (counter > 1) {
          counter--;
          RepositoryCart.getQuantity = counter;
        }
      } else if (event == CounterEvent.increment) {
        counter++;
        RepositoryCart.getQuantity = counter;
      }
      // counterSink.add(counter);
    });
  }

  void dispose() {
    _stateStreamController.close();
  
  }
}
