
import 'package:fluter_19pmd/models/notification_models.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:http/http.dart' as http;

class RepositoryNotification {
  // ignore: missing_return
  static Future<List<Notifications>> loadNotification() async {
    var client = http.Client();
    List<Notifications> notification;
    var response = await client.get(
      Uri.parse('http://10.0.2.2:8000/api/notifications/show'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      notification = notificationsFromJson(jsonString);
      return notification;
    } else {
      return null;
    }
  }

  static Future<List<Notifications>> loadNotificationForUser() async {
    var client = http.Client();
    List<Notifications> notification;
    var response = await client.get(Uri.parse(
        'http://10.0.2.2:8000/api/notifications/getNoticationsForUser/${RepositoryUser.info.id}'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      notification = notificationsFromJson(jsonString);
      return notification;
    } else {
      return null;
    }
  }
}
