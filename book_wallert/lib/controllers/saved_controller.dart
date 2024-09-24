import 'package:book_wallert/controllers/token_controller.dart';
import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/models/user.dart';
import 'package:book_wallert/services/saved_api_services.dart';

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

  Future<void> insertReviewToSaved(reviewId) async {
    try {
      final token = await getToken();
      await savedService.insertReviewToSaved(token, reviewId);
    } catch (e) {
      print('Error inserting to saved: $e');
    }
  }

  Future<void> insertBookToSaved(bookId) async {
    try {
      print("hi");
      final token = await getToken();
      await savedService.insertBookToSaved(token, bookId);
    } catch (e) {
      print('Error inserting to saved: $e');
    }
  }

  Future<void> insertProfileToSaved(userID) async {
    try {
      final token = await getToken();
      await savedService.insertProfileToSaved(token!, userID);
    } catch (e) {
      print('Error inserting to saved: $e');
    }
  } // Check if a review is saved

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

  // Remove a review from saved items
  Future<void> removeReviewFromSaved(reviewId) async {
    try {
      final token = await getToken();
      await savedService.removeReviewFromSaved(token, reviewId);
    } catch (e) {
      print('Error removing review from saved: $e');
    }
  }

  // Remove a book from saved items
  Future<void> removeBookFromSaved(bookId) async {
    try {
      final token = await getToken();
      await savedService.removeBookFromSaved(token, bookId);
    } catch (e) {
      print('Error removing book from saved: $e');
    }
  }

  // Remove a profile from saved items
  Future<void> removeProfileFromSaved(profileId) async {
    try {
      final token = await getToken();
      await savedService.removeProfileFromSaved(token, profileId);
    } catch (e) {
      print('Error removing profile from saved: $e');
    }
  }
}
