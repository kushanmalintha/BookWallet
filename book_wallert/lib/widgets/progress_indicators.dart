import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

Widget buildProgressIndicator() {
  return const Padding(
    padding: EdgeInsets.all(10.0),
    child: Center(
      child: CircularProgressIndicator(
        backgroundColor: MyColors.panelColor,
        color: MyColors
            .selectedItemColor, // Set color for the circular progress indicator
      ),
    ),
  );
}
