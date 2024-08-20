import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/services/share_service.dart'; // Assuming you have a ShareService
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/colors.dart';

class ShareButton extends StatefulWidget {
  final ReviewModel review;
  final IconData icon;
  int sharesCount;

  ShareButton({
    Key? key,
    required this.review,
    required this.icon,
    required this.sharesCount,
  }) : super(key: key);

  @override
  _ShareButtonState createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  late ShareService _shareService;
  bool isShared = false;

  @override
  void initState() {
    super.initState();
    _shareService = ShareService();
    _checkIfShared();
  }

  Future<void> _checkIfShared() async {
    try {
      bool shared = await _shareService.checkIfShared(widget.review.reviewId, globalUser!.userId);
      setState(() {
        isShared = shared;
      });
    } catch (e) {
      print('Error checking if review is shared: $e');
    }
  }

  void _handleShare() async {
    try {
      if (isShared) {
        await _shareService.shareReview(widget.review.reviewId, globalUser!.userId);
        setState(() {
          widget.sharesCount--;
          isShared = false;
        });
      } else {
        await _shareService.shareReview(widget.review.reviewId, globalUser!.userId);
        setState(() {
          widget.sharesCount++;
          isShared = true;
        });
      }
    } catch (e) {
      print('Error sharing/unsharing review: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            widget.icon,
            color: isShared ? MyColors.selectedItemColor : MyColors.nonSelectedItemColor,
          ),
          onPressed: _handleShare,
        ),
        Text(
          '${widget.sharesCount}', // Display the share count
          style: const TextStyle(
            color: MyColors.text2Color,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
