import 'package:book_wallert/controllers/token_controller.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/models/share_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:book_wallert/ipaddress.dart';
//import 'package:book_wallert/services/token_service.dart'; // Import your token service

class ShareService {
  final String _baseUrl = '${ip}/api/reviews'; // Replace with your actual API endpoint

  // Method to share a review
  Future<void> shareReview(int reviewId, int userId) async {
    final url = Uri.parse('$_baseUrl/share');
    String? token = await getToken(); // Get the token

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Add the token to the headers
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
  Future<void> UnshareReview(int reviewId, int userId) async {
    final url = Uri.parse('$_baseUrl/share');
    String? token = await getToken(); // Get the token

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Add the token to the headers
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
  Future<bool> checkIfShared(int reviewId, int userId) async {
    final url = Uri.parse('$_baseUrl/check-shared');

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

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['shared'] as bool;
    } else {
      throw Exception('Failed to check if review is shared');
    }
  }

  // Method to fetch shared reviews
  Future<List<SharedReview>> fetchSharedReviews(int userId) async {
    final url = Uri.parse('$_baseUrl/shared-reviews/$userId');
    String? token = await getToken(); // Get the token

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token', // Add the token to the headers
      },
    );

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
            sharesCount: json['sharesCount'] ?? 0, 
            // Handle null values
          ), sharedUserId: json['sharedUserId'], imagePath: json['imageUrl'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load shared reviews');
    }
  }

  Future<List<Map<String, dynamic>>> fetchShares(int reviewId) async {
    final url = Uri.parse('$_baseUrl/$reviewId/shared-users');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data
          .map((json) => {
                'user_id': json['user_id'],
                'username': json['username'],
              })
          .toList();
    } else {
      throw Exception('Failed to load shares');
    }
  }
 Future<List<ReviewModel>> fetchUserTimeline(int userId) async {
  final url = Uri.parse('$_baseUrl/shared-reviews-timeOrder/$userId');
  String? token = await getToken(); // Get the token

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token', // Add the token to the headers
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) {
      return ReviewModel(
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
        sharesCount: json['sharesCount'] ?? 0, 
      );
    }).toList();
  } else {
    throw Exception('Failed to load user timeline');
  }
}

  
}
