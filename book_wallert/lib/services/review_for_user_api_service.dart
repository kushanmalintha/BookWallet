import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:http/http.dart' as http;
import '../models/review_model.dart';

class ReviewForUserService {
  String apiUrl(int userId) =>
      '${ip}/api/reviews/getReviewWithUserId/$userId';

  Future<List<ReviewModel>> fetchPosts(int userId, int page) async {
    final url = '${apiUrl(userId)}?page=$page';
    print('$url');
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print(data);
      return data.map((item) => ReviewModel.fromJson(item)).toList();
    } else {
      print('Failed to load posts with status code: ${response.statusCode}');
      throw Exception('Failed to load posts');
    }
  }
}
