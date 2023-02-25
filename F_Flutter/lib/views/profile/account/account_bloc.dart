import 'dart:async';
import 'package:fluter_19pmd/views/profile/account/account_event.dart';

class OpenEditAccount {
  bool openAccount = false;
  final _stateStreamController = StreamController<bool>();
  StreamSink<bool> get editProfileSink => _stateStreamController.sink;
  Stream<bool> get editProfileStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<AccountEvent>();
  StreamSink<AccountEvent> get eventSink => _eventStreamController.sink;
  Stream<AccountEvent> get _eventStream => _eventStreamController.stream;

  OpenEditAccount() {
    _eventStream.listen((event) async {
      switch (event) {
        case AccountEvent.editAccount:
          openAccount = !openAccount;

          editProfileSink.add(openAccount);
          break;
        case AccountEvent.saveAccount:
          openAccount = !openAccount;

          editProfileSink.add(openAccount);
          break;
        default:
      }
    });
  }
  void dispose() {
    _stateStreamController.close();
  }
}
