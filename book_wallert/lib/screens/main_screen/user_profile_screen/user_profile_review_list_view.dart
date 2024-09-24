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

class _UserProfileReviewListViewState extends State<UserProfileReviewListView>
    with AutomaticKeepAliveClientMixin {
  late Future<void> _reviewsFuture;
  late ReviewForUserController _reviewForUserController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _reviewForUserController = ReviewForUserController(widget.userId);
    _reviewsFuture = _fetchMoreData(); // Load reviews when widget initializes
  }

  Future<void> _fetchMoreData() async {
    await _reviewForUserController.fetchPosts((updatedReviews) {
      setState(() {
        _reviewForUserController.reviews = updatedReviews;
      });
    });
  }

  Future<void> _onRefresh() async {
    setState(() {
      _reviewForUserController.reviews = []; // Clear reviews before refresh
    });
    await _fetchMoreData(); // Fetch fresh data
  }

  Widget getScreen(int index) {
    return ReviewCard(review: _reviewForUserController.reviews[index]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for keeping state alive

    return RefreshIndicator(
      color: MyColors.selectedItemColor,
      backgroundColor: MyColors.bgColor,
      onRefresh: _onRefresh,
      child: FutureBuilder<void>(
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
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: const Center(
                    child: Text(
                      'No reviews',
                      style: TextStyle(
                        color: MyColors.textColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
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
      ),
    );
  }
}
