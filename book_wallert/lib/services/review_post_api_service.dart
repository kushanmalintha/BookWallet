import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:http/http.dart' as http;
import 'package:book_wallert/models/book_model.dart';

class ReviewPostApiService {
  static final String _baseUrl = 'http://${ip}:3000/api/book-review/add';

  Future<void> reviewPost(
      BookModel book, String reviewText, double rating, int userId) async {
    // print('Book is: ${book}');
    // print('review text is: ${reviewText}');
    // print('rating in book is: ${book.totalRating}');
    // print('rating in book type is: ${(book.totalRating).runtimeType}');
    // print('user rating num is: ${rating}');
    // print('user Id is: ${userId}');

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
      }),
    );

    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

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
