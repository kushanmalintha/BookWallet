import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:http/http.dart' as http;
import '../models/review_model.dart';

class ReviewForUserService {
  String apiUrl(int userId) =>
      'http://${ip}:3000/api/reviews/getReviewWithBookId/$userId';

  Future<List<ReviewModel>> fetchPosts(int userId, int page) async {
    final response = await http.get(Uri.parse('${apiUrl(userId)}?page=$page'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print(data);
      return data.map((item) => ReviewModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
