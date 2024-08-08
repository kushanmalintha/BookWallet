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

  Future<void> fetchBookId(BookModel book) async {
    try {
      bookId = await _bookIdService.fetchId(book);
    } catch (e) {
      throw Exception('Error fetching book ID: $e');
    }
  }

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

  Future<void> addBookToWishlistAndNotify(
      BuildContext context, int userId, BookModel book) async {
    try {
      await fetchBookId(book);
      await addBookToWishlist(userId, bookId!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Book added to wishlist successfully.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding book to wishlist: $e')),
      );
    }
  }
}
