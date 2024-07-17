import 'dart:convert';
import 'package:book_wallert/ipaddress.dart'; // Import IP address for API URL
import 'package:http/http.dart'
    as http; // Import HTTP library for making requests
import '../models/review_model.dart'; // Import ReviewModel for data parsing

class ReviewService {
  final String apiUrl =
      'http://${ip}:3000/api/posts/review'; // API URL for fetching posts

  Future<List<ReviewModel>> fetchPosts(int page) async {
    final response =
        await http.get(Uri.parse('$apiUrl?page=$page')); // Perform GET request

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body); // Decode JSON response
      return data
          .map((item) => ReviewModel.fromJson(item))
          .toList(); // Convert JSON to ReviewModel list
    } else {
      throw Exception('Failed to load posts'); // Throw error if request fails
    }
  }
}
