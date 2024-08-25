import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/models/user.dart';
import 'package:book_wallert/services/history_api_service.dart';

class HistoryController {
  final HistoryService historyService;
  bool isLoading = true;
  List<BookModel> historyBooks = [];
  List<ReviewModel> historyReviews = [];
  List<User> historyUsers = [];
  List<dynamic> allItems = []; // list for keep all items 

  HistoryController(int userId) : historyService = HistoryService(userId);

  Future<void> fetchBooks(Function(List<BookModel>) onSuccess) async {
    try {
      historyBooks = await historyService.fetchBooks();
      onSuccess(historyBooks);
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchReviews(Function(List<ReviewModel>) onSuccess) async {
    try {
      historyReviews = await historyService.fetchReviews();
      onSuccess(historyReviews);
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchUsers(Function(List<User>) onSuccess) async {
    try {
      historyUsers = await historyService.fetchUsers();
      onSuccess(historyUsers);
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchAllItems(Function(List<dynamic>) onSuccess) async {
    try {
      // Assign the fetched items directly to the class-level allItems list
      allItems = await historyService.fetchAllItems();
      onSuccess(allItems);
    } catch (e) {
      print(e);
    }
  }
}
