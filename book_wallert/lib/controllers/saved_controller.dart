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
  }
}
