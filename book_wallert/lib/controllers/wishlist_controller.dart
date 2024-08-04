import 'package:book_wallert/models/book_model.dart';
import 'package:book_wallert/services/wishlist_api_service.dart';
import 'package:flutter/material.dart';

class WishlistController extends ChangeNotifier {
  final WishlistApiService apiService;
  List<BookModel> wishlistBooks = [];
  bool isLoading = false;

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
}
