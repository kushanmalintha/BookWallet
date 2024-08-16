import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/controllers/share_controller.dart';
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
  late ShareController _shareController;

  @override
  void initState() {
    super.initState();
    _shareController = ShareController();
  }

  void _handleShare() async {
    try {
      await _shareController.shareReview(widget.review.reviewId, globalUser!.userId);
      setState(() {
        widget.sharesCount++;
      });
    } catch (e) {
      print('Error sharing review: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            widget.icon,
            color: MyColors.nonSelectedItemColor,
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
