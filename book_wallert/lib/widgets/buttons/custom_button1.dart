import 'package:book_wallert/colors.dart';
import 'package:flutter/material.dart';

// A custom button widget with round edges
class CustomButton1 extends StatelessWidget {
  // Text to be displayed on the button
  final String text;

  // Function to be called when the button is pressed
  final Function press;

  // Background color of the button
  final Color backgroundColor;

  // Text color of the button
  final Color textColor;

  // Border color of the button
  final Color borderColor;

  // Horizontal space
  final double horizontalSpace;

  // Vertical space
  final double verticalSpace;

  // Font size
  final double textSize;

  // Constructor to initialize the button properties
  const CustomButton1({
    super.key,
    required this.text,
    required this.press,
    this.backgroundColor = MyColors.selectedItemColor,
    this.textColor = MyColors.bgColor,
    this.borderColor = MyColors.textColor,
    this.horizontalSpace = 30,
    this.verticalSpace = 10,
    this.textSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // Define the button's style
      style: TextButton.styleFrom(
        // Padding inside the button
        padding: EdgeInsets.symmetric(
            vertical: verticalSpace, horizontal: horizontalSpace),
        // Background color of the button
        backgroundColor: backgroundColor,
        // border color of the button
        side: BorderSide(color: borderColor),
        // Text color of the button
        foregroundColor: textColor,
      ),
      // Define the function to be called when the button is pressed
      onPressed: () => press(),
      // Define the child widget (text) of the button
      child: Text(
        text,
        style: TextStyle(
          // Font size of the text
          fontSize: textSize,
        ),
      ),
    );
  }
}
