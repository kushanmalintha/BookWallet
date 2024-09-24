import 'package:flutter/material.dart';
import 'package:book_wallert/services/BookStatusService.dart';

class BookStatusController extends ChangeNotifier {
  final BookStatusService bookStatusService;

  bool _isInWishlist = false;
  bool _isSaved = false;

  bool get isInWishlist => _isInWishlist;
  bool get isSaved => _isSaved;

  BookStatusController(this.bookStatusService);

  Future<void> checkBookStatus(int userId, int bookId) async {
    try {
      final status = await bookStatusService.checkBookStatus(userId, bookId);
      _isInWishlist = status['wishlistStatus']!;
      _isSaved = status['saveStatus']!;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to check book status: $e');
    }
  }
}
