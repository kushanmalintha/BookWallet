import 'package:book_wallert/ipaddress.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/models/user_model.dart'; // Import the User model

class HistoryController {
  final int userId;
  bool isLoading = true;
  List<BookModel> historyBooks = [];
  List<ReviewModel> historyReviews = [];
  List<User> historyUsers = []; // List to store user data
  Map<int, List<BookModel>> bookHistoryByIndex = {};
  Map<int, List<ReviewModel>> reviewHistoryByIndex = {};
  Map<int, List<User>> userHistoryByIndex =
      {}; // Map to store users by their search index

  HistoryController(this.userId);

  Future<void> fetchBooks(Function(List<BookModel>) onSuccess) async {
    final response = await http.get(
      Uri.parse('http://${ip}:3000/api/history/$userId/books'),
    );
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      for (var item in data) {
        int searchIndex = item['searchIndex'];
        BookModel book = BookModel.fromJson(item['book']);

        if (!bookHistoryByIndex.containsKey(searchIndex)) {
          bookHistoryByIndex[searchIndex] = [];
        }
        bookHistoryByIndex[searchIndex]!.add(book);
      }

      historyBooks = bookHistoryByIndex.values.expand((list) => list).toList();
      onSuccess(historyBooks);
    } else {
      print('Failed to load books');
    }
  }

  Future<void> fetchReviews(Function(List<ReviewModel>) onSuccess) async {
    final response = await http.get(
      Uri.parse('http://${ip}:3000/api/history/$userId/reviews'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      for (var item in data) {
        int searchIndex = item['searchIndex'];
        ReviewModel review = ReviewModel.fromJson(item['post']);

        if (!reviewHistoryByIndex.containsKey(searchIndex)) {
          reviewHistoryByIndex[searchIndex] = [];
        }
        reviewHistoryByIndex[searchIndex]!.add(review);
      }

      historyReviews =
          reviewHistoryByIndex.values.expand((list) => list).toList();
      onSuccess(historyReviews);
    } else {
      print('Failed to load reviews');
    }
  }

  Future<void> fetchUsers(Function(List<User>) onSuccess) async {
    print("object");
    final response = await http.get(
      Uri.parse('http://${ip}:3000/api/history/$userId/user-details'),
    );

    if (response.statusCode == 200) {
      print(response.body);
      final List<dynamic> data = json.decode(response.body);
      print("78");
      for (var item in data) {
        int searchIndex = item['searchIndex'];
        print("aja");
        User user = User.fromJson(item['userDetails']);
        print("hela");

        if (!userHistoryByIndex.containsKey(searchIndex)) {
          userHistoryByIndex[searchIndex] = [];
        }
        userHistoryByIndex[searchIndex]!.add(user);
      }

      historyUsers = userHistoryByIndex.values.expand((list) => list).toList();
      onSuccess(historyUsers);
    } else {
      print('Failed to load users');
    }
  }
}
