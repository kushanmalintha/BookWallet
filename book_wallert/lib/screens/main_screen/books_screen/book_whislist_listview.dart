import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class BookWishlistListview extends StatefulWidget {
  final int globalUserId;

  const BookWishlistListview({super.key, required this.globalUserId});

  @override
  State<BookWishlistListview> createState() => _BookWishlistListviewState();
}

class _BookWishlistListviewState extends State<BookWishlistListview> {
  @override
  Widget build(BuildContext context) {
    // Fetch reviews based on the userId and display them
    // Placeholder implementation for now
    return Center(
      child: Text(
        'whislist for user ID: ${widget.globalUserId}',
        style: const TextStyle(color: MyColors.selectedItemColor),
      ),
    );
  }
}
