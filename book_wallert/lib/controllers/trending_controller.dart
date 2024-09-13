import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/services/trending_service.dart';
import 'package:flutter/material.dart';

class TrendingController extends ChangeNotifier {
  final TrendingService trendingService;
  List<BookModel> trendingBooks = [];
  bool isLoading = true;

  TrendingController(this.trendingService);

  Future<void> fetchTrendingBooks() async {
    try {
      trendingBooks = await trendingService.fetchTrendingBooks();
    } catch (e) {
      print('Error fetching trending books: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify the UI to rebuild
    }
  }
}
