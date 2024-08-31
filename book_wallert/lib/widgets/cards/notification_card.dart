import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

class NotificationCard extends StatelessWidget {
  final String username;
  final String bookName;
  final String action; // "liked", "commented", "shared"

  const NotificationCard({
    Key? key,
    required this.username,
    required this.bookName,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.panelColor, // Set the card color
      child: ListTile(
        title: Text(
          '$username $action your review on $bookName',
          style: TextStyle(
            color: MyColors.textColor, // Set the text color
          ),
        ),
      ),
    );
  }
}

// LikeNotificationCard
class LikeNotificationCard extends NotificationCard {
  const LikeNotificationCard({
    Key? key,
    required String username,
    required String bookName,
  }) : super(key: key, username: username, bookName: bookName, action: 'liked');
}

// CommentNotificationCard
class CommentNotificationCard extends NotificationCard {
  const CommentNotificationCard({
    Key? key,
    required String username,
    required String bookName,
  }) : super(key: key, username: username, bookName: bookName, action: 'commented on');
}

// ShareNotificationCard
class ShareNotificationCard extends NotificationCard {
  const ShareNotificationCard({
    Key? key,
    required String username,
    required String bookName,
  }) : super(key: key, username: username, bookName: bookName, action: 'shared');
}
