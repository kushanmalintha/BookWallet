import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

class TopPanel extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const TopPanel({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyColors.navigationBarColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: MyColors.titleColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search),
                color: MyColors.nonSelectedItemColor,
                onPressed: () {
                  // Add search functionality here
                },
              ),
              IconButton(
                icon: const Icon(Icons.menu_rounded),
                color: MyColors.nonSelectedItemColor,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/TestScreen');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
