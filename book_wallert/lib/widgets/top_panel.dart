import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

class TopPanel extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const TopPanel({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: MyColors.navigationBarColor,
      title: Text(
        title,
        style: const TextStyle(
          color: MyColors.titleColor,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          color: MyColors.nonSelectedItemColor,
          onPressed: () {
            // Add search functionality here
          },
        ),
        PopupMenuButton<String>(
          elevation: 10,
          shadowColor: MyColors.bgColor,
          color: MyColors.nonSelectedItemColor,
          icon: const Icon(
            Icons.menu,
            color: MyColors.nonSelectedItemColor,
          ),
          onSelected: (String result) {
            // Handle menu item selections
            if (result == 'Test Screens') {
              Navigator.pushNamed(context, '/TestScreen');
            } else if (result == 'Settings') {
              Navigator.pushNamed(context, '/SettingsScreen');
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Test Screens',
              child: Text('Test Screens'),
            ),
            const PopupMenuItem<String>(
              value: 'Settings',
              child: Text('Settings'),
            ),
            const PopupMenuItem<String>(
              value: 'Settings',
              child: Text('Settings'),
            ),
            const PopupMenuItem<String>(
              value: 'Settings',
              child: Text('Settings'),
            ),
            const PopupMenuItem<String>(
              value: 'Settings',
              child: Text('Settings'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
