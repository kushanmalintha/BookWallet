import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/notiffication_controller.dart';
import 'package:book_wallert/controllers/review_controller.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/services/notification_api_service.dart';
import 'package:book_wallert/widgets/cards/review_card.dart';
import 'package:flutter/material.dart';

class NotificationAllListView extends StatefulWidget {
  final int globalUserId;

  NotificationAllListView({Key? key, required this.globalUserId})
      : super(key: key);

  @override
  _NotificationAllListViewState createState() =>
      _NotificationAllListViewState();
}

class _NotificationAllListViewState extends State<NotificationAllListView>
    with AutomaticKeepAliveClientMixin {
  final NotificationController _notificationController =
      NotificationController();
  final ReviewController _reviewController = ReviewController();
  late Future<List<AppNotificationAll>> _notificationsFuture;

  @override
  void initState() {
    super.initState();
    _fetchNotifications(); // Initial fetch
  }

  Future<void> _fetchNotifications() async {
    setState(() {
      _notificationsFuture =
          _notificationController.getAllNotifications(widget.globalUserId);
    });
  }

  @override
  bool get wantKeepAlive => true; // Keep alive when moving between list views

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: _notificationsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error fetching notifications"));
        }

        final notifications = snapshot.data as List<AppNotificationAll>?;

        return RefreshIndicator(
          color: MyColors.selectedItemColor,
          backgroundColor: MyColors.bgColor,
          onRefresh:
              _fetchNotifications, // Trigger fetching notifications on refresh
          child: notifications == null || notifications.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: const Center(
                        child: Text(
                          'No notifications',
                          style: TextStyle(
                            color: MyColors.textColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];

                    return GestureDetector(
                      onTap: () async {
                        // Fetch the review details when the card is clicked
                        ReviewModel review = await _reviewController
                            .fetchReview(notification.reviewID);

                        // Show the review in a dialog box
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8), // Slightly rounded corners
                              ),
                              backgroundColor: MyColors
                                  .bgColor, // Set background color to your custom color
                              insetPadding: const EdgeInsets.all(
                                  10), // Reduce the outer padding to minimize white border
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    1.0, // Increased width to 90% of the screen
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: MyColors
                                      .bgColor, // Background color of the dialog content
                                  borderRadius: BorderRadius.circular(
                                      8), // Ensure the inner content has rounded corners too
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize
                                      .min, // Adjust height based on content
                                  children: [
                                    ReviewCard(review: review), // Review card
                                    const SizedBox(height: 8),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          "Close",
                                          style: TextStyle(
                                              color:
                                                  MyColors.selectedItemColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Card(
                        color: MyColors.panelColor, // Set card background color
                        child: ListTile(
                          title: Text(
                            notification
                                .message, // Use the message coming from JSON directly
                            style: TextStyle(
                              color: MyColors.textColor, // Set text color
                            ),
                          ),
                          // Uncomment if you want to display the date
                          // subtitle: notification.date != null
                          //     ? Align(
                          //         alignment: Alignment.bottomRight,
                          //         child: Text(
                          //           notification.date!, // Display date if available
                          //           style: TextStyle(
                          //             color: MyColors.textColor, // Set text color
                          //             fontSize: 12.0, // Smaller font size for date
                          //           ),
                          //         ),
                          //       )
                          //     : null,
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
