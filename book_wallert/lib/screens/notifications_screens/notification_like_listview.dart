import 'package:book_wallert/controllers/notiffication_controller.dart';
import 'package:book_wallert/services/notification_api_service.dart';
import 'package:book_wallert/widgets/cards/notification_card.dart';
import 'package:flutter/material.dart';

class NotificationLikeListView extends StatelessWidget {
  final int globalUserId;
  final NotificationController _notificationController =
      NotificationController();

  NotificationLikeListView({Key? key, required this.globalUserId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _notificationController.getLikeNotifications(
          globalUserId), // Fetch notifications using the controller
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error fetching notifications"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No notifications"));
        }

        final notifications = snapshot.data as List<AppNotificationLike>;

        return ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return LikeNotificationCard(
                username: notifications[index].likedUserName,
                bookName: notifications[index].bookname);
          },
        );
      },
    );
  }
}
