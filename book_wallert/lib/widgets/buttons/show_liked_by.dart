// show_like_menu.dart

import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class ShowLikeMenu {
  static void show(BuildContext context, Offset position) {
    showMenu(
      context: context,
      elevation: 10,
      shadowColor: MyColors.bgColor,
      color: MyColors.nonSelectedItemColor,
      position: RelativeRect.fromLTRB(
          position.dx, position.dy, position.dx, position.dy),
      items: [
        const PopupMenuItem(
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('images/user1.jpg'),
                radius: 10,
              ),
              SizedBox(width: 10),
              Text('User 1'),
            ],
          ),
        ),
        const PopupMenuItem(
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('images/user2.jpg'),
                radius: 10,
              ),
              SizedBox(width: 10),
              Text('User 2'),
            ],
          ),
        ),
        // Add more PopupMenuItem for additional users
      ],
    );
  }
}
