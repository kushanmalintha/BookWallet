import 'package:book_wallert/models/share_model.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/services/share_service.dart';

class ShareController {
  final ShareService _shareService = ShareService();
  List<Map<String, dynamic>> shares = [];
  bool isLoading = false;

  


  Future<void> shareReview(int reviewId, int userId) async {
    try {
      await _shareService.shareReview(reviewId, userId);
    } catch (e) {
      throw Exception('Failed to share review: $e');
    }
  }
  Future<List<SharedReview>> getSharedReviews(int userId) async {
    try {
      return await _shareService.fetchSharedReviews(userId);
    } catch (e) {
      throw Exception('Failed to fetch shared reviews: $e');
    }
  }
  //  Future<void> fetchShares(int reviewId) async {
  //   isLoading = true;
  //   notifyListeners();

  //   try {
  //     shares = await apiService.fetchShares(reviewId);
  //   } catch (e) {
  //     print('Error fetching shares: $e');
  //   } finally {
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }

}
