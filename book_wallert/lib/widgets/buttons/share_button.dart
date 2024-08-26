import 'package:book_wallert/functions/global_navigator_functions.dart';
import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/screens/review_screens/review_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/services/share_service.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/colors.dart';

class ShareButton extends StatefulWidget {
  final ReviewModel review;
  final IconData icon;
  final int sharesCount;

  const ShareButton({
    Key? key,
    required this.review,
    required this.icon,
    required this.sharesCount,
  }) : super(key: key);

  @override
  _ShareButtonState createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool isShared = false;
  int _shareCount = 0;
  final ShareService _shareService = ShareService();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);

    _shareCount = widget.sharesCount;
    _checkIfShared(); // Check if the user has shared the review
  }

  Future<void> _checkIfShared() async {
    try {
      final userId = globalUser?.userId;
      if (userId == null) {
        // Handle the case where the user is not logged in or userId is not available
        print('User is not logged in');
        return;
      }

      final shared =
          await _shareService.checkIfShared(widget.review.reviewId, userId);
      setState(() {
        isShared = shared;
        print(
            isShared); // Fix: Set `isShared` directly to the result of the service call
      });
    } catch (e) {
      print('Failed to check if shared: $e');
    }
  }

  Future<void> _handleShare() async {
    try {
      final userId = globalUser?.userId;
      if (userId == null) {
        // Handle the case where the user is not logged in or userId is not available
        print('User is not logged in');
        return;
      }

      if (isShared) {
        await _shareService.UnshareReview(widget.review.reviewId, userId);
        setState(() {
          _shareCount--;
          isShared = false;
        });
      } else {
        await _shareService.shareReview(widget.review.reviewId, userId);
        setState(() {
          _shareCount++;
          isShared = true;
        });
      }
      // Trigger animation without affecting button state
      _controller.forward().then((_) => _controller.reverse());
    } catch (e) {
      print('Failed to toggle share: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: _handleShare,
          child: ScaleTransition(
            scale: Tween(begin: 0.95, end: 1.05).animate(
                CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
            child: Icon(
              widget.icon,
              size: 21,
              color: isShared
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
                  index: 2,
                ));
          }, // Optionally, trigger the share on text tap as well
          child: Text(
            '$_shareCount', // Display the share count
            style: const TextStyle(color: MyColors.text2Color, fontSize: 14),
          ),
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
