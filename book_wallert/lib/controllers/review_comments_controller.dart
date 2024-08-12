import 'package:flutter/material.dart';
import 'package:book_wallert/services/review_comments_api_service.dart';
import 'package:book_wallert/functions/global_user_provider.dart';

class CommentController {
  final TextEditingController commentController = TextEditingController();
  final CommentApiService commentApiService = CommentApiService();
  final int reviewId; // ID of the review to comment on

  CommentController(this.reviewId);

  Future<void> addComment(BuildContext context) async {
    final user = globalUser; // Get the global user
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User not logged in'),
        ),
      );
      return;
    }

    try {
      await commentApiService.addComment(
        reviewId,
        commentController.text,
        user.userId, // Use the user ID from the global user
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Comment added successfully'),
          ),
        );
        commentController.clear(); // Clear the comment input field
      }
    } catch (e) {
      print(e);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add the comment'),
          ),
        );
      }
    }
  }
}
