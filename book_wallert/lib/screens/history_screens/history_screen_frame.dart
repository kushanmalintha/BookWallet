import 'package:book_wallert/colors.dart';
import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:book_wallert/screens/history_screens/history_list_screen_body.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.navigationBarColor,
        title: const Text(
          'History',
          style: TextStyle(color: MyColors.text2Color),
        ),
      ),
      body: HistoryListScreenBody(
        globalUserId: globalUser!.userId,
      ),
    );
  }
}
// Description: Represents what type of entity the user searched for. You can use the following mapping:
// 0 for Reviews
// 1 for Books
// 2 for Profiles
// 3 for Groups