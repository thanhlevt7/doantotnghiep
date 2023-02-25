import 'dart:async';

import 'package:fluter_19pmd/models/notification_models.dart';
import 'package:fluter_19pmd/repository/notification_api.dart';
import 'package:fluter_19pmd/services/notification/notification_event.dart';

class NotificationBloc {
  final _stateStreamController = StreamController<List<Notifications>>();
  StreamSink<List<Notifications>> get _notificationSink =>
      _stateStreamController.sink;
  Stream<List<Notifications>> get notificationStream =>
      _stateStreamController.stream;

  final _eventStreamController = StreamController<NotificationEvent>();
  StreamSink<NotificationEvent> get eventSink => _eventStreamController.sink;
  Stream<NotificationEvent> get _eventStream => _eventStreamController.stream;
  NotificationBloc() {
    _eventStream.listen((event) async {
      if (event == NotificationEvent.fetchForUser) {
        var notification =
            await RepositoryNotification.loadNotificationForUser();
        _notificationSink.add(notification);
      }
    });
  }

  void dispose() {
    _stateStreamController.close();
  }
}
