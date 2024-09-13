import 'package:book_wallert/controllers/notiffication_controller.dart';
import 'package:book_wallert/controllers/review_controller.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/services/notification_api_service.dart';
import 'package:book_wallert/widgets/cards/notification_card.dart';
import 'package:book_wallert/widgets/cards/review_card.dart';
import 'package:flutter/material.dart';

class NotificationCommentListView extends StatelessWidget {
  final int globalUserId;
  final NotificationController _notificationController = NotificationController();
  final ReviewController _reviewController = ReviewController();

  NotificationCommentListView({Key? key, required this.globalUserId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _notificationController.getCommentNotifications(globalUserId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error fetching notifications"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No notifications"));
        }

        final notifications = snapshot.data as List<AppNotificationComment>;

        return ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                // Fetch the review details when the card is clicked
                ReviewModel review = await _reviewController.fetchReview(notifications[index].reviewID);

                // Show the review in a dialog box
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: ReviewCard(review: review),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Close"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: CommentNotificationCard(
                username: notifications[index].CommentedUserName,
                bookName: notifications[index].bookname,
              ),
            );
          },
        );
      },
    );
  }
}
