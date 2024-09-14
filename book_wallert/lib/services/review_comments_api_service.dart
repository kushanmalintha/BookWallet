import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:book_wallert/models/comment_model.dart';
import 'package:http/http.dart' as http;
import 'package:book_wallert/controllers/token_controller.dart';

class CommentApiService {
  static final String _baseUrl = '${ip}/api/reviews';

  Future<void> addComment(int reviewId, String commentText, int userId) async {
    final token = await getToken(); // Retrieve the token
    if (token == null) {
      throw Exception('Session has expired. Please login again.');
    }
    final response = await http.post(
      Uri.parse('$_baseUrl/comments/add'),
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
      print('Comment added successfully');
    } else if (response.statusCode == 400) {
      print('Bad request: ${response.body}');
    } else if (response.statusCode == 401) {
      print('Unauthorized access');
    } else if (response.statusCode == 500) {
      print('Server error: ${response.body}');
    } else {
      print('Unexpected error: ${response.statusCode}');
    }
  }

  Future<List<Comment>> fetchComments(int reviewId) async {
    final response = await http.get(Uri.parse('$_baseUrl/$reviewId/comments'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Comment.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}

class CommentUpdateService {
  static final String _baseUrl = '${ip}/api/reviews';

  Future<void> updateComment(
      int commentId, int userId, String content, String token) async {
    final url = Uri.parse('$_baseUrl/comments/update/$commentId/$userId');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: '{"context": "$content","token": "$token"}',
      );

      if (response.statusCode == 200) {
        print('Comment updated successfully.');
      } else {
        print('Failed to update comment. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('An error occurred while updating comment: $e');
    }
  }
}

class CommentDeleteService {
  static final String _baseUrl = '${ip}/api/reviews';

  Future<void> deleteComment(int commentId, int userId, String token) async {
    final url = Uri.parse('$_baseUrl/comments/delete/$commentId/$userId');
    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: '{"token": "$token"}',
      );

      if (response.statusCode == 200) {
        print('Comment deleted successfully.');
      } else {
        print('Failed to delete comment. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('An error occurred while deleting comment: $e');
    }
  }
}
