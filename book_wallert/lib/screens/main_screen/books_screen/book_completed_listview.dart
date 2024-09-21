import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class BookCompletedListview extends StatefulWidget {
  final int globalUserId;

  const BookCompletedListview({super.key, required this.globalUserId});

  @override
  State<BookCompletedListview> createState() => _BookCompletedListviewState();
}

class _BookCompletedListviewState extends State<BookCompletedListview>
    with AutomaticKeepAliveClientMixin {
  // AutomaticKeepAliveClientMixin added to make sure scroll view remains same when moving to other listviews in same screen
  @override
  bool get wantKeepAlive =>
      true; // Keep alive even when move to diffeerent listview

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // Fetch reviews based on the userId and display them
    // Placeholder implementation for now
    return Center(
      child: Text(
        'Completed for user ID: ${widget.globalUserId}',
        style: const TextStyle(color: MyColors.selectedItemColor),
      ),
    );
  }
}
