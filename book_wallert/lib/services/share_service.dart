import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/models/share_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
class ShareService {
  final String _baseUrl = 'http://${ip}:3000/api/reviews'; // Replace with your actual API endpoint

  Future<void> shareReview(int reviewId, int userId) async {
    final url = Uri.parse('$_baseUrl/share');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'review_id': reviewId,
        'user_id': userId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to share review');
    }
  }
   Future<List<SharedReview>> fetchSharedReviews(int userId) async {
    final url = Uri.parse('$_baseUrl/shared-reviews/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) {
        return SharedReview(
          reviewId: json['review_id'],
          sharerUsername: json['sharer_username'],
          review: ReviewModel(
            reviewId: json['review_id'],
            bookId: json['book_id'],
            userId: json['user_id'],
            imagePath: json['imageUrl'], // Ensure this matches the field from the backend
            bookName: json['title'], // Adjust if needed
            authorName: json['author'],
            context: json['context'],
            rating: json['rating'].toDouble(),
            date: json['date'],
            reviwerName: json['reviewer_username'], // Adjust if needed
            likesCount: json['likesCount'] ?? 0, // Handle null values
            commentsCount: json['commentsCount'] ?? 0, // Handle null values
            sharesCount: json['sharesCount'] ?? 0, // Handle null values
          ),
        );
      }).toList();
    } else {
      throw Exception('Failed to load shared reviews');
    }
  }
}
