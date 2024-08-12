import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:book_wallert/models/book_model.dart';
import 'package:http/http.dart' as http;

// Post recommendation details
class RecommendDetailsService {
  static final String _baseUrl = 'http://$ip:3000/api/user/followers';
  // http://localhost:3000/api/user/followers/recommendedBooks/21/68

  Future<void> postRecommendDetails(
      int userId, int bookId, String token) async {
    final url = Uri.parse('$_baseUrl/recommendedBooks/$bookId/$userId');
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: '{"token": "$token"}');

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
      'http://$ip:3000/api/user/recommendedBooks/$userId';
  // http://localhost:3000/api/user/recommendedBooks/69

  Future<List<BookModel>> fetchBooks(int userId, int page) async {
    final url = '${apiUrl(userId)}?page=$page';
    print('Fetching books from URL: $url'); // Debugging step

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      // print('title ${data[0]["title"].runtimeType}');
      // print('authore ${data[0]["author"].runtimeType}');
      // print('pages ${data[0]["pages"].runtimeType}');
      // print('gener ${data[0]["genre"].runtimeType}');
      // print('isbn10 ${data[0]["ISBN10"].runtimeType}');
      // print('isbn13 ${data[0]["ISBN13"].runtimeType}');
      // print('rating ${data[0]["totalRating"].runtimeType}');
      // print('pub date ${data[0]["publishedDate"].runtimeType}');
      // print('img ${data[0]["imageUrl"].runtimeType}');
      // print('des ${data[0]["description"].runtimeType}');
      // print('res ${data[0]["resource"].runtimeType}');
      print(data);
      return data.map((item) => BookModel.fromJson(item)).toList();
    } else {
      print('Failed to load books with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load books');
    }
  }
}
