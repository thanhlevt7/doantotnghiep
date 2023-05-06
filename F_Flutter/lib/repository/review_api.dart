import 'dart:convert';

import 'package:fluter_19pmd/models/reviews_models.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:http/http.dart' as http;

class RepositoryReview {
  static Future<dynamic> post(String id, String product, String content,
      String image, String starNumber) async {
    var client = http.Client();
    var response = await client.post(
        Uri.parse('http://10.0.2.2:8000/api/reviews/post-comment'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          'invoiceID': id.toString(),
          'userID': RepositoryUser.info.id,
          'productID': product.toString(),
          'content': content,
          'image': image,
          'quantity': starNumber,
        }));
    if (response.statusCode == 200) {
      return 200;
    } else if (response.statusCode == 201) {
      return 201;
    } else {
      return 404;
    }
  }

  static Future<List<Review>> getReviewsForUser() async {
    List<Review> review;
    var client = http.Client();
    var response = await client.get(
      Uri.parse(
          'http://10.0.2.2:8000/api/reviews/getReviewsForUser/${RepositoryUser.info.id}'),
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;
      review = reviewFromJson(jsonString);
      return review;
    }
    return null;
  }
}
