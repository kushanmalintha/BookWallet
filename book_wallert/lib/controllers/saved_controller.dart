import 'package:book_wallert/controllers/token_controller.dart';
import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/models/user.dart';
import 'package:book_wallert/services/saved_api_services.dart';
import 'package:flutter/material.dart';

class SavedController {
  final SavedService savedService;
  bool isLoading = true;
  List<BookModel> savedBooks = [];
  List<ReviewModel> savedReviews = [];
  List<User> savedUsers = [];

  SavedController(int userId) : savedService = SavedService(userId);

  Future<void> fetchBooks(Function(List<BookModel>) onSuccess) async {
    try {
      savedBooks = await savedService.fetchBooks();
      onSuccess(savedBooks);
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchReviews(Function(List<ReviewModel>) onSuccess) async {
    try {
      savedReviews = await savedService.fetchReviews();
      onSuccess(savedReviews);
      print(savedReviews);
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchUsers(Function(List<User>) onSuccess) async {
    try {
      savedUsers = await savedService.fetchUsers();
      onSuccess(savedUsers);
    } catch (e) {
      print(e);
    }
  }

  Future<void> insertReviewToSaved(BuildContext context, int reviewId) async {
    try {
      final token = await getToken();
      await savedService.insertReviewToSaved(token, reviewId);
      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Review saved successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // Show error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error inserting to saved: $e'),
          duration: Duration(seconds: 2),
        ),
      );
      print('Error inserting to saved: $e');
    }
  }

 Future<void> insertBookToSaved(BuildContext context, int bookId) async {
  try {
    final token = await getToken(); // Get the token
    await savedService.insertBookToSaved(token, bookId);
    
    // Show success snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Book saved successfully!'),
        duration: Duration(seconds: 2), // Optional: set duration
      ),
    );
  } catch (e) {
    // Show error snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error inserting book to saved: $e'),
        duration: Duration(seconds: 2), // Optional: set duration
      ),
    );
    print('Error inserting to saved: $e'); // Print error to console
  }
}


Future<void> insertProfileToSaved(BuildContext context, int userID) async {
  try {
    final token = await getToken(); // Get the token
    await savedService.insertProfileToSaved(token!, userID);
    
    // Show success snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile saved successfully!'),
        duration: Duration(seconds: 2), // Optional: set duration
      ),
    );
  } catch (e) {
    // Show error snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error inserting profile to saved: $e'),
        duration: Duration(seconds: 2), // Optional: set duration
      ),
    );
    print('Error inserting to saved: $e'); // Print error to console
  }
}


  Future<bool> isReviewSaved(reviewId) async {
    try {
      final token = await getToken();
      return await savedService.isReviewSaved(token, reviewId);
    } catch (e) {
      print('Error checking review saved status: $e');
      return false;
    }
  }

  // Check if a book is saved
  Future<bool> isBookSaved(bookId) async {
    try {
      final token = await getToken();
      return await savedService.isBookSaved(token, bookId);
    } catch (e) {
      print('Error checking book saved status: $e');
      return false;
    }
  }

  // Check if a profile is saved
  Future<bool> isProfileSaved(profileId) async {
    try {
      final token = await getToken();
      return await savedService.isProfileSaved(token, profileId);
    } catch (e) {
      print('Error checking profile saved status: $e');
      return false;
    }
  }

 Future<void> removeReviewFromSaved(BuildContext context, int reviewId) async {
  try {
    final token = await getToken();
    await savedService.removeReviewFromSaved(token, reviewId);
    // Show success snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Review removed from saved items!'),
        duration: Duration(seconds: 2),
      ),
    );
  } catch (e) {
    // Show error snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error removing review: $e'),
        duration: Duration(seconds: 2),
      ),
    );
    print('Error removing review from saved: $e');
  }
}


Future<void> removeBookFromSaved(BuildContext context, int bookId) async {
  try {
    final token = await getToken(); // Get the token
    await savedService.removeBookFromSaved(token, bookId);
    
    // Show success snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Book removed from saved items!'),
        duration: Duration(seconds: 2), // Optional: set duration
      ),
    );
  } catch (e) {
    // Show error snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error removing book from saved: $e'),
        duration: Duration(seconds: 2), // Optional: set duration
      ),
    );
    print('Error removing book from saved: $e'); // Print error to console
  }
}


Future<void> removeProfileFromSaved(BuildContext context, int profileId) async {
  try {
    final token = await getToken(); // Get the token
    await savedService.removeProfileFromSaved(token, profileId);
    
    // Show success snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile removed from saved items!'),
        duration: Duration(seconds: 2), // Optional: set duration
      ),
    );
  } catch (e) {
    // Show error snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error removing profile from saved: $e'),
        duration: Duration(seconds: 2), // Optional: set duration
      ),
    );
    print('Error removing profile from saved: $e'); // Print error to console
  }
}
}
