import 'package:book_wallert/colors.dart';
import 'package:book_wallert/functions/global_navigator_functions.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/screens/main_screen/review_screens/review_screen_body.dart';
import 'package:flutter/material.dart';

class CommentButton extends StatefulWidget {
  final ReviewModel review;
  final IconData icon;
  final bool isComment;
  final VoidCallback? onTap;
  final Function(bool) onCommentChanged;
  int commentsCount;

  CommentButton({
    super.key,
    required this.review,
    required this.icon,
    this.onTap,
    required this.isComment,
    required this.onCommentChanged,
    required this.commentsCount,
  });

  @override
  State<CommentButton> createState() => _CommentButtonState();
}

class _CommentButtonState extends State<CommentButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              !widget.isComment
                  ? widget.commentsCount++
                  : widget.commentsCount--;
            });
            widget.onCommentChanged(!widget.isComment);
            _controller.reverse().then((value) => _controller.forward());

            // Call the custom onTap function if provided
            if (widget.onTap != null) {
              widget.onTap!();
            }
          },
          child: ScaleTransition(
            scale: Tween(begin: 0.7, end: 1.0).animate(
                CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
            child: widget.isComment
                ? Icon(
                    widget.icon,
                    size: 20,
                    color: MyColors.selectedItemColor,
                  )
                : Icon(
                    widget.icon,
                    size: 20,
                    color: MyColors.nonSelectedItemColor,
                  ),
          ),
        ),
        TextButton(
          onPressed: () {
            screenChange(
                context,
                ReviewScreenBody(
                  review: widget.review,
                  index: 0,
                ));
          },
          child: Text('${widget.commentsCount}',
              style: const TextStyle(color: MyColors.textColor)),
        ),
      ],
    );
  }
}
