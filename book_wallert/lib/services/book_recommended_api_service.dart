import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:book_wallert/models/book_model.dart';
import 'package:http/http.dart' as http;

// Post recommendation details
class RecommendDetailsService {
  static final String _baseUrl = 'http://$ip:3000/api/user/followers';
  // http://localhost:3000/api/user/followers/recommendedBooks/21/68

  Future<void> postRecommendDetails(int userId, int bookId) async {
    final url = Uri.parse('$_baseUrl/recommendedBooks/$bookId/$userId');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Book recommended to the followers successfully.');
      } else {
        print(
            'Failed to recommend details. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('An error occurred while recommending details: $e');
    }
  }
}

// Fetch recommended books for user
class BookForRecommendService {
  String apiUrl(int userId) =>
      'http://$ip:3000/api/reviews/getReviewWithBookId/$userId';
  // http://localhost:3000/api/user/recommendedBooks/69

  Future<List<BookModel>> fetchBooks(int userId, int page) async {
    final response = await http.get(Uri.parse('${apiUrl(userId)}?page=$page'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        return data.map((item) => BookModel.fromJson(item)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load books');
    }
  }
}
