// http://localhost:3000/api/reviews/deleteReview/91
import 'package:book_wallert/ipaddress.dart';
import 'package:http/http.dart' as http;

class ReviewDeleteService {
  static final String _baseUrl = 'http://$ip:3000/api/reviews';

  Future<void> deleteReview(int reviewId, int userId, String token) async {
    final url = Uri.parse('$_baseUrl/deleteReview/$reviewId/$userId');
    try {
      final response = await http.delete(url,
          headers: {'Content-Type': 'application/json'},
          body: '{"token": "$token"}');

      if (response.statusCode == 200) {
        print('Review delete successfully.');
      } else {
        print('Failed to delete review. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('An error occurred while deleting review: $e');
    }
  }
}
