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
  late ReviewForUserController _reviewForUserController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _reviewForUserController = ReviewForUserController(widget.userId);
    _fetchMoreData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchMoreData() {
    _reviewForUserController.fetchPosts((updatedReviews) {
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
    return _reviewForUserController.isloading
        ? Center(child: buildProgressIndicator())
        : _reviewForUserController.reviews.isEmpty
            ? const Center(
                child: Text('No reviews',
                    style: TextStyle(color: MyColors.textColor)))
            : ListView.builder(
                controller: _scrollController,
                itemCount: _reviewForUserController.reviews.length + 1,
                itemBuilder: (context, index) {
                  if (index < _reviewForUserController.reviews.length) {
                    return Column(
                      children: [
                        getScreen(index),
                        const SizedBox(height: 3),
                      ],
                    );
                  }
                  return null;
                },
              );
  }
}
