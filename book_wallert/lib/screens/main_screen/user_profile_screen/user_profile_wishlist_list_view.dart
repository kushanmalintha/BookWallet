import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class UserProfileWishlistListView extends StatefulWidget {
  final int userId;

  const UserProfileWishlistListView({super.key, required this.userId});

  @override
  State<UserProfileWishlistListView> createState() => _UserProfileWishlistListViewState();
}

class _UserProfileWishlistListViewState extends State<UserProfileWishlistListView> {
  @override
  Widget build(BuildContext context) {
    // Fetch reviews based on the userId and display them
    // Placeholder implementation for now
    return Center(
      child: Text(
        'Wishlist for user ID: ${widget.userId}',
        style: const TextStyle(color: MyColors.selectedItemColor),
      ),
    );
  }
}
