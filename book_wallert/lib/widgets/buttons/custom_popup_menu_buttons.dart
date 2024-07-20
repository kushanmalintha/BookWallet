import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class CustomPopupMenuButtons extends StatelessWidget {
  final List<String> items;
  final List<Function> onItemTap;
  final Icon icon;

  const CustomPopupMenuButtons({
    super.key,
    required this.items,
    required this.onItemTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      elevation: 10,
      shadowColor: MyColors.bgColor,
      color: MyColors.nonSelectedItemColor,
      icon: icon,
      onSelected: (String result) {
        int index = items.indexOf(result);
        if (index >= 0 && index < onItemTap.length) {
          onItemTap[index](); // Call the corresponding function
        }
      },
      itemBuilder: (BuildContext context) => items
          .map((item) => PopupMenuItem<String>(
                value: item,
                child: Text(item),
              ))
          .toList(),
    );
  }
}
