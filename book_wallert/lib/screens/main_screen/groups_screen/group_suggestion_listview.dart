import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class GroupSuggestionListview extends StatefulWidget {
  final int globalUserId;

  const GroupSuggestionListview({super.key, required this.globalUserId});

  @override
  State<GroupSuggestionListview> createState() => _GroupSuggestionListviewState();
}

class _GroupSuggestionListviewState extends State<GroupSuggestionListview> {
  @override
  Widget build(BuildContext context) {
    // Fetch reviews based on the userId and display them
    // Placeholder implementation for now
    return Center(
      child: Text(
        'Suggestion for user ID: ${widget.globalUserId}',
        style: const TextStyle(color: MyColors.selectedItemColor),
      ),
    );
  }
}
