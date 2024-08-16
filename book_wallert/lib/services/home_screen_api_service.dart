import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
import 'package:http/http.dart' as http;
import '../models/review_model.dart';
import '../models/book_model.dart';

class HomeScreenService {
  final String apiUrl = 'http://${ip}:3000/api/getHomeScreen';
  List<dynamic> results = [];

  Future<List<dynamic>> fetchHomeScreen(int userId, int page) async {
    final response = await http.get(Uri.parse('$apiUrl/$userId?page=$page'));
    print('Response Body: ${response.body}');
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      final reviewsData = jsonResponse['reviews'];
      final booksData = jsonResponse['books'];

      for (var item in reviewsData) {
        // reviews
        results.add(ReviewModel.fromJson(item));
      }

      for (var item in booksData) {
        // books
        results.add(BookModel.fromJson(item));
      }

      return results;
    } else {
      throw Exception('Failed to load home screen');
    }
  }
}
