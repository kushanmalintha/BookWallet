import 'package:book_wallert/controllers/token_controller.dart';
import 'package:book_wallert/services/review_delete_service.dart';
import 'package:flutter/material.dart';

class ReviewDeleteController {
  final ReviewDeleteService _reviewDeleteService = ReviewDeleteService();
  final int reviewId;
  final int userId;

  ReviewDeleteController(this.reviewId, this.userId);

  Future<void> deleteReview(BuildContext context) async {
    try {
      String? token = await getToken();
      await _reviewDeleteService.deleteReview(reviewId, userId, token!);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Review deleted successfully'),
          ),
        );
      }
    } catch (e) {
      print(e);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to delete the review'),
          ),
        );
      }
    }
  }
}
