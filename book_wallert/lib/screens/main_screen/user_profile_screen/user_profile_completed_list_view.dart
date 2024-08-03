import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class UserProfileCompletedListView extends StatefulWidget {
  final int userId;

  const UserProfileCompletedListView({super.key, required this.userId});

  @override
 State<UserProfileCompletedListView> createState() => _UserProfileCompletedListViewState();
}

class _UserProfileCompletedListViewState extends State<UserProfileCompletedListView> {
  @override
  Widget build(BuildContext context) {
    // Fetch reviews based on the userId and display them
    // Placeholder implementation for now
    return Center(
      child: Text(
        'Completed for user ID: ${widget.userId}',
        style: TextStyle(color: MyColors.selectedItemColor),
      ),
    );
  }
}
