import 'dart:convert';
import 'package:book_wallert/ipaddress.dart'; // Import IP address for API URL
import 'package:http/http.dart'
    as http; // Import HTTP library for making requests
import '../models/book_model.dart'; // Import your existing BookModel

class GoogleBooksApiService {
  final String apiUrl =
      '${ip}/api/googleapi/search'; // API URL for Google Books API

  // Function to fetch book details
  Future<List<BookModel>> fetchBooks(
      {required String query, required int page}) async {
    final response = await http.get(
        Uri.parse('$apiUrl?query=$query&index=$page')); // Perform GET request

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
}
