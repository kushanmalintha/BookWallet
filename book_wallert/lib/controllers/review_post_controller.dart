import 'package:book_wallert/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/services/review_post_api_service.dart';
import 'package:book_wallert/functions/global_user_provider.dart'; // Import the global user functions

class ReviewPostController {
  final TextEditingController reviewPostController = TextEditingController();
  final ReviewPostApiService reviewPostApiService = ReviewPostApiService();
  double rating = 0.0; // Rating from the user
  final BookModel book; // Book object

  ReviewPostController(this.book);

  Future<void> reviewPost(BuildContext context) async {
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
      await reviewPostApiService.reviewPost(
        book,
        reviewPostController.text,
        rating,
        user.userId, // Use the user ID from the global user
      );
      // if (context.mounted) {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => BookProfileScreenBody(book: dummyBook)));
      // }
    } catch (e) {
      print(e);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to post the review'),
          ),
        );
      }
    }
  }
}
