import 'package:book_wallert/controllers/review_comments_controller.dart';
import 'package:book_wallert/functions/global_navigator_functions.dart';
import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/models/comment_model.dart';
import 'package:book_wallert/screens/main_screen/user_profile_screen/user_profile_screen_body.dart';
import 'package:book_wallert/widgets/buttons/custom_popup_menu_buttons.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

class CommentCard extends StatefulWidget {
  final Comment comment;

  const CommentCard({super.key, required this.comment});

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool isEditing = false;
  late TextEditingController _controller;
  late CommentUpdateController _updateController;
  late CommentDeleteController _deleteController;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.comment.context);
    _updateController =
        CommentUpdateController(widget.comment.commentId, globalUser!.userId);
    _deleteController =
        CommentDeleteController(widget.comment.commentId, globalUser!.userId);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _editComment() async {
    final newText = _controller.text;
    if (newText.isNotEmpty) {
      await _updateController.updateComment(context, newText);
      setState(() {
        widget.comment.context = newText;
        isEditing = false; // Properly exit editing mode
      });
    }
  }

  Future<void> _deleteComment() async {
    await _deleteController.deleteComment(context);
    // Optionally, you can remove the comment from the UI if this is part of a list
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          color: MyColors.panelColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        screenChange(
                          context,
                          UserProfileScreenBody(
                            userId: widget
                                .comment.userId, // Access userId from Comment
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(
                          'http://example.com/user/${widget.comment.userId}/image',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.comment.username,
                            style: const TextStyle(
                              color: MyColors.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          if (isEditing)
                            TextField(
                              controller: _controller,
                              maxLines: null,
                              style: const TextStyle(
                                color: MyColors.textColor,
                                fontSize: 15,
                              ),
                            )
                          else
                            Text(
                              widget.comment.context,
                              style: const TextStyle(
                                color: MyColors.text2Color,
                                fontSize: 15,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${widget.comment.date}',
                        style: const TextStyle(
                          color: MyColors.textColor,
                          fontSize: 12,
                        ),
                      ),
                      if (isEditing)
                        TextButton(
                          onPressed: () async {
                            setState(() {
                              isEditing = false;
                            });
                            await _editComment();
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(color: MyColors.selectedItemColor),
                          ),
                        ),
                      if (isEditing)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isEditing = false;
                            });
                          },
                          child: const Text(
                            'Cancel',
                            style:
                                TextStyle(color: MyColors.nonSelectedItemColor),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: CustomPopupMenuButtons(
            items: widget.comment.userId == globalUser!.userId
                ? const ['Edit', 'Delete']
                : const ['Report'],
            onItemTap: widget.comment.userId == globalUser!.userId
                ? [
                    () {
                      setState(() {
                        isEditing = true;
                      });
                    },
                    _deleteComment,
                  ]
                : [
                    () {
                      // Implement report functionality here
                    },
                  ],
            icon: const Icon(Icons.more_vert_rounded,
                color: MyColors.nonSelectedItemColor),
          ),
        ),
      ],
    );
  }
}
