import 'package:book_wallert/colors.dart';
import 'package:book_wallert/controllers/notiffication_controller.dart';
import 'package:book_wallert/controllers/review_controller.dart';
import 'package:book_wallert/models/review_model.dart';
import 'package:book_wallert/services/notification_api_service.dart';
import 'package:book_wallert/widgets/cards/notification_card.dart';
import 'package:book_wallert/widgets/cards/review_card.dart';
import 'package:flutter/material.dart';

class NotificationCommentListView extends StatefulWidget {
  final int globalUserId;

  const NotificationCommentListView({
    Key? key,
    required this.globalUserId,
  }) : super(key: key);

  @override
  _NotificationCommentListViewState createState() =>
      _NotificationCommentListViewState();
}

class _NotificationCommentListViewState
    extends State<NotificationCommentListView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final NotificationController _notificationController = NotificationController();
  final ReviewController _reviewController = ReviewController();
  List<AppNotificationComment> notifications = [];
  bool isLoading = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchNotifications() async {
    try {
      final fetchedNotifications = await _notificationController.getCommentNotifications(widget.globalUserId);
      setState(() {
        notifications = fetchedNotifications;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      notifications = [];
      isLoading = true;
    });
    await _fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);  // Ensure the keep-alive mixin works

    return RefreshIndicator(
      color: MyColors.selectedItemColor,
      backgroundColor: MyColors.bgColor,
      onRefresh: _onRefresh,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : notifications.isEmpty
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
                  controller: _scrollController,
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        ReviewModel review = await _reviewController.fetchReview(notifications[index].reviewID);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: MyColors.bgColor,
                              insetPadding: const EdgeInsets.all(10),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 1.0,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: MyColors.bgColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ReviewCard(review: review),
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
                                            color: MyColors.selectedItemColor,
                                          ),
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
                      child: CommentNotificationCard(
                        username: notifications[index].CommentedUserName,
                        bookName: notifications[index].bookname,
                      ),
                    );
                  },
                ),
    );
  }
}
