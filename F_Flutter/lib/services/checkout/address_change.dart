import 'dart:async';


enum ChangeEvent {
  open,
  close,
  choose,
}

class AddressChange {
  final _stateStreamController = StreamController<bool>();
  StreamSink<bool> get _changeSink => _stateStreamController.sink;
  Stream<bool> get changeStream => _stateStreamController.stream;

  final _addressController = StreamController<String>();
  StreamSink<String> get chooseSink => _addressController.sink;
  Stream<String> get chooseStream => _addressController.stream;

  final _eventStreamController = StreamController<ChangeEvent>();
  StreamSink<ChangeEvent> get eventSink => _eventStreamController.sink;
  Stream<ChangeEvent> get _eventStream => _eventStreamController.stream;
  AddressChange() {
    _eventStream.listen((event) async {
      if (event == ChangeEvent.open) {
        _changeSink.add(true);
      } else if (event == ChangeEvent.close) {
        _changeSink.add(false);
      } else if (event == ChangeEvent.choose) {
        _changeSink.add(false);
      }
    });
  }
  void dispose() {
    _stateStreamController.close();
    _addressController.close();
  }
}
