import 'package:book_wallert/controllers/token_controller.dart';
import 'package:book_wallert/services/review_update_service.dart';
import 'package:flutter/material.dart';

class ReviewUpdateController {
  final TextEditingController reviewUpdateController = TextEditingController();
  final ReviewUpdateService _reviewUpdateService = ReviewUpdateService();
  final int reviewId;
  final int userId;
  double rating = 0.0;

  ReviewUpdateController(this.reviewId, this.userId);

  Future<void> updateReview(BuildContext context) async {
    try {
      String? token = await getToken();
      await _reviewUpdateService.updateReview(
          reviewId, userId, reviewUpdateController.text, rating, token!);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Review updated successfully'),
          ),
        );
      }
    } catch (e) {
      print(e);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update the review'),
          ),
        );
      }
    }
  }
}
