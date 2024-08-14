import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;

  const FloatingActionButtonWidget(
      {super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: MyColors.selectedItemColor,
      onPressed: onPressed,
      child: icon,
    );
  }
}
