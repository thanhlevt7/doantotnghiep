import 'package:fluter_19pmd/models/notification_models.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

class RepositoryNotification {
  static Future<List<Notifications>> loadNotificationForUser() async {
    var client = http.Client();
    List<Notifications> notification;
    var response = await client.get(Uri.parse(
        '$hostDomainLocal/api/notifications/getNoticationsForUser/${RepositoryUser.info.id}'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      notification = notificationsFromJson(jsonString);
      return notification;
    } else {
      return null;
    }
  }
}
