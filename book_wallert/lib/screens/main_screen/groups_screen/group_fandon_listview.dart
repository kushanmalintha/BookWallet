import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class GroupFandomListview extends StatefulWidget {
  final int globalUserId;

  const GroupFandomListview({super.key, required this.globalUserId});

  @override
  State<GroupFandomListview> createState() => _GroupFandomListviewState();
}

class _GroupFandomListviewState extends State<GroupFandomListview> {
  @override
  Widget build(BuildContext context) {
    // Fetch reviews based on the userId and display them
    // Placeholder implementation for now
    return Center(
      child: Text(
        'Fandom for user ID: ${widget.globalUserId}',
        style: const TextStyle(color: MyColors.selectedItemColor),
      ),
    );
  }
}
