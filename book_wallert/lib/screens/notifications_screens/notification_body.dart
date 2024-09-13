import 'package:book_wallert/colors.dart';
import 'package:book_wallert/screens/notifications_screens/notification_all_listview.dart';
import 'package:book_wallert/screens/notifications_screens/notification_comment_listview.dart';
import 'package:book_wallert/screens/notifications_screens/notification_like_listview.dart';
import 'package:book_wallert/widgets/buttons/selection_bar.dart';
import 'package:flutter/material.dart';
import 'notification_share_listview.dart';

class NotificationScreen extends StatefulWidget {
  final int globalUserId;

  const NotificationScreen({
    super.key,
    required this.globalUserId,
  });

  @override
  State<NotificationScreen> createState() {
    return _NotificationScreenState();
  }
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabNames = [
    'All',
    'Like',
    'Comment',
    'Share',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabNames.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      appBar: AppBar(
        backgroundColor: MyColors.bgColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: SelectionBar(tabController: _tabController, tabNames: _tabNames),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          NotificationAllListView(), // All notifications
          NotificationLikeListView(globalUserId: widget.globalUserId,), // Likes
          NotificationCommentListView(globalUserId: widget.globalUserId,), // Comments
          NotificationShareListView(globalUserId: widget.globalUserId), // Shares
        ],
      ),
    );
  }
}
