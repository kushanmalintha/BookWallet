import 'package:book_wallert/ipaddress.dart';
import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryService {
  final int userId;

  HistoryService(this.userId);

  Future<List<BookModel>> fetchBooks() async {
    final response = await http.get(
      Uri.parse('http://$ip:3000/api/history/$userId/books'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // Convert JSON data to List<BookModel>
      return data.map((item) => BookModel.fromJson(item['book'])).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<ReviewModel>> fetchReviews() async {
    final response = await http.get(
      Uri.parse('http://$ip:3000/api/history/$userId/reviews'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // Convert JSON data to List<ReviewModel>
      return data.map((item) => ReviewModel.fromJson(item['post'])).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  Future<List<User>> fetchUsers() async {
    final response = await http.get(
      Uri.parse('http://$ip:3000/api/history/$userId/user-details'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // Convert JSON data to List<User>
      return data.map((item) => User.fromJson(item['userDetails'])).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<List<dynamic>> fetchAllItems() async {
    final response =
        await http.get(Uri.parse('http://${ip}:3000/api/history/all/$userId'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse is List<dynamic>) {
        print(response.body);
        return jsonResponse;
      } else {
        throw Exception('Expected a JSON list but got a different format');
      }
    } else {
      throw Exception('Failed to load items');
    }
  }
}
