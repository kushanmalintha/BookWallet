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
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_reviewForUserController.isloading) {
      _fetchMoreData();
    }
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
    return ListView.builder(
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
        } else {
          return buildProgressIndicator();
        }
      },
    );
  }
}
