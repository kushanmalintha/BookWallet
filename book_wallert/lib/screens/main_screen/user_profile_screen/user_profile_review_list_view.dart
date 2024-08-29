import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/review_for_user_controller.dart';
import 'package:book_wallert/widgets/cards/review_card.dart';
import 'package:book_wallert/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';

class UserProfileReviewListView extends StatefulWidget {
  final int userId;

  const UserProfileReviewListView({super.key, required this.userId});

  @override
  State<UserProfileReviewListView> createState() =>
      _UserProfileReviewListViewState();
}

class _UserProfileReviewListViewState extends State<UserProfileReviewListView> {
  late Future<void> _reviewsFuture;
  late ReviewForUserController _reviewForUserController;

  @override
  void initState() {
    super.initState();
    _reviewForUserController = ReviewForUserController(widget.userId);
    _reviewsFuture = _fetchMoreData();
  }

  Future<void> _fetchMoreData() async {
    await _reviewForUserController.fetchPosts((updatedReviews) {
      setState(() {
        _reviewForUserController.reviews = updatedReviews;
      });
    });
  }

  Widget getScreen(int index) {
    return ReviewCard(review: _reviewForUserController.reviews[index]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _reviewsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: buildProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(
              'Failed to load reviews',
              style: TextStyle(color: MyColors.textColor),
            ),
          );
        } else if (_reviewForUserController.reviews.isEmpty) {
          return const Center(
            child: Text(
              'No reviews',
              style: TextStyle(color: MyColors.textColor),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: _reviewForUserController.reviews.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  getScreen(index),
                  const SizedBox(height: 3),
                ],
              );
            },
          );
        }
      },
    );
  }
}
