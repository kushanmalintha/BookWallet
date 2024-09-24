import 'package:book_wallert/controllers/token_controller.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/services/review_comments_api_service.dart';
import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/models/comment_model.dart';

class CommentController {
  final TextEditingController commentController = TextEditingController();
  final CommentApiService commentApiService = CommentApiService();
  final int reviewId;
  List<Comment> comments = [];

  CommentController(this.reviewId);

  Future<void> addComment(BuildContext context) async {
    final user = globalUser;
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
        user.userId,
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

  Future<List<Comment>> fetchComments() async {
    try {
      return comments = await commentApiService.fetchComments(reviewId);
    } catch (e) {
      print(e);
      return [];
    }
  }
}

class CommentUpdateController {
  final CommentUpdateService _commentUpdateService = CommentUpdateService();
  final int commentId;
  final int userId;

  CommentUpdateController(this.commentId, this.userId);

  Future<void> updateComment(BuildContext context, String newText) async {
    try {
      String? token = await getToken();
      await _commentUpdateService.updateComment(
          commentId, userId, newText, token!);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Comment updated successfully'),
          ),
        );
      }
    } catch (e) {
      print(e);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update the comment'),
          ),
        );
      }
    }
  }
}

class CommentDeleteController {
  final CommentDeleteService _commentDeleteService = CommentDeleteService();
  final int commentId;
  final int userId;

  CommentDeleteController(this.commentId, this.userId);

  Future<void> deleteComment(BuildContext context) async {
    try {
      String? token = await getToken();
      await _commentDeleteService.deleteComment(commentId, userId, token!);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Comment deleted successfully'),
          ),
        );
      }
    } catch (e) {
      print(e);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to delete the comment'),
          ),
        );
      }
    }
  }
}
