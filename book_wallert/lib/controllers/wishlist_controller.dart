import 'package:book_wallert/controllers/book_recommended_controller.dart';
import 'package:book_wallert/controllers/token_controller.dart';
import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/services/fetch_bookId_from_ISBN.dart';
import 'package:book_wallert/services/wishlist_api_service.dart';
import 'package:flutter/material.dart';

class WishlistController extends ChangeNotifier {
  final BookIdService _bookIdService = BookIdService();
  final WishlistApiService apiService;
   final BookRecommendController bookRecommendController =
        BookRecommendController(globalUser!.userId);
   final WishlistApiService _apiService= WishlistApiService();     
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
      String? token = await getToken();  // Get the token
      await apiService.postwhislistDetails(userId, bookId, token);
    } catch (e) {
      print('Error adding book to wishlist: $e');
    }
  }

  Future<void> removeBookFromWishlist(int userId, int bookId) async {
    try {
      await apiService.removeBookFromWishlist(userId, bookId);
    } catch (e) {
      print('Error removing book from wishlist: $e');
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
   Future<void> addOrRemoveWishlistBook(BuildContext context, BookModel book, bool isInWishlist) async {
    try {
      String? token = await getToken();
      await bookRecommendController.fetchBookId(book);
      if (isInWishlist) {
        // Remove from wishlist
         await apiService.removeBookFromWishlist(globalUser!.userId,
                              bookRecommendController.bookId!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Book removed from wishlist successfully.')),
        );
      } else {
        // Add to wishlist
        await apiService.postwhislistDetails(globalUser!.userId,
                              bookRecommendController.bookId!, token);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Book added to wishlist successfully.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> wishlistfetchBookId(BookModel book) async {
    try {
      bookId = await _apiService.fetchId(book);
    } catch (e) {
      throw Exception('Error fetching book ID: $e');
    }
  }
}

