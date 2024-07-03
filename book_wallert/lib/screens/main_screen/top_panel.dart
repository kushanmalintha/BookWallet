import 'package:flutter/material.dart';
import 'package:book_wallert/colors.dart';

// ignore: must_be_immutable
class TopPanel extends StatelessWidget {
  TopPanel({super.key, required this.title});
  String title;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                // Add options functionality here
              },
            ),
          ],
        ),
      ],
    );
  }
}
