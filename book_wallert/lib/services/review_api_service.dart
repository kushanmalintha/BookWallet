import 'dart:convert';
import 'package:book_wallert/ipaddress.dart'; // Import IP address for API URL
import 'package:http/http.dart'
    as http; // Import HTTP library for making requests
import '../models/review_model.dart'; // Import ReviewModel for data parsing

class ReviewService {
  final String apiUrl =
      'http://${ip}:3000/api/posts/reviews'; // API URL for fetching
  // http://localhost:3000/api/posts/reviews

  Future<List<ReviewModel>> fetchPosts(int page) async {
    final response =
        await http.get(Uri.parse('$apiUrl?page=$page')); // Perform GET request
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body); // Decode JSON response
      print(data);
      return data
          .map((item) => ReviewModel.fromJson(item))
          .toList(); // Convert JSON to ReviewModel list
    } else {
      throw Exception('Failed to load posts'); // Throw error if request fails
    }
  }
}

class GetReviewWithIdService {
  String apiUrl = 'http://$ip:3000/api/reviews/getReviewWithId';

  Future<ReviewModel> fetchReview(int reviewId) async {
    final response = await http.get(Uri.parse('$apiUrl/$reviewId'));
    if (response.statusCode == 200) {
      // Parse the response as a single JSON object
      Map<String, dynamic> data = jsonDecode(response.body)[0];
      return ReviewModel.fromJson(data);
    } else {
      throw Exception('Failed to load review');
    }
  }
}
