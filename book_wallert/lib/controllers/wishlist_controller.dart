import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/services/fetch_bookId_from_ISBN.dart';
import 'package:book_wallert/services/wishlist_api_service.dart';
import 'package:flutter/material.dart';

class WishlistController extends ChangeNotifier {
  final BookIdService _bookIdService = BookIdService();
  final WishlistApiService apiService;
  List<BookModel> wishlistBooks = [];
  bool isLoading = false;
  int? bookId;

  WishlistController(this.apiService);

  Future<void> fetchWishlist(int userId) async {
    // Changed String to int
    isLoading = true;
    notifyListeners();

    try {
      wishlistBooks = await apiService.fetchWishlist(userId);
      print(wishlistBooks);
    } catch (e) {
      print('Error fetching wishlist: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addBookToWishlist(int userId, int bookId) async {
    try {
      // Add your logic to fetch the bookId from the wishlist if needed
      await apiService.postwhislistDetails(userId, bookId);
    } catch (e) {
      print('Error adding book to recommendation: $e');
    }
  }

  Future<void> removeBookFromWishlist(int userId, int bookId) async {
    try {
      await apiService.removeBookFromWishlist(userId, bookId);
    } catch (e) {
      print('Error removing book from wishlist: $e');
    }
  }
}
