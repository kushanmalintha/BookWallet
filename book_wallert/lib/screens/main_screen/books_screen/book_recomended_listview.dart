import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class BookRecomendedListview extends StatefulWidget {
  final int globalUserId;

  const BookRecomendedListview({super.key, required this.globalUserId, });

  @override
  State<BookRecomendedListview> createState() => _BookRecomendedListviewState();
}

class _BookRecomendedListviewState extends State<BookRecomendedListview> {
  @override
  Widget build(BuildContext context) {
    // Fetch reviews based on the userId and display them
    // Placeholder implementation for now
    return Center(
      child: Text(
        'Completed for user ID: ${widget.globalUserId}',
        style: TextStyle(color: MyColors.selectedItemColor),
      ),
    );
  }
}