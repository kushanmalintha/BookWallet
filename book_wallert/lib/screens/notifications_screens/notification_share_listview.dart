import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/notiffication_controller.dart';
import 'package:book_wallert/controllers/review_controller.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/services/notification_api_service.dart';
import 'package:book_wallert/widgets/cards/notification_card.dart';
import 'package:book_wallert/widgets/cards/review_card.dart';
import 'package:flutter/material.dart';

class NotificationShareListView extends StatefulWidget {
  final int globalUserId;

  const NotificationShareListView({Key? key, required this.globalUserId}) : super(key: key);

  @override
  State<NotificationShareListView> createState() => _NotificationShareListViewState();
}

class _NotificationShareListViewState extends State<NotificationShareListView> with AutomaticKeepAliveClientMixin {
  late NotificationController _notificationController;
  late ReviewController _reviewController;
  bool _isLoading = true;
  List<AppNotificationShare> _notifications = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _notificationController = NotificationController();
    _reviewController = ReviewController();
    _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    try {
      final fetchedNotifications = await _notificationController.getShareNotifications(widget.globalUserId);
      setState(() {
        _notifications = fetchedNotifications;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      // Handle error if necessary
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isLoading = true;
    });
    await _fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      color: MyColors.selectedItemColor,
      backgroundColor: MyColors.bgColor,
      onRefresh: _onRefresh,
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notifications.isEmpty
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
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: _notifications.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        // Fetch the review details when the card is clicked
                        ReviewModel review = await _reviewController.fetchReview(_notifications[index].reviewID);

                        // Show the review in a custom-styled dialog box
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8), // Slightly rounded corners
                              ),
                              backgroundColor: MyColors.bgColor, // Set background color to your custom color
                              insetPadding: const EdgeInsets.all(10), // Reduce the outer padding to minimize white border
                              child: Container(
                                width: MediaQuery.of(context).size.width * 1.0, // Increased width to 90% of the screen
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: MyColors.bgColor, // Background color of the dialog content
                                  borderRadius: BorderRadius.circular(8), // Ensure the inner content has rounded corners too
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min, // Adjust height based on content
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
                                          style: TextStyle(color: MyColors.selectedItemColor),
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
                      child: ShareNotificationCard(
                        username: _notifications[index].sharedUserName,
                        bookName: _notifications[index].bookname,
                        date: _notifications[index].date,
                      ),
                    );
                  },
                ),
    );
  }
}
