import 'dart:async';

class EventForUserInFavorite {
  static int index;
  final _stateStreamController = StreamController<bool>();
  StreamSink<bool> get openFavoriteSink => _stateStreamController.sink;
  Stream<bool> get openFavoriteStream => _stateStreamController.stream;

  final _stateDeleteController = StreamController<bool>();
  StreamSink<bool> get deleteTitleSink => _stateDeleteController.sink;
  Stream<bool> get deleteTitleStream => _stateDeleteController.stream;
  void dispose() {
    _stateStreamController.close();
    _stateDeleteController.close();
  }
}
