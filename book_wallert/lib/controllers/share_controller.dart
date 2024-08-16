import 'package:book_wallert/models/share_model.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/services/share_service.dart';

class ShareController {
  final ShareService _shareService = ShareService();

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
}
