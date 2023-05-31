import 'package:fluter_19pmd/models/favorites_model.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

class RepositoryFavorite {
  static getHeightItem(var length) {
    double dem = 0;
    for (var i = 1; i <= length; i++) {
      dem += 200;
    }
    return dem;
  }

  static getHeight(var length) {
    double dem = 0;
    for (var i = 1; i <= length; i++) {
      dem += 65;
    }
    return dem;
  }

  static getHeightForScreenHome(var length) {
    double dem = 0;
    for (var i = 1; i <= length; i++) {
      dem += 50;
    }
    return dem;
  }

  static getHeightForBody(var length) {
    double dem = 0;
    for (var i = 1; i <= length; i++) {
      dem += 0.14;
    }
    return dem;
  }

  static Future<List<Favorites>> showFavorite() async {
    var client = http.Client();
    var response = await client.get(
      Uri.parse(
        '$hostDomainLocal/api/favorites/show/${RepositoryUser.info.id}',
      ),
    );
    if (response.statusCode == 200) {
      var favorites = favoritesFromJson(response.body);

      return favorites;
    } else {
      throw Exception("update Cart lỗi");
    }
  }

  static Future<dynamic> addTitle(String title) async {
    var client = http.Client();
    var response = await client.post(
      Uri.parse(
        '$hostDomainLocal/api/favorites/AddFavoriteTitle/${RepositoryUser.info.id}',
      ),
      body: ({
        'userID': RepositoryUser.info.id.toString(),
        'title': title,
      }),
    );

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  static Future<dynamic> deleteFavorite(int id) async {
    var client = http.Client();
    var response = await client.delete(
      Uri.parse(
        '$hostDomainLocal/api/favorites/DeleteFavoriteTitle',
      ),
      body: ({
        'id': id.toString(),
      }),
    );

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  static Future<dynamic> addProduct(int productID, int favoriteID) async {
    var client = http.Client();
    var response = await client.post(
      Uri.parse(
        '$hostDomainLocal/api/favorites/Add-product',
      ),
      body: ({
        'favoriteID': favoriteID.toString(),
        'productID': productID.toString(),
      }),
    );
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  static Future<dynamic> deleteProduct(var productID, {var favoriteID}) async {
    var client = http.Client();

    var response = (favoriteID == null)
        ? await client.post(
            Uri.parse(
              '$hostDomainLocal/api/favorites/delete-product',
            ),
            body: ({
              'productID': productID.toString(),
            }),
          )
        : await client.post(
            Uri.parse(
              '$hostDomainLocal/api/favorites/delete-product',
            ),
            body: ({
              'favoriteID': favoriteID.toString(),
              'productID': productID.toString(),
            }),
          );

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
}
