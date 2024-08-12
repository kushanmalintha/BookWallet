import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:http/http.dart' as http;
import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/controllers/token_controller.dart';

class ReviewPostApiService {
  static final String _baseUrl = 'http://${ip}:3000/api/book-review/add';

  Future<void> reviewPost(
      BookModel book, String reviewText, double rating, int userId) async {
    final token = await getToken(); // Retrieve the token
    if (token == null) {
      throw Exception('Session has expired. Please login again.');
    }

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'book': {
          'title': book.title,
          'ISBN10': book.ISBN10,
          'ISBN13': book.ISBN13,
          'publication_date': book.publishedDate,
          'description': book.description,
          'author': book.author,
          'rating': book.totalRating, // Assuming this is the book rating
          'pages': book.pages,
          'genre': book.genre,
          'imageUrl': book.imageUrl,
          'resource': book.resource
        },
        'review': {
          'user_id': userId,
          'context': reviewText,
          'rating': rating,
          'group_id': null, // Set to null if not used
        },
        'token': token, // Include the token to verify
      }),
    );

    if (response.statusCode == 201) {
      // Successful response handling
      print('Review posted successfully');
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
