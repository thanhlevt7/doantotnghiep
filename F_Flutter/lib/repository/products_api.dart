import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/models/reviews_models.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

class RepositoryProduct {
  static var getID;
  static List<Product> products = [];
  static List<Review> reviews = [];
  static double getHeightForUserReview(var length) {
    double dem = 0;
    for (var i = 1; i <= length; i++) {
      dem += 0.5;
    }
    return dem;
  }

  static double getHeight() {
    double dem = 0;
    for (var i = 1; i <= products.length; i++) {
      if (i % 2 != 0) {
        dem += 0.40;
      }
    }
    return dem;
  }

  static Future<List<Product>> getAllProduct() async {
    var client = http.Client();
    List<Product> newProduct;
    var response = await client.get(
      Uri.parse(
          '$hostDomainLocal/api/products/getAllProduct/${RepositoryUser.info.id}'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      newProduct = productFromJson(jsonString);
      products = newProduct;
      return newProduct;
    }
    return null;
  }

  static Future<List<Product>> newProduct() async {
    var client = http.Client();
    List<Product> newProduct;
    var response = await client.get(
      Uri.parse(
          '$hostDomainLocal/api/products/newProduct/${RepositoryUser.info.id}'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      newProduct = productFromJson(jsonString);
      products = newProduct;
      return newProduct;
    }
    return null;
  }

  static Future<List<Product>> getFruit() async {
    var client = http.Client();
    List<Product> newProduct;
    var response = await client.get(
      Uri.parse(
          '$hostDomainLocal/api/products/Fruit/${RepositoryUser.info.id}'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      newProduct = productFromJson(jsonString);

      return newProduct;
    }
    return null;
  }

  static Future<List<Product>> getMeat() async {
    var client = http.Client();
    List<Product> newProduct;
    var response = await client.get(
      Uri.parse('$hostDomainLocal/api/products/Meat/${RepositoryUser.info.id}'),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      newProduct = productFromJson(jsonString);
      return newProduct;
    }
    return null;
  }

  static Future<List<Product>> getDrink() async {
    var client = http.Client();
    List<Product> newProduct;
    var response = await client.get(
      Uri.parse(
          '$hostDomainLocal/api/products/Drink/${RepositoryUser.info.id}'),
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      newProduct = productFromJson(jsonString);

      return newProduct;
    }
    return null;
  }

  static Future<List<Product>> getVegetable() async {
    var client = http.Client();
    List<Product> newProduct;
    var response = await client.get(
      Uri.parse(
          '$hostDomainLocal/api/products/Vegetable/${RepositoryUser.info.id}'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      newProduct = productFromJson(jsonString);
      return newProduct;
    }
    return null;
  }

  static Future<List<Product>> bestSeller() async {
    var client = http.Client();
    List<Product> newProduct;
    var response = await client.get(
      Uri.parse('$hostDomainLocal/api/products/getBestSeller'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      newProduct = productFromJson(jsonString);

      return newProduct;
    }
    return null;
  }

  static Future<List<Product>> filterProuct(String value,
      {String maxPrice, String minPrice, String typeProduct}) async {
    var client = http.Client();
    List<Product> newProduct;
    var response = await client.post(
        Uri.parse(
            '$hostDomainLocal/api/products/result-filter/${RepositoryUser.info.id}'),
        body: ({
          'keyword': value,
          'maxPrice': maxPrice ?? "",
          'minPrice': minPrice ?? "",
          'type': typeProduct ?? "",
        }));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      newProduct = productFromJson(jsonString);
      return newProduct;
    }
    return null;
  }
}
