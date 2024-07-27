import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

void _showLikePopupMenu(BuildContext context, Offset offset) {

  final List<Map<String, String>> likedBy = [
    {'name': 'User 1', 'imagePath': 'images/user1.jpg'},
    {'name': 'User 2', 'imagePath': 'images/user2.jpg'},
    {'name': 'User 3', 'imagePath': 'images/user3.jpg'},
    {'name': 'User 4', 'imagePath': 'images/user4.jpg'},
    {'name': 'User 5', 'imagePath': 'images/user5.jpg'},
  ];
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, offset.dx, offset.dy),
      items: <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Liked by',
          child: Text('Liked by'),
        ),
      ],
      elevation: 8.0,
    ).then((String? selectedItem) {
      if (selectedItem == 'Liked by') {
        // Perform the desired action here
        print('Liked by tapped');
      }
    });
  }