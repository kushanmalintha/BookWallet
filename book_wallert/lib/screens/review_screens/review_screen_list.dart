import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/share_controller.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/controllers/review_likes_controller.dart';
import 'package:book_wallert/services/review_likes_api_service.dart';
import 'package:book_wallert/controllers/review_comments_controller.dart'; // Import CommentController
import 'package:book_wallert/models/user.dart';
import 'package:book_wallert/models/comment_model.dart'; // Import Comment model
import 'package:book_wallert/widgets/cards/user_card.dart';
import 'package:book_wallert/widgets/cards/comment_card.dart'; // Import CommentCard widget

class ReviewScreenListView extends StatefulWidget {
  final int reviewId;
  final String screenName;
  const ReviewScreenListView({
    super.key,
    required this.reviewId,
    required this.screenName,
  });

  @override
  _ReviewScreenListViewState createState() => _ReviewScreenListViewState();
}

class _ReviewScreenListViewState extends State<ReviewScreenListView>
    with AutomaticKeepAliveClientMixin {
  late LikesController _likesController;
  late CommentController _commentController;
  late ShareController _shareController; // Declare ShareController
  bool _loadingLikes = false;
  bool _loadingComments = false;
  bool _loadingShares = false; // Track share loading state
  List<Map<String, dynamic>> _likes = [];
  List<Comment> _comments = [];
  List<Map<String, dynamic>> _shares = []; // Store shares data

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _likesController = LikesController(LikesApiService());
    _commentController =
        CommentController(widget.reviewId); // Initialize CommentController
    _shareController = ShareController(); // Initialize ShareController

    if (widget.screenName == 'Like') {
      _fetchLikes();
    } else if (widget.screenName == 'Comment') {
      _fetchComments();
    } else if (widget.screenName == 'Share') {
      _fetchShares();
    }
  }

  Future<void> _fetchLikes() async {
    setState(() {
      _loadingLikes = true;
    });
    await _likesController.fetchLikes(widget.reviewId);
    setState(() {
      _likes = _likesController.likes;
      _loadingLikes = false;
    });
  }

  Future<void> _fetchComments() async {
    setState(() {
      _loadingComments = true;
    });
    final comments = await _commentController.fetchComments();
    setState(() {
      _comments = comments;
      _loadingComments = false;
    });
  }

  Future<void> _fetchShares() async {
    setState(() {
      _loadingShares = true;
    });
    await _shareController.fetchShares(widget.reviewId);
    setState(() {
      _shares = _shareController.shares;
      _loadingShares = false;
    });
  }

  Future<void> _onRefresh() async {
    if (widget.screenName == 'Like') {
      await _onRefreshLikes();
    } else if (widget.screenName == 'Comment') {
      await _onRefreshComments();
    } else if (widget.screenName == 'Share') {
      await _onRefreshShares();
    }
  }

  Future<void> _onRefreshLikes() async {
    setState(() {
      _likesController.likes = [];
    });
    _fetchLikes();
  }

  Future<void> _onRefreshComments() async {
    setState(() {
      _commentController.comments = [];
    });
    _fetchComments();
  }

  Future<void> _onRefreshShares() async {
    setState(() {
      _shareController.shares = [];
    });
    _fetchShares();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      color: MyColors.selectedItemColor,
      backgroundColor: MyColors.bgColor,
      onRefresh: _onRefresh,
      child: getScreen(widget.screenName),
    );
  }

  Widget getScreen(String screenName) {
    switch (screenName) {
      case 'Comment':
        return _loadingComments
            ? Center(child: CircularProgressIndicator())
            : _comments.isEmpty
                ? Center(child: Text('No comments yet'))
                : ListView.builder(
                    itemCount: _comments.length,
                    itemBuilder: (context, index) {
                      final comment = _comments[index];
                      return CommentCard(comment: comment);
                    },
                  );
      case 'Like':
        return _loadingLikes
            ? Center(child: CircularProgressIndicator())
            : _likes.isEmpty
                ? Center(child: Text('No likes yet'))
                : ListView.builder(
                    itemCount: _likes.length,
                    itemBuilder: (context, index) {
                      final like = _likes[index];
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
        return _loadingShares
            ? Center(child: CircularProgressIndicator())
            : _shares.isEmpty
                ? Center(child: Text('No shares yet'))
                : ListView.builder(
                    itemCount: _shares.length,
                    itemBuilder: (context, index) {
                      final share = _shares[index];
                      return UserCard(
                        user: User(
                          userId: share['user_id'],
                          username: share['username'],
                          email: '', // Adjust if you have email data
                        ),
                      );
                    },
                  );
      default:
        return Center(child: Text('Invalid screen name'));
    }
  }
}
