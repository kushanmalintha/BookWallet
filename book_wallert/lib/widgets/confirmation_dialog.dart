import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

Future<void> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String confirmText,
  required String cancelText,
  required Future<void> Function() onConfirm,
}) async {
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        backgroundColor: MyColors.nonSelectedItemColor,
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              cancelText,
              style: TextStyle(color: MyColors.bgColor),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              confirmText,
              style: TextStyle(color: MyColors.bgColor),
            ),
          ),
        ],
      );
    },
  );

  if (result == true) {
    await onConfirm();
  }
}
