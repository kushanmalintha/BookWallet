// http://localhost:3000/api/reviews/updateReview/92/47
import 'dart:convert';

import 'package:book_wallert/ipaddress.dart';
import 'package:http/http.dart' as http;

class ReviewUpdateService {
  static final String _baseUrl = '${ip}/api/reviews';

  Future<void> updateReview(int reviewId, int userId, String content,
      double rating, String token) async {
    final url = Uri.parse('$_baseUrl/updateReview/$reviewId/$userId');
    print('aaaaaaaaaaaaaaaaaaaaaaaa$url');
    try {
      final response = await http.put(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
              {'content': content, 'rating': rating, 'token': token}));
      print('qqqqqqqqqqqqqqqqqqqqqqqqqq $content $rating $token');
      if (response.statusCode == 200) {
        print('Review update successfully.');
      } else {
        print('Failed to update review. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('An error occurred while updating review: $e');
    }
  }
}
