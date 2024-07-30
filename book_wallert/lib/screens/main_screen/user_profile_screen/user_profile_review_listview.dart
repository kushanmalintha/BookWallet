import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class UserProfileReviewListView extends StatelessWidget {
  final int userId;

  const UserProfileReviewListView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // Fetch reviews based on the userId and display them
    // Placeholder implementation for now
    return Center(
      child: Text(
        'Reviews for user ID: $userId',
        style: TextStyle(color: MyColors.selectedItemColor),
      ),
    );
  }
}
