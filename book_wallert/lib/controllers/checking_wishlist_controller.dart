import 'package:flutter/material.dart';
import 'package:book_wallert/services/checking_wishlist_service.dart';

class CheckingWishlistController extends ChangeNotifier {
  final CheckingWishlistService checkingWishlistService;

  bool _isInWishlist = false;
  bool get isInWishlist => _isInWishlist;

  CheckingWishlistController(this.checkingWishlistService);

  Future<bool> checkWishlistStatus(int userId, int bookId) async {
    try {
      _isInWishlist =
          await checkingWishlistService.isBookInWishlist(userId, bookId);
      notifyListeners();
      return _isInWishlist;
    } catch (e) {
      throw Exception('Failed to check wishlist status: $e');
    }
  }
}
