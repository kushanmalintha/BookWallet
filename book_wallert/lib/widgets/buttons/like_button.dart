// widgets/like_button.dart
import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/services/review_likes_api_service.dart';
import 'package:book_wallert/screens/review_screens/review_screen_body.dart';
import 'package:book_wallert/functions/global_navigator_functions.dart'; // Import your global functions

class LikeButton extends StatefulWidget {
  final ReviewModel review;
  final IconData icon;
  final VoidCallback? onTap;
  final int likesCount;

  const LikeButton({
    super.key,
    required this.review,
    required this.icon,
    required this.likesCount,
    this.onTap,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isLike = false;
  int _likeCount = 0;
  final LikesApiService _apiService = LikesApiService();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);

    _likeCount = widget.likesCount;
    _checkIfLiked(); // Check if the user has liked the review
  }

  Future<void> _checkIfLiked() async {
    try {
      final userId = globalUser?.userId; // Use the global user ID
      if (userId == null) {
        // Handle the case where the user is not logged in or userId is not available
        print('User is not logged in');
        return;
      }

      final isLiked =
          await _apiService.checkIfLiked(widget.review.reviewId, userId);
      setState(() {
        _isLike = isLiked;
      });
    } catch (e) {
      print('Failed to check if liked: $e');
    }
  }

  Future<void> _toggleLike() async {
    try {
      final userId = globalUser?.userId; // Use the global user ID
      if (userId == null) {
        // Handle the case where the user is not logged in or userId is not available
        print('User is not logged in');
        return;
      }

      if (_isLike) {
        await _apiService.unlikeReview(widget.review.reviewId, userId);
        setState(() {
          _likeCount--;
          _isLike = false;
        });
      } else {
        await _apiService.likeReview(widget.review.reviewId, userId);
        setState(() {
          _likeCount++;
          _isLike = true;
        });
      }
      // Trigger animation without affecting button state
      _controller.forward().then((_) => _controller.reverse());
    } catch (e) {
      print('Failed to toggle like: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: _toggleLike,
          child: ScaleTransition(
            scale: Tween(begin: 0.95, end: 1.05).animate(
                CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
            child: Icon(
              widget.icon,
              size: 21,
              color: _isLike
                  ? MyColors.selectedItemColor
                  : MyColors.nonSelectedItemColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            screenChange(
                context,
                ReviewScreenBody(
                  review: widget.review,
                  index: 1,
                ));
          },
          child: Text('$_likeCount',
              style: const TextStyle(color: MyColors.textColor)),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
