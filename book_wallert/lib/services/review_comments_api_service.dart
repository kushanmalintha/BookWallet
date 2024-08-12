import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:http/http.dart' as http;
import 'package:book_wallert/controllers/token_controller.dart';

class CommentApiService {
  static final String _baseUrl = 'http://${ip}:3000/api/reviews/comments/add';

  Future<void> addComment(int reviewId, String commentText, int userId) async {
    final token = await getToken(); // Retrieve the token
    if (token == null) {
      throw Exception('Session has expired. Please login again.');
    }

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'comment': {
          'user_id': userId,
          'context': commentText,
        },
        'reviewId': reviewId,
        'token': token, // Include the token to verify
      }),
    );

    if (response.statusCode == 201) {
      // Successful response handling
      print('Comment added successfully');
    } else if (response.statusCode == 400) {
      // Bad request
      print('Bad request: ${response.body}');
    } else if (response.statusCode == 401) {
      // Unauthorized
      print('Unauthorized access');
    } else if (response.statusCode == 500) {
      // Server error
      print('Server error: ${response.body}');
    } else {
      // Other unexpected status code
      print('Unexpected error: ${response.statusCode}');
    }
  }
}
