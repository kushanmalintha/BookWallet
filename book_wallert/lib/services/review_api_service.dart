import 'dart:convert';
import 'package:book_wallert/ipaddress.dart'; // Import IP address for API URL
import 'package:http/http.dart'
    as http; // Import HTTP library for making requests
import '../models/review_model.dart'; // Import ReviewModel for data parsing
class GetReviewWithIdService {
  String apiUrl = '${ip}/api/reviews/getReviewWithId';

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
