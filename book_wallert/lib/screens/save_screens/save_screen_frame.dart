import 'package:book_wallert/colors.dart';
import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/screens/save_screens/save_list_screen_body.dart';
import 'package:flutter/material.dart';

class SaveScreen extends StatelessWidget {
  const SaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.navigationBarColor,
        title: const Text(
          'Saved',
          style: TextStyle(color: MyColors.text2Color),
        ),
      ),
      body: SaveListScreenBody(
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