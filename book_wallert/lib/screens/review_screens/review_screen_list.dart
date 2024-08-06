import 'package:book_wallert/dummy_data/user_dummy.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/controllers/review_likes_controller.dart';
import 'package:book_wallert/services/review_likes_api_service.dart';
import 'package:book_wallert/models/user.dart';
import 'package:book_wallert/widgets/cards/user_card.dart';

class ReviewScreenListView extends StatefulWidget {
  final int reviewId; // Assuming reviewId is needed to fetch likes
  final String screenName;

  const ReviewScreenListView({
    super.key,
    required this.reviewId,
    required this.screenName,
  });

  @override
  _ReviewScreenListViewState createState() => _ReviewScreenListViewState();
}

class _ReviewScreenListViewState extends State<ReviewScreenListView> {
  late LikesController _likesController;

  @override
  void initState() {
    super.initState();
    _likesController = LikesController(LikesApiService());
    if (widget.screenName == 'Like') {
      _fetchLikes();
    }
  }

  Future<void> _fetchLikes() async {
    await _likesController.fetchLikes(widget.reviewId);
    setState(() {}); // Refresh the UI after data is fetched
  }

  @override
  Widget build(BuildContext context) {
    return getScreen(widget.screenName);
  }

  Widget getScreen(String screenName) {
    switch (screenName) {
      case 'Comment':
        return UserCard(user: dummyUser); // Replace with actual user data
      case 'Like':
        return _likesController.isLoading
            ? Center(child: CircularProgressIndicator())
            : _likesController.likes.isEmpty
                ? Center(child: Text('No likes yet'))
                : ListView.builder(
                    itemCount: _likesController.likes.length,
                    itemBuilder: (context, index) {
                      final like = _likesController.likes[index];
                      return UserCard(
                        user: User(
                          userId: like['user_id'],
                          username: like['username'],
                          email: '',
                        ),
                      );
                    },
                  );
      case 'Share':
        return UserCard(user: dummyUser); // Replace with actual user data
      default:
        return UserCard(user: dummyUser); // Replace with actual user data
    }
  }
}
