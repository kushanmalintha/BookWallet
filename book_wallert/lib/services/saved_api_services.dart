import 'package:book_wallert/ipaddress.dart';
import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SavedService {
  final int userId;

  SavedService(this.userId);

  Future<List<BookModel>> fetchBooks() async {
    final response = await http.get(
      Uri.parse('${ip}/api/saved-items/books/$userId'),
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
      Uri.parse('${ip}/api/saved-items/reviews/$userId'),
    );

    print(response.body);
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
      Uri.parse('${ip}/api/saved-items/profiles/$userId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // Convert JSON data to List<User>
      return data.map((item) => User.fromJson(item['userDetails'])).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> insertReviewToSaved(String? token, int reviewId) async {
    final url = Uri.parse('${ip}/api/saved-items/save/review');
    final body = json.encode({
      'token': token,
      'relevant_id': reviewId,
    });
    print(111);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json'
        }, // Set the Content-Type header
        body: body,
      );

      if (response.statusCode == 200) {
        print(' Review Saved successfully');
      } else {
        print('Failed to insert Saved: ${response.body}');
      }
    } catch (e) {
      print('Error inserting Saved: $e');
    }
  }

  Future<void> insertBookToSaved(String? token, int bookId) async {
    final url = Uri.parse('${ip}/api/saved-items/save/book');
    final body = json.encode({
      'token': token,
      'relevant_id': bookId,
    });
    print(token);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json'
        }, // Set the Content-Type header
        body: body,
      );

      if (response.statusCode == 200) {
        print('Book saved successfully');
      } else {
        print('Failed to insert Saved: ${response.body}');
      }
    } catch (e) {
      print('Error inserting Saved: $e');
    }
  }

  Future<void> insertProfileToSaved(String token, int userId) async {
    final url = Uri.parse('${ip}/api/saved-items/save/profile');
    final body = json.encode({
      'token': token,
      'relevant_id': userId,
    });

    print(token);
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        print('profile saved successfully');
      } else {
        print('Failed to save user profile: ${response.body}');
      }
    } catch (e) {
      print('Error saving user profile: $e');
    }
  }

  // Check if a review is saved by the user
  Future<bool> isReviewSaved(String? token, int reviewId) async {
    final url = Uri.parse('${ip}/api/saved-items/reviews/is-saved');
    final body = json.encode({
      'token': token,
      'relevant_id': reviewId,
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data[
            'isSaved']; // Assume response contains { "isSaved": true/false }
      } else {
        throw Exception('Failed to check if review is saved');
      }
    } catch (e) {
      print('Error checking review saved status: $e');
      return false;
    }
  }

  // Check if a book is saved by the user
  Future<bool> isBookSaved(String? token, int bookId) async {
    final url = Uri.parse('${ip}/api/saved-items/check/book');
    final body = json.encode({
      'token': token,
      'relevant_id': bookId,
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['isSaved'];
      } else {
        throw Exception('Failed to check if book is saved');
      }
    } catch (e) {
      print('Error checking book saved status: $e');
      return false;
    }
  }

  // Check if a profile is saved by the user
  Future<bool> isProfileSaved(String? token, int profileId) async {
    final url = Uri.parse('${ip}/api/saved-items/profiles/is-saved');
    final body = json.encode({
      'token': token,
      'relevant_id': profileId,
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['isSaved'];
      } else {
        throw Exception('Failed to check if profile is saved');
      }
    } catch (e) {
      print('Error checking profile saved status: $e');
      return false;
    }
  }

  // Remove a saved review
  Future<void> removeReviewFromSaved(String? token, int reviewId) async {
    final url = Uri.parse('${ip}/api/saved-items/remove/review');
    final body = json.encode({
      'token': token,
      'relevant_id': reviewId,
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (response.statusCode == 200) {
        print('Review removed from saved');
      } else {
        print('Failed to remove review: ${response.body}');
      }
    } catch (e) {
      print('Error removing review from saved: $e');
    }
  }

  // Remove a saved book
  Future<void> removeBookFromSaved(String? token, int bookId) async {
    final url = Uri.parse('${ip}/api/saved-items/remove/book');
    final body = json.encode({
      'token': token,
      'relevant_id': bookId,
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (response.statusCode == 200) {
        print('Book removed from saved');
      } else {
        print('Failed to remove book: ${response.body}');
      }
    } catch (e) {
      print('Error removing book from saved: $e');
    }
  }

  // Remove a saved profile
  Future<void> removeProfileFromSaved(String? token, int profileId) async {
    final url = Uri.parse('${ip}/api/saved-items/remove/profile');
    final body = json.encode({
      'token': token,
      'relevant_id': profileId,
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (response.statusCode == 200) {
        print('Profile removed from saved');
      } else {
        print('Failed to remove profile: ${response.body}');
      }
    } catch (e) {
      print('Error removing profile from saved: $e');
    }
  }
}
