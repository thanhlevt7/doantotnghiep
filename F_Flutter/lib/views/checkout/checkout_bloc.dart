import 'dart:async';

class VoucherBloc {
  final _stateStreamController = StreamController<int>();
  StreamSink<int> get getSink => _stateStreamController.sink;
  Stream<int> get getStream => _stateStreamController.stream;

  void dispose() {
    _stateStreamController.close();
  }
}
