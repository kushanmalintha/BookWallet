import 'package:book_wallert/dummy_data/book_dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/services/review_post_api_service.dart';
import 'package:book_wallert/screens/main_screen/book_profile_screen/book_profile_screen_body.dart';

class ReviewPostController {
  final TextEditingController reviewPostController = TextEditingController();
  final ReviewPostApiService reviewPostApiService = ReviewPostApiService();
  Future<void> reviewPost(BuildContext context) async {
    try {
      await reviewPostApiService.reviewPost(reviewPostController.text);
      if (context.mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookProfileScreenBody(book: dummyBook)));
      }
    } catch (e) {
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
