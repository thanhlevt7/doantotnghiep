import 'dart:async';

class LoadingBloc {
  final _stateStreamController = StreamController<bool>();
  StreamSink<bool> get loadingSink => _stateStreamController.sink;
  Stream<bool> get loadingStream => _stateStreamController.stream;

  void dispose() {
    _stateStreamController.close();
  }
}
