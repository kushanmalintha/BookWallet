import 'package:book_wallert/models/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;

  const CommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.panelColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Row: Image and Comment
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    'http://example.com/user/${comment.userId}/image', // Update with actual image URL
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.username,
                        style: const TextStyle(
                          color: MyColors.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        comment.context,
                        style: const TextStyle(
                          color: MyColors.textColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Second Row: Date
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  '${comment.date}',
                  style: const TextStyle(
                    color: MyColors.textColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
