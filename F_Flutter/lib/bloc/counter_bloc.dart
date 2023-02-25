import 'dart:async';
import 'package:fluter_19pmd/counter_event.dart';

class CounterBloc {
  int counter;
  final _stateStreamController = StreamController<int>();
  StreamSink<int> get counterSink => _stateStreamController.sink;
  Stream<int> get counterStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<CounterEvent>();
  StreamSink<CounterEvent> get eventSink => _eventStreamController.sink;
  Stream<CounterEvent> get eventStream => _eventStreamController.stream;
  CounterBloc() {
    counter = 1;
    eventStream.listen((event) {
      if (event == CounterEvent.decrement) {
        if (counter > 1) {
          counter--;
        }
      } else if (event == CounterEvent.increment) {
        counter++;
      }
      counterSink.add(counter);
    });
  }

  void dispose() {
    _stateStreamController.close();
  }
}
