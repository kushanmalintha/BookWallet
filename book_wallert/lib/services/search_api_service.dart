import 'dart:convert';
import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/ipaddress.dart'; // Import IP address for API URL
import 'package:book_wallert/models/group_model.dart';
import 'package:book_wallert/models/user.dart';
import 'package:http/http.dart'
    as http; // Import HTTP library for making requests
import '../models/book_model.dart'; // Import your existing BookModel

class SearchApiService {
  final String apiUrl = '${ip}/api/search/'; // API URL for Google Books API

  // Function to fetch book details
  Future<List<BookModel>> searchBooks(
      {required String query, required int page}) async {
    final response = await http.get(Uri.parse(
        '$apiUrl/books?query=$query&index=$page')); // Perform GET request

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body); // Decode JSON response

      print(data);
      // Directly convert JSON to BookModel list
      List<BookModel> books =
          data.map<BookModel>((item) => BookModel.fromJson(item)).toList();

      return books;
    } else {
      throw Exception('Failed to load books'); // Throw error if request fails
    }
  }

  // Function to fetch book details
  Future<List<User>> searchUsers(
      {required String query, required int page}) async {
    final response = await http.get(Uri.parse(
        '$apiUrl/users?query=$query&index=$page')); // Perform GET request

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body); // Decode JSON response

      print(data);
      // Directly convert JSON to BookModel list
      List<User> users = data.map<User>((item) => User.fromJson(item)).toList();

      return users;
    } else {
      throw Exception('Failed to load users'); // Throw error if request fails
    }
  }

  // Function to fetch book details
  Future<List<GroupModel>> searchGroups(
      {required String query, required int page}) async {
    final response = await http.get(Uri.parse(
        '$apiUrl/groups?query=$query&index=$page&user_id=${globalUser!.userId}')); // Perform GET request

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body); // Decode JSON response
      print(data);
      // Directly convert JSON to BookModel list
      List<GroupModel> groups =
          data.map<GroupModel>((item) => GroupModel.fromJson(item)).toList();

      return groups;
    } else {
      throw Exception('Failed to load groups'); // Throw error if request fails
    }
  }
}
